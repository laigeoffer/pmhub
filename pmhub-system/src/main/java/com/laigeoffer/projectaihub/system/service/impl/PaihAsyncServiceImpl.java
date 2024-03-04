package com.laigeoffer.projectaihub.system.service.impl;


import cn.hutool.core.util.ObjectUtil;
import cn.hutool.log.LogFactory;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.laigeoffer.projectaihub.common.utils.file.FileUtils;
import com.laigeoffer.projectaihub.system.domain.PaihAsync;
import com.laigeoffer.projectaihub.system.mapper.PaihAsyncMapper;
import com.laigeoffer.projectaihub.system.service.IPaihAsyncService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

@Service
public class PaihAsyncServiceImpl implements IPaihAsyncService {

    @Autowired
    PaihAsyncMapper paihAsyncMapper;

    /**
     * 创建异步任务记录
     *
     * @param asyncName 异步任务名
     * @param asyncType 异步任务类型
     * @param createBy  创建者
     */
    @Override
    public PaihAsync addAsyncJob(String asyncName, String asyncType, String createBy) {
        PaihAsync paihAsync = new PaihAsync(asyncName,asyncType,createBy);
        paihAsyncMapper.insert(paihAsync);
        return paihAsync;
    }

    /**
     * 更新任务状态
     *
     * @param paihAsync 任务信息
     */
    @Override
    public void updateAsyncJob(PaihAsync paihAsync) {
        paihAsync.setUpdateTime(new Date());
        paihAsyncMapper.updateById(paihAsync);
    }

    /**
     * 查询异步任务信息
     *
     * @param paihAsync
     * @return {@link List}<{@link PaihAsync}>
     */
    @Override
    public List<PaihAsync> list(PaihAsync paihAsync) {
        paihAsync.setAsyncLog(null);
        QueryWrapper<PaihAsync> queryWrapper = new QueryWrapper<>();
        // 如果 asyncName 字段不为空，则添加模糊查询条件
        if (paihAsync.getAsyncName() != null && !paihAsync.getAsyncName().isEmpty()) {
            // 添加模糊查询条件
            queryWrapper.like("async_name", "%"+paihAsync.getAsyncName()+"%");
        }
        if (paihAsync.getAsyncType() != null && !paihAsync.getAsyncType().isEmpty()) {
            // 添加精确查询条件
            queryWrapper.eq("async_type", paihAsync.getAsyncType());
        }
        if (paihAsync.getAsyncStatus() != null) {
            // 添加精确查询条件
            queryWrapper.eq("async_status", paihAsync.getAsyncStatus());
        }
        if (paihAsync.getCreateBy() != null && !paihAsync.getCreateBy().isEmpty()) {
            // 添加精确查询条件
            queryWrapper.eq("create_by", paihAsync.getCreateBy());
        }
        if (paihAsync.getId() != null && !paihAsync.getId().isEmpty()) {
            // 添加精确查询条件
            queryWrapper.eq("id", paihAsync.getId());
        }
        queryWrapper.orderByDesc("update_time"); // 添加根据 updateTime 字段的倒序排序
        // 查询所有记录
        return paihAsyncMapper.selectList(queryWrapper);
    }

    /**
     * 查询单条异步任务信息
     *
     * @param id id
     * @return {@link List}<{@link PaihAsync}>
     */
    @Override
    public PaihAsync load(String id) {
        PaihAsync paihAsync = new PaihAsync();
        paihAsync.setId(id);
        List<PaihAsync> paihAsyncs = list(paihAsync);
        if (!paihAsyncs.isEmpty()){
            return paihAsyncs.get(0);
        }else {
            return null;
        }
    }


    /**
     * 删除
     * @param ids ids
     */
    @Transactional
    @Override
    public void delete(String[] ids) {
        for (String id:ids){
            PaihAsync paihAsync = new PaihAsync();
            paihAsync.setId(id);
            delete(paihAsync);
        }
    }

    /**
     * 下载附件
     *
     * @param id       任务id
     * @param response Http
     */
    @Override
    public void downloadFile(String id, String user, HttpServletResponse response) {
        PaihAsync paihAsync = load(id);
        if (paihAsync==null){
            throw new RuntimeException("不存在的任务");
        }else if (paihAsync.getFile()==null||paihAsync.getFile().isEmpty()){
            throw new RuntimeException("不存在的附件");
        }else if (!paihAsync.getCreateBy().equals(user)){
            throw new RuntimeException("非法操作");
        }else {
            // 单文件下载
            try {
                FileUtils.setAttachmentResponseHeader(response, paihAsync.getFile());
                FileUtils.writeBytes(paihAsync.getFile(), response);
            } catch (UnsupportedEncodingException e) {
                LogFactory.get().error(e);
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private void delete(PaihAsync paihAsync) {
        paihAsync = paihAsyncMapper.selectById(paihAsync.getId());

        if (paihAsync==null){
            return;
        }

        if (paihAsync.getAsyncStatus()==0){
            throw new RuntimeException("任务进行中禁止删除");
        }

        // 文件路径
        String filePath = paihAsync.getFile();
        if (ObjectUtil.isNotEmpty(filePath)){
            // 删除文件
            boolean result = new File(filePath).delete();

            if (result) {
                LogFactory.get().info("任务["+paihAsync.getId()+"]文件已被成功删除");
            } else {
                LogFactory.get().warn("任务["+paihAsync.getId()+"]文件删除失败，可能文件不存在或无法删除");
            }
        }
        paihAsyncMapper.deleteById(paihAsync);
    }

}
