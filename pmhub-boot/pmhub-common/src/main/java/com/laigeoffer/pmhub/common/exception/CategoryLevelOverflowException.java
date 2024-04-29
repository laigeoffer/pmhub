package com.laigeoffer.pmhub.common.exception;



/**
 * 物料类别超过最大允许的级数
 * @author canghe
 */
public class CategoryLevelOverflowException extends RuntimeException{

    private int errorCode = 510;

    public static final String message = "物料类别最大允许【%s】级分类，当前操作试图将物料类别设置为【%s】级";



    public CategoryLevelOverflowException(Integer maxLevel,Integer level){
        super(String.format(CategoryLevelOverflowException.message,maxLevel,level));
    }

}
