<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
<title>COMS Evapotranspiration</title>

	<script src="<c:url value="/js/jquery/jquery-1.9.1.js"/>"></script>	
	<script src="<c:url value="/js/jquery/ui/jquery-ui-1111.js"/>"></script>
	<link rel="stylesheet" href="<c:url value="/js/jquery/ui/themes/smoothness/jquery-ui.css"/>">

	<!-- 2c.doe.layout -->
	    <link href="<c:url value="/mestrap/css/COMS_ET/normalize.css"/>" rel="stylesheet">


	<!-- 2c.doe.hicharts -->
	<script src="<c:url value="/js/highchart_DEPRECATED/highcharts.js"/>"></script>
	<script src="<c:url value="/js/highchart_DEPRECATED/highcharts-more.js"/>"></script>
	<script src="<c:url value="/js/highchart_DEPRECATED/modules/exporting.js"/>"></script>

    <!-- dateJS -->
	<script type="text/javascript" src="<c:url value="/js/jquery/date.js"/>"></script>
 
<script>
$(function () {
	
		 //bat tini
	    $('#tabs-nohdr').tabs({
	        activate: function(event, ui){
//	        	 console.log(ui.newTab.index());
				var range = $('#dataRangeChooser').find(":selected").val()+'';
		        requestData( $("#datepicker").val().split('-').join(''),  range, ui.newTab.index());
	        }
	    });
	
	  $("#topNavi").find("#datepicker").datepicker({
			 inline: true,
					//nextText: '&rarr;',
					//prevText: '&larr;',
					showOtherMonths: true,
					//dateFormat: 'dd MM yy',
					dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
					dateFormat: 'yy-mm-dd',
					//showOn: "button",
					//buttonImage: "img/calendar-blue.png",
					//buttonImageOnly: true,
				  	//showMonthAfterYear: true,
				  	onSelect:function(selected,event){
				  		udpateDateHandler(selected);
				  	}
			});
	  
		// Toggle data labels
	    $('#dataRangeChooser').change(function () {
	    	
	    	var dataSelected = $("#datepicker").val().split('-').join('');
			var $tabs = $('#tabs-nohdr').tabs();
			var activeIdx = $tabs.tabs('option', 'active');
			var rangeSelected  = $('#dataRangeChooser').find(":selected").val()+'';
			requestData(dataSelected,  rangeSelected, activeIdx);
	    	
			rangeSelected  =  rangeSelected*1;
			
	    	var rad2redraw = 3;
			if(rangeSelected == 1){
				rad2redraw = 3;
			}else if(rangeSelected == 3){
				rad2redraw = 2;
			}else if(rangeSelected == 6){
				rad2redraw = 1;
			}else if(rangeSelected == 12){
				rad2redraw = 1;
			}
	    	
	    	var _meteorological = $('#meteorological').highcharts();	
	    	var mSeries = _meteorological.series;
	    	
	    	if(rangeSelected == 1 || rangeSelected == 3){
		    	for(var i=1; i<mSeries.length; i++){
			    	_meteorological.series[i].update({
			            marker: {
			            	radius : rad2redraw,
			            	enabled:true
			            }
			        });
		    	}
	    	}else{
		    	for(var i=1; i<mSeries.length; i++){
			    	_meteorological.series[i].update({
			            marker: {
				            enabled:false
			            }
			        });
		    	}
	    	}
	    	
	    	var _fluxtower = $('#fluxtower').highcharts();	
	    	var fSeries = _fluxtower.series;
	    	for(var i=1; i<fSeries.length; i++){
	    		_fluxtower.series[i].update({
		            marker: {
		            	radius : rad2redraw+1,
		            }
		        });
	    	}
			
	    });
	  
});
</script>

<script>
	var chart_fluxTower;
	var chart_meteorological;

	$(document).ready(
				function() {
					chart_fluxTower = new Highcharts.Chart({
						
							chart : {
				  backgroundColor: "rgba(255, 255, 255, 0)",
				    plotBackgroundColor: "rgba(255, 255, 255, 0)",
								type : 'scatter',
								renderTo : 'fluxtower',  				events:{load:requestData('init')},
								defaultSeriesType : 'line',
								plotBorderWidth : 1,
								plotBorderColor : 'black',
								animation:false,
								zoomType : 'xy',
								//margin: [0, 0, 0, 0]
								marginLeft : 60,
								marginRight : 60,
								style: {
				                	fontFamily: 'NanumGothic'
				            	}
							},
							plotOptions : {
								animation:false,
								series : {
									animation:false,
									lineWidth : 1,
									marker : {
										symbol : 'circle',
										radius : 4
									}
								}
							},
							title : {
								text : 'KoFlux Cheongmicheon Farmland site (청미천), Rice Paddy, 위치 (38.51°N, 127.65°E)',
								align : 'left',
								style : {
									/* font: 'bold 16px "Trebuchet MS", Verdana, sans-serif' */
										font: 'bold 14px NanumGothic',
									//fontSize : '14px'
								}
							},
							xAxis : {
								type : 'datetime',
								labels : {
									formatter : function() {
										var myDate = new Date(this.value);
										var newDateMs = Date.UTC(myDate.getUTCFullYear(), myDate.getUTCMonth() , myDate.getUTCDate());
										return Highcharts.dateFormat('%e. %b',newDateMs);
									}
								},
								lineColor : 'black',
								lineWidth : 1,
								gridLineWidth : 1
							},
							yAxis : [
								{ // Primary yAxis evapo.!!!!
								labels : {
									style : {
										color : '#000000'
									}
								},
								title : {
									text : 'Evapotranspiration (mm/Day)',
									style : {
										color : '#000000'
									}
								},
								min : -5,
								max : 15,
								tickInterval : 5,
								gridLineWidth : 1
							},
								{ // secondary  yAxis evapo.!!!!
								labels : {
									style : {
										color : '#000000'
									}
								},
								title : {
									text : 'Evapotranspiration (mm/Day)',
									style : {
										color : '#000000'
									}
								},
								min : -5,
								max : 15,
								tickInterval : 5,
								opposite : true,
								gridLineWidth : 1
							}],
							plotOptions : {
								scatter : {
									marker : {
										radius : 4,
										states : {
											hover : {
												enabled : true,
												lineColor : '#0c66a4'
											}
										}
									},
									states : {
										hover : {
											marker : {
												enabled : false
											}
										}
									},
									tooltip : {
										headerFormat : '<b>{series.name}</b><br>',
										pointFormat : '{point.x} °C  /  {point.y} °C'
									}
								}
							},
							/**
							//top-right
							legend: {
				                align: 'right',
				                verticalAlign: 'top',
				                y: 5,
				                floating: true,
				                borderWidth: 0
				            },
				            //border~
				            legend: {
				                layout: 'vertical',
				                align: 'left',
				                verticalAlign: 'top',
				                x: 150,
				                y: 100,
				                floating: true,
				                borderWidth: 1,
				                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
				            },
				            
				            
							*/
							tooltip : {
								shared : false,
								
								//crosshairs : {
								//	snap : false,
								//	color : 'blue'
								//},
								
								//formatter : function() {
								//	var myDate = new Date(this.value);
								//	var newDateMs = Date.UTC(myDate.getUTCFullYear(), myDate.getUTCMonth() - 1, myDate.getUTCDate());
								//	return Highcharts.dateFormat('%e. %b',newDateMs);
								//}
								
								formatter : function() {
									var myDate = new Date(this.x);
									var newDateMs = Date.UTC(myDate.getUTCFullYear(), myDate.getUTCMonth() , myDate.getUTCDate());
									return '<b>' + this.series.name + '</b><br/>' + Highcharts .dateFormat('%e. %b', newDateMs) + ': ' + this.y;
								}
							},
							
							exporting: {
								enabled:false
					        },

							credits : {
								enabled : false
							},
							series : [
							        {  name : 'Diff.',
										type : 'column',
										color : '#4db6dc',
										borderColor: '#4db6dc',
										data : [],
										pointInterval : 24 * 3600 * 1000,
									},
									{  name : 'Flux_Tower',
										color : '#996699',
										data : [],
										pointInterval : 24 * 3600 * 1000, //one day
									},
									{  name : 'NMSC ET',
										color : '#0000cc',
										data : [],
										pointInterval : 24 * 3600 * 1000, //one day
									}]
					});
						
						//
					chart_fluxTower = new Highcharts.Chart({
						
								chart : {
									 backgroundColor: "rgba(255, 255, 255, 0)",
									    plotBackgroundColor: "rgba(255, 255, 255, 0)",
									
									renderTo : 'meteorological',		//		events:{load:requestData},
									defaultSeriesType : 'line',
									plotBorderWidth : 1,
									plotBorderColor : 'black',
									zoomType : 'xy',
									marginLeft : 60,
									marginRight : 60,
									animation:false,
									style: {
					                	fontFamily: 'NanumGothic'
					            	}
								},
								plotOptions : {
									series : {
										animation:false,
										lineWidth : 1,
										marker : {
											symbol : 'circle',
											radius : 3,
										}
									}
								},
								title : {
									text : 'Icheon Meteorological station, 이천기상대, 위치(37.26°N, 127.48°E)',
									align : 'left',
									style : {
										/* font: 'bold 16px "Trebuchet MS", Verdana, sans-serif' */
										font: 'bold 14px NanumGothic',
										//fontSize : '14px'
									}
								},
								xAxis : {
									type : 'datetime',
									labels : {
										formatter : function() {
											var myDate = new Date(this.value);
											var newDateMs = Date.UTC(myDate
													.getUTCFullYear(),
													myDate.getUTCMonth() , myDate
															.getUTCDate());
											return Highcharts.dateFormat('%e. %b',
													newDateMs);

										}
									},
									lineColor : 'black',
									lineWidth : 1,
									gridLineWidth : 1
								},
								yAxis : [ { // Primary yAxis temperature!!!!
									labels : {
										style : {
											color : '#000000'
										}
									},
									title : {
										text : 'Temperature (°C)',
										style : {
											color : '#000000',
//											font : '12px  NanumGothic',
//											fontWeight: 'bold'
										}
									},
									min : -10,
									max : 40,
									tickInterval : 10,
									gridLineWidth : 1
								}, { // Secondary yAxis precipitation mm
									labels : {
										style : {
											color : '#000000'
//											font : '12px  Helvetica',
//											fontWeight: 'bold'
										}
									},
									title : {
										text : 'Accumulated Rain (mm/Day)',
										style : {
											color : '#000000',
//											font : '12px  Helvetica',
											font : '12px  ',
											fontWeight: 'normal'
										}
									},
									opposite : true,
									min : 0
								} ],

								tooltip : {
									shared : false,
								//	crosshairs : {
								//		snap : false,
								//		color : 'blue'
								//	},
									formatter : function() {
										var myDate = new Date(this.x);
										var newDateMs = Date.UTC(myDate.getUTCFullYear(),
												myDate.getUTCMonth() , myDate
														.getUTCDate());
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts
														.dateFormat('%e. %b', newDateMs)
												+ ': ' + this.y;
									}
								},
								
								exporting: {
									enabled:false
						        },
								
								credits : {
									enabled : false
								},

								series : [
										{
											name : 'Obs_Rain',
											type : 'column',
											color : '#4db6dc',
											borderColor: '#4db6dc',
											yAxis : 1,
											data : [],
											pointInterval : 24 * 3600 * 1000,
										},
										//        주 네 블
										//      cc3300 0000cc 000000
										{
											name : 'Obs_Ts_Mean',
											color : '#0000cc',
											yAxis : 0,
											data : [],
											connectNulls:false,
											pointInterval : 24 * 3600 * 1000, //one day
											dashStyle : 'Dash'
										},

										{
											name : 'Obs_Ta_Max',
											color : '#996699',
											yAxis : 0,
											data : [],
											connectNulls:false,
											pointInterval : 24 * 3600 * 1000, //one day
											dashStyle : 'Dash'
										},
										{
											name : 'COMS_Ts',
											color : '#000000',
											yAxis : 0,
											data : [],
											connectNulls:false,
											pointInterval : 24 * 3600 * 1000, //one day
										},
										{
											name : 'NMSC_Ta',
											color : '#cc3300',
											yAxis : 0,
											data : [],
											connectNulls:false,
											pointInterval : 24 * 36e5, //one day
										}
								]
					});
//				    $('.chart-container').bind('dblclick', function () {
//				        $(this).toggleClass('modal');
//				        $('.chart', this).highcharts().reflow();
//				    });	
						
				
	});
</script>


<script type="text/javascript">

	var date_latestStuff;
	
	function requestData(dateFrom,  retrieveRange, whichSite){
		$.ajax({
			type: 'GET',dataType:'json',contentType:'application/json',
			url: '${pageContext.request.contextPath}/ajax/et/coms/fluxtower_observation',
			data:'reqType=et_fluxtowerObservation'+'&dateFrom='+dateFrom + '&whichsite='+whichSite + '&retrieverange='+retrieveRange,
	        success: function(jsonData) {
	        	console.log(jsonData);
				//fluxTowerSeries
				nimr_et = [];
				flux_tower = [];
				diff = [];
				//meteoSeries
				obs_rain=[];
				obs_ta_max=[];
				obs_ts_mean=[];
				nimr_ta=[];
				coms_ts=[];
	        	
				if(jsonData.latestStuff !=null){
					var date_lastOne = new Date(jsonData.latestStuff.substring(0,4) , jsonData.latestStuff.substring(4,6)*1 -1, jsonData.latestStuff.substring(6,8));
					date_latestStuff = date_lastOne;
					//datipicker setDate() method is causing the datepicker to always be seen at the bottom of the page..
					// append the following right after datepicker creation code
					$('#ui-datepicker-div').css('display','none'); // eliminate the visual artifact on the screen.. 
					$('#datepicker').datepicker("setDate", date_lastOne);
				}
				
				if(jsonData.dateActual != null){
					if(jsonData.dateTarget != null){
						var str = '( ' + jsonData.dateTarget + ' ~ ' + jsonData.dateActual + ' )';
						  $('#varTitleContainer').find('#retrievalRange').text(str);
						// $('#retrievalRange').text( '(' + jsonData.dateTarget + ' ~ ' + jsonData.dateAcutal + ')');
					}
				}
				
				for ( var i = 0; i < jsonData.someList.length; i++) {
					var dateStrArr = jsonData.someList[i].date.split(",");
					var yy = parseInt(dateStrArr[0]);
					var mm = parseInt(dateStrArr[1]);
					var dd = parseInt(dateStrArr[2]);

					nimr_et.push([Date.UTC(yy,mm-1, dd),parseNumericVal(jsonData.someList[i].nimrET) ]);
					flux_tower.push([Date.UTC(yy,mm-1, dd),parseNumericVal(jsonData.someList[i].fluxMax) ]);
					diff.push([Date.UTC(yy,mm-1, dd),parseNumericVal(jsonData.someList[i].diff) ]);
					
					obs_rain.push([Date.UTC(yy,mm-1, dd),parseNumericVal(jsonData.someList[i].AccRN) ]);
					obs_ts_mean.push([Date.UTC(yy,mm-1, dd),parseNumericVal(jsonData.someList[i].TsMean) ]);
					obs_ta_max.push([Date.UTC(yy,mm-1, dd),parseNumericVal(jsonData.someList[i].TaMax) ]);
					coms_ts.push([Date.UTC(yy,mm-1, dd),parseNumericVal(jsonData.someList[i].COMS_Ts) ]);
					nimr_ta.push([Date.UTC(yy,mm-1, dd),parseNumericVal(jsonData.someList[i].NIMR_Ta) ]);
				}

				var _fluxTower = $('#fluxtower').highcharts();				
				var _meteorological = $('#meteorological').highcharts();				
				_fluxTower.series[0].setData(diff); 
				_fluxTower.series[1].setData(flux_tower); 
				_fluxTower.series[2].setData(nimr_et); 

				
				_meteorological.series[0].setData(obs_rain); 
				_meteorological.series[1].setData(obs_ts_mean); 
				_meteorological.series[2].setData(obs_ta_max);
				_meteorological.series[3].setData(coms_ts);
				_meteorological.series[4].setData(nimr_ta); 

				
				var Bias = jsonData.Bias;
				var RMSE = jsonData.RMSE;
				var Nobs = jsonData.Nobs;
				var verficationStr = '<b>Bias:' + Bias + '</b><br/><b>RMSE:' + RMSE + '</b><br/><b>Nobs:' + Nobs + '</b>';
				//var resultStr = "<b>RMSE: " + jsonData.RMSE + '</b><br><b>Bias: ' + jsonData.Bias + '</b><br><b>Nobs: ' + jsonData.Nobs +'</b>';
				placeSomeLabelOnTheChart(_fluxTower, verficationStr, 5, 12, 'ETVerification');
				
				changeTimeseriesTitle(_fluxTower, false, (whichSite!=1)? 'KoFlux Cheongmicheon Farmland site (청미천), Rice Paddy, 위치(38.51°N, 127.65°E)' : 'KoFlux Seolmacheon site (설마천), Mixed Forest, 위치(37.93°N, 126.95°E)');
				changeTimeseriesTitle(_meteorological, false,  (whichSite!=1)? 'Icheon Meteorological station, 이천기상대, 위치(37.26°N, 127.48°E)' : 'Munsan Meteorological station, 문산기상대, 위치(37.89°N, 126.77°E)');
				
	        },
	        cache: false	
		});
	}
	
	function changeTimeseriesTitle(chartObj, isSubtitle, titleStr){
		if(! isSubtitle){
			chartObj.setTitle({text:titleStr}, undefined);
		}else{
			chartObj.setTitle(undefined, {text:titleStr});
		}
	}
	
	function placeSomeLabelOnTheChart(chartObj, someTxt, leftPad, topPad, idStr){
		$('#ETVerification').remove();
		text = chartObj.renderer.text(someTxt).add();
		textBBox = text.getBBox();
//		x = chartObj.plotLeft + (chartObj.plotWidth  * leftPad) ; //- (textBBox.width  * 0.5);
//		y = chartObj.plotTop  + (chartObj.plotHeight * topPad) + (textBBox.height * 0.25);
//		x = chartObj.plotWidth  -  textBBox.width + leftPad ; //- (textBBox.width  * 0.5);
		x = chartObj.plotLeft +  leftPad ; //- (textBBox.width  * 0.5);
		y = chartObj.plotTop  +  topPad;
		text.attr({x: x, y: y, id:idStr, zIndex:999});
	}
	
	//missing val  <-assign null
	function parseNumericVal(someStuff){
		if(someStuff == null){
			return null;
		}else if(Math.abs(someStuff)==999){	
			return null;
		}else{
			return parseFloat(someStuff);
		}
	}

	function udpateDateHandler(selectedDateStr) {
		$("#topNavi").find("#datepicker").val(selectedDateStr);
		var interval = $('#dataRangeChooser').find(":selected").val()+'';
		requestData(selectedDateStr.split('-').join(''), interval);
	}
	
	
	function updateSelectedDate(selectedDateStr){
		var interval = $('#dataRangeChooser').find(":selected").val()+'';
		var $tabs = $('#tabs-nohdr').tabs();
		var activeIdx = $tabs.tabs('option', 'active');
//alert(selectedDateStr.split('-').join(''));
		requestData(selectedDateStr.split('-').join(''), interval, activeIdx);
	}
	
	function getDateCalculated(whichOperator){
		var dateStr =  $("#datepicker").val();		
		var currDate = $.datepicker.parseDate('yy-mm-dd',dateStr);
		currDate = getRetrievalInterval(whichOperator,currDate);
		
/* 		if(currDate.getTime()==date_latestStuff.getTime())return;
		else if(date_latestStuff.getTime() < currDate.getTime()){
			alert('date_latestStuff.getTime() <= currDate.getTime() \n doNothing..');
		} */
		
		$('#datepicker').datepicker("setDate", currDate);
		updateSelectedDate( $("#datepicker").val());
	}
	
	function getRetrievalInterval(operator,currDate){
		var dateCalculated = currDate;
//		var dateCalculated = new Date(currDate.getFullYear(),currDate.getMonth(),currDate.getDate(),0,0,0,0);
		var interval = $('#retrievalIntervalChooser').find(":selected").val()+'';
		var math_it_up={ 'btn_next': function (x, y) { return x + y },
			    		 'btn_prev': function (x, y) { return x - y }
		};
 		if(interval=='DAY'){
 			dateCalculated.setDate(math_it_up[operator](dateCalculated.getDate(),1));
		}else if(interval=='WEEK'){
			dateCalculated.setDate(math_it_up[operator](dateCalculated.getDate(),7));
		}else if(interval=='MONTH'){
//			dateCalculated.setMonth(math_it_up[operator](dateCalculated.getMonth(),1));
			var addOrSubtractMonth= (operator=='btn_prev')? -1:1; //31 Jan + 1 month = 28 Feb
			dateCalculated = new Date(dateCalculated).add(addOrSubtractMonth).month();
		}else{
			// btn_latest // return latest Stuff dateObj.. 
		}
		return dateCalculated;
	}
	
	function initEvtHandler(){
		var selectedInterval  = $('#dataRangeChooser').find(":selected").val()+'';
		var $tabs = $('#tabs-nohdr').tabs();
		var activeIdx = $tabs.tabs('option', 'active');
		requestData('init', selectedInterval, activeIdx);
	}
	
	
	
	
</script>


</head>

<body id="fabulousbdtc">



	<div class="hor-align" id="content">
		
<div align="left" id="timeSeriesContentWrapper">		

		<div class="hbox">
		
			<div id="topNavi" class="navigator" align="left" style="padding-left: 10px;">
				<p>
					<label for="datepicker" style="font-size: 13px;">날짜 선택: </label><input type="text" id="datepicker" style="width: 80px;;font-size: 12px;">
					<input type="button" id="btn_latest" value="최근"
						style="width: 55px; font-size: 9pt"
						onclick="initEvtHandler()" /> | 
						<input type="button" id="btn_prev" value="&lt;" 
							style="width: 30px; font-size: 9pt"
							onclick="getDateCalculated(this.id)" /> 
						<select id="retrievalIntervalChooser" style="font-size: 9pt;"   title="검색 간격 선택">
							<option value="WEEK">1 Week</option>
							<option value="MONTH" selected="selected">1 Month</option>
						</select> 
						<input type="button" id="btn_next" value="&gt;"
							style="width: 30px; font-size: 9pt"
							onclick="getDateCalculated(this.id)" /><label for="dataRangeChooser" style="font-size: 13px;"> | 자료 제공기간 </label>
						<select id="dataRangeChooser" style="font-size: 9pt;" >
							<option value="1">1</option>
							<option value="3">3</option>
							<option value="6">6</option>
							<option value="12" >12</option>
							<!-- 
							 -->
						</select> <label style="font-size: 13px;">개월</label> 	
							
				</p>
			</div>
			<div align="center" class="titleEnhancer"  id="varTitleContainer">
				<p style="font-size: 16px">Comparison of daily NMSC Evapotranspiration with Flux-Tower observation</p>
				<p style="font-size: 14px" id="retrievalRange">&nbsp;</p>
			</div>
			
		
			<div align="center">
			
				<div id="tabs-nohdr" align="left" >  
					<ul>    
						<li><a href="#tabs-cheongmi">Cheongmi</a></li>    
						<li><a href="#tabs-cheongmi">Seolma</a></li>    
					</ul>  
					<div id="tabs-cheongmi" align="center">    
						<div id="fluxtower" style="width: 730px; height: 300px"></div>
						<div id="meteorological"  style="width: 730px; height: 300px"></div>
					</div>  
				</div> 
			</div>
			<div align="left" class="navigator"
				style="padding-left: 20px; padding-top: 20px; font-size: 12px;">※ 플럭스타워 관측자료는
				국토해양부 유량조사사업단의 자료이며, 실시간으로 제공되지 않습니다.
			</div>
		</div>	
		
</div>		

</div>

</body>

</html>