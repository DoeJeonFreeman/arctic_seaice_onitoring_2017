package kr.go.seaice.arctic.main.web;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.go.seaice.arctic.timeseries.service.TimeSeriesChartService;
import kr.go.seaice.common.UpToDateStuffVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller 
public class ArcticIceMainNewController {

    @Autowired
    private TimeSeriesChartService timeseriesService;
    
    private static final String IMG_FCST_PATH_DISK = "/data/apphome/seaice/arcticData/IMG/FCST/";
    private static final String IMG_FCST_PATH_WEB = "/data/IMG/FCST/";
    private static final String FILE_NAME_OBS_EXT_PREFIX = "seaice_obs_ext_";
    private static final String FILE_NAME_DIFF_P_O_PREFIX = "seaice_diff_p_o_";
    private static final String FILE_NAME_PRE_EXT_PREFIX = "seaice_pre_ext_";
    private static final String FILE_NAME_LEAD_TIME_00_SUFFIX = "_00.png";
    private static final String FILE_NAME_LEAD_TIME_01_SUFFIX = "_01.png";
    private static final String FILE_NAME_LEAD_TIME_02_SUFFIX = "_02.png";
    private static final String FILE_NAME_LEAD_TIME_03_SUFFIX = "_03.png";
    private static final String FILE_NAME_LEAD_TIME_04_SUFFIX = "_04.png";
    private static final String FILE_NAME_TIMESERIES_DIFF_P_O_PREFIX = "seaice_diff_p_o_";
    private static final String FILE_NAME_TIMESERIES_DIFF_P_O_SUFFIX = "_ts.png";
    
    private static final SimpleDateFormat FORMAT_YYYYMM = new SimpleDateFormat("yyyyMM");
    
    @RequestMapping(value = "arctic/monthlyPredictionNew.do")
    public String getPredictiveIceModelNew(HttpServletRequest request, ModelMap model) throws Exception{
//        System.out.println("request method for ArcticIceMainNewController.getPredictiveIceModelNew");
        
        UpToDateStuffVO stuff =  timeseriesService.selectLatestStuff("02PRE");
        
        File path = new File(IMG_FCST_PATH_DISK);
        if (path.exists() && path.isDirectory()) {
            File[] list = path.listFiles();
            if (list != null) {
                List<String> filenameList = new ArrayList<String>();
                for (File file : list) {
                    if (file.getName().startsWith("seaice_pre_ext_ano_")) {
                        filenameList.add(file.getName());
                    }
                }
                
                if (filenameList.size() > 0) {
                    int lastDate = -999;
                    for (String filename : filenameList) {
                        String[] split = filename.split("_");
                        if (split.length == 5) {
                            String dateString = split[split.length-1];
                            dateString = dateString.replace(".png", "");
                            int dateInt = new Integer(dateString);
                            if (lastDate == -999 || lastDate < dateInt) {
                                lastDate = dateInt;
                            }
                        }
                    }
                    
                    if (lastDate != -999) {
                        stuff.setLateststuff(""+lastDate);
                    }
                }
            }
        }
        
        model.addAttribute("mostRecentStuff", stuff);
        return "arctic/ext_predictive_new";
    }
    
    @RequestMapping(value = "arctic/monthlyPredictionDiff.do")
    public String getPredictiveIceModelDiff(HttpServletRequest request, ModelMap model,
            @ModelAttribute("searchVo") UpToDateStuffVO searchCondtion,
            @RequestParam(value="interval", required=false) String interval) throws Exception{
//        System.out.println("request method for ArcticIceMainNewController.getPredictiveIceModelDiff");
//        System.out.println("[parameters]");
//        System.out.println("yyyyMM: " + searchCondtion.getLateststuff());
//        System.out.println("interval: " + interval);
        
        String searchYearMonth = searchCondtion.getLateststuff(); //검색년월
        UpToDateStuffVO mostRecentStuff = new UpToDateStuffVO();  //가장 최근 이미지 정보
        File path = new File(IMG_FCST_PATH_DISK);
        if (path.exists() && path.isDirectory()) {
            File[] list = path.listFiles();
            if (list != null) {
                List<String> filenameList = new ArrayList<String>();
                for (File file : list) {
                    if (file.getName().startsWith(FILE_NAME_DIFF_P_O_PREFIX)) {
                        filenameList.add(file.getName());
                    }
                }
                
                if (filenameList.size() > 0) {  //가장 최근 이미지 날짜 조회
                    int lastDate = -999;
                    for (String filename : filenameList) {
                        String[] split = filename.split("_");   // seaice_diff_o_p_201507_00.png
                        if (split.length == 6) {
                            String dateString = split[split.length-2];
                            dateString = dateString.replace(".png", "");
                            int dateInt = new Integer(dateString);
                            if (lastDate == -999 || lastDate < dateInt) {
                                lastDate = dateInt;
                            }
                        }
                    }
                    
                    if (lastDate != -999) {
                        mostRecentStuff.setLateststuff(""+lastDate);
                        if ("".equals(searchYearMonth) || searchYearMonth == null) {
                            searchYearMonth = mostRecentStuff.getLateststuff();
                            searchCondtion.setLateststuff(searchYearMonth); //검색년월
                        }
                    } else {
                        Calendar now = Calendar.getInstance();
                        mostRecentStuff.setLateststuff(FORMAT_YYYYMM.format(now.getTime()));
                        if ("".equals(searchYearMonth) || searchYearMonth == null) {
                            searchYearMonth = mostRecentStuff.getLateststuff();
                            searchCondtion.setLateststuff(searchYearMonth); //검색년월
                        }
                    }
                }
                
                if (!("".equals(searchYearMonth) || searchYearMonth == null)) {
                    String preExt01Path = IMG_FCST_PATH_DISK + FILE_NAME_PRE_EXT_PREFIX + searchYearMonth + FILE_NAME_LEAD_TIME_01_SUFFIX;  //전망+1월 이미지 디스크경로
                    String preExt02Path = IMG_FCST_PATH_DISK + FILE_NAME_PRE_EXT_PREFIX + searchYearMonth + FILE_NAME_LEAD_TIME_02_SUFFIX;  //전망+2월 이미지 디스크경로
                    String preExt03Path = IMG_FCST_PATH_DISK + FILE_NAME_PRE_EXT_PREFIX + searchYearMonth + FILE_NAME_LEAD_TIME_03_SUFFIX;  //전망+3월 이미지 디스크경로
                    String preExt04Path = IMG_FCST_PATH_DISK + FILE_NAME_PRE_EXT_PREFIX + searchYearMonth + FILE_NAME_LEAD_TIME_04_SUFFIX;  //전망+4월 이미지 디스크경로
                    
                    String diffOP01Path = IMG_FCST_PATH_DISK + FILE_NAME_DIFF_P_O_PREFIX + searchYearMonth + FILE_NAME_LEAD_TIME_01_SUFFIX; //차이+1월 이미지 디스크경로
                    String diffOP02Path = IMG_FCST_PATH_DISK + FILE_NAME_DIFF_P_O_PREFIX + searchYearMonth + FILE_NAME_LEAD_TIME_02_SUFFIX; //차이+2월 이미지 디스크경로
                    String diffOP03Path = IMG_FCST_PATH_DISK + FILE_NAME_DIFF_P_O_PREFIX + searchYearMonth + FILE_NAME_LEAD_TIME_03_SUFFIX; //차이+3월 이미지 디스크경로
                    String diffOP04Path = IMG_FCST_PATH_DISK + FILE_NAME_DIFF_P_O_PREFIX + searchYearMonth + FILE_NAME_LEAD_TIME_04_SUFFIX; //차이+4월 이미지 디스크경로
                    
                    String timeseriesDiffOPPath = IMG_FCST_PATH_DISK + FILE_NAME_TIMESERIES_DIFF_P_O_PREFIX + searchYearMonth + FILE_NAME_TIMESERIES_DIFF_P_O_SUFFIX; //시계열 이미지 디스크경로
                    
                    //관측 이미지 조회용 일자 변환
                    Date parseSearchYearMonth = FORMAT_YYYYMM.parse(searchYearMonth);
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(parseSearchYearMonth);
                    
                    calendar.add(Calendar.MONTH, 1);
                    String obsExt01Path = IMG_FCST_PATH_DISK + FILE_NAME_OBS_EXT_PREFIX + FORMAT_YYYYMM.format(calendar.getTime()) + FILE_NAME_LEAD_TIME_00_SUFFIX;   //관측+1월 이미지 디스크경로
                    
                    calendar.add(Calendar.MONTH, 1);
                    String obsExt02Path = IMG_FCST_PATH_DISK + FILE_NAME_OBS_EXT_PREFIX + FORMAT_YYYYMM.format(calendar.getTime()) + FILE_NAME_LEAD_TIME_00_SUFFIX;   //관측+2월 이미지 디스크경로
                    
                    calendar.add(Calendar.MONTH, 1);
                    String obsExt03Path = IMG_FCST_PATH_DISK + FILE_NAME_OBS_EXT_PREFIX + FORMAT_YYYYMM.format(calendar.getTime()) + FILE_NAME_LEAD_TIME_00_SUFFIX;   //관측+3월 이미지 디스크경로
                    
                    calendar.add(Calendar.MONTH, 1);
                    String obsExt04Path = IMG_FCST_PATH_DISK + FILE_NAME_OBS_EXT_PREFIX + FORMAT_YYYYMM.format(calendar.getTime()) + FILE_NAME_LEAD_TIME_00_SUFFIX;   //관측+4월 이미지 디스크경로
                    
                    File preExt01File = new File(preExt01Path);
                    if (preExt01File.exists()) {
                        model.addAttribute("preExt01WebPath", IMG_FCST_PATH_WEB + preExt01File.getName());  //전망+1월 이미지 웹경로
                        
                        File obsExt01File = new File(obsExt01Path);
                        if (obsExt01File.exists()) {
                            model.addAttribute("obsExt01WebPath", IMG_FCST_PATH_WEB + obsExt01File.getName()); //관측+1월 이미지 웹경로
                            
                            File diffOP01File = new File(diffOP01Path);
                            if (diffOP01File.exists()) {
                                model.addAttribute("diffOP01WebPath", IMG_FCST_PATH_WEB + diffOP01File.getName()); //차이+1월 이미지 웹경로
                            }
                            
                        }
                    }
                    
                    File preExt02File = new File(preExt02Path);
                    if (preExt02File.exists()) {
                        model.addAttribute("preExt02WebPath", IMG_FCST_PATH_WEB + preExt02File.getName());  //전망+2월 이미지 웹경로
                        
                        File obsExt02File = new File(obsExt02Path);
                        if (obsExt02File.exists()) {
                            model.addAttribute("obsExt02WebPath", IMG_FCST_PATH_WEB + obsExt02File.getName()); //관측+2월 이미지 웹경로
                            
                            File diffOP02File = new File(diffOP02Path);
                            if (diffOP02File.exists()) {
                                model.addAttribute("diffOP02WebPath", IMG_FCST_PATH_WEB + diffOP02File.getName()); //차이+2월 이미지 웹경로
                            }
                            
                        }
                    }
                    
                    File preExt03File = new File(preExt03Path);
                    if (preExt03File.exists()) {
                        model.addAttribute("preExt03WebPath", IMG_FCST_PATH_WEB + preExt03File.getName());  //전망+3월 이미지 웹경로
                        
                        File obsExt03File = new File(obsExt03Path);
                        if (obsExt03File.exists()) {
                            model.addAttribute("obsExt03WebPath", IMG_FCST_PATH_WEB + obsExt03File.getName()); //관측+3월 이미지 웹경로
                            
                            File diffOP03File = new File(diffOP03Path);
                            if (diffOP03File.exists()) {
                                model.addAttribute("diffOP03WebPath", IMG_FCST_PATH_WEB + diffOP03File.getName()); //차이+3월 이미지 웹경로
                            }
                            
                        }
                    }
                    
                    File preExt04File = new File(preExt04Path);
                    if (preExt04File.exists()) {
                        model.addAttribute("preExt04WebPath", IMG_FCST_PATH_WEB + preExt04File.getName());  //전망+4월 이미지 웹경로
                        
                        File obsExt04File = new File(obsExt04Path);
                        if (obsExt04File.exists()) {
                            model.addAttribute("obsExt04WebPath", IMG_FCST_PATH_WEB + obsExt04File.getName()); //관측+4월 이미지 웹경로
                            
                            File diffOP04File = new File(diffOP04Path);
                            if (diffOP04File.exists()) {
                                model.addAttribute("diffOP04WebPath", IMG_FCST_PATH_WEB + diffOP04File.getName()); //차이+4월 이미지 웹경로
                            }
                            
                        }
                    }
                    
                    File timeseriesDiffOPFile = new File(timeseriesDiffOPPath);
                    if (timeseriesDiffOPFile.exists()) {
                        model.addAttribute("timeseriesDiffOPWebPath", IMG_FCST_PATH_WEB + timeseriesDiffOPFile.getName()); //시계열 이미지 웹경로
                    }
                }
            }
        } else {
            Calendar now = Calendar.getInstance();
            mostRecentStuff.setLateststuff(FORMAT_YYYYMM.format(now.getTime()));
            if ("".equals(searchYearMonth) || searchYearMonth == null) {
                searchCondtion.setLateststuff(mostRecentStuff.getLateststuff()); //검색년월
            }
        }
        
        model.addAttribute("searchCondtion", searchCondtion);   // 검색 조건
        model.addAttribute("mostRecentStuff", mostRecentStuff); // 가장 최근 이미지 정보
        model.addAttribute("interval", ("".equals(interval) || interval == null) ? "MONTH" : interval); // 1개월 or 1년
        
        return "arctic/ext_predictive_diff";
    }
}
