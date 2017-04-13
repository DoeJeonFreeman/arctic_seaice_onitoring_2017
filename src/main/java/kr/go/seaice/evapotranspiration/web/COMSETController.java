package kr.go.seaice.evapotranspiration.web;


import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.go.seaice.evapotranspiration.service.COMSETService;


@Controller
public class COMSETController {

	@Autowired
	private COMSETService evapoService;
	
	
	/** Monthly Mean NMSC Evapotranspiration */
	@RequestMapping(value = "et/coms/sdist.do")
	public String monthlyMeanEvapo(HttpServletRequest request, ModelMap model) throws Exception{
		return "coms/et_sdist";
	}
	
	/** Comparison of daily NMSC Evapotranspiration with MODIS data */
	@RequestMapping(value = "et/coms/modis.do")
	public String comparisonWithModisPET(HttpServletRequest request, ModelMap model) throws Exception{
		return "coms/et_modis";
	}
	
	/** Comparison of daily NIMR Evapotranspiration with Flux-Tower observation */
	@RequestMapping(value = "et/coms/obs.do")
	public String comparisonWithObservation(HttpServletRequest request, ModelMap model) throws Exception{
		return "coms/et_observation";
	}
	
	
	
	@RequestMapping(value = "ajax/et/coms/monthlyMeanNMSCEvapotranspiration")
	@ResponseBody
	public JSONObject getMostRecentStuff_ET(@RequestParam("dateFrom") String dFrom, @RequestParam("reqType") String reqType, HttpServletRequest request ){
		return evapoService.getMostRecentStuff(dFrom, reqType, request);
	}
		
		
	
	@RequestMapping(value = "ajax/et/coms/fluxtower_observation")
	@ResponseBody
	public JSONObject timeseriesJSONOutputter_fluxTower(@RequestParam("dateFrom") String dFrom, @RequestParam("reqType") String reqType, @RequestParam("whichsite") String idx_site, HttpServletRequest request ){
		return evapoService.getFluxTowerObservationData(dFrom, reqType, idx_site, request); 
	}
		
		
	@RequestMapping(value = "ajax/et/coms/comparison_with_modis")
	@ResponseBody
	public JSONObject timeseriesJSONOutputter_modis(@RequestParam("dateFrom") String dFrom, @RequestParam("reqType") String reqType,  HttpServletRequest request ){
		return evapoService.getModisPETData(dFrom, reqType, request);
	}
	


	
}
