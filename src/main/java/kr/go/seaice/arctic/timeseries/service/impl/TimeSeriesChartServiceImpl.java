package kr.go.seaice.arctic.timeseries.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import kr.go.seaice.arctic.timeseries.service.MostRecentStuffVO;
import kr.go.seaice.arctic.timeseries.service.TimeSeriesChartService;
import kr.go.seaice.arctic.timeseries.service.TimeSeriesDataVO;
import kr.go.seaice.common.UpToDateStuffVO;
import kr.go.seaice.mybatis.MostRecentStuffMapper;
import kr.go.seaice.mybatis.UpToDateStuffMapper;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * @author Administrator
 *
 */
@Service("chartService")
public class TimeSeriesChartServiceImpl  implements TimeSeriesChartService{

	
	@Autowired 
	UpToDateStuffMapper  latestStuffPicker;
	
	@Autowired 
	MostRecentStuffMapper  mostRecentStuffPicker;

	
	private static final SimpleDateFormat CAL_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	
	
	public UpToDateStuffVO selectLatestStuff(String id) throws Exception {
		return latestStuffPicker.seekLatestOne(id);
	}

	//WEEEKLY
	//WEEEKLY
	public MostRecentStuffVO retrievingIfArcticDataExists() throws Exception {
		return mostRecentStuffPicker.retrieveOneArcticData();
	}
	
	public MostRecentStuffVO findMatchingArcticData(String givenDateStr) throws Exception {
		String weekAgo = CAL_DATE_FORMAT.format(DateUtils.addDays(CAL_DATE_FORMAT.parse(givenDateStr), -6));
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("dateSelected", givenDateStr);
		hashmap.put("weekAgo", weekAgo);
		return mostRecentStuffPicker.retrieveMatchingArcticData(hashmap);
	}
	
	/* 
	 * @see kr.go.seaice.arctic.timeseries.service.TimeSeriesChartService#findMatchingArcticDataList(java.lang.String)
	 * sdist slide show 
	 */
	public List<MostRecentStuffVO> findMatchingArcticDataList(String givenDateStr) throws Exception {
		String beginDate = CAL_DATE_FORMAT.format(DateUtils.addMonths(CAL_DATE_FORMAT.parse(givenDateStr), -2));
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("dBegin", beginDate);
		hashmap.put("dEnd", givenDateStr);
		return mostRecentStuffPicker.retrieveMatchingArcticDataList(hashmap);
	}
	
	//monthly
	//monthly
	public MostRecentStuffVO retrievingIfArcticDataExists2() throws Exception {
		return mostRecentStuffPicker.retrieveOneArcticData_monthly();
	}
	
	//monthly
	//monthly
	public MostRecentStuffVO findMatchingArcticData2(String givenDateStr) throws Exception {
//		String weekAgo = CAL_DATE_FORMAT.format(DateUtils.addDays(CAL_DATE_FORMAT.parse(givenDateStr), -6));
		HashMap<String, String> hashmap = new HashMap<String, String>();
		givenDateStr = givenDateStr.substring(0,givenDateStr.lastIndexOf("-"))+"01";
		hashmap.put("dateSelected", givenDateStr);
//		hashmap.put("weekAgo", weekAgo);
		return mostRecentStuffPicker.retrieveMatchingArcticData_monthly(hashmap);
	}
	
	/* 
	 * @see kr.go.seaice.arctic.timeseries.service.TimeSeriesChartService#findMatchingArcticDataList(java.lang.String)
	 * sdist slide show 
	 */
	public List<MostRecentStuffVO> findMatchingArcticDataList2(String givenDateStr) throws Exception {
		givenDateStr = givenDateStr.substring(0,givenDateStr.lastIndexOf("-"))+"-01";
		String beginDate = CAL_DATE_FORMAT.format(DateUtils.addMonths(CAL_DATE_FORMAT.parse(givenDateStr), -9));
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("dBegin", beginDate);
		hashmap.put("dEnd", givenDateStr);
		return mostRecentStuffPicker.retrieveMatchingArcticDataList_monthly(hashmap);
	}
	
	
//	private DateUtil dateUtil;
	//doesnt need anymore
	//use apache commons-lang dateutils class instead
//	public void setDateUtil(DateUtil dateUtil) {
//		this.dateUtil = dateUtil;
//	}
	
	
	
	public void getExtentRoughnessGraphic() throws Exception {
		// TODO Auto-generated method stub
	}

	public TimeSeriesDataVO selectIceExtentSeries() throws Exception {
		return null;
	}

	public TimeSeriesDataVO selectIceTrendSeries() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public TimeSeriesDataVO selectTimeseriesAndSDistGraphic() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


}
