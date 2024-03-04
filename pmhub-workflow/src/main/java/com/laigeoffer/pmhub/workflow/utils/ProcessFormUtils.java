package com.laigeoffer.pmhub.workflow.utils;

import cn.hutool.core.convert.Convert;
import com.laigeoffer.pmhub.workflow.core.FormConf;

import java.util.List;
import java.util.Map;

/**
 * 流程表单工具类
 *
 * @author canghe
 * @createTime 2022/8/7 17:09
 */
public class ProcessFormUtils {

    private static final String CONFIG = "__config__";
    private static final String MODEL = "__vModel__";

    /**
     * 填充表单项内容
     *
     * @param formConf 表单配置信息
     * @param data 表单内容
     */
    public static void fillFormData(FormConf formConf, Map<String, Object> data) {
        for (Map<String, Object> field : formConf.getFields()) {
            recursiveFillField(field, data);
        }
    }

    @SuppressWarnings("unchecked")
    private static void recursiveFillField(final Map<String, Object> field, final Map<String, Object> data) {
        if (!field.containsKey(CONFIG)) {
            return;
        }
        Map<String, Object> configMap = (Map<String, Object>) field.get(CONFIG);
        if (configMap.containsKey("children")) {
            List<Map<String, Object>> childrens = (List<Map<String, Object>>) configMap.get("children");
            for (Map<String, Object> children : childrens) {
                recursiveFillField(children, data);
            }
        }
        String modelKey = Convert.toStr(field.get(MODEL));
        Object value = data.get(modelKey);
        if (value != null) {
            configMap.put("defaultValue", value);
        }
    }
}
