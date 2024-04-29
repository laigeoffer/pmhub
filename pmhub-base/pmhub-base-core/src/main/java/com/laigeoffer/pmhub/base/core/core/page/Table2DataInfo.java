package com.laigeoffer.pmhub.base.core.core.page;

import cn.hutool.http.HttpStatus;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * @author canghe
 * @date 2023-02-23 09:44
 */
@Data
@NoArgsConstructor
public class Table2DataInfo<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 总记录数
     */
    private long total;

    /**
     * 列表数据
     */
    private List<T> rows;

    /**
     * 消息状态码
     */
    private int code;

    /**
     * 消息内容
     */
    private String msg;

    /**
     * 分页
     *
     * @param list  列表数据
     * @param total 总记录数
     */
    public Table2DataInfo(List<T> list, long total) {
        this.rows = list;
        this.total = total;
    }

    public static <T> Table2DataInfo<T> build(IPage<T> page) {
        Table2DataInfo<T> rspData = new Table2DataInfo<>();
        rspData.setCode(HttpStatus.HTTP_OK);
        rspData.setMsg("查询成功");
        rspData.setRows(page.getRecords());
        rspData.setTotal(page.getTotal());
        return rspData;
    }

    public static <T> Table2DataInfo<T> build(List<T> list) {
        Table2DataInfo<T> rspData = new Table2DataInfo<>();
        rspData.setCode(HttpStatus.HTTP_OK);
        rspData.setMsg("查询成功");
        rspData.setRows(list);
        rspData.setTotal(list.size());
        return rspData;
    }

    public static <T> Table2DataInfo<T> build() {
        Table2DataInfo<T> rspData = new Table2DataInfo<>();
        rspData.setCode(HttpStatus.HTTP_OK);
        rspData.setMsg("查询成功");
        return rspData;
    }

}