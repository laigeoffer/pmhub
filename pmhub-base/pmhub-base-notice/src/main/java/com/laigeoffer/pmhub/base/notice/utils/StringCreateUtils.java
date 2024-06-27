package com.laigeoffer.pmhub.base.notice.utils;

import java.util.List;

/**
 * 字符串拼接工具
 * @author canghe
 */
public class StringCreateUtils {

    /**
     * 将文本数组合并为一个用分隔符拼接的字符串
     * @param list 文本数组
     * @param flag 分隔符
     * @return 拼接的字符串
     * */
    public static String listStringCompose(List<String> list,String flag){
        StringBuilder str = new StringBuilder();
        for (int i=0;i<list.size();i++){
            if (i<list.size()-1){
                str.append(list.get(i)).append(flag);
            }else {
                str.append(list.get(i));
            }
        }
        return str.toString();
    }

}
