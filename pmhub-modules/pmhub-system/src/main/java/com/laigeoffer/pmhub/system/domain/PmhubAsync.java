package com.laigeoffer.pmhub.system.domain;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.IdUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.laigeoffer.pmhub.base.core.annotation.Excel;
import com.laigeoffer.pmhub.base.core.annotation.Excel.ColumnType;
import com.laigeoffer.pmhub.base.core.core.domain.BaseEntity;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 异步任务表 pmhub_async
 *
 * @author canghe
 */
@Data
public class PmhubAsync extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 类型： 生成文件
     */
    public static final String TYPE_BUILD_FILE = "生成文件";


    /**
     * 任务id
     */
    @Excel(name = "任务编号", cellType = ColumnType.NUMERIC)
    private String id;

    /**
     * 异步任务类型（文件生成）
     */
    @Excel(name = "任务类型")
    private String asyncType;

    /**
     * 任务名
     */
    @Excel(name = "任务名")
    private String asyncName;

    /**
     * 任务描述
     */
    @Excel(name = "描述")
    private String asyncDesc;

    /**
     * 执行进度
     */
    @Excel(name = "进度")
    private BigDecimal asyncSchedule;

    /**
     * 结束时间
     */
    @Excel(name = "结束时间")
    private Date finishTime;

    /**
     * 状态（0 进行中 1 已失败 2 已完成）
     */
    @Excel(name = "状态", readConverterExp = "（0 进行中 1 已失败 2 已完成）")
    private Integer asyncStatus;

    /**
     * 任务执行信息
     */
    @Excel(name = "任务执行信息")
    private String asyncLog = "[]";

    /**
     * 附件地址
     */
    @Excel(name = "附件地址")
    private String file;

    public PmhubAsync(){

    }

    /**
     * 创建一个任务的最基础信息
     * @param asyncName
     * @param asyncType
     * @param createBy
     */
    public PmhubAsync(String asyncName, String asyncType, String createBy){
        this.id = IdUtil.fastUUID();
        this.asyncName = asyncName;
        this.asyncType = asyncType;
        this.asyncSchedule = new BigDecimal(0);
        this.asyncStatus = 0;
        setCreateBy(createBy);
        setCreateTime(new Date());
        setUpdateBy(createBy);
        setUpdateTime(getCreateTime());
    }

    /**
     * 添加日志
     * @param log 新日志
     */
    public void addLog(String log){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("time",new DateTime());
        jsonObject.put("log",log);
        JSONArray jsonArray = JSON.parseArray(this.asyncLog);
        jsonArray.add(jsonObject);
        this.asyncLog = jsonArray.toJSONString();
    }

}
