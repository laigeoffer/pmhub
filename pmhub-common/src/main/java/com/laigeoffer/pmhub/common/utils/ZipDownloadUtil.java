package com.laigeoffer.pmhub.common.utils;

import cn.hutool.core.io.FileUtil;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 文件打包下载
 * @author canghe
 */
public class ZipDownloadUtil {


    /**
     * 获取当前系统的临时目录
     */
    public static final String FILE_PATH = System.getProperty("java.io.tmpdir") + File.separator;

    private static final int ZIP_BUFFER_SIZE = 8192;

    /**
     * zip打包下载
     *
     * @param response
     * @param zipFileName
     * @param fileList
     */
    public static void zipDownload(HttpServletResponse response, String zipFileName, List<File> fileList) throws IOException {



        // zip文件路径
        String zipTmpFileName = zipFileName + "-" + UUID.randomUUID()+".zip";
        String zipPath = FILE_PATH + zipTmpFileName;

        // 如果只有一个文件，需要添加一个空文件放入压缩包
        if (fileList.size()==1){
            fileList.add(FileUtil.touch(FILE_PATH+"请不要批量下载单个文件"+ "-" + UUID.randomUUID()));
        }


        try {
            //创建zip输出流
            try (ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipPath))) {
                //声明文件集合用于存放文件
                byte[] buffer = new byte[1024];
                //将文件放入zip压缩包
                for (int i = 0; i < fileList.size(); i++) {

                    if (fileList.get(i).exists()){
                        File file = fileList.get(i);
                        try (FileInputStream fis = new FileInputStream(file)) {
                            out.putNextEntry(new ZipEntry(file.getName()));
                            int len;
                            // 读入需要下载的文件的内容，打包到zip文件
                            while ((len = fis.read(buffer)) > 0) {
                                out.write(buffer, 0, len);
                            }
                            out.closeEntry();
                        }
                    }

                }
            }
            //下载zip文件
            downFile(response, zipFileName,zipTmpFileName);
        } catch (Exception e) {
            throw e;
        } finally {
            // zip文件也删除
            // fileList.add(new File(zipPath));
            //  deleteFile(fileList);
        }
    }


    /**
     * 文件下载
     *
     * @param response
     * @param zipFileName
     */
    private static void downFile(HttpServletResponse response, String zipFileName,String zipTmpFileName) throws IOException {
        try {
            String path = FILE_PATH + zipTmpFileName;
            File file = new File(path);
            if (file.exists()) {
                try (InputStream ins = new FileInputStream(path);
                     BufferedInputStream bins = new BufferedInputStream(ins);
                     OutputStream outs = response.getOutputStream();
                     BufferedOutputStream bouts = new BufferedOutputStream(outs)) {
                    response.setContentType("application/x-download");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(zipFileName, "UTF-8"));
                    int bytesRead = 0;
                    byte[] buffer = new byte[ZIP_BUFFER_SIZE];
                    while ((bytesRead = bins.read(buffer, 0, ZIP_BUFFER_SIZE)) != -1) {
                        bouts.write(buffer, 0, bytesRead);
                    }
                    bouts.flush();
                }
            }
        } catch (Exception e) {
            throw e;
        }
    }

    /**
     * 删除文件
     *
     * @param fileList
     * @return
     */
    public static void deleteFile(List<File> fileList) {
        for (File file : fileList) {
            if (file.exists()) {
                file.delete();
            }
        }
    }

}
