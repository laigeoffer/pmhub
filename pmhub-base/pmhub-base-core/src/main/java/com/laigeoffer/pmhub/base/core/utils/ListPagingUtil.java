package com.laigeoffer.pmhub.base.core.utils;

import java.util.List;

/**
 * @author canghe
 * @date 2023-07-13 17:22
 */
public class ListPagingUtil {
    private Integer pageNum;//当前页
    private Integer pageSize;//每页显示记录条数
    private Integer pages;//总页数
    private Integer star;//开始数据
    private Integer total;//总条数
    private List<?> list;//每页显示的数据

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getPages() {
        return pages;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }

    public Integer getStar() {
        return star;
    }

    public void setStar(Integer star) {
        this.star = star;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "ListPagingUtil{" +
                "pageNum=" + pageNum +
                ", pageSize=" + pageSize +
                ", pages=" + pages +
                ", list=" + list +
                ", star=" + star +
                ", total=" + total +
                '}';
    }

    public void pageStartInfo(Integer pageNum, Integer pageSize) {
        //如果传入的pageNumber为null给pageNumber赋为1
        pageNum = pageNum == null ? 1 : pageNum;
        //如果传入的pageSize为null给pageSize赋为10
        pageSize = pageSize == null ? 10 : pageSize;
        this.setPageNum(pageNum);
        this.setPageSize(pageSize);
    }

    public static ListPagingUtil getListPagingUtil(Integer currentPage, Integer pageSize, List<?> list) {
        ListPagingUtil pagingUtil = new ListPagingUtil();
        //初始化
        pagingUtil.pageStartInfo(currentPage, pageSize);
        //设置起始数据
        pagingUtil.setStar((pagingUtil.getPageNum() - 1) * pagingUtil.getPageSize());
        //设置总数
        pagingUtil.setTotal(list.size());
        //设置总页数
        pagingUtil.setPages(pagingUtil.getTotal() % pagingUtil.getPageSize() == 0 ? pagingUtil.getTotal() / pagingUtil.getPageSize() : pagingUtil.getTotal() / pagingUtil.getPageSize() + 1);
        //截取list
        pagingUtil.setList(list.subList(pagingUtil.getStar(), pagingUtil.getTotal() - pagingUtil.getStar() > pagingUtil.getPageSize() ? pagingUtil.getStar() + pagingUtil.getPageSize() : pagingUtil.getTotal()));
        return pagingUtil;
    }
}
