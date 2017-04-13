package kr.go.seaice.evapotranspiration.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import kr.go.seaice.evapotranspiration.service.COMSETService;


/**
 * @author Administrator
 *
 */
@Service("evapoService")
public class COMSETServiceImpl  implements COMSETService{

	private static final SimpleDateFormat CAL_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	
	public JSONObject getMostRecentStuff(String dFrom, String reqTypeStr, HttpServletRequest request )  {
		JSONObject jsonObj = new JSONObject();
		
		if(reqTypeStr.toUpperCase().equals("ET_SDIST")){
			String str_repos = request.getSession().getServletContext().getRealPath("/") +  "DAGR/et/COMS_OUT"; //java 1.5
			
			if(dFrom.toUpperCase().equals("INIT")){
				File repos_modis = new File(str_repos);
				File[] fileList = repos_modis.listFiles();
				Arrays.sort(fileList);
				Pattern p = Pattern.compile("\\d{6,8}");
				File lastOne = fileList[fileList.length-1];
				String d = lastOne.getName();
				Matcher m = p.matcher(d);
				while (m.find()) {
					dFrom = m.group(0);
				}	
				jsonObj.put("latestStuff", dFrom);
			}
		}
		return jsonObj;
	}
	

	public JSONObject getFluxTowerObservationData(String dFrom, String reqTypeStr, String whichSite, HttpServletRequest request )  {
		JSONObject json_subtracted = new JSONObject();
		
		if(reqTypeStr.toUpperCase().equals("ET_FLUXTOWEROBSERVATION")){
			String obsSiteName  = "";
			if(whichSite.equals("undefined") || Integer.parseInt(whichSite)==0){
				obsSiteName = "cfk.json";
			}else if(Integer.parseInt(whichSite)==1){
				obsSiteName = "smk.json";
			}
			
			String retrieveRange = (String)request.getParameter("retrieverange");
			if(retrieveRange.equals("undefined")){
				retrieveRange = "1";
			}
			String file2Parse = request.getSession().getServletContext().getRealPath("/") + "DAGR/et/" + obsSiteName;
			json_subtracted = getObsTimeseries(file2Parse, dFrom, retrieveRange, true);
		}
		
		return json_subtracted;
		
		
	}

	public JSONObject getModisPETData(String dFrom, String reqTypeStr, HttpServletRequest request )  {
		
		JSONObject json_subtracted = new JSONObject();
		
		if(reqTypeStr.toUpperCase().equals("ET_MODIS")){
			if(dFrom.toUpperCase().equals("INIT")){
				File repos_modis = new File(request.getSession().getServletContext().getRealPath("/") + "DAGR/et/with_MODIS/month/stn_korea_all");
				File[] fileList = repos_modis.listFiles();
				Arrays.sort(fileList);
				Pattern p = Pattern.compile("\\d+");
				File lastOne = fileList[fileList.length-1];
				String d = lastOne.getName();
				Matcher m = p.matcher(d);
				while (m.find()) {
					dFrom = m.group(0);
				}	
				json_subtracted.put("latestStuff", dFrom);
			}
			String file2Parse = request.getSession().getServletContext().getRealPath("/") + "DAGR/et/with_MODIS/month/stn_GTS/ETcoms_ETmodis_avg_" + dFrom + "_stn_GTS_point.txt";
			json_subtracted.put("modis_easia",getMODISComparison(file2Parse, dFrom));
			file2Parse = request.getSession().getServletContext().getRealPath("/") + "DAGR/et/with_MODIS/month/stn_korea_all/ETcoms_ETmodis_avg_" + dFrom + "_stn_korea_all_point.txt";
			json_subtracted.put("modis_korea", getMODISComparison(file2Parse, dFrom));
		}
		
		return json_subtracted;
	}

	
	
	public JSONObject getObsTimeseries(String filePath, String dateFrom,  String retrieveRange, boolean needVerificationData){
		JSONObject json_subtracted = new JSONObject();
		FileReader reader = null;
		//RMSE, Bias, Number of observation
		int nObservation = 0;
		double sum_diff = 0;
		double sumPow = 0;
		
		String mv_Bias = "";
		String mv_RMSE = "";
		
		try {
			// read the json file
			reader = new FileReader(filePath);

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(reader);
			JSONArray arr= (JSONArray) jsonObject.get("timeseries");
			
			if(dateFrom.toUpperCase().equals("INIT")){
				JSONObject lastOne = (JSONObject) arr.get(arr.size()-1); 
				dateFrom = lastOne.get("date").toString().replace(",", "");
				json_subtracted.put("latestStuff",dateFrom );
			}
			//now selected
			int dateActual = Integer.parseInt(dateFrom); 
			int dateTarget = getRetrievalInterval(dateFrom, Integer.parseInt(retrieveRange)  , getProperDateFormat(dateFrom, false) ); //addDelimeter~ returns yyyyMMdd 
			json_subtracted.put("dateActual", addDelimeterIntoDateStr(dateActual+"",true));
			json_subtracted.put("dateTarget", addDelimeterIntoDateStr(dateTarget+"",true));
			//subtracting matched values from arr..
			//and store the result into arr_partial..
			JSONArray arr_partial = new JSONArray();
			
//			// take each value from the json array separately
			Iterator iter = arr.iterator();
			while (iter.hasNext()) {
				JSONObject innerObj = (JSONObject) iter.next();
				int currDate = Integer.parseInt(innerObj.get("date").toString().replace(",", ""));
				if(dateTarget<=currDate && currDate <= dateActual){
					arr_partial.add(innerObj);
					if(needVerificationData){
						String fluxTower = ( innerObj.get("fluxMax") !=null)?  innerObj.get("fluxMax").toString() : null;
						String nimrET =     (innerObj.get("nimrET") != null)?  innerObj.get("nimrET").toString() : null;
						if(nimrET != null && fluxTower != null){
							double diff = Double.parseDouble(fluxTower) - Double.parseDouble(nimrET); 
							sum_diff += diff;
							sumPow = Math.pow(diff, 2);
							nObservation ++;
						}
					}
				}
			}
			
			if(needVerificationData){
				DecimalFormat df =  new DecimalFormat("0.###");
				mv_Bias = df.format(round3f(sum_diff / nObservation));
				mv_RMSE = df.format(round3f(Math.sqrt(sumPow / nObservation)));
				json_subtracted.put("Bias",mv_Bias);
				json_subtracted.put("RMSE",mv_RMSE);
				json_subtracted.put("Nobs",nObservation);
			}
			json_subtracted.put("someList", arr_partial);
		} catch (FileNotFoundException ex) {
			ex.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		} catch (ParseException ex) {
			ex.printStackTrace();
		} catch (NullPointerException ex) {
			ex.printStackTrace();
		}finally{
	            try {
	          	  if(reader !=null)reader.close();
		            } catch (IOException e) {
		                e.printStackTrace();
		            }
		        }
		return json_subtracted;
		//return haha
	}
	

	private double round3f(double val){
		return Math.round(val * 1000d ) / 1000d;
	}
	
	
	public JSONObject getMODISComparison(String filePath, String dateFrom){
		//RMSE, Bias, Number of observation
		JSONObject json_subtracted = new JSONObject();
		BufferedReader reader = null;
		
		//RMSE, Bias, Number of observation
		int nObservation = 0;
		double sum_diff = 0;
		double sumPow = 0;
		
		String mv_Bias = "";
		String mv_RMSE = "";
		
		JSONArray matchupData = new JSONArray();

		try {
			String line = "";
			reader = new BufferedReader(new FileReader(filePath));
			while ((line = reader.readLine()) != null) {
				
				line = line.replaceAll("^\\s+", "");
				line = line.replaceAll("\\s+$", "");
				
				String [] tokens  = line.split("\\s+");
				if(tokens.length < 6) continue; 
				
				 if(!isNumeric(tokens[3]) || !isNumeric(tokens[5])){ //   !!!! isNumeric 
					continue;
				 }else if(Double.isNaN(Double.parseDouble(tokens[3])) || Double.isNaN(Double.parseDouble(tokens[5]))){  
					 continue;
				}else if(Double.parseDouble(tokens[3])==0|| Double.parseDouble(tokens[5])==0){  
					continue;
				}else if(Double.parseDouble(tokens[3]) < 0 || Double.parseDouble(tokens[3]) > 10){
					continue;
				}else if(Double.parseDouble(tokens[5]) < 0 || Double.parseDouble(tokens[5]) > 10){
					continue;
				}
				 	
				 double COMS_ET = Double.parseDouble(tokens[3]);
				 double MODIS_PET = Double.parseDouble(tokens[5]);
				
				JSONObject innerObj = new JSONObject();
				innerObj.put("et_nimr", COMS_ET);
				innerObj.put("pet_modis", MODIS_PET);
				matchupData.add(innerObj);
				
				sum_diff += COMS_ET - MODIS_PET;
				sumPow += Math.pow(COMS_ET-MODIS_PET, 2);
				nObservation ++;
			}
			DecimalFormat df =  new DecimalFormat("0.###");
//			df.setRoundingMode(RoundingMode.HALF_UP);
			mv_Bias = df.format(round3f(sum_diff / nObservation));
			mv_RMSE = df.format(round3f(Math.sqrt(sumPow / nObservation)));
			json_subtracted.put("matchupData", matchupData);
			json_subtracted.put("Bias",mv_Bias);
			json_subtracted.put("RMSE",mv_RMSE);
			json_subtracted.put("Nobs",nObservation);
			json_subtracted.put("dateActual", addDelimeterIntoDateStr(dateFrom+"",true));
		} catch (FileNotFoundException ex) {
			ex.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		} catch (NullPointerException ex) {
			ex.printStackTrace();
		}finally{
			try {
				if(reader !=null)reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return json_subtracted;
	}	
	
	
	public boolean isNumeric(String str)  {  
		  try  {  
		    double d = Double.parseDouble(str);  
		  } catch(NumberFormatException nfe)  {  
		    return false;  
		  }  
		  return true;  
	}

	public String getProperDateFormat(String dateStr, boolean addDelimeter){
		String dFormat = "";
		if(dateStr.length()==6){
			dFormat = (addDelimeter)? "yyyy.MM." : "yyyyMM";
		}else if(dateStr.length()==8){
			dFormat = (addDelimeter)? "yyyy.MM.dd." : "yyyyMMdd";
		}else if(dateStr.length()==12){
			dFormat = (addDelimeter)? "yyyy.MM.dd. HH:mm" : "yyyyMMddHHmm";
		}
		return dFormat;
	}
	
	
	
	public String addDelimeterIntoDateStr(String dateStr, boolean addDelimeter){
		String formattedDate = "";
		try {
			Date d = new SimpleDateFormat(getProperDateFormat(dateStr, false)).parse(dateStr);
			formattedDate = new SimpleDateFormat(getProperDateFormat(dateStr,true)).format(d);
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		return formattedDate;
	}

	public int getRetrievalInterval(String dateFrom, String formatStr){
		String formattedDate = "";
		try {
			Date d = new SimpleDateFormat(formatStr).parse(dateFrom);
			Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(d.getTime());
			calendar.add(Calendar.MONTH , -1);

			Date dateTo = new Date(calendar.getTimeInMillis());
			formattedDate = new SimpleDateFormat(formatStr).format(dateTo);
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		return Integer.parseInt(formattedDate);
	}
	
	
	public int getRetrievalInterval(String dateFrom, int months, String formatStr){
		String formattedDate = "";
		try {
			Date d = new SimpleDateFormat(formatStr).parse(dateFrom);
			Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(d.getTime());
			calendar.add(Calendar.MONTH , -months);
			
			Date dateTo = new Date(calendar.getTimeInMillis());
			formattedDate = new SimpleDateFormat(formatStr).format(dateTo);
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		return Integer.parseInt(formattedDate);
	}

	
}
