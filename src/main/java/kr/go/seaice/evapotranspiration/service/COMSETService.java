package kr.go.seaice.evapotranspiration.service;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;

/**
 * 2C.DJFreeman
 * */
public interface COMSETService {
	
	/** 
	 * Monthly mean NMSC Evapotranspiration (spatial distribution) 
	 * */
	JSONObject getMostRecentStuff(String dFrom, String reqTypeStr, HttpServletRequest request ) ;
	
	/** 
	 * Comparison of daily NMSC Evapotranspiration with MODIS data 
	 * */
	JSONObject getFluxTowerObservationData(String dFrom, String reqTypeStr,String whichSite, HttpServletRequest request );
	
	/** 
	 * Comparison of daily NMSC Evapotranspiration with Flux-tower observation
	 * */
	JSONObject getModisPETData(String dFrom, String reqTypeStr, HttpServletRequest request ) ;
	
}



