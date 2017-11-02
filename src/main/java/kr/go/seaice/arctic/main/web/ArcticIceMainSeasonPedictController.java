package kr.go.seaice.arctic.main.web;

import java.io.File;
import java.io.FileFilter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller 
public class ArcticIceMainSeasonPedictController {

    private static final String IMG_FCST_PATH_DISK = "/data/apphome/seaice/arcticData/IMG/FCST/GS5/";
    private static final String IMG_FCST_PATH_WEB = "/data/IMG/FCST/GS5/";
    private static final String FILE_NAME_MONTHY_PREFIX = "gs5";
    private static final String FILE_NAME_TIMESERIES_PREFIX = FILE_NAME_MONTHY_PREFIX + ".ts";
    private static final String FILE_NAME_VARIALBE_MSLP_INFIX = ".mslp";
    private static final String FILE_NAME_VARIALBE_T15M_INFIX = ".t15m";
    private static final String FILE_NAME_VARIALBE_TSFC_INFIX = ".tsfc";
    private static final String FILE_NAME_VARIALBE_WIND_INFIX = ".wind";
    private static final String FILE_NAME_TIMESERIES_SEAAREA_BRNT_INFIX = ".BRNT";
    private static final String FILE_NAME_TIMESERIES_SEAAREA_KARA_INFIX = ".KARA";
    private static final String FILE_NAME_TIMESERIES_SEAAREA_LPTV_INFIX = ".LPTV";
    private static final String FILE_NAME_TIMESERIES_SEAAREA_ESBR_INFIX = ".ESBR";
    private static final String FILE_NAME_TIMESERIES_SEAAREA_CHKC_INFIX = ".CHKC";
    private static final String FILE_NAME_TIMESERIES_SEAAREA_BRNG_INFIX = ".BRNG";
    private static final String FILE_NAME_MONTHY_M01_INFIX = ".m01";
    private static final String FILE_NAME_MONTHY_M02_INFIX = ".m02";
    private static final String FILE_NAME_MONTHY_M03_INFIX = ".m03";
    private static final String FILE_NAME_SUFFIX = ".png";
    
    private static final String[] FILE_NAME_VARIALBE_INFIX = {
        FILE_NAME_VARIALBE_MSLP_INFIX,
        FILE_NAME_VARIALBE_T15M_INFIX,
        FILE_NAME_VARIALBE_TSFC_INFIX,
        FILE_NAME_VARIALBE_WIND_INFIX
    };
    
    private static final String[] FILE_NAME_TIMESERIES_SEAAREA_INFIX = {
        FILE_NAME_TIMESERIES_SEAAREA_BRNT_INFIX,
        FILE_NAME_TIMESERIES_SEAAREA_KARA_INFIX,
        FILE_NAME_TIMESERIES_SEAAREA_LPTV_INFIX,
        FILE_NAME_TIMESERIES_SEAAREA_ESBR_INFIX,
        FILE_NAME_TIMESERIES_SEAAREA_CHKC_INFIX,
        FILE_NAME_TIMESERIES_SEAAREA_BRNG_INFIX
    };
    
    private static final String[] FILE_NAME_MONTHY_INFIX = {
        FILE_NAME_MONTHY_M01_INFIX,
        FILE_NAME_MONTHY_M02_INFIX,
        FILE_NAME_MONTHY_M03_INFIX
    };
    
    private static final SimpleDateFormat FORMAT_YYYYMMDD = new SimpleDateFormat("yyyyMMdd");
    
    @RequestMapping(value = "arctic/monthlyPredictionMap.do")
    public String getPredictiveIceModelMap(HttpServletRequest request, ModelMap model,
            @RequestParam(value="searchDate", required=false) String searchDate) throws Exception{
//        System.out.println("request method for ArcticIceMainNewController.getPredictiveIceModelMap");
//        System.out.println(searchDate);
        
        String imageFileNamePrefix = FILE_NAME_MONTHY_PREFIX + FILE_NAME_VARIALBE_MSLP_INFIX + ".arctic.";
        String imageFileNameSuffix  = FILE_NAME_MONTHY_M01_INFIX + FILE_NAME_SUFFIX;
        String recentDate = getLastFileDate(IMG_FCST_PATH_DISK, imageFileNamePrefix, imageFileNameSuffix); // gs5.mslp.arctic.20161024.m01.png
        
        if ("".equals(recentDate) || recentDate == null || recentDate.length() != 8) {
            Calendar now = Calendar.getInstance();
            int mondayOfWeek = 2;
            int dayOfWeek = now.get(Calendar.DAY_OF_WEEK);
            now.add(Calendar.DATE, -(dayOfWeek-mondayOfWeek));  //월요일로 설정
            recentDate = FORMAT_YYYYMMDD.format(now.getTime());
        }
        
        recentDate = recentDate.substring(0, 4) + "-" + recentDate.substring(4, 6) + "-" + recentDate.substring(6, 8);
        
        if ("".equals(searchDate) || searchDate == null) {
            searchDate = recentDate;
        }
        String yyyyMMdd = searchDate.replace("-", "");
        
        //지도 이미지 검색
        for (int idxVar = 0; idxVar < FILE_NAME_VARIALBE_INFIX.length; idxVar++) {
            for (int idxMon = 0; idxMon < FILE_NAME_MONTHY_INFIX.length; idxMon++) {
                // /data/apphome/seaice/arcticData/IMG/FCST/GS5/gs5.mslp.arctic.20161024.m01.png
                String imagePath = IMG_FCST_PATH_DISK + FILE_NAME_MONTHY_PREFIX + FILE_NAME_VARIALBE_INFIX[idxVar] + ".arctic." + yyyyMMdd + FILE_NAME_MONTHY_INFIX[idxMon] + FILE_NAME_SUFFIX;
                File imageFile = new File(imagePath);
                // webPath_mslp_m01
                String modelName = "webPath" + FILE_NAME_VARIALBE_INFIX[idxVar].replace(".", "_") + FILE_NAME_MONTHY_INFIX[idxMon].replace(".", "_");
                if (imageFile.exists()) {
                    model.addAttribute(modelName, IMG_FCST_PATH_WEB + imageFile.getName());
                } else {
//                    System.out.println("no image: " + imagePath);
                    //model.addAttribute(modelName, "");    //noImage
                }
            }
        }
        
        //시계열 이미지 검색
        for (int idxArea = 0; idxArea < FILE_NAME_TIMESERIES_SEAAREA_INFIX.length; idxArea++) {
            for (int idxVar = 0; idxVar < FILE_NAME_VARIALBE_INFIX.length; idxVar++) {
                // /data/apphome/seaice/arcticData/IMG/FCST/GS5/gs5.ts.mslp.BRNT.20161024.png
                String imagePath = IMG_FCST_PATH_DISK + FILE_NAME_TIMESERIES_PREFIX + FILE_NAME_VARIALBE_INFIX[idxVar] + FILE_NAME_TIMESERIES_SEAAREA_INFIX[idxArea] + "." + yyyyMMdd + FILE_NAME_SUFFIX;
                File imageFile = new File(imagePath);
                // webPath_ts_BRNT_mslp
                String modelName = "webPath_ts" + FILE_NAME_TIMESERIES_SEAAREA_INFIX[idxArea].replace(".", "_") + FILE_NAME_VARIALBE_INFIX[idxVar].replace(".", "_");
                if (imageFile.exists()) {
                    model.addAttribute(modelName, IMG_FCST_PATH_WEB + imageFile.getName());
                } else {
//                    System.out.println("no image: " + imagePath);
                    //model.addAttribute(modelName, "");    //noImage
                }
            }
        }
        
        model.addAttribute("recentDate", recentDate);
        model.addAttribute("searchDate", searchDate);
        model.addAttribute("imageDate", yyyyMMdd);
        
        return "arctic/ext_predictive_map";
    }

    /**
     * 해당 디렉토리 내에서 가장 최신의 파일명의 날짜문자열을 반환
     * @param dir
     * @param prefix
     * @param suffix
     * @return
     */
    private String getLastFileDate(String dir, String prefix, String suffix) {
        File targetPath = new File(dir);
        if (!targetPath.exists()) {
            System.err.println("Not directory or file: " + dir);
            return null;
        }
        
        File[] files = targetPath.listFiles(new FileFilter() {
            public boolean accept(File file) {
                return file.isFile();
            }
        });
        
        if (files == null || files.length == 0) {
            System.err.println("Empty directory: " + dir);
            return null;
        }
        
        List<String> fileNameList = new ArrayList<String>();
        for (File file : files) {
            fileNameList.add(file.getName());
        }
        
        if (fileNameList.size() == 0) {
            System.err.println("Empty year directory: " + dir);
            return null;
        }
        
        Collections.sort(fileNameList, new Comparator<String>(){
            public int compare(String fileName1, String fileName2) {
                return fileName2.compareToIgnoreCase(fileName1);
            }
        });
        
        for (String fileName : fileNameList) {
            if (fileName.indexOf(prefix) > -1 && fileName.indexOf(suffix) > 0) {
                return fileName.substring(prefix.length(), fileName.indexOf(suffix));
            }
        }
        
        System.err.println("Not found lastFileDate in directory: " + dir);
        System.err.println("file prefix: " + prefix);
        System.err.println("file suffix: " + suffix);
        return null;
    }
}
