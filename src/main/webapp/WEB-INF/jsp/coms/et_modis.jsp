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
	$("#topNavi").find("#datepicker").datepicker({
		 inline: true,
		showOtherMonths: true,
		dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
		dateFormat: 'yy-mm-dd',
	  	onSelect:function(selected,event){
	  		udpateDateHandler(selected);
	  	}
	});
});	

	function requestData(dateFrom){
		$.ajax({
			type: 'GET',dataType:'json',contentType:'application/json',
			url: '${pageContext.request.contextPath}/ajax/et/coms/comparison_with_modis',
			data:'reqType=et_modis'+'&dateFrom='+dateFrom.substring(0,6),
			//dataType:'json',
	        success: function(jsonData) {
				sst_scatter=[];
	        	
				if(jsonData.latestStuff !=null){
					var date_lastOne = new Date(jsonData.latestStuff.substring(0,4) , jsonData.latestStuff.substring(4,6)*1 -1);//, jsonData.latestStuff.substring(6,8));
					$('#ui-datepicker-div').css('display','none'); // eliminate the visual artifact on the screen.. 
					$('#datepicker').datepicker("setDate", date_lastOne);
				}
				
				 $('#titleContainer').find('#retrievalRange').text('(' + jsonData.modis_korea.dateActual + ')');
				
				if(jsonData.modis_korea.matchupData !=null) subtractPointData(jsonData.modis_korea, 'modis_korea');
				if(jsonData.modis_easia.matchupData !=null) subtractPointData(jsonData.modis_easia, 'modis_easia');
	       },
				
	        cache: false	
		});
	}
	
	function subtractPointData(modisComparison, targetDiv){
		arr_sPlot = [];
		
		for ( var i = 0; i < modisComparison.matchupData.length; i++) {
			var nimr = modisComparison.matchupData[i].et_nimr;
			var modis = modisComparison.matchupData[i].pet_modis;
			arr_sPlot.push([parseNumericVal(modis),parseNumericVal(nimr)]);
		}

		//var resultStr = "<b>RMSE: " + jsonData.RMSE + '</b><br><b>Bias: ' + jsonData.Bias + '</b><br><b>Nobs: ' + jsonData.Nobs +'</b>';
		//placeSomeLabelOnTheChart(_chart_sPlot, resultStr, 10, 20, 'mResult');
		var _chart; 
		if(targetDiv == 'modis_korea'){
			_chart = $('#div_kor').highcharts();				
		}else if(targetDiv == 'modis_easia'){
			_chart = $('#div_eAsia').highcharts();				
		}
		
		_chart.series[0].setData(arr_sPlot); 
		_chart.setTitle(undefined, {text:modisComparison.dateActual});
		setVerificationTable(modisComparison, targetDiv);
		
//		var resultStr = '<b>RMSE: ' + modisComparison.RMSE + '</b><br><b>Bias: ' + modisComparison.Bias + '</b><br><b>Nobs: ' + modisComparison.Nobs +'</b>';
//		placeSomeLabelOnTheChart(_chart, resultStr, 10, 20, 'mResult');
	}
	
	function setVerificationTable(vObj, whichOne){
		if(whichOne=='modis_easia'){
			$('.ea_date').html(vObj.dateActual);
			$('.ea_rmse').html(vObj.RMSE);
			$('.ea_bias').html(vObj.Bias);
			$('.ea_nobs').html(vObj.Nobs);
		}else{
			$('.ko_date').html(vObj.dateActual);
			$('.ko_rmse').html(vObj.RMSE);
			$('.ko_bias').html(vObj.Bias);
			$('.ko_nobs').html(vObj.Nobs);
		}
	}
	
	function placeSomeLabelOnTheChart(chartObj, someTxt, leftPad, topPad, idStr){
		alert(someTxt);
		$('#mResult').remove();
		text = chartObj.renderer.text(someTxt).add();
		textBBox = text.getBBox();
		x = chartObj.plotLeft +  leftPad ; //- (textBBox.width  * 0.5);
		y = chartObj.plotTop  +  topPad;
		text.attr({x: x, y: y, id:idStr, zIndex:999});
	}
	
	//missing val  <-assign null
	function parseNumericVal(someStuff){
		
		if(someStuff == null){
			return null;
		}else{
			return parseFloat(someStuff);
		}
	}

	function udpateDateHandler(selectedDateStr) {
		$("#topNavi").find("#datepicker").val(selectedDateStr);
		requestData(selectedDateStr.split('-').join('').substring(0,6));
	}
	
	
	function updateSelectedDate(selectedDateStr){
		requestData(selectedDateStr.split('-').join('').substring(0,6));
	}
	
	function getDateCalculated(whichOperator){
		var dateStr =  $("#datepicker").val();		
		var currDate = $.datepicker.parseDate('yy-mm-dd',dateStr);
		currDate = getRetrievalInterval(whichOperator,currDate);
		$('#datepicker').datepicker("setDate", currDate);
		updateSelectedDate( $("#datepicker").val());
	}
	
	function getRetrievalInterval(operator,currDate){
		var dateCalculated = currDate;
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
	
</script>


<script>
var sPlot_eAsia;
var sPlot_kor;

$(document).ready(
	function() {
		sPlot_eAsia = new Highcharts.Chart({
			chart: {
	            type: 'scatter',
	            renderTo: 'div_eAsia',  						events:{load:requestData('init')},
	            plotBorderWidth:1,
	            plotBorderColor:'black',
	            zoomType: 'xy',
	            style: {
                	fontFamily: 'NanumGothic'
            	}
	        },
	        
	        title: {
	            text: '동아시아',x:25,
	            style:{
	            	font:'bold 15px NanumGothic'
	            }
	        },
	        subtitle: {
	            text: ' . ',x:25,
	            style:{
	            	font:'normal 13px NanumGothic'
	            }
	        },
	        xAxis: {
	            title: {
	                enabled: true,
	                text: 'MODIS 가능증발산량 (mm/day)'
	            },
	            min:0,
	            max:10,
	            tickInterval:2,
	            //lineWidth:1,
	            lineColor:'#000000',
	            gridLineWidth:1,
	            //gridLineDashStyle: 'longdash',
//	            startOnTick: true,
//	            endOnTick: true,
//	            showLastLabel: true,
				tickLength:0
				
	        },
	        yAxis: {
	            title: {
	                text: 'NMSC 위성 증발산량 (mm/day)'
	            },
	            min:0,
	            max:10,
	            tickInterval:2,
	            //lineWidth:1,
	            lineColor:'#000000',
	          //  gridLineDashStyle: 'longdash',
	            gridLineWidth:1,
	        },
	        
			exporting: {
				enabled:false
//	            chartOptions: {
//	                chart: {
//	                    events: {
//	                        load: function () {
//	                            this.renderer.image('http://112.217.150.33:8319/assets/banner_nimr.png', 530, 40, 92, 50)
//	                                .add();
//	                        }
//	                    }
//	                }
//	            }
	        },
	        
	        credits: {
	            enabled: false
	        },
	        plotOptions: {
	            scatter: {
	                marker: {
	                    radius: 3,
	                    states: {
	                        hover: {
	                            enabled: true,
	                            lineColor: '#0c66a4'
	                        }
	                    }
	                },
	                states: {
	                    hover: {
	                        marker: {
	                            enabled: false
	                        }
	                    }
	                },
	                tooltip: {
	                    headerFormat: '<b>{series.name}</b><br>',
	                    pointFormat: '{point.x} °C  /  {point.y} °C'
	                }
	            }
	        },
	        series: [{
	            name: 'NMSC ET .vs. MODIS PET',
	            color: 'rgba(1, 151, 255, .5)',
	            showInLegend:false,
	            data: []
	        },
	        {
                type: 'line',
                name: 'Regression Line',
                data: [[0,0], [10,10]],
                showInLegend:false,
                lineWidth:1,
                lineColor:'#0066ff',
                marker: {
                    enabled: false
                },
                states: {
                    hover: {
                        lineWidth: 0
                    }
                },
                enableMouseTracking: false
            }]
		},function (chart) { // on complete
//	        chart.renderer.path(['M', 64, 353, 'L', 341, 63])
//	            .attr({
//	                'stroke-width': 1,
//	                stroke: '#555555',
//	            })
//	            .add();
		});
		
		
		
		sPlot_kor = new Highcharts.Chart({
			chart: {
	            type: 'scatter',
	            renderTo: 'div_kor',  					//	events:{load:requestData('init')},
	            plotBorderWidth:1,
	            plotBorderColor:'black',
	            zoomType: 'xy',
	            style: {
                	fontFamily: 'NanumGothic'
            	}
	        },
	        
	        title: {
	            text: '한반도',x:25,
	            style:{
	            	font:'bold 15px NanumGothic'
	            }
	        },
	        subtitle: {
	            text: ' . ',x:25,
	            style:{
	            	font:'normal 13px NanumGothic'
	            }
	        },
	        xAxis: {
	            title: {
	                enabled: true,
	                text: 'MODIS 가능증발산량 (mm/day)'
	            },
	            min:0,
	            max:10,
	            tickInterval:2,
	            lineWidth:1,
	            lineColor:'#000000',
	            gridLineWidth:1,
//	            startOnTick: true,
//	            endOnTick: true,
//	            showLastLabel: true,
				tickLength:0
				
	        },
	        yAxis: {
	            title: {
	                text: 'NMSC 위성 증발산량 (mm/day)'
	            },
	            min:0,
	            max:10,
	            tickInterval:2,
	            lineWidth:1,
	            lineColor:'#000000',
	            gridLineWidth:1,
	        },
	        
			exporting: {
				enabled:false
	        },
	        
	        credits: {
	            enabled: false
	        },
	        plotOptions: {
	            scatter: {
	                marker: {
	                    radius: 3,
	                    states: {
	                        hover: {
	                            enabled: true,
	                            lineColor: '#0c66a4'
	                        }
	                    }
	                },
	                states: {
	                    hover: {
	                        marker: {
	                            enabled: false
	                        }
	                    }
	                },
	                tooltip: {
	                    headerFormat: '<b>{series.name}</b><br>',
	                    pointFormat: '{point.x} °C  /  {point.y} °C'
	                }
	            }
	        },
	        series: [{
	            name: 'NMSC ET .vs. MODIS PET',
	            color: 'rgba(1, 151, 255, .5)',
	            showInLegend:false,
	            data: []
	        },
	        {
                type: 'line',
                name: 'Regression Line',
                data: [[0,0], [10,10]],
                showInLegend:false,
                lineWidth:1,
                lineColor:'#0066ff',
                marker: {
                    enabled: false
                },
                states: {
                    hover: {
                        lineWidth: 0
                    }
                },
                enableMouseTracking: false
            }]
		},function (chart) { // on complete
//	        chart.renderer.path(['M', 64, 353, 'L', 341, 63])
//	            .attr({
//	                'stroke-width': 1,
//	                stroke: '#555555',
//	            })
//	            .add();
		});
});			





    
    
        

    
    
    
    

    
</script>


	
</head>

<body id="fabulousbdtc">


	<div class="hor-align" id="content">

<div align="left" id="timeSeriesContentWrapper">		

		<div class="hbox">
		
			<div id="topNavi" class="navigator" align="left" style="padding-left: 10px;">
				<p>
					<label for="datepicker" style="font-size: 13px;">날짜 선택: </label><input type="text" id="datepicker" style="width: 80px;font-size: 12px;">
					<input type="button" id="btn_latest" value="최근" style="width: 55px;font-size: 9pt" onclick="requestData('init')"/>
					 | <input type="button"  id="btn_prev"  value="&lt;" style="width: 30px;font-size: 9pt"  onclick="getDateCalculated(this.id)"/>
					<select id="retrievalIntervalChooser" style="font-size: 9pt;"  title="검색 간격 선택">
						<option value="MONTH">1 Month</option>
					</select>
					<input type="button" id="btn_next" value="&gt;" style="width: 30px;font-size: 9pt" onclick="getDateCalculated(this.id)"/>
				</p>
			</div>
			<div align="center" class="titleEnhancer" id="varTitleContainer">
				<br>
				<div>Comparison of daily NMSC Evapotranspiration with MODIS data</div>
				<div id="retrievalRange">&nbsp;</div>
			</div>
			<div class="hor-align" align="center">
				<div id="div_eAsia" class="sdist" style="width: 350px;height: 410px"></div>
				<div id="div_kor" class="sdist" style="width: 350px;height: 410px"></div>
			</div>
			
			<!-- 
			<div align="center" class="title" style="width: 700px">
				<p>Vertical Averaged Verification Table<p>
			</div>
			 -->
			<div class="hor-align" align="center" style="height: 75px">
				<div class="sdist" style="width:350px;height:75px" align="center">
					<table  id="veriTbl"   class="tblVerification"  width="280px" style="margin-left: 50px">
						<tr>
							<td   width="80">Date</td>
							<td  >Bias</td>
							<td style="border:1px gray solid;">RMSE</td>
							<td  >Nobs</td>
						</tr>
							<tr>
							<td  class='ea_date'  >&nbsp;</td>
							<td class='ea_bias'  >&nbsp;</td>
							<td class='ea_rmse'  >&nbsp;</td>
							<td class='ea_nobs' style="border:1px gray solid;">&nbsp;</td>
						</tr>
					</table>
				</div>
				<div class="sdist" style="width:350px;height:75px"  align="center">
				<table  id="veriTbl"   class="tblVerification"  width="280px" style="margin-left: 50px">
						<tr>
							<td   width="80">Date</td>
							<td  >Bias</td>
							<td  >RMSE</td>
							<td  >Nobs</td>
						</tr>
						<tr>
							<td class='ko_date'  >&nbsp;</td>
							<td class='ko_bias'  >&nbsp;</td>
							<td class='ko_rmse'  >&nbsp;</td>
							<td class='ko_nobs'  >&nbsp;</td>
						</tr>
					</table>
				</div>
			</div>
			
			<div align="left" class="navigator"
				style="padding-left: 20px; padding-top: 0px; font-size: 12px;"" >※ MODIS 위성자료는 실시간으로 제공되지 않습니다.
			</div>
			
			<!-- 
			<div class="navigator" style="border:1px solid black;">
				<div> sample container</div>
				<div>
					<div>header</div>
					<span>content goes here</span>
					<span>side menu optional</span>
				</div>
				<div>footer</div>
			</div>
			 -->
		</div>	

</div>		
		
	</div>	
</body>

</html>