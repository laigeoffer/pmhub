package com.laigeoffer.pmhub.system.service.impl;


import cn.hutool.core.util.ObjectUtil;
import cn.hutool.log.LogFactory;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.laigeoffer.pmhub.common.utils.file.FileUtils;
import com.laigeoffer.pmhub.system.domain.PmhubAsync;
import com.laigeoffer.pmhub.system.mapper.PmhubAsyncMapper;
import com.laigeoffer.pmhub.system.service.IPmhubAsyncService;
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
public class PmhubAsyncServiceImpl implements IPmhubAsyncService {

    @Autowired
    PmhubAsyncMapper pmhubAsyncMapper;

    /**
     * 创建异步任务记录
     *
     * @param asyncName 异步任务名
     * @param asyncType 异步任务类型
     * @param createBy  创建者
     */
    @Override
    public PmhubAsync addAsyncJob(String asyncName, String asyncType, String createBy) {
        PmhubAsync pmhubAsync = new PmhubAsync(asyncName,asyncType,createBy);
        pmhubAsyncMapper.insert(pmhubAsync);
        return pmhubAsync;
    }

    /**
     * 更新任务状态
     *
     * @param pmhubAsync 任务信息
     */
    @Override
    public void updateAsyncJob(PmhubAsync pmhubAsync) {
        pmhubAsync.setUpdateTime(new Date());
        pmhubAsyncMapper.updateById(pmhubAsync);
    }

    /**
     * 查询异步任务信息
     *
     * @param pmhubAsync
     * @return {@link List}<{@link PmhubAsync}>
     */
    @Override
    public List<PmhubAsync> list(PmhubAsync pmhubAsync) {
        pmhubAsync.setAsyncLog(null);
        QueryWrapper<PmhubAsync> queryWrapper = new QueryWrapper<>();
        // 如果 asyncName 字段不为空，则添加模糊查询条件
        if (pmhubAsync.getAsyncName() != null && !pmhubAsync.getAsyncName().isEmpty()) {
            // 添加模糊查询条件
            queryWrapper.like("async_name", "%"+ pmhubAsync.getAsyncName()+"%");
        }
        if (pmhubAsync.getAsyncType() != null && !pmhubAsync.getAsyncType().isEmpty()) {
            // 添加精确查询条件
            queryWrapper.eq("async_type", pmhubAsync.getAsyncType());
        }
        if (pmhubAsync.getAsyncStatus() != null) {
            // 添加精确查询条件
            queryWrapper.eq("async_status", pmhubAsync.getAsyncStatus());
        }
        if (pmhubAsync.getCreateBy() != null && !pmhubAsync.getCreateBy().isEmpty()) {
            // 添加精确查询条件
            queryWrapper.eq("create_by", pmhubAsync.getCreateBy());
        }
        if (pmhubAsync.getId() != null && !pmhubAsync.getId().isEmpty()) {
            // 添加精确查询条件
            queryWrapper.eq("id", pmhubAsync.getId());
        }
        queryWrapper.orderByDesc("update_time"); // 添加根据 updateTime 字段的倒序排序
        // 查询所有记录
        return pmhubAsyncMapper.selectList(queryWrapper);
    }

    /**
     * 查询单条异步任务信息
     *
     * @param id id
     * @return {@link List}<{@link PmhubAsync}>
     */
    @Override
    public PmhubAsync load(String id) {
        PmhubAsync pmhubAsync = new PmhubAsync();
        pmhubAsync.setId(id);
        List<PmhubAsync> pmhubAsyncs = list(pmhubAsync);
        if (!pmhubAsyncs.isEmpty()){
            return pmhubAsyncs.get(0);
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
            PmhubAsync pmhubAsync = new PmhubAsync();
            pmhubAsync.setId(id);
            delete(pmhubAsync);
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
        PmhubAsync pmhubAsync = load(id);
        if (pmhubAsync ==null){
            throw new RuntimeException("不存在的任务");
        }else if (pmhubAsync.getFile()==null|| pmhubAsync.getFile().isEmpty()){
            throw new RuntimeException("不存在的附件");
        }else if (!pmhubAsync.getCreateBy().equals(user)){
            throw new RuntimeException("非法操作");
        }else {
            // 单文件下载
            try {
                FileUtils.setAttachmentResponseHeader(response, pmhubAsync.getFile());
                FileUtils.writeBytes(pmhubAsync.getFile(), response);
            } catch (UnsupportedEncodingException e) {
                LogFactory.get().error(e);
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private void delete(PmhubAsync pmhubAsync) {
        pmhubAsync = pmhubAsyncMapper.selectById(pmhubAsync.getId());

        if (pmhubAsync ==null){
            return;
        }

        if (pmhubAsync.getAsyncStatus()==0){
            throw new RuntimeException("任务进行中禁止删除");
        }

        // 文件路径
        String filePath = pmhubAsync.getFile();
        if (ObjectUtil.isNotEmpty(filePath)){
            // 删除文件
            boolean result = new File(filePath).delete();

            if (result) {
                LogFactory.get().info("任务["+ pmhubAsync.getId()+"]文件已被成功删除");
            } else {
                LogFactory.get().warn("任务["+ pmhubAsync.getId()+"]文件删除失败，可能文件不存在或无法删除");
            }
        }
        pmhubAsyncMapper.deleteById(pmhubAsync);
    }

}
