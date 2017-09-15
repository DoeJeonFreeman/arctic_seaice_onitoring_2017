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
    
	<title><spring:message code="global.main.title"/></title>
	
	<script src="<c:url value="/js/jquery/jquery-1.9.1.js"/>"></script>	
    <script src="<c:url value="/mestrap/js/bootstrap.min.js"/>"></script>
    
    <!-- Bootstrap Core CSS -->
    <link href="<c:url value="/mestrap/css/bootstrap.min.css"/>" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="<c:url value="/mestrap/css/modern-business.css"/>" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="<c:url value="/mestrap/font-awesome/css/font-awesome.min.css"/>" rel="stylesheet" type="text/css">
	<!-- 2c.doe.hicharts -->
	<script src="<c:url value="/js/highchart/highcharts.js"/>"></script>
	<script src="<c:url value="/js/highchart/highcharts-more.js"/>"></script>
	<script src="<c:url value="/js/highchart/modules/exporting.js"/>"></script>
	<script src="${pageContext.request.contextPath}/js/highchart/modules/offline-exporting.js"></script>
	
	<!-- dateRangePicker 1css 2momentjs 3js-->
	<link href="<c:url value="/js/daterangepicker/daterangepicker.css"/>" rel="stylesheet" type="text/css">	
	<script type="text/javascript" src="<c:url value="/js/daterangepicker/moment.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/daterangepicker/daterangepicker.js"/>"></script>
	<!-- dateJS -->
	<script type="text/javascript" src="<c:url value="/js/jquery/date.js"/>"></script>
	
	<!--
	<script src="<c url value="/js/scalable/colorpicker.js"/>"></script>
	<script src="<c url value="/js/scalable/mapcolorizer2.js"/>"></script>
	<script src="<c url value="/js/scalable/messagebox.js"/>"></script>
	-->
	
	<!-- custom context menu-->	
    <script src="<c:url value="/js/ctxmenu/BootstrapMenu.min.js"/>"></script>
    <!-- 
	    <link href="<c url value="/js/ctxmenu/toastr.css"/>" rel="stylesheet">
    	<script src="<c url value="/js/ctxmenu/toastr.js"/>"></script>
     -->
	<!-- watermark-->	
    <script src="<c:url value="/js/exporting/jquery.watermark.js"/>"></script>
    <script src="<c:url value="/js/exporting/FileSaver.js"/>"></script>	
    <script src="<c:url value="/js/exporting/canvas-toBlob.js"/>"></script>	
	
	<script>
	
	var thisYear = 2017;
	
 	$(document).ready(function(){
 		changeImgSrc("<c:out value="${seaRoute.compbegindateInString}" />","<c:out value="${seaRoute.compbegindate4View}" />","<c:out value="${seaRoute.sensor}" />");
	}); 
 
 
 	Date.prototype.customFormat = function(formatString){
	    var YYYY,YY,MMMM,MMM,MM,M,DDDD,DDD,DD,D,hhh,hh,h,mm,m,ss,s,ampm,AMPM,dMod,th;
	    var dateObject = this;
	    YY = ((YYYY=dateObject.getFullYear())+"").slice(-2);
	    MM = (M=dateObject.getMonth()+1)<10?('0'+M):M;
	    MMM = (MMMM=["January","February","March","April","May","June","July","August","September","October","November","December"][M-1]).substring(0,3);
	    DD = (D=dateObject.getDate())<10?('0'+D):D;
	    DDD = (DDDD=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"][dateObject.getDay()]).substring(0,3);
	    th=(D>=10&&D<=20)?'th':((dMod=D%10)==1)?'st':(dMod==2)?'nd':(dMod==3)?'rd':'th';
	    formatString = formatString.replace("#YYYY#",YYYY).replace("#YY#",YY).replace("#MMMM#",MMMM).replace("#MMM#",MMM).replace("#MM#",MM).replace("#M#",M).replace("#DDDD#",DDDD).replace("#DDD#",DDD).replace("#DD#",DD).replace("#D#",D).replace("#th#",th);

	    h=(hhh=dateObject.getHours());
	    if (h==0) h=24;
	    if (h>12) h-=12;
	    hh = h<10?('0'+h):h;
	    AMPM=(ampm=hhh<12?'am':'pm').toUpperCase();
	    mm=(m=dateObject.getMinutes())<10?('0'+m):m;
	    ss=(s=dateObject.getSeconds())<10?('0'+s):s;
	    return formatString.replace("#hhh#",hhh).replace("#hh#",hh).replace("#h#",h).replace("#mm#",mm).replace("#m#",m).replace("#ss#",ss).replace("#s#",s).replace("#ampm#",ampm).replace("#AMPM#",AMPM);
	}
	
 	/**
 	usage.. 
 	mePadPro(18,4) --> 0018
 	mePadPro(38,5,'#') --> ###38
 	*/
	function mePadPro(n, meDigit, z) {
	  z = z || '0';
	  n = n + '';
	  return n.length >= meDigit ? n : new Array(meDigit - n.length + 1).join(z) + n;
	}
 
	
	var extentSeriesJson;
	function requestData(dateFrom){
		$.ajax({
			type: 'GET',dataType:'json',contentType:'application/json',
			url: '${pageContext.request.contextPath}/ajax/getSeriesData',
			data:'whichSeries=PASSAGEExt',
	        success: function(jsonData) {
	        	extentSeriesJson = jsonData.data.ice.someList;			
//				subtractPointData(jsonData.data.ice.someList.laptev, 'psgExt');
				subtractPointData(jsonData.data.ice.someList['barents'], 'psgExt');
	        },
	        cache: false	
		});
	}
	
	var roughnessSeriesJson;
	function requestData_rou(dateFrom){
		$.ajax({
			type: 'GET',dataType:'json',contentType:'application/json',
			url: '${pageContext.request.contextPath}/ajax/getSeriesData',
			data:'whichSeries=PASSAGERou',
	        success: function(jsonData) {
	        	roughnessSeriesJson = jsonData.data.ice.someList;
				subtractPointData(jsonData.data.ice.someList.barents, 'psgRou');
	        },
	        cache: false	
		});
	}
	
	function subtractPointData(someList, targetDiv){
		e07 = [];
		e08 = [];
		e09 = [];
		e10 = [];
		e11 = [];
		e12 = [];
		e13 = [];
		e14 = [];
		e15 = [];
		e16 = [];
		e17 = [];
		
//		var fracDigit = (targetDiv=='psgExt')? 3 : 0;
		var fracDigit = (targetDiv=='psgExt')? 0 : 18; //Oct 05, 2015
		for ( var i = 0; i < someList.length; i++) {
			var dateStrArr = someList[i].date.split(",");
			var mm = parseInt(dateStrArr[0]);
			var dd = parseInt(dateStrArr[1]);

			e07.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e07,fracDigit) ]);
			e08.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e08,fracDigit) ]);
			e09.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e09,fracDigit) ]);
			e10.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e10,fracDigit) ]);
			e11.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e11,fracDigit) ]);
			e12.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e12,fracDigit) ]);
			e13.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e13,fracDigit) ]);
			e14.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e14,fracDigit) ]);
			e15.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e15,fracDigit) ]);
			e16.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e16,fracDigit) ]);
			e17.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e17,fracDigit) ]);
		}
		var _chart; 
		if(targetDiv == 'psgExt'){
			_chart = $('#psgExt').highcharts();				
		}else if(targetDiv == 'psgRou'){
			_chart = $('#psgRou').highcharts();				
		}
		
		_chart.series[0].setData(e07); 
		_chart.series[1].setData(e08); 
		_chart.series[2].setData(e09); 
		_chart.series[3].setData(e10); 
		_chart.series[4].setData(e11); 
		_chart.series[5].setData(e12); 
		_chart.series[6].setData(e13); 
		_chart.series[7].setData(e14); 
		_chart.series[8].setData(e15); 
		_chart.series[9].setData(e16); 
		_chart.series[10].setData(e17); 
	}
	
	//missing val  <-assign null
	function parseNumericVal(someStuff, fracDigit){
		if(someStuff == null){
			return null;
		}else if(Math.abs(someStuff)==999){	 //missing -999.000 
			return null;
		}else{
			if(fracDigit == 18 && Math.abs(someStuff)==0){
				return null;
				//return ((parseFloat(someStuff) / Math.pow(10,fracDigit)).toFixed(3));
			}else{
				return parseFloat(someStuff);
			}
		}
	}

	
	</script>


	<script>
	var chart_ext;
	var chart_rou;

	$(document).ready(function(){
		
		
		$.ajax({
			type: 'GET',dataType:'json',contentType:'application/json',
			url: '${pageContext.request.contextPath}/ajax/getSeriesData',
			data:'whichSeries=PASSAGEExt',
	        success: function(jsonData) {
	        
				chart_ext = new Highcharts.Chart({
					chart : {
						type : 'line',
						renderTo : 'psgExt',  								//events:{load:requestData('init')},
						defaultSeriesType : 'line',
						plotBorderWidth : 1,
						plotBorderColor : '#346691', // '#346691',
						zoomType : 'xy',
						//marginLeft : 60,
						//marginRight : 60
						style: {
		                	fontFamily: 'NanumGothic'
		            	}
					},
					title: {
			            text: '바렌츠해(Barents Sea)의 해빙 면적변화',
			            align: 'center',
			            //x:50,
			            style:{
		//	            	font:'bold 16px NanumGothic'
			            	font:' 16px NanumGothic'
			            }
			        },
			        subtitle: {
			            text: null,
			            x: 25,
			            style:{
			            	font:'normal 12px NanumGothic'
			            }
			        },
			        xAxis : {
						type : 'datetime',
						labels : {
							formatter : function() {
								var myDate = new Date(this.value);
								var newDateMs = Date.UTC(myDate.getUTCFullYear(), myDate.getUTCMonth() , myDate.getUTCDate());
							  //return Highcharts.dateFormat('%e. %b',newDateMs);
		//						return Highcharts.dateFormat('%m월 %d일',newDateMs);
							   return Highcharts.dateFormat('%b',newDateMs);
							}
						},
						
		
						//remove leading n trailling padding?space from the series of the timeseries chart haha
						startOnTick: true,
						endOnTick: false,				
						minPadding:0,
						maxPadding:0,
			            //tickmarkplacement:"on",
						
						lineColor : '#346691',
						lineWidth : 1,
						//gridLineWidth : 1
					},
			        yAxis: {
			    		gridLineWidth: 0,
			            tickColor: '#346691',
			            tickLength: 5,
			            tickWidth: 1,
			            tickPosition: 'inside',
			            labels: {
			                align: 'right',
			                x:-10,
			                y:5
			            },
			            lineWidth:0,
			    		//get rid of horizontal grid lines  
			            title: {
			            	useHTML: true,
			                text: $('#axisTitle').val()+" (x10<sup>5</sup> ㎢)",
		                	style : {
		                		font:'normal 12px NanumGothic'
								//color : '#000000'
		                	}	
			            },
			            labels:{
				            style : {
			            		font:'normal 11px NanumGothic'
								//color : '#000000'
				            },
				            formatter: function() { //numberFormat (Number number, [Number decimals], [String decimalPoint], [String thousandsSep])
				            	return Highcharts.numberFormat(this.value, 0, '.', ',');
				            }
		            	},	
			            plotLines: [{ //verticalColoredBand
			               // value: 0,
			                //width: 0,
			                //color: '#346691', 
			            }],
			            tickInterval:2,
			            max:12,
			            min:0
			        },
			        tooltip: {
		//	            shared: true,
		//	            valueSuffix: '°C',
		//	            crosshairs: {
		//	            	color: 'red',
		//	            	snap: false
		//	           	},
			            formatter: function() {
			            	var myDate = new Date(this.x);
			            	var newDateMs = Date.UTC(myDate.getUTCFullYear(), myDate.getUTCMonth() , myDate.getUTCDate());
			                var s = this.series.name + '<br/>';
							s+= Highcharts.dateFormat('%b %e', newDateMs)+'<br/>';
		//	                var s = Highcharts .dateFormat('%e. %b %Y', newDateMs)+'<br/>';
							s+= '<b>'+this.y + '</b>'
		//					Highcharts.dateFormat('%Y. %m. %d.', newDateMs)+'<br/>';
		//	                $.each(this.points, function(i, point) {
		//	                    s += this.series.name + ': <b>' + this.y + '°C</b><br/>';
		//	                    Highcharts.dateFormat('%a %e %b %Y', this.point.options.from) + 
		//	                    ' - ' + Highcharts.dateFormat('%a %e %b %Y', this.point.options.to);
		//	                });
			                return s;
			            }
			        },
			        
					exporting: {
			            chartOptions: { // specific options for the exported image
			                plotOptions: {
			                    series: {
			                        dataLabels: {
			                            enabled: false// canDropLabels==true
			                        }
			                    }
			                }
				          /*   ,chart:{
			                    events:{
			                        load:function(){
	//		                            this.renderer.image('${pageContext.request.contextPath}/mestrap/assets/ci/kma_kr_en_opacity50.png', 320, 170, 189, 31).add();
			                            this.renderer.image('${pageContext.request.contextPath}/mestrap/assets/ci/footer_kma_kr_en.png', 320, 140, 189, 31).add();
			                        }
			                    }
			                } */
			            },
			            sourceWidth: 800,
			            sourceHeight: 330,
			            // scale: 2 (default)
			            scale: 1,
			            fallbackToExportServer: false
			        },
			        
			        credits: {
			            enabled: false
			        },
			        plotOptions:{
			        	series:{
			        		//showCheckbox:true,
			        		lineWidth:1,
			    		  	marker:{
				            		symbol:'circle',
				            		radius:2,
				            		enabled:false
			  	            }
			        	},
			        	//handle select all or none event haha
			        	 line: {
			                    events: {
			                        legendItemClick: function (e) {
//			                        	if(e.currentTarget.index*1 == chart_ext.series.length-1){//all or none selected!! // 9
			                        	if(this.index*1 == chart_ext.series.length-1){//all or none selected!! // 9
//			                        		var visibility = e.currentTarget.visible ? 0 : 1;
			                        		var visibility = this.visible ? 0 : 1;
			                        		 for(i=0; i < chart_ext.series.length-1;i++){
			 	            	                if (visibility==0) {
			 	            	                	//console.log('hide')
			 	            	                	chart_ext.series[i].hide();
			 	            	                } else if(visibility==1) {
			 	            	                	chart_ext.series[i].show();
			 	                                }
			                        		 }   
			                        	}else{
				                            var c = 0; // count visible legend items
//				                            var c = e.currentTarget.visible ? 0 : 1;
				                            var c = this.visible ? 0 : 1;
				                            for(i = 0; i < chart_ext.series.length-1; i++) {
			                                	if(chart_ext.series[i] != e.currentTarget && chart_ext.series[i].visible) c++;
				                            }
				                            if (chart_ext.series.length-1 == c) { 
				                                  chart_ext.series[chart_ext.series.length-1].show()
				                            } else if (c < chart_ext.series.length-1) { 
				                                  chart_ext.series[chart_ext.series.length-1].hide()
				                            } 
			                        	}
			                        }
			                    }
			                }
			        	
			        },
			        series: [
				 	            {
				 	             name: '\'07',
				 	             color: '#ff0000' ,
				     	         connectNulls:false, data: []},
				 	        	{name: '\'08',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'09',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'10',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'11',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'12',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'13',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'14',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'15',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'16',
				 	           	 color: '#0000ff',            	 
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'17',
				 	           	 color: '#000000',            	 
				 	           	connectNulls:false, data: []}, 
				 	            {name: ' 모두 선택',
				 	           	 color: '#ffffff', //#0000cc            	 
				 	           	connectNulls:false, data: []}]
			        ,legend: {
			        	layout: 'horizontal',
		                align: 'left',
		        //        verticalAlign: 'top',
		                itemWidth:72,
		      //          useHTML:true,
		                x: 60,
		                borderWidth: 0,
		                itemStyle: {
		                    fontSize: '12px',
		                    fontWeight:'bold'
		                } 
		             /*something wired    
		             	itemMarginTop: 0,
		                itemMarginBottom: 0,
		                itemStyle: {
		                    lineHeight: '14px'
		                } */
		            }    
					
				},function(chart_ext){
		//			$('#visiblityControlBtn').click(function(){
						//do stuff
		//          });
				}); //해빙 면적변화 시계열차트
				
				extentSeriesJson = jsonData.data.ice.someList;			
		//		subtractPointData(jsonData.data.ice.someList.laptev, 'psgExt');
				subtractPointData(jsonData.data.ice.someList['barents'], 'psgExt');
		    },
		    cache: false	
		});
		
		
		$.ajax({
			type: 'GET',dataType:'json',contentType:'application/json',
			url: '${pageContext.request.contextPath}/ajax/getSeriesData',
			data:'whichSeries=PASSAGERou',
	        success: function(jsonData) {
				
				chart_rou = new Highcharts.Chart({
					chart : {
						type : 'line',
						renderTo : 'psgRou',  								//events:{load:requestData_rou('init')},
						defaultSeriesType : 'line',
						plotBorderWidth : 1,
						plotBorderColor : '#346691',
						zoomType : 'xy',
						//marginLeft : 60,
						//marginRight : 60
						style: {
		                	fontFamily: 'NanumGothic'
		            	}
					},
					title: {
			            text: '바렌츠해(Barents Sea)의 해빙 표면거칠기변화',
			            align: 'center',
			            //x: 50,
			            style:{
		//	            	font:'bold 16px NanumGothic'
			            	font:' 16px NanumGothic'
			            }
			        },
			        subtitle: {
			            text: null, 
			            x: 25,
			            style:{
			            	font:'normal 13px NanumGothic'
			            }
			        },
			        xAxis : {
						type : 'datetime',
						labels : {
							formatter : function() {
								var myDate = new Date(this.value);
								var newDateMs = Date.UTC(myDate.getUTCFullYear(), myDate.getUTCMonth() , myDate.getUTCDate());
							  //return Highcharts.dateFormat('%e. %b',newDateMs);
							   return Highcharts.dateFormat('%b',newDateMs);
							}
						},
						
		
						//remove leading n trailling padding?space from the series of the timeseries chart haha
						startOnTick: true,
						endOnTick: false,				
						minPadding:0,
						maxPadding:0,
			            //tickmarkplacement:"on",
						
						lineColor : '#346691',
						lineWidth : 1,
						gridLineWidth : 0 //
					},
			        yAxis: {
			        	//get rid of horizontal grid lines haha
		    			gridLineWidth: 0,
		    	        tickColor: '#346691',
		    	        tickLength: 5,
		    	        tickWidth: 1,
		    	        tickPosition: 'inside',
		    	        labels: {
		    	            align: 'right',
		    	            x:-10,
		    	            y:5
		    	        },
		    	        lineWidth:0,
			        	
			            title: {
			            	 text: $('#axisTitle_rou').val(),
		                	style : {
		                		font:'normal 12px NanumGothic'
								//color : '#000000'
		                	}	
			            },
			            labels:{
				            style : {
			            		font:'normal 11px NanumGothic'
								//color : '#000000'
				            }
		            	},
			            plotLines: [{ //verticalColoredBand
			             //   value: 0,
			              //  width: 0,
			            //    color: '#ff0000',
			            }],
			            tickInterval:0.2,
			            max:0.6,
			            min:0
			        },
			        tooltip: {
		//	            shared: true,
		//	            valueSuffix: '°C',
		//	            crosshairs: {
		//	            	color: 'red',
		//	            	snap: false
		//	           	},
			            formatter: function() {
			            	var myDate = new Date(this.x);
			            	var newDateMs = Date.UTC(myDate.getUTCFullYear(), myDate.getUTCMonth() , myDate.getUTCDate());
			                var s = this.series.name + '<br/>';
							s+= Highcharts.dateFormat('%b %e', newDateMs)+'<br/>';
							s+= '<b>'+this.y + '</b>'
			                return s;
			            }
			        },
			        
					exporting: {
			            chartOptions: { // specific options for the exported image
			                plotOptions: {
			                    series: {
			                        dataLabels: {
			                            enabled: false// canDropLabels==true
			                        }
			                    }
			                }
				            /* ,chart:{
			                    events:{
			                        load:function(){
	//		                            this.renderer.image('${pageContext.request.contextPath}/mestrap/assets/ci/kma_kr_en_opacity50.png', 320, 170, 189, 31).add();
			                            this.renderer.image('${pageContext.request.contextPath}/mestrap/assets/ci/footer_kma_kr_en.png', 320, 140, 189, 31).add();
			                        }
			                    }
			                } */
			            },
			            sourceWidth: 800,
			            sourceHeight: 330,
			            // scale: 2 (default)
			            scale: 1,
			            fallbackToExportServer: false
			        },
			        
			        credits: {
			            enabled: false
			        },
			        plotOptions:{
			        	series:{
			        		lineWidth:1,
			    		  	marker:{
				            		symbol:'circle',
				            		radius:2,
				            		enabled:false
			  	            }
			        	},
			        	//handle select all or none event haha
			        	 line: {
			                    events: {
			                        legendItemClick: function (e) {
			                        	//if(e.currentTarget.index*1 == chart_rou.series.length-1){//all or none selected!! // 9
		                        		if(this.index*1 == chart_ext.series.length-1){//all or none selected!! // 9
//			                        		var visibility = e.currentTarget.visible ? 0 : 1;
			                        		var visibility = this.visible ? 0 : 1;
			                        		//console.log('visibility: ' +visibility)
			                        		 for(i=0; i < chart_rou.series.length-1;i++){
			 	            	                if (visibility==0) {
			 	            	                	//console.log('hide')
			 	            	                	chart_rou.series[i].hide();
			 	            	                } else if(visibility==1) {
			 	            	                	//console.log('show') // 계속 타내
			 	            	                	chart_rou.series[i].show();
			 	                                }
			                        		 }   
			                        	/* for(i=0; i < chart_rou.series.length;i++){
			            	                if ($(this).text() === 'Hide') {
			            	                	chart_rou.series[i].hide();
			            	                } else {
			            	                	chart_rou.series[i].show();
			                                }
			                            }
			                            var changeText = ($(this).text() == 'Hide') ? 'Show' : 'Hide';
			                            $(this).text(changeText);
			                        	 */
			                        	}else{
				                           // console.log(e);
				                            var c = 0; // count visible legend items
//				                            var c = e.currentTarget.visible ? 0 : 1;
				                            var c = this.visible ? 0 : 1;
				                            for(i = 0; i < chart_rou.series.length-1; i++) {
			                                	if(chart_rou.series[i] != e.currentTarget && chart_rou.series[i].visible) c++;
				                            }
				                            //console.log(c);
				                            if (chart_rou.series.length-1 == c) { //모든 연도 선택되면 모두선택버튼 활성화
				                                  //$('#visiblityControlBtn').text('Hide');
				                                  chart_rou.series[chart_rou.series.length-1].show()
		//		                            } else if (c == 0) {
				                            } else if (c < chart_rou.series.length-1) { // 07~현재연도 중 하나라도 unchecked면 모두선택버튼 비활성화 
				                                  //$('#visiblityControlBtn').text('Show'); 
				                                  chart_rou.series[chart_ext.series.length-1].hide()
				                            } 
			                        	}
			                        }
			                    }
			                }
			        },
			        series: [
				 	            {
				 	             name: '\'07',
				 	             color: '#ff0000' ,
				     	         connectNulls:false, data: []},
				 	        	{name: '\'08',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'09',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'10',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'11',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'12',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'13',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'14',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	           {name: '\'15',
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'16',
				 	           	 color: '#0000ff',            	 
				 	           	connectNulls:false, data: []}, 
				 	        	{name: '\'17',
				 	           	 color: '#000000',            	 
				 	           	connectNulls:false, data: []}, 
				 	            {name: ' 모두 선택',
				 	           	 color: '#ffffff', //#0000cc            	 
				 	           	connectNulls:false, data: []}]
			 	          ,legend: {
			 	        	 layout: 'horizontal',
			                 align: 'left',
			         //        verticalAlign: 'top',
			                 itemWidth:72,
			       //          useHTML:true,
			                 x: 60,
			                 y: 0,
			                 borderWidth: 0,
			                 itemStyle: {
			                     fontSize: '12px',
			                     fontWeight:'bold'
			                 } 
			             }    
					
				}); //Deokjeokdo
		
	        	roughnessSeriesJson = jsonData.data.ice.someList;
				subtractPointData(jsonData.data.ice.someList.barents, 'psgRou');
	        },
	        cache: false	
		});
		
		$('#routeSelector').on('click','.option li',function(){
			var i = $(this).parents('.select').attr('id');
			var v = $(this).children().text();
			var o = $(this).attr('id');
			var valStr = $(this).attr('value'); // (WEEK || MONTH || YEAR)
			var meIdx = $(this).attr('meIdx'); // (1 thru 6)
			var meLatLng = $(this).attr('meLatLng'); // (latLng label haha)
			var ename = $(this).attr('ename'); // (latLng label haha)
			$('#'+i+' .selected').attr('id',o);
			$('#'+i+' .selected').text(v);
			$('#'+i+' .selected').attr('value',valStr);
			$('#'+i+' .selected').attr('meIdx',meIdx);
			$('#'+i+' .selected').attr('meLatLng',meLatLng);
			$('#'+i+' .selected').attr('ename',ename);
			// 1
			changeImgSrc(dateStr_currStuff, dateRangeStr_currStuff, sensor);
			// 2
			var whichRoute = $('#routeSelector .selected').attr('value');
			subtractPointData(extentSeriesJson[whichRoute], 'psgExt');
			subtractPointData(roughnessSeriesJson[whichRoute], 'psgRou');
			//3
			//change subtitle.. arg 0=title 1=subtitle
//			$('#psgExt').highcharts().setTitle({text:$('#routeSelector .selected').attr('meLatLng') + ' 해빙 면적'},undefined); 
//			$('#psgRou').highcharts().setTitle({text:$('#routeSelector .selected').attr('meLatLng') + ' 해빙 표면거칠기'},undefined);
			var extChartTitle = $('#routeSelector .selected').text() +'(' +$('#routeSelector .selected').attr('ename') + ')의 해빙 면적변화';
			var rouChartTitle = $('#routeSelector .selected').text() +'(' +$('#routeSelector .selected').attr('ename') + ')의 해빙 표면거칠기변화';
			$('#psgExt').highcharts().setTitle({text:extChartTitle},undefined);// xx해 해빙면적 
			$('#psgRou').highcharts().setTitle({text:rouChartTitle},undefined);// xx해 해빙 표면거칠기
			//4
			$('#lbl_latlonRange').text($('#routeSelector .selected').attr('meLatLng'));
			//alert("pasaageName ~ setTItle " + whichRoute);
		});
		
	}); //JCV good to go sir

	

	</script>
	
	
	
	
		<script>
		var dateStr_currStuff = '${seaRoute.compbegindateInString}';
		var dateRangeStr_currStuff = '${seaRoute.compbegindate4View}';
		var sensor = '${seaRoute.sensor}';
		
		function meRequest(meDateObj){
	 		$.ajax({
     			  type: "get",
     			  url: "<c:url value='/' />arctic/findMatchingStuff",
     			  cache: false,    
     			  data: "selectedDate="+meDateObj.format('YYYY-MM-DD'),
     			  success: function(response){
     				dateStr_currStuff = response.compbegindateInString;
     				dateRangeStr_currStuff = response.compbegindate4View;
     				sensor = response.sensor;
        	        changeImgSrc(dateStr_currStuff, dateRangeStr_currStuff, sensor);
     			  },
     			  error: function(){      
     			   alert('Error while request..');
     			  },
     			  cache:false
   			 });
		}
		
		function changeImgSrc(dateStr,dRangeStr,sensor){
			var meIdx = mePadPro($('#routeSelector .selected').attr('meIdx'),2);
			var meLatLng = $('#routeSelector .selected').attr('meLatLng');
		
			var path_img = "<c:url value='/'/>data/IMG/PSG/PSG" + meIdx + "/Y" + dateStr.substring(0,4) + "/dmsp_ssmis_ice_psg" + meIdx + "_" + dateStr + ".png";
			//console.log('changeImgSrc:: ' + path_img);
 	        $("#psgImg").attr("src",path_img);
 	        
 	        $('#psgImgWrapper h4').text($('#routeSelector .selected').text() + ' ' + sensor+ ' ' + $('#extTrailling').val()); //or use .html(<strong>textGoesHere</strong>') instead haha
 	        $('#psgImgWrapper h5').text(dRangeStr); 
		}
		
		
		//var minDate = 20070101;
		//var mostRecent = "${seaRoute.compbegindateInString}" * 1;
		var minDate = new Date(2007,0,01);
		var recentStuffArr = "${seaRoute.compbegindate4Cal}".split('-');
		var mostRecentDate = new Date(recentStuffArr[0],recentStuffArr[1]-1,recentStuffArr[2]);
		/* console.log(mostRecentDate instanceof Date && !isNaN(mostRecentDate.valueOf())) */
		
		function getDateCalculated(whichOperator){
			var dStrArr =  $("#meDemo").val().split('-');		
			//var currDate = $('#meDemo').data('daterangepicker').startDate;    ---> not a date obj
			var currDate = new Date(dStrArr[0],dStrArr[1]-1,dStrArr[2]);
			var dateTarget = getRetrievalInterval(whichOperator,currDate);
			
			if(dateTarget.getTime() < minDate.getTime()){
				alert("자료 제공 범위는 2007-01-01 부터   ${seaRoute.compbegindate4Cal}까지 입니다.");
				$('#meDemo').data('daterangepicker').setStartDate(moment(minDate).format('YYYY-MM-DD'));
    			$('#meDemo').data('daterangepicker').setEndDate(moment(minDate).format('YYYY-MM-DD'));
    			$('#meDemo').val(moment(minDate).format('YYYY-MM-DD'));
				meRequest(moment(minDate));
			}else if(dateTarget.getTime() > mostRecentDate.getTime()){
				alert("자료 제공 범위는 2007-01-01 부터   ${seaRoute.compbegindate4Cal}까지 입니다.");
				$("#btn_getMostRecentOne").trigger( "click" );
			}else{
				$('#meDemo').data('daterangepicker').setStartDate(moment(dateTarget).format('YYYY-MM-DD'));
    			$('#meDemo').data('daterangepicker').setEndDate(moment(dateTarget).format('YYYY-MM-DD'));
    			$('#meDemo').val(moment(dateTarget).format('YYYY-MM-DD'));
				meRequest(moment(dateTarget));
			}
			
			
			//$('#datepicker').datepicker("setDate", currDate);
			
			//updateSelectedDate( $("#datepicker").val().split('-').join(''));
		}
		
		
		function getRetrievalInterval(operator,currDate){
			var dateCalculated = currDate;
			//var interval = $('#retrievalIntervalChooser').find(":selected").val()+'';
    		var interval = $('#retrievalRangeSelector .selected').attr('value');
			var math_it_up={ 'btn_next': function (x, y) { return x + y },
				    		 'btn_prev': function (x, y) { return x - y }
			};
			
	 		if(interval=='DAY'){
	 			dateCalculated.setDate(math_it_up[operator](dateCalculated.getDate(),1));
			}else if(interval=='WEEK'){
				dateCalculated.setDate(math_it_up[operator](dateCalculated.getDate(),7));
			}else if(interval=='MONTH'){
				//dateCalculated.setMonth(math_it_up[operator](dateCalculated.getMonth(),1));
				var addOrSubtractMonth= (operator=='btn_prev')? -1:1; //31 Jan + 1 month = 28 Feb
				dateCalculated = new Date(dateCalculated).add(addOrSubtractMonth).month();
			}else if(interval=='YEAR'){
				dateCalculated = new Date(dateCalculated).add((operator=='btn_prev')? -1:1).year();
			}
			return dateCalculated;
		}
		
	</script>
	

</head>

<body  id="fabulousbdtc">  <!-- onload="mapcolorizer = new MapColorizer(document.getElementById('map'))" -->
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
	<!-- 전체 레이어 시작 -->

	<!-- header-->
	<div id="meHeader">
	    <c:import url="/arcticPageLink.do?link=main/inc/meNavTop" />
	</div>
	
	<!-- context menu -->
	<c:set var="saveImage"><spring:message code="ctx.menu.save.image"/></c:set>
	<c:set var="printImage"><spring:message code="ctx.menu.save.print"/></c:set>
	<input id="saveImage" type="hidden" value="${saveImage}"/>
	<input id="printImage" type="hidden" value="${printImage}"/>
	
	<!-- axis title -->
	<c:set var="axisTitle"><spring:message code="timeseries.chart.axis.title.million"/></c:set>
	<input id="axisTitle" type="hidden" value="${axisTitle}"/>
	<c:set var="axisTitle_rou"><spring:message code="timeseries.chart.axis.title.roughness"/></c:set>
	<input id="axisTitle_rou" type="hidden" value="${axisTitle_rou}"/>
	
	<c:set var="showAll"><spring:message code="timeseries.chart.legend.select.all"/></c:set>
	<input id="showAll" type="hidden" value="${showAll}"/>
	
	<c:set var="extTrailling"><spring:message code="sdist.ext.title.trailling.str"/></c:set>
	<input id="extTrailling" type="hidden" value="${extTrailling}"/>
	
		<!--dateChoooooser--> 
	<!--dateChoooooser--> 
	<!--dateChoooooser--> 
	<header class="meControllPanel">
		<div class="container" align="left">
            <div class="row form-horizontal">
            
            	 <div class="col-lg-2 col-md-2 col-sm-3 col-xs-5 demo vcenter">
		            <input type="text" id="meDemo" class="form-control meHandCursor" readonly="readonly">
		            <i class="glyphicon-calendar fa fa-calendar" style="cursor:default"></i>
		          </div>
            	
            	
              <div class="vcenter">
		            <div class="pull-left" style="margin-right: 15px;">
		            		<button  type="button" class="meBtn meBtn-primary meBtn-lg outline " style="margin-top:2px;text-transform: none;" id="btn_getMostRecentOne"><spring:message code="button.latest.stuff"/></button>
		            	</div>
		            	
		            	<div class="pull-left">
		            		<button  id="btn_prev" type="button" class="meBtn meBtn-primary  fa fa-chevron-left"
		            			 onclick="getDateCalculated(this.id)"></button>
		            	</div>
	
	
					<div id="retrievalRangeSelector" class="dropdown select pull-left" style="margin-left: 3px;margin-right: 3px">
					    <button class="  btn-small dropdown-toggle " type="button" id="menu1" data-toggle="dropdown" style="margin-top:6px;">
						    	<span class="selected" id="1" value="WEEK"><spring:message code="dropdown.seeking.interval.weekly"/></span><span class="caret"></span>
					    	</button>
					    <ul class="dropdown-menu option" role="menu" >
					      <li id="1" role="presentation" value="WEEK"><a role="menuitem" tabindex="-1" ><spring:message code="dropdown.seeking.interval.weekly"/></a></li>
					      <li id="2" role="presentation" value="MONTH"><a role="menuitem" tabindex="-1" ><spring:message code="dropdown.seeking.interval.monthly"/></a></li>
					      <li id="3" role="presentation" value="YEAR"><a role="menuitem" tabindex="-1" ><spring:message code="dropdown.seeking.interval.annually"/></a></li>
					      <!-- 
					      <li role="presentation" class="divider"></li>
					       -->
					    </ul>
				    </div>
				    
			     	<div class="pull-left">
		            		<button  id="btn_next" type="button" class="meBtn meBtn-primary fa fa-chevron-right"  
		            			onclick="getDateCalculated(this.id)"></button>
		            	</div>
	            </div>	
            
            	<!-- 
            	<div id="routeSelector" class="dropdown select pull-left">
				    <button class="btn-small dropdown-toggle " type="button"  data-toggle="dropdown" style="margin-top:5px;">
				    	<span class="selected" ename="Barents Sea" id="passage1" meIdx="1" meLatLng="바렌츠해 (lat: 65 ~ 80N, lon: 20 ~ 60E)" value="barents">바렌츠해</span><span class="caret"></span>
			    	</button>
				    <ul class="dropdown-menu option" role="menu" >
				      <li id="passage1" ename="Barents Sea" meIdx="1" meLatLng="바렌츠해 (lat: 65 ~ 80N, lon: 20 ~ 60E)" value="barents"><a role="menuitem">바렌츠해</a></li>
				      <li id="passage2" ename="Kara Sea" meIdx="2" meLatLng="카라해 (lat: 70 ~ 80N, lon: 60 ~ 100E)" value="kara"><a role="menuitem" >카라해</a></li>
				      <li id="passage3" ename="Laptev Sea" meIdx="3" meLatLng="랍테프해 (lat: 70 ~ 80N, lon: 100 ~ 135E)" value="laptev"><a role="menuitem">랍테프해</a></li>
				      <li id="passage4" ename="East Siberian Sea" meIdx="4" meLatLng="동시베리아해 (lat: 70 ~ 80N, lon: 135 ~ 180E)" value="eastSiberia"><a role="menuitem">동시베리아해</a></li>
				      <li id="passage5" ename="Chukchi Sea" meIdx="5" meLatLng="척치해 (lat: 65 ~ 75N, lon: 150 ~ 180W)" value="chukchi"><a role="menuitem">척치해</a></li>
				      <li id="passage6" ename="Bering Sea" meIdx="6" meLatLng="베링해 (lat: 55 ~ 65N, lon: 160W ~ 165E)" value="bering"><a role="menuitem">베링해</a></li>
				    </ul>
			    </div>	 
            	 -->
			    
           		<div class="pull-right" style="padding-right:50px;"> 
	            	<ul id="breadcrumbs-one" class="pull-right vcenter" >
						<li><a href="<c:url value='/cmm/main/mainPage.do'/>">Home</a></li>
						<li><a><spring:message code="nav.routes"/></a></li>
					</ul>
            	</div>
            	
            	
            	
            	
            	
            	
            	
            </div>
		     
		            
        	<script type="text/javascript">
        	
    		
        	 /*        	$('body').on('click','.option li',function(){
        	        		var i = $(this).parents('.select').attr('id');
        	        		var v = $(this).children().text();
        	        		var o = $(this).attr('id');
        	        		$('#'+i+' .selected').attr('id',o);
        	        		$('#'+i+' .selected').text(v);
        	        	}); */
        	        	
        	        	
        		        	$('#retrievalRangeSelector').on('click','.option li',function(){
        		        		var i = $(this).parents('.select').attr('id');
        		        		var v = $(this).children().text();
        		        		var o = $(this).attr('id');
        		        		var valStr = $(this).attr('value'); // (WEEK || MONTH || YEAR)
        		        		$('#'+i+' .selected').attr('id',o);
        		        		$('#'+i+' .selected').text(v);
        		        		$('#'+i+' .selected').attr('value',valStr);
        		        		//var haha = $('#retrievalRangeSelector .selected').attr('value');
        		        	});
        	        	
        	        	
        	        		$('#btn_getMostRecentOne').click(function(){
        	        			//change the selected date range of that picker
        	        			$('#meDemo').data('daterangepicker').setStartDate('<c:out value="${seaRoute.compbegindate4Cal}" />');
        	        			$('#meDemo').data('daterangepicker').setEndDate('<c:out value="${seaRoute.compbegindate4Cal}" />');
        	        			
        	        			$('#meDemo').val('<c:out value="${seaRoute.compbegindate4Cal}" />');
        	        			changeImgSrc("<c:out value="${seaRoute.compbegindateInString}" />","<c:out value="${seaRoute.compbegindate4View}" />","<c:out value="${seaRoute.sensor}" />");
        	        		});
        	        	
        	           		$('#meDemo').daterangepicker({
        	           			locale: {
        	           				format: 'YYYY-MM-DD'
        	           			}, 
        	           		    "singleDatePicker": true,
        	           		    "showDropdowns": true,
        	           		    /* "startDate": moment().subtract(6, 'days'), */
        	           		    /* "endDate":moment().subtract(0, 'days'),*/
        	           		    "startDate": "<c:out value="${seaRoute.compbegindate4Cal}" />", 
        	           		    "endDate" : "<c:out value="${seaRoute.compbegindate4Cal}" />",
        	           		    "minDate": "2007-01-01",
        	           		    "maxDate": "<c:out value="${seaRoute.compbegindate4Cal}" />"     //today
        	           		    
        	           		}, function(start, end, label) {
        	           			meRequest(start);
        	           		});
        			        	
        	           		//=======================================================================
        	           		function showSeries(e) {
        	           		    this.graph.attr("stroke", (e.checked ? this.color : '#ccc'));
        	           		    if(e.checked ==  true){
        	           		        this.group.toFront();
        	           		        if(this.visible == false){
        	           		            this.show();
        	           		        }
        	           		    }
        	           		}
        	           		
        	           		$('#checkAll').click(function(){
        	           		    for(i=0; i < chart.series.length; i++) {
        	           		        if(chart.series[i].selected == false){
        	           		            chart.series[i].select();
        	           		            showSeries.call(chart.series[i], {checked: true});
        	           		        }
        	           		    }
        	           		});
        	           		$('#uncheckAll').click(function(){
        	           		    for(i=0; i < chart.series.length; i++) {
        	           		        if(chart.series[i].selected == true){
        	           		            chart.series[i].select();
        	           		            showSeries.call(chart.series[i], {checked: false});
        	           		        }
        	           		    }
        	           		});
        	           		//=======================================================================
        	           		
        	           		
        	           		var cmenu = new BootstrapMenu('#psgImg', {
			      		      actions: [{
			      		        name: '이미지 저장',
			      		        onClick: function() {
			      		         	 $('.watermark').watermark({
			      		             	path: '${pageContext.request.contextPath}/mestrap/assets/ci/banner_kma_kr_en.png',
			      		              	margin: 3,
			      		              	gravity: 'sw',
			      		              	opacity: 0.7,
			      		              	outputWidth: 'auto',
			      		    			outputHeight: 'auto',
			      		    			outputType: 'png',
			      		    			done: function(imgURL) {
			    		    				//this.src = imgURL;
			    				          	var savefilename = this.src;
			    				          	savefilename = savefilename.substring(this.src.indexOf("ssmis_"),savefilename.length);//.toUpperCase();
			    				          	/* download attribute on Anchor tag not working in IE */
			    				          	/*
			    					          	toastr.success(save);
			    			    		 		var tmp = $('<a>').attr('download', savefilename.indexOf("ssmis_")!=-1? savefilename : "notAvailable.png").attr('href', imgURL);
			    								tmp[0].click();
			    								tmp.remove(); 
			    							*/
			    				          	/* download attribute on Anchor tag not working in IE */
			    							
			    							var canvas = document.getElementById('canvas4export'), ctx = canvas.getContext('2d');
			    							var tempImg = new Image();
			    							tempImg.onload = function() {
			    								ctx.drawImage(this, 0, 0, canvas.width, canvas.height);
			    								canvas.toBlob(function(blob) {
			    								    saveAs(blob, savefilename.indexOf("ssmis_")!=-1? savefilename : "notAvailable.png");
			    								});
			    							}
			    							tempImg.src = imgURL; 
			    		    			}
			      			         });
			      			      }//onclick
			      		    	}, {
			    			        name: '이미지 인쇄',
			    			        onClick: function() {
			    			        	
			    		 	         	$('.watermark').watermark({
			    		 	         		path: '${pageContext.request.contextPath}/mestrap/assets/ci/banner_kma_kr_en.png',
				      		              	margin: 3,
				      		              	gravity: 'sw',
				      		              	opacity: 0.7,
				      		              	outputWidth: 'auto',
				      		    			outputHeight: 'auto',
				      		    			outputType: 'png',
			    			    			done: function(imgURL) {
			    								var canvas = document.getElementById('canvas4export'), ctx = canvas.getContext('2d');
			    								var tempImg = new Image();
			    								tempImg.onload = function() {
			    									ctx.drawImage(this, 0, 0, canvas.width, canvas.height);
			    								//	window.open(canvas.toDataURL('image/png')).print();
			    									var data = canvas.toDataURL();
			    									var html  = '<html><head><title></title></head>';
			    									    html += '<body style="width: 100%; padding: 0; margin: 0;"';
			    									    html += ' onload="window.focus(); window.print(); window.close()">';
			    									    html += '<img src="' + data + '" /></body></html>';
			    									var printWindow = window.open('', 'to_print');
			    									printWindow.document.open();
			    									printWindow.document.write(html);
			    									printWindow.document.close();
			    									printWindow.close();
			    								
			    								}
			    								tempImg.src = imgURL; 
			    								
			    			    			}
			    				         }); 
			    				      }//onclick
			    			    	}]
			      		    });		
        	           			
		    </script>    
		        
		</div>
	</header>
	<!--dateChoooooser--> 
	
	
	
	
	
	<div  id="contentWrapperDiv">
		
	 	<div class="container" style="padding-top:20px;">
			<!-- left.map -->
			<div class="col-md-6" align="center" >
				<!-- 
				<h4>랍테프해 (lat: 70 ~ 80, lon: 100 ~ 135)</h4>
				 -->		
				 
				<!-- 
				<div id="routeSelector" class="dropdown select pull-left">
				    <button class="  btn-small dropdown-toggle " type="button"  data-toggle="dropdown" style="margin-top:5px;">
				    	<span class="selected" ename="Barents Sea" id="passage1" meIdx="1" meLatLng="바렌츠해 (lat: 65 ~ 80N, lon: 20 ~ 60E)" value="barents">바렌츠해</span><span class="caret"></span>
			    	</button>
				    <ul class="dropdown-menu option" role="menu" >
				      <li id="passage1" ename="Barents Sea" meIdx="1" meLatLng="바렌츠해 (lat: 65 ~ 80N, lon: 20 ~ 60E)" value="barents"><a role="menuitem" tabindex="-1" >바렌츠해</a></li>
				      <li id="passage2" ename="Kara Sea" meIdx="2" meLatLng="카라해 (lat: 70 ~ 80N, lon: 60 ~ 100E)" value="kara"><a role="menuitem" tabindex="-1" >카라해</a></li>
				      <li id="passage3" ename="Laptev Sea" meIdx="3" meLatLng="랍테프해 (lat: 70 ~ 80N, lon: 100 ~ 135E)" value="laptev"><a role="menuitem" tabindex="-1" >랍테프해</a></li>
				      <li id="passage4" ename="East Siberian Sea" meIdx="4" meLatLng="동시베리아해 (lat: 70 ~ 80N, lon: 135 ~ 180E)" value="eastSiberia"><a role="menuitem" tabindex="-1" >동시베리아해</a></li>
				      <li id="passage5" ename="Chukchi Sea" meIdx="5" meLatLng="척치해 (lat: 65 ~ 75N, lon: 150 ~ 180W)" value="chukchi"><a role="menuitem" tabindex="-1" >척치해</a></li>
				      <li id="passage6" ename="Bering Sea" meIdx="6" meLatLng="베링해 (lat: 55 ~ 65N, lon: 160W ~ 165E)" value="bering"><a role="menuitem" tabindex="-1" >베링해</a></li>
				    </ul>
			    </div>
				 -->
					    
				
				<form role="form" class="form-horizontal myForm">
			      <div class="form-group">
			       		
						<div id="routeSelector" class="dropdown select pull-left">
						    <button class="btn-small dropdown-toggle " type="button"  data-toggle="dropdown" style="margin-top:5px;width:120px;">
						    	<span class="selected" ename="Barents Sea" id="passage1" meIdx="1" meLatLng="바렌츠해 (lat: 65 ~ 80N, lon: 20 ~ 60E)" value="barents"><spring:message code="shipping.routes.dropdown.barents"/></span><span class="caret"></span>
					    	</button>
						    <ul class="dropdown-menu option" role="menu" >
						      <li id="passage1" ename="Barents Sea" meIdx="1" meLatLng="(lat: 65 ~ 80N, lon: 20 ~ 60E)" value="barents"><a role="menuitem" tabindex="-1" ><spring:message code="shipping.routes.dropdown.barents"/></a></li>
						      <li id="passage2" ename="Kara Sea" meIdx="2" meLatLng="(lat: 70 ~ 80N, lon: 60 ~ 100E)" value="kara"><a role="menuitem" tabindex="-1" ><spring:message code="shipping.routes.dropdown.kara"/></a></li>
						      <li id="passage3" ename="Laptev Sea" meIdx="3" meLatLng="(lat: 70 ~ 80N, lon: 100 ~ 135E)" value="laptev"><a role="menuitem" tabindex="-1" ><spring:message code="shipping.routes.dropdown.laptev"/></a></li>
						      <li id="passage4" ename="East Siberian Sea" meIdx="4" meLatLng="(lat: 70 ~ 80N, lon: 135 ~ 180E)" value="eastSiberia"><a role="menuitem" tabindex="-1" ><spring:message code="shipping.routes.dropdown.siberian"/></a></li>
						      <li id="passage5" ename="Chukchi Sea" meIdx="5" meLatLng="(lat: 65 ~ 75N, lon: 150 ~ 180W)" value="chukchi"><a role="menuitem" tabindex="-1" ><spring:message code="shipping.routes.dropdown.chukchi"/></a></li>
						      <li id="passage6" ename="Bering Sea" meIdx="6" meLatLng="(lat: 55 ~ 65N, lon: 160W ~ 165E)" value="bering"><a role="menuitem" tabindex="-1" ><spring:message code="shipping.routes.dropdown.bering"/></a></li>
						    </ul>
					    </div>	    
					    
			       		<label class="control-label pull-left" id="lbl_latlonRange" style="padding-left: 5px;"> (lat: 65 ~ 80N, lon: 20 ~ 60E)</label>	    
			       		
					</div>
					
				</form>		    
						    
					    
					    
				<div  align="center"><!-- class="mapBG" -->
					<!-- 
						<svg width="400" height="400" xmlns="http://www.w3.org/2000/svg">
			  			  <g id="svgShape">
				 		       <path fill="#ffc300" stroke="null" stroke-width="5" stroke-linejoin="null"
				       		   stroke-linecap="null" d="m235.257813,126c0,-16.984634 13.981323,-30.742188 31.242188,-30.742188c17.260895,0 31.242188,13.757553 31.242188,30.742188c0,16.984634 -13.981293,30.742188 -31.242188,30.742188c-17.260864,0 -31.242188,-13.757553 -31.242188,-30.742188z"
				       		   id="siberia" marker-start="url(#se_marker_start_siberia)" opacity="0.6"></path>
				    		    <circle fill="#afe51b" stroke="null" stroke-width="5" stroke-linejoin="null"
						          stroke-linecap="null" opacity="0.6" cx="312.500002" cy="173.499999" r="29.941406"
						          id="laptev"></circle>
						        <circle fill="#00bfbf" stroke="null" stroke-width="5" stroke-linejoin="null"
						          stroke-linecap="null" opacity="0.6" cx="320.5" cy="247.5" r="32.3125"
						          id="kara"></circle>
						        <text fill="#000000" stroke="null" stroke-width="0" stroke-linejoin="null"
						          stroke-linecap="null" opacity="0.6" x="287.5" y="110.5" id="svg_8" font-size="14"
						          font-family="Sans-serif" text-anchor="middle" xml:space="preserve">East Siberia</text>
						        <text fill="#000000" stroke="null" stroke-width="5" stroke-linejoin="null"
						          stroke-linecap="null" opacity="0.6" x="336.5" y="158.5" id="svg_9" font-size="14"
						          font-family="Sans-serif" text-anchor="middle" xml:space="preserve">Laptev Sea</text>
						        <text fill="#000000" stroke="null" stroke-width="5" stroke-linejoin="null"
						          stroke-linecap="null" opacity="0.6" x="337.5" y="237.5" id="svg_10" font-size="14"
						          font-family="Sans-serif" text-anchor="middle" xml:space="preserve">Kara Sea</text>
	         				 </g>
						</svg>
					 -->
					 
					<canvas width="434" height="434" id="canvas4export" style="display: none;"></canvas>
					<img class="img-responsive" src="<c:url value="/assets/passgeMap.png"/>"  width="80%">
				</div>
				<!-- 
			    <p>
	    	      <object id="map" data="<c:url value="/js/scalable/BlankMap-World6_compact_+++.svg"/>" width="100%" height="415px" type="image/svg+xml"></object>
			      Click a country to give it a color!</p>
			    <button onclick="mapcolorizer.export_svg()">Export SVG</button>
			    <button onclick="mapcolorizer.export_stylesheet()">Export map stylesheet only</button>
			    <p style="font-size:75%; text-align: right">By <a href="mailto:ed@opera.com">Erik Dahlström</a>, 2008<br/>
			    World map from <a href="http://commons.wikimedia.org/wiki/Image:BlankMap-World6,_compact.svg">Wikimedia Commons</a>, public domain.
		      	<object id="mapArctic" data="<c:url value="/js/scalable/arctic.svg"/>" width="30%" height="30%" type="image/svg+xml"></object>
			    </p>
				 -->
			</div>
			
			
			<!-- right.smallIce spatialDistribution image -->
			<div id="psgImgWrapper" class="col-md-6" align="center">
				<h4>바렌츠해 ${seaRoute.sensor} 해빙 면적</h4> 
				<h5>${seaRoute.compbegindate4View} </h5>
		        <img id="psgImg" class="img-responsive watermark"  width="65%;"  alt="북극항로 공간분포 그래픽">
			</div>
		</div>	 			
	<!-- 
		<div class="container">
			    <p>
	    	      <object id="map" data="<c:url value="/js/scalable/BlankMap-World6_compact_+++.svg"/>" width="100%" height="415px" type="image/svg+xml"></object>
			      Click a country to give it a color!</p>
			    <button onclick="mapcolorizer.export_svg()">Export SVG</button>
			    <button onclick="mapcolorizer.export_stylesheet()">Export map stylesheet only</button>
			    <p style="font-size:75%; text-align: right">By <a href="mailto:ed@opera.com">Erik Dahlström</a>, 2008<br/>
			    World map from <a href="http://commons.wikimedia.org/wiki/Image:BlankMap-World6,_compact.svg">Wikimedia Commons</a>, public domain.
		      	<object id="mapArctic" data="<c:url value="/js/scalable/arctic.svg"/>" width="100%" height="100%" type="image/svg+xml"></object>
			    </p>
		</div>	
	 -->		
		
		<div class="container ">
			<hr/>         	
	    </div>
	         	
	         	
		<!-- timeseries -->
		<div class="container">
			<div class="col-lg-12" >
				<div id="psgExt" class="col-lg-6 col-md-6 col-sm-12"  style="height: 280px"></div>
				<div id="psgRou" class="col-lg-6 col-md-6 col-sm-12" style="height: 280px"></div>
		 	</div>
	
		</div>	
		
	</div>
	
    <!-- Footer -->
	<div id="meFooter"  style="margin-top: 20px;">
		<c:import url="/arcticPageLink.do?link=main/inc/meFooter" />
	</div>	 	
	
</body>

</html>