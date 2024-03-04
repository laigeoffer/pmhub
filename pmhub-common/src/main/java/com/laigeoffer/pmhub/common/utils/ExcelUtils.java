package com.laigeoffer.pmhub.common.utils;

import cn.hutool.core.util.IdUtil;
import cn.hutool.log.LogFactory;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.laigeoffer.pmhub.common.utils.file.FileUtils;
import org.apache.poi.ss.usermodel.*;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Excel工具
 * @author canghe
 */
public class ExcelUtils {

    /**
     * 导出excel
     * @param rows 需要导出的数据
     * @param response response
     * @param tempFileName 导出文件的模板名称
     * */
    public static void exportExcelRows(List<Map<String, Object>> rows, HttpServletResponse response, String tempFileName){
        // 生成临时文件
        String fileName = tempFileName + "-" + IdUtil.simpleUUID();
        String tmpExcelPath = createExcel(rows,System.getProperty("java.io.tmpdir"),tempFileName);
        if (tmpExcelPath == null){
            return;
        }

        // 文件输出
        try {
            FileUtils.setAttachmentResponseHeader(response, fileName);
            FileUtils.writeBytes(tmpExcelPath, response);
        }catch (IOException ex){
            LogFactory.get().error(ex);
            throw new RuntimeException("文件导出失败！");
        }

        FileUtils.deleteFile(tmpExcelPath);
    }

    public static String createExcel(List<Map<String, Object>> rows,String path,String fileName){
        String excelPath = path + File.separator + fileName+".xlsx";
        ExcelWriter writer =  ExcelUtil.getWriter(excelPath);
        // 合并单元格后的标题行，使用默认标题样式
        if (rows.isEmpty()){
            return null;
        }
        writer.merge(rows.get(0).size()-1, fileName);
        writer.write(rows, true);
        // 关闭writer，释放内存
        writer.close();
        return excelPath;
    }

    /**
     * 导出excel
     * @param rows 需要导出的数据
     * @param response response
     * @param tempFileName 导出文件的模板名称
     * */
    public static void exportMaterialsChangeRows(List<Map<String, Object>> rows, HttpServletResponse response, String tempFileName){
        // 生成临时文件
        String fileName = tempFileName + "-" + IdUtil.simpleUUID()+".xlsx";
        String tmpExcelPath = System.getProperty("java.io.tmpdir") + File.separator + fileName;
        ExcelWriter writer =  ExcelUtil.getWriter(tmpExcelPath);
        writer.setDefaultRowHeight(44);
        writer.setColumnWidth(0, 20);
        writer.setColumnWidth(1, 20);
        writer.setColumnWidth(2, 20);
        writer.setColumnWidth(3, 20);
        writer.setColumnWidth(4, 20);
        writer.setColumnWidth(5, 25);
        writer.setColumnWidth(6, 20);
        writer.setColumnWidth(7, 20);
        writer.setColumnWidth(8, 25);
        writer.setColumnWidth(9, 16);
        writer.setColumnWidth(10, 16);
        writer.setColumnWidth(11, 16);
        writer.setColumnWidth(12, 16);
        writer.setColumnWidth(13, 16);
        writer.setColumnWidth(14, 25);
        writer.setColumnWidth(15, 16);
        // 合并单元格后的标题行，使用默认标题样式
        if (rows.size() == 0) {
            return;
        }
        // 在最后一行添加自定义数据
        writer.writeCellValue(0, rows.size() + 3, "保管人");
        writer.writeCellValue(8, rows.size() + 3, "采购/接收人");
        writer.merge(rows.get(0).size() - 1, tempFileName);

        // 获取Workbook对象
        Workbook workbook = writer.getWorkbook();
        DataFormat dataFormat = writer.getWorkbook().createDataFormat();
        CellStyle cellStyle2 = writer.getStyleSet().getCellStyleForDate();
        short format2 = dataFormat.getFormat("yyyy-MM-dd");
        cellStyle2.setDataFormat(format2);
        writer.setStyle(cellStyle2,0, 1);
        // 获取默认单元格样式
        org.apache.poi.ss.usermodel.CellStyle cellStyle = workbook.createCellStyle();
        // 设置边框样式为无边框
        cellStyle.setBorderBottom(BorderStyle.NONE);
        cellStyle.setBorderTop(BorderStyle.NONE);
        cellStyle.setBorderLeft(BorderStyle.NONE);
        cellStyle.setBorderRight(BorderStyle.NONE);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);

        // 设置单元格样式为无边框样式
        writer.setStyle(cellStyle, 0, rows.size() + 3);
        writer.setStyle(cellStyle, 8, rows.size() + 3);

        writer.write(rows, true);
        // 关闭writer，释放内存
        writer.close();
        // 文件输出
        try {
            FileUtils.setAttachmentResponseHeader(response, fileName);
            FileUtils.writeBytes(tmpExcelPath, response);
        }catch (IOException ex){
            LogFactory.get().error(ex);
            throw new RuntimeException("文件导出失败！");
        }
        FileUtils.deleteFile(tmpExcelPath);
    }
}
