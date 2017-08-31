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
    
	<!-- datePicker -->
	<link href="<c:url value="/js/daterangepicker/daterangepicker.css"/>" rel="stylesheet" type="text/css">	
	<script type="text/javascript" src="<c:url value="/js/daterangepicker/moment.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/daterangepicker/daterangepicker.js"/>"></script>
    <!-- dateJS -->
	<script type="text/javascript" src="<c:url value="/js/jquery/date.js"/>"></script>
	
    
	<!-- 2c.doe.hicharts -->
	<script src="<c:url value="/js/highchart/highcharts.js"/>"></script>
	<script src="<c:url value="/js/highchart/highcharts-more.js"/>"></script>
	<script src="<c:url value="/js/highchart/modules/exporting.js"/>"></script>
	<script src="${pageContext.request.contextPath}/js/highchart/modules/offline-exporting.js"></script>


<script>
	
	var thisYear = 2017;
	var extAvg_since2007 = 0;
	var extAvg_since1988 = 0;
	
	var extentSeriesJson;
	
	/**
	DEREPCATED
	*/
	function requestData(dateFrom){
		$.ajax({
			type: 'GET',dataType:'json',contentType:'application/json',
			url: '${pageContext.request.contextPath}/ajax/getSeriesData',
			data:'whichSeries=ts_ice',
	        success: function(jsonData) {
				extentSeriesJson = jsonData.data.ice.someList.ext;			
//				console.log(jsonData.data.ice.someList.hasOwnProperty('extAvg_since2007'));
				extAvg_since2007 = (jsonData.data.ice.someList.hasOwnProperty('extAvg_since2007'))? jsonData.data.ice.someList.extAvg_since2007 : 11.2714; // ~2015 
				extAvg_since1988 = (jsonData.data.ice.someList.hasOwnProperty('extAvg_since1988'))? jsonData.data.ice.someList.extAvg_since1988 : null; // ~2015 
				subtractPointData(jsonData.data.ice.someList.ext, 'ts_extent');
	        },
	        cache: false	
		});
	}
	
	
	function meRequest(meDateObj){
  	  	redrawSeriesData(extentSeriesJson,meDateObj.format('YYYY-MM-DD'));
	}
	
	
	var minDate = new Date(2007,0,01);
	var recentStuffArr = "${extSeries.compbegindate4Cal}".split('-');
	var mostRecentDate = new Date(recentStuffArr[0],recentStuffArr[1]-1,recentStuffArr[2]);
	/* console.log(mostRecentDate instanceof Date && !isNaN(mostRecentDate.valueOf())) */
	
	function getDateCalculated(whichOperator){
		var dStrArr =  $("#meDemo").val().split('-');		
		//var currDate = $('#meDemo').data('daterangepicker').startDate;    ---> not a date obj
		var currDate = new Date(dStrArr[0],dStrArr[1]-1,dStrArr[2]);
		var dateTarget = getRetrievalInterval(whichOperator,currDate);
		
		if(dateTarget.getTime() < minDate.getTime()){
			alert("자료 제공 범위는 2007-01-01 부터  ${extSeries.compbegindate4Cal}까지 입니다.");
			$('#meDemo').data('daterangepicker').setStartDate(moment(minDate).format('YYYY-MM-DD'));
			$('#meDemo').data('daterangepicker').setEndDate(moment(minDate).format('YYYY-MM-DD'));
			$('#meDemo').val(moment(minDate).format('YYYY-MM-DD'));
			meRequest(moment(minDate));
		}else if(dateTarget.getTime() > mostRecentDate.getTime()){
			alert("자료 제공 범위는 2007-01-01 부터  ${extSeries.compbegindate4Cal}까지 입니다.");
			$("#btn_getMostRecentOne").trigger( "click" );
		}else{
			$('#meDemo').data('daterangepicker').setStartDate(moment(dateTarget).format('YYYY-MM-DD'));
			$('#meDemo').data('daterangepicker').setEndDate(moment(dateTarget).format('YYYY-MM-DD'));
			$('#meDemo').val(moment(dateTarget).format('YYYY-MM-DD'));
			meRequest(moment(dateTarget));
		}
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
	
	function errOccuredWhileChangingSource(imgObj){
	//	imgObj.onerror = '';
		imgObj.src = "<c:url value='/assets/onError/seaice_noData.png'/>";
		return true;
	}
	
	
	
	var currYearArr = [];
	function subtractPointData(someList, targetDiv){
		e07 = [];
		e12 = [];
		e16 = [];
		e8yearMean = [];
		e8yearMean_week = [];
		eNadirPeak = [];
		weeklyMean_since98 = [];
		meanSince98 = [];
		
		for ( var i = 0; i < someList.length; i++) {
			var dateStrArr = someList[i].date.split(",");
			var mm = parseInt(dateStrArr[0]);
			var dd = parseInt(dateStrArr[1]);

			e07.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e07) ]);
			e12.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e12) ]);
			e16.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e16) ]);
			currYearArr.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].e17) ]);
			e8yearMean_week.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].weeklyMean) ]);
			weeklyMean_since98.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].weeklyMean30) ]);
			eNadirPeak.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(someList[i].nadir),parseNumericVal(someList[i].peak) ]);
		}
		var _chart; 
		//if(targetDiv == 'ts_extent'){
			_chart = $('#ts_extent').highcharts();				
		//}else if(targetDiv == 'gmd'){
		//	_chart = $('#gmd').highcharts();				
		//}else if(targetDiv == 'uld'){
		//	_chart = $('#uld').highcharts();				
		//}
		//console.log(extAvg_since2007);
		e8yearMean.push([Date.UTC(thisYear,0,1), parseNumericVal(extAvg_since2007)]);
		e8yearMean.push([Date.UTC(thisYear,11,24), parseNumericVal(extAvg_since2007)]);
		
		meanSince98.push([Date.UTC(thisYear,0,1), parseNumericVal(extAvg_since1988)]);
		meanSince98.push([Date.UTC(thisYear,11,24), parseNumericVal(extAvg_since1988)]);
		console.log(extAvg_since1988)
		
		_chart.series[0].setData(e07); 
		_chart.series[1].setData(e12); 
		_chart.series[2].setData(e16); 
		_chart.series[3].setData(currYearArr); //adios 2015
		_chart.series[4].setData(e8yearMean); 
		_chart.series[5].setData(e8yearMean_week); 
		_chart.series[6].setData(meanSince98);
		_chart.series[7].setData(weeklyMean_since98); 
		_chart.series[8].setData(eNadirPeak); 
		
		meRequest(moment(mostRecentDate));//최저순위스트링 삽입
	}
	/*
		여기서 순위스트링도 바꾸자잉
	*/
	function redrawSeriesData(extSeries,dateTarget){
		//alert("fu : "+dateTarget);
		currYearArr = [];
		//yyyymmdd = dateTarget.split('-').join('');
		dArr = dateTarget.split('-');
		
		var selectedYear = 'e' + (dArr[0].substring(2,4)); //요걸로 e+연도 스트링만들고
		var selectedMMDDInNumber = dArr[1]+dArr[2]; 
		
		//getNadir2017
		var dateTargetInDateObj = new Date(thisYear,parseInt(dArr[1])-1,parseInt(dArr[2]));
		//$('.dRangeStr_SSMIS p').text(dRangeStr); //or use .html(<strong>textGoesHere</strong>') instead haha
		$('#nadirString').html(''); //or use .html(<strong>textGoesHere</strong>') instead haha
		
		
		for ( var i = 0; i < extSeries.length; i++) {
			var dateStrArr = extSeries[i].date.split(",");
			var mm = parseInt(dateStrArr[0]);
			var dd = parseInt(dateStrArr[1]);
			
			//getNadir2017
			var dateFrom = new Date(thisYear, mm-1, dd);
			var dateTo = new Date(dateFrom).add(6).day();
			if(dateFrom <= dateTargetInDateObj && dateTargetInDateObj <= dateTo){
				//alert(moment(dateFrom).format('YYYY-MM-DD') + ' ~ ' + moment(dateTo).format('YYYY-MM-DD') + ' [' +moment(dateTargetInDateObj).format('YYYY-MM-DD')+']');
				var nadir1st = extSeries[i].nadir1;
				var nadir2nd = extSeries[i].nadir2;
				var nadir3rd = extSeries[i].nadir3;
				//alert(moment(dateFrom).format('YYYY-MM-DD') + ' : ' + nadir1st + ' / ' + nadir2nd + ' / ' + nadir3rd)
				var nadirText = '※ 1988년 이후 최저 면적('+ moment(dateFrom).format('MM월DD일') + ' ~ ' + moment(dateTo).format('MM월DD일') + ') ';
				nadirText += "<span title="+nadir1st.split(",")[1]+">1위:" + nadir1st.split(",")[0] + "년</span>";
				nadirText += ", <span title="+nadir2nd.split(",")[1]+">2위:" + nadir2nd.split(",")[0] + "년</span>";
				nadirText += ", <span title="+nadir3rd.split(",")[1]+">3위:" + nadir3rd.split(",")[0] + "년</span>";
				$('#nadirString').html(nadirText);
				//※ 1988년 이후 최저 면적(MM월 DD일~MM월 DD일) <span title="extent value">1위:YYYY년</span>, <span>2위:YYYY년</span>, <span>3위:YYYY년</span> 
			}
			//getNadir2017
			
			var mmddIntVal = (dateStrArr[0] + dateStrArr[1] + '')*1;
			if(selectedMMDDInNumber >= mmddIntVal){
				var seriesObj = extSeries[i];
				currYearArr.push([Date.UTC(thisYear,mm -1, dd),parseNumericVal(seriesObj[selectedYear]) ]); 
				//console.log(selectedYear + ' : ' + mmddIntVal + ' ->  '+  seriesObj[selectedYear]);
/* 				
				var p = extSeries[i];
				for (var key in p){
					console.log(' name=' + key + ' value=' + p[key]);	
				}
 */				
			}else{
				currYearArr.push([Date.UTC(thisYear,mm -1, dd), null]); //currSeries만 선택될 경우 axis range 마지막 데이터 날짜로 바뀌네 허허
			}
		}
		
		var _chart = $('#ts_extent').highcharts(); 
		
		_chart.series[3].setData(currYearArr); 
		_chart.series[3].update({name: dArr[0].substring(2,4)+ '\''}, false);
		_chart.redraw();
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

	
</script>



<script>
	var meChart;

	$(document).ready(function(){
		
		$.ajax({
			type: 'GET',dataType:'json',contentType:'application/json',
			url: '${pageContext.request.contextPath}/ajax/getSeriesData',
			data:'whichSeries=ts_ice',
			
	        success: function(jsonData) {
		
	        	
				meChart = new Highcharts.Chart({
					chart : {
						type : 'line',
						renderTo : 'ts_extent',  								//events:{load:requestData('init')},
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
			            text: '최근 해빙 변화 경향',
			            align: 'center',
		//	            x: 50,
			            style:{
			            	font:'bold 16px NanumGothic'
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
						tickColor: '#346691',
						labels : {
							formatter : function() {
								var myDate = new Date(this.value);
								var newDateMs = Date.UTC(myDate.getUTCFullYear(), myDate.getUTCMonth() , myDate.getUTCDate());
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
						plotBands: [{ // maxBand
						    color: 'rgba(199, 230, 253, 0.2)', // Color value
						    from: Date.UTC(thisYear,2,1), // Start of the plot band
						    to: Date.UTC(thisYear,2,31) // End of the plot band
						},{// minBand 
						    color: 'rgba(199, 230, 253, 0.2)', 
						    from: Date.UTC(thisYear,8,1), 
						    to: Date.UTC(thisYear,8,30)} 
						]
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
			            	useHTML: true,
			                text: "해빙 면적 (x10<sup>6</sup> ㎢)",
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
		
						//add a mean plot lines
						/*  plotLines: [{
					        color: '#555',
					        dashStyle : 'Dash',
					        value: '11.2714',
					        width: '0.7',
					        zIndex: 2 // To not get stuck below the regular plot lines
					    }], */
			      
			            tickInterval:2,
			            max:18,
			            min:2
			        },
			        tooltip: {
		//	            shared: true,
		//	            valueSuffix: '°C',
		//	            crosshairs: {
		//	            	color: 'red',
		//	            	snap: false
		//	           	},
		            shared: false,
			            formatter: function() {
			            	var myDate = new Date(this.x);
			            	var newDateMs = Date.UTC(myDate.getUTCFullYear(), myDate.getUTCMonth() , myDate.getUTCDate());
			                var s = '<b>'+this.series.name + '</b><br/>';
							s+= Highcharts.dateFormat('%m월 %d일', newDateMs)+'<br/>';
		//					s+= '<b>'+this.y + '</b>'
							s+= '<b>'+parseFloat(this.y).toFixed(4) + '</b>'
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
			            	//Add a image from an external resource. 
/*  			                ,chart:{
			                    events:{
			                        load:function(){
			                           // this.renderer.image('${pageContext.request.contextPath}/mestrap/assets/ci/kma_kr_en_opacity70.png', 420, 220, 189, 31).add();
			                            this.renderer.image('${pageContext.request.contextPath}/mestrap/assets/ci/footer_kma_kr_en.png', 420, 220, 189, 31).add();
			                        }
			                    }
			                }  */
			            },
			            sourceWidth: 1000,
			            sourceHeight: 500,
			            // scale: 2 (default)
			            scale: 1,
			            fallbackToExportServer: false
			        },
			        
		                /* 
					exporting: {
						enabled:false
						chartOptions:{
			                chart:{
			                    events:{
			                        load:function(){
			                            this.renderer.image("<c:url value='/assets/exp_bld_kma.png'/>", 500, 250, 189, 31).add();
			                        }
			                    }
			                }
			            } 
			        },
						*/
			        
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
			        	}  
			        },
			        series: [
				 	            {
				 	             name: '\'07',
				 	             color: '#ff0000' ,
				     	         connectNulls:false, data: []},
				 	        	{name: '\'12',
				 	           	  color: '#ff6600',            	 
				 	           	   dashStyle : 'Dash',
				 	           	connectNulls:false, data: []}, 
				 	            {name: '\'16',
				 	           	   dashStyle : 'Dash',
				 	           	   color: '#424143' ,
				 	           	connectNulls:false, data: []} ,
				 	            {name: '\'17',
				 	           	 color: '#000000', //#0000cc 
				 	           	 lineWidth:2,
				 	           	connectNulls:false, data: []} ,
				 	            {name: '10년평균(\'07~\'16)',
				 	           	 color: '#21618C', //#0000cc            	 
				 	           	 connectNulls:false, 
				 	             showInLegend: true,
					 	         dashStyle : 'Dash',
					 	         lineWidth : 0.8,
		//		 	             data: [[Date.UTC(thisYear,0,1), 11.2714], [Date.UTC(thisYear,11,24), 11.2714]],
		//		 	             data: [[Date.UTC(thisYear,0,1), extAvg_since2007], [Date.UTC(thisYear,11,24), extAvg_since2007]],
				 	             data: [],
				 	              marker: {
				 	                   enabled: false
				 	               },
				 	               states: {
				 	                   hover: {
				 	                       lineWidth: 0
				 	                   }
				 	               },
				 	               enableMouseTracking: true
				 	            } ,
				 	            {name: '주간단위 10년평균(\'07~\'16)',
				 	           	 color: '#009DFF', //#0000cc            	 
				 	           	connectNulls:false, data: []} ,
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				 	           	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				 	           	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				 	           	
				 	            {name: '29년평균(\'88~\'16)',
				 	           	 color: '#117A65', //#0000cc            	 
				 	           	 connectNulls:false, 
				 	             showInLegend: true,
					 	         dashStyle : 'Dash',
					 	         lineWidth : 0.8,
				 	             data: [],
				 	              marker: {
				 	                   enabled: false
				 	               },
				 	               states: {
				 	                   hover: {
				 	                       lineWidth: 0
				 	                   }
				 	               },
				 	               enableMouseTracking: true
				 	            } ,
				 	            {name: '주간단위 29년평균(\'88~\'16)',
				 	           	 color: '#229954', //#0000cc            	 
				 	           	connectNulls:false, data: []} ,
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				 	           	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				 	           	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				 	           	
				 	           	
				 	            {
			 	           		name: '역대최고/최저',
				 	            type: 'arearange',
				 	            lineWidth: 0,
				 	            
				 	           /*  linkedTo: ':previous', */
				 	            color: Highcharts.getOptions().colors[0],
				 	            fillOpacity: 0.3,
				 	            zIndex: 0,
			 	           	    connectNulls:false, data: []}]
			        , legend: {
		                layout: 'horizontal',
		                align: 'right',
		        //        verticalAlign: 'top',
		                itemWidth:250,
		      //          useHTML:true,
		                x: -10,
		                y: 0,
		                borderWidth: 0,
		             /*something wired    
		             	itemMarginTop: 0,
		                itemMarginBottom: 0,
		                itemStyle: {
		                    lineHeight: '14px'
		                } */
		            }    
					
				}); // chart
				
				extentSeriesJson = jsonData.data.ice.someList.ext;			
//				console.log(jsonData.data.ice.someList.hasOwnProperty('extAvg_since2007'));
				extAvg_since2007 = (jsonData.data.ice.someList.hasOwnProperty('extAvg_since2007'))? jsonData.data.ice.someList.extAvg_since2007 : 11.2714; // ~2015 
				extAvg_since1988 = (jsonData.data.ice.someList.hasOwnProperty('extAvg_since1988'))? jsonData.data.ice.someList.extAvg_since1988 : null; 
				subtractPointData(jsonData.data.ice.someList.ext, 'ts_extent');	
	
	        } //$.ajax
		 	,cache: false
		});
		
	}); //JCV good to go sir //end of $.ready


</script>

	
</head>

<body id="fabulousbdtc">
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
	<!-- 전체 레이어 시작 -->
	
	<!-- header-->
	<div id="meHeader">
	    <c:import url="/arcticPageLink.do?link=main/inc/meNavTop" />
	</div>
	
	<!--dateChoooooser--> 
	<!--dateChoooooser--> 
	<header class="meControllPanel">
		<div class="container" align="left">
            <div class="row form-horizontal">
            	 <div class="col-lg-2 col-md-2 col-sm-3 col-xs-5 demo vcenter">
		            <input type="text" id="meDemo" class="form-control" readonly="readonly">
		            <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
		          </div>
            	
            	
	             <div class="vcenter">
	            	<div class="pull-left" style="margin-right: 15px;">
	            		<button  type="button" class="meBtn meBtn-primary meBtn-lg outline " style="margin-top:2px;" id="btn_getMostRecentOne">최근</button>
	            	</div>
	            	
	            	<div class="pull-left">
	            		<button  id="btn_prev" type="button" class="meBtn meBtn-primary  fa fa-chevron-left"
	            			 onclick="getDateCalculated(this.id)"></button>
	            	</div>


					<div id="retrievalRangeSelector" class="dropdown select pull-left"
						style="margin-left: 3px; margin-right: 3px">
						<button class="  btn-small dropdown-toggle " type="button"
							id="menu1" data-toggle="dropdown" style="margin-top: 6px;">
							<span class="selected" id="1" value="WEEK">1주일</span><span
								class="caret"></span>
						</button>
						<ul class="dropdown-menu option" role="menu">
							<li id="1" role="presentation" value="WEEK"><a
								role="menuitem" tabindex="-1">1주일</a></li>
							<li id="2" role="presentation" value="MONTH"><a
								role="menuitem" tabindex="-1">1개월</a></li>
							<li id="3" role="presentation" value="YEAR"><a
								role="menuitem" tabindex="-1">1년</a></li>
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
            
           		<div class="pull-right" style="padding-right:50px;"> 
	            	<ul id="breadcrumbs-one" class="pull-right vcenter" >
						<li><a href="<c:url value='/cmm/main/mainPage.do'/>">Home</a></li>
						<li><a>해빙감시</a></li>
						<li><a>최근해빙변화</a></li>
					</ul>
            	</div>
            </div>
		     
		            
        	<script type="text/javascript">
        	
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
        			$('#meDemo').data('daterangepicker').setStartDate('<c:out value="${extSeries.compbegindate4Cal}" />');
        			$('#meDemo').data('daterangepicker').setEndDate('<c:out value="${extSeries.compbegindate4Cal}" />');
        			$('#meDemo').val('<c:out value="${extSeries.compbegindate4Cal}" />');
					//click event는 발생안하네        			
        			meRequest(moment(mostRecentDate));
        		});
        	
           		$('#meDemo').daterangepicker({
           			locale: {
           				format: 'YYYY-MM-DD'
           			}, 
           		    "singleDatePicker": true,
           		    "showDropdowns": true,
           		    /* "startDate": moment().subtract(6, 'days'), */
           		    /* "endDate":moment().subtract(0, 'days'),*/
           		    "startDate": "<c:out value="${extSeries.compbegindate4Cal}" />", 
           		    "endDate" : "<c:out value="${extSeries.compbegindate4Cal}" />",
           		    "minDate": "2007-01-01",
           		    "maxDate": "<c:out value="${extSeries.compbegindate4Cal}" />"     //today
           		    
           		}, function(start, end, label) {
           			
           			meRequest(start);
           			
           		 /* 
           		  console.log("<c:out value="${extSeries.compbegindate4Cal}" />");
           		  console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
           		  console.log("[START] " + start.format('YYYY-MM-DD')); //start=longtime
           		  console.log("[END] " + end.format('YYYY-MM-DD'));
           		  console.log("[LABEL] " + label);
           		  console.log(start);
           		  console.log(end);
           		  console.log(label); 
           		  */
           		  
           		});
		        	
		    </script>    
		        
		</div>
	</header>
	<!--dateChoooooser--> 
	
	
	
	
	<div class="container"  id="contentWrapperDiv">
		<div class="hor-align" align="center">
			<div id="ts_extent" class="sdist" style="width:100%; height: 530px;padding-top: 20px"></div>
	 	</div>
	 	<div id="nadirString" style="padding-left:55px"> </div> 
 	</div>
	
    <!-- Footer -->
	<div id="meFooter"  style="margin-top: 20px;">
		<c:import url="/arcticPageLink.do?link=main/inc/meFooter" />
	</div>	 	
</body>

</html>