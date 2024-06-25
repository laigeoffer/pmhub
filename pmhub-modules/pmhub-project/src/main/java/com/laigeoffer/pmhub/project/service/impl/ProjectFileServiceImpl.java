package com.laigeoffer.pmhub.project.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.pmhub.api.system.UserFeignService;
import com.laigeoffer.pmhub.api.system.domain.dto.SysUserDTO;
import com.laigeoffer.pmhub.base.core.constant.SecurityConstants;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.core.domain.vo.SysUserVO;
import com.laigeoffer.pmhub.base.core.enums.FileTypeEnum;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import com.laigeoffer.pmhub.base.core.utils.file.FileUtils;
import com.laigeoffer.pmhub.project.domain.ProjectFile;
import com.laigeoffer.pmhub.project.domain.vo.project.file.FileVO;
import com.laigeoffer.pmhub.project.domain.vo.project.file.ProjectFileIdsVO;
import com.laigeoffer.pmhub.project.domain.vo.project.file.ProjectFileReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.file.ProjectFileResVO;
import com.laigeoffer.pmhub.project.mapper.ProjectFileMapper;
import com.laigeoffer.pmhub.project.mapper.ProjectMemberMapper;
import com.laigeoffer.pmhub.project.mapper.ProjectTaskMapper;
import com.laigeoffer.pmhub.project.service.ProjectFileService;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.*;
import java.util.*;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * @author canghe
 * @date 2022-12-16 09:24
 */
@Service
public class ProjectFileServiceImpl extends ServiceImpl<ProjectFileMapper, ProjectFile> implements ProjectFileService {

    @Autowired
    private ProjectFileMapper projectFileMapper;
    @Autowired
    private ProjectMemberMapper projectMemberMapper;
    @Autowired
    private ProjectTaskMapper projectTaskMapper;
    @Resource
    private UserFeignService userFeignService;


    @Override
    public PageInfo<ProjectFileResVO> queryFileList(ProjectFileReqVO projectFileReqVO) {


        PageHelper.startPage(projectFileReqVO.getPageNum(), projectFileReqVO.getPageSize());
        List<ProjectFileResVO> files = new ArrayList<>(10);
        if (StringUtils.isNotBlank(projectFileReqVO.getType())) {
            switch (projectFileReqVO.getType()) {
                case "project":
                    files = projectFileMapper.queryProjectFileList(projectFileReqVO);
                    break;
                case "task":
                    files = projectFileMapper.queryTaskFileList(projectFileReqVO);
                    break;
                case "template":
                    files = projectFileMapper.queryTemplateFileList(projectFileReqVO);
                    break;
            }
        } else {
            files = projectFileMapper.queryFileList(projectFileReqVO);
        }

        if (CollectionUtils.isNotEmpty(files)) {
            List<Long> userIds = files.stream().map(ProjectFileResVO::getUserId).distinct().collect(Collectors.toList());
            // 根据 userIds 查询用户列表
            SysUserDTO sysUserDTO = new SysUserDTO();
            sysUserDTO.setUserIds(userIds);
            R<List<SysUserVO>> userResult = userFeignService.listOfInner(sysUserDTO, SecurityConstants.INNER);

            if (Objects.isNull(userResult) || CollectionUtils.isEmpty(userResult.getData())) {
                throw new ServiceException("远程调用查询用户列表：" + userIds + " 失败");
            }
            List<SysUserVO> userVOList = userResult.getData();
            List<SysUser> sysUsers = userVOList.stream()
                    .map(userVO -> (SysUser) userVO)
                    .collect(Collectors.toList());
            Map<Long, List<SysUser>> map = sysUsers.stream().collect(Collectors.groupingBy(SysUser::getUserId));
            files.forEach(a -> {
                if (FileTypeEnum.P.getStatus().equals(a.getType())) {
                    a.setName(a.getProjectName());
                } else if (FileTypeEnum.T.getStatus().equals(a.getType())) {
                    a.setName(projectTaskMapper.selectById(a.getPtId()).getTaskName());
                }
                a.setNickName(map.get(a.getUserId()).get(0).getNickName());
                a.setTypeName(FileTypeEnum.getStatusNameByStatus(a.getType()));
            });
        }

        return new PageInfo<>(files);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteFileList(ProjectFileIdsVO projectFileIdsVO) {
        if (CollectionUtils.isNotEmpty(projectFileIdsVO.getFileVOList())) {
            List<String> ids = projectFileIdsVO.getFileVOList().stream().map(FileVO::getProjectFileId).collect(Collectors.toList());
            List<ProjectFile> projectFiles = projectFileMapper.selectBatchIds(ids);
            List<String> urls = projectFiles.stream().map(ProjectFile::getPathName).collect(Collectors.toList());
            projectFileMapper.deleteBatchIds(ids);
            urls.forEach(FileUtils::deleteFile);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void rename(ProjectFileReqVO projectFileReqVO) {
        ProjectFile projectFile = projectFileMapper.selectById(projectFileReqVO.getProjectFileId());
        // D:/pmhub-manage/uploadPath/project/admin/20221229/s1iqii2engq.jpg
        String fileUrl = projectFile.getPathName();
        // 旧的文件或目录
        File oldName = new File(fileUrl);
        // 新的文件或目录
        File newName = new File(fileUrl.substring(0, fileUrl.lastIndexOf("/") + 1)
                + projectFileReqVO.getFileName());
        // 确保新的文件名不存在
        if (newName.exists()) {
            throw new ServiceException("file exists");
        }
        if (oldName.renameTo(newName)) {
            projectFile.setPathName(fileUrl.substring(0, fileUrl.lastIndexOf("/") + 1) + projectFileReqVO.getFileName());
            projectFile.setFileUrl(projectFile.getFileUrl().substring(0, projectFile.getFileUrl().lastIndexOf("/") + 1) + projectFileReqVO.getFileName());
            projectFile.setFileName(projectFileReqVO.getFileName());
            projectFile.setUpdatedBy(SecurityUtils.getUsername());
            projectFile.setUpdatedTime(new Date());
            projectFileMapper.updateById(projectFile);
        }
    }

    @Override
    public void batchDownload(String totalZip, List<String> paths) throws IOException {
        //Linux不会自动创建，手动创建临时的.zip文件
        File totalFile = new File(totalZip);
        if (!totalFile.exists()) {
            totalFile.createNewFile();
        }

        if (paths.size() != 0) {
            // 压缩输出流,包装流,将临时文件输出流包装成压缩流,将所有文件输出到这里,打成zip包
            ZipOutputStream totalZipOut = new ZipOutputStream(new FileOutputStream(totalZip));
            // 循环调用压缩文件方法,将一个一个需要下载的文件打入压缩文件包
            for (String path : paths) {
                // 文件完整路径
                String pathFile = path.replaceAll("/profile", "");
                // 调用压缩方法在下面定义
                fileToZip(pathFile, totalZipOut);
            }
            totalZipOut.close();
        }

    }

    private static void fileToZip(String filePath, ZipOutputStream zipOut) throws IOException {
        // 需要压缩的文件
        File file = new File(filePath);
        // 获取文件名称,如果有特殊命名需求,可以将参数列表拓展,传fileName
        String documents = file.getName();
        FileInputStream fileInput = new FileInputStream(filePath);
        // 缓冲
        byte[] bufferArea = new byte[1024 * 10];
        BufferedInputStream bufferStream = new BufferedInputStream(fileInput, 1024 * 10);
        // 将当前文件作为一个zip实体写入压缩流,fileName代表压缩文件中的文件名称
        zipOut.putNextEntry(new ZipEntry(documents));
        int length;
        // 最常规IO操作,不必紧张
        while ((length = bufferStream.read(bufferArea, 0, 1024 * 10)) != -1) {
            zipOut.write(bufferArea, 0, length);
        }
        // 关闭流
        fileInput.close();
        // 需要注意的是缓冲流必须要关闭流,否则输出无效
        bufferStream.close();
        // 压缩流不必关闭,使用完后再关
    }

}
