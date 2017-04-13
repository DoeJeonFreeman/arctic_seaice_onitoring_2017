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
	
	
	    <link href="<c:url value="/mestrap/css/COMS_ET/normalize.css"/>" rel="stylesheet">
	


	<!-- datePicker -->
	<link href="<c:url value="/js/daterangepicker/daterangepicker.css"/>" rel="stylesheet" type="text/css">	
	<script type="text/javascript" src="<c:url value="/js/daterangepicker/moment.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/daterangepicker/daterangepicker.js"/>"></script>
    <!-- dateJS -->
	<script type="text/javascript" src="<c:url value="/js/jquery/date.js"/>"></script>
	

	<script type="text/javascript" src="<c:url value="/js/jquery/jquery.zoom.min.js"/>"></script>
	<link rel="stylesheet" href="<c:url value="/mestrap/css/COMS_ET/zoomable.css"/>">
	<script>
		$(document).ready(function(){
			$('#et_sdist_zoom').zoom({ on:'click' });			 
		});
	</script>


<script>
	//document is good to go man
	$(function () {
//		$("#sst_daily").imageLens({ lensSize: 200 });
		
		requestData();
	});	
	
	
	function requestData(){
		$.ajax({
			type: 'GET',dataType:'json',contentType:'application/json',
			url: '${pageContext.request.contextPath}/ajax/et/coms/monthlyMeanNMSCEvapotranspiration',
			data:'reqType=et_sDist'+'&dateFrom=INIT',
			//dataType:'json',
	        success: function(jsonData) {
				if(jsonData.latestStuff !=null){
					var date_lastOne = new Date(jsonData.latestStuff.substring(0,4) , jsonData.latestStuff.substring(4,6)*1 -1);
					//datipicker setDate() method is causing the datepicker to always be seen at the bottom of the page..
					// append the following right after datepicker creation code
					$('#ui-datepicker-div').css('display','none'); // eliminate the visual artifact on the screen.. 
					$('#datepicker').datepicker("setDate", date_lastOne);
					
					
					$('#varTitleContainer').find('#retrievalRange').text('Monthly Mean NMSC Evapotranspiration (' + date_lastOne.customFormat( "#YYYY#.#MM#." ) + ')');
					
					 var path_img = "${pageContext.request.contextPath}/DAGR/et/COMS_OUT/ET_" +  date_lastOne.customFormat( "#YYYY##MM#" )+ "_mean.png";
			        $("#et_sdist").attr("src",path_img);
			        $('#et_sdist_zoom').zoom({ on:'click' });			 
					
				}
	       },
				
	        cache: false	
		});
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
	
	function udpateDateHandler(selectedDateStr){
		var yyyymmdd = selectedDateStr.split('-').join('') + '';
		updateSelectedDate(yyyymmdd);
	}
	
	
	function updateSelectedDate(selectedDateStr){
		var path_img = "${pageContext.request.contextPath}/DAGR/et/COMS_OUT/ET_";
		 $("#et_sdist").attr("src",path_img + selectedDateStr.substring(0,6) + "_mean.png");
		 
		 var currDate = new Date(selectedDateStr.substring(0,4) , selectedDateStr.substring(4,6)*1 -1,  selectedDateStr.substring(6,8));
		 
		$('#varTitleContainer').find('#retrievalRange').text('Monthly Mean NMSC Evapotranspiration (' + currDate.customFormat( "#YYYY#.#MM#." ) + ')');
		$('#et_sdist_zoom').zoom({ on:'click' });			 
	}
	
	function getDateCalculated(whichOperator){
		var dateStr =  $("#datepicker").val();		
		var currDate = $.datepicker.parseDate('yy-mm-dd',dateStr);
		currDate = getRetrievalInterval(whichOperator,currDate);
		$('#datepicker').datepicker("setDate", currDate);
		updateSelectedDate( $("#datepicker").val().split('-').join(''));
	}
	
	function getRetrievalInterval(operator,currDate){
		var dateCalculated = currDate;
//		var interval = $('#retrievalIntervalChooser option:selected').text();
		var interval = $('#retrievalIntervalChooser').find(":selected").val()+'';
		//  //,'btn_latestStuff' : function() {}
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
		}else if(interval=='YEAR'){
			dateCalculated.setFullYear(math_it_up[operator](dateCalculated.getFullYear(),1));
			// btn_latest // return latest Stuff dateObj.. 
		}
		return dateCalculated;
	}
	
	function ImgError(source){
		//	source.onerror = '';
			source.src = "${pageContext.request.contextPath}/DAGR/et/ET_noDataAvailable.png";
			$('#et_sdist_zoom').trigger('zoom.destroy');		
			return true;
	}
	
</script>



<script>

$(function () {
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
					<input type="button" id="btn_latest" value="최근" style="width: 55px;font-size: 9pt" onclick="requestData()"/>
					 | <input type="button"  id="btn_prev"  value="&lt;" style="width: 30px;font-size: 9pt"  onclick="getDateCalculated(this.id)"/>
					<select id="retrievalIntervalChooser" style="font-size: 9pt;"  title="검색 간격 선택">
						<option value="MONTH">1 Month</option>
						<option value="YEAR">1 Year</option>
					</select>
					<input type="button" id="btn_next" value="&gt;" style="width: 30px;font-size: 9pt" onclick="getDateCalculated(this.id)"/>
				</p>
			</div>
			<div align="center" class="titleEnhancer"  id="varTitleContainer" >
				<p id="retrievalRange">Monthly Mean NMSC Evapotranspiration</p>
			</div>
			<!-- 
			<div align="center" class="subtitle" id="varTitleContainer" >
					<p id="retrievalRange"> &nbsp;<p>
			</div>
			 -->
			<div  align="center" class="hbox">
				<div  style="width: 660px; "  class="sdist">
					<span class="zoom" id="et_sdist_zoom" >
						<img id="et_sdist"    width="660px"  alt="monthly mean NMSC Evapotranspiration"  onerror="return ImgError(this)">
					</span>
				</div>
				<div style="font-size: 12px; display: inline-block;" >
					<font>mm/Day</font>
				</div>
			</div>
			<br>
		</div>	

</div>
		
	</div>
</body>

</html>
