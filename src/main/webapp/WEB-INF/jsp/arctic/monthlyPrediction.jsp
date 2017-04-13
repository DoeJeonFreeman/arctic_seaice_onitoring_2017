<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<title>해빙전망</title>
	
	<script src="<c:url value="/js/jquery/jquery-1.9.1.js"/>"></script>	
    <script src="<c:url value="/mestrap/js/bootstrap.min.js"/>"></script>
    <!-- Bootstrap Core CSS -->
    <link href="<c:url value="/mestrap/css/bootstrap.min.css"/>" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="<c:url value="/mestrap/css/modern-business.css"/>" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<c:url value="/mestrap/font-awesome/css/font-awesome.min.css"/>" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

	<!-- datePicker -->
	<link href="<c:url value="/js/daterangepicker/daterangepicker.css"/>" rel="stylesheet" type="text/css">	
	<script type="text/javascript" src="<c:url value="/js/daterangepicker/moment.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/daterangepicker/daterangepicker.js"/>"></script>
    <!-- dateJS -->
	<script type="text/javascript" src="<c:url value="/js/jquery/date.js"/>"></script>
	
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
		$(document).ready(function(){
			//console.log('mostRecentStuff.lateststuff:: ${mostRecentStuff.lateststuff}');
		    var path_img = "<c:url value='/data/IMG/PRD/'/>" + "fig_ext_${mostRecentStuff.lateststuff}.png";
	        $("#monthlyPrediction").attr("src",path_img);
			
		}); //JCV good to go sir
		
		
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
		function meRequest(meDateObj){
      	    changeImgSrc(meDateObj.format('YYYYMM'));
		}
		
		
		function changeImgSrc(dateStr){
			//alert(dateStr);
			var path = "<c:url value='/data/IMG/PRD/'/>" + "fig_ext_"+dateStr+".png";
			$("#monthlyPrediction").attr("src",path);
		}
		
		
		
		//var minDate = 20070101;
		//var mostRecent = "${sdist.compbegindateInString}" * 1;
		var minDate = new Date(2015,5,01);
		var recentStuffArr = "${mostRecentStuff.lateststuff4Cal}".split('-');
		var mostRecentDate = new Date(recentStuffArr[0],recentStuffArr[1]*1 -1,recentStuffArr[2]);
		/* console.log(mostRecentDate instanceof Date && !isNaN(mostRecentDate.valueOf())) */
		
		function getDateCalculated(whichOperator){
			var dStrArr =  $("#meDemo").val().split('-');		
			//var currDate = $('#meDemo').data('daterangepicker').startDate;    ---> not a date obj
			var currDate = new Date(dStrArr[0],dStrArr[1]-1,dStrArr[2]);
			var dateTarget = getRetrievalInterval(whichOperator,currDate);
			
			if(dateTarget.getTime() < minDate.getTime()){
				alert("자료 제공 범위는 2015-06-01 부터   ${mostRecentStuff.lateststuff4Cal}까지 입니다.");
				$('#meDemo').data('daterangepicker').setStartDate(moment(minDate).format('YYYY-MM-DD'));
    			$('#meDemo').data('daterangepicker').setEndDate(moment(minDate).format('YYYY-MM-DD'));
    			$('#meDemo').val(moment(minDate).format('YYYY-MM-DD'));
				meRequest(moment(minDate));
			}else if(dateTarget.getTime() > mostRecentDate.getTime()){
				alert("자료 제공 범위는 2015-06-01 부터   ${mostRecentStuff.lateststuff4Cal}까지 입니다.");
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

<body id="fabulousbdtc" >
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
	<!-- 전체 레이어 시작 -->
	

	<!-- header-->
	<div id="meHeader">
	    <c:import url="/arcticPageLink.do?link=main/inc/meNavTop" />
	</div>
	

	<!--dateChoooooser--> 
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
	            	
	            	
	            	<div id="retrievalRangeSelector" class="dropdown select pull-left" style="margin-left: 3px;margin-right: 3px">
					    <button class="  btn-small dropdown-toggle " type="button" id="menu1" data-toggle="dropdown" style="margin-top:6px;">
					    	<span class="selected" id="2" value="MONTH">1개월</span><span class="caret"></span>
				    	</button>
					    <ul class="dropdown-menu option" role="menu" >
					      <li id="2" role="presentation" value="MONTH"><a role="menuitem" tabindex="-1" href="#">1개월</a></li>
					      <li id="3" role="presentation" value="YEAR"><a role="menuitem" tabindex="-1" href="#">1년</a></li>
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
						<li><a href="#">해빙전망</a></li>
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
	        	});
        	
        		$('#btn_getMostRecentOne').click(function(){
        			//change the selected date range of that picker
        			$('#meDemo').data('daterangepicker').setStartDate('<c:out value="${mostRecentStuff.lateststuff4Cal}" />');
        			$('#meDemo').data('daterangepicker').setEndDate('<c:out value="${mostRecentStuff.lateststuff4Cal}" />');
        			
        			$('#meDemo').val('<c:out value="${mostRecentStuff.lateststuff4Cal}" />');
					//click event는 발생안하네        			
        			changeImgSrc("<c:out value="${mostRecentStuff.lateststuff}" />");
        		});
        	
           		$('#meDemo').daterangepicker({
           			locale: {
           				format: 'YYYY-MM-DD'
           			}, 
           		    "singleDatePicker": true,
           		    "showDropdowns": true,
           		    "startDate": "<c:out value="${mostRecentStuff.lateststuff4Cal}" />", 
           		    "endDate" : "<c:out value="${mostRecentStuff.lateststuff4Cal}" />",
           		    "minDate": "2015-06-01",
           		    "maxDate": "<c:out value="${mostRecentStuff.lateststuff4Cal}" />"     //today
           		    
           		}, function(start, end, label) {
           			
           			meRequest(start);
           			
           		  
           		});
           		
           		
           		var cmenu = new BootstrapMenu('#monthlyPrediction', {
        		      actions: [{
        		        name: '이미지 저장',
        		        onClick: function() {
        		         	 $('.watermark').watermark({
        		             	path: '${pageContext.request.contextPath}/mestrap/assets/ci/banner_kma_kr_en.png',
        		              	margin: 200,
        		              	gravity: 'n',
        		              	opacity: 0.5,
        		              	outputWidth: 'auto',
        		    			outputHeight: 'auto',
        		    			outputType: 'png',
        		    			done: function(imgURL) {
        		    				//this.src = imgURL;
        				          	var savefilename = this.src;
        				          	savefilename = savefilename.substring(this.src.indexOf("ext_"),savefilename.length);//.toUpperCase();
        				          	/* download attribute on Anchor tag not working in IE */
        				          	/*
        					          	toastr.success(save);
        			    		 		var tmp = $('<a>').attr('download', savefilename.indexOf("ssmis_")!=-1? savefilename : "notAvailable.png").attr('href', imgURL);
        								tmp[0].click();
        								tmp.remove(); 
        							*/
        				          	/* download attribute on Anchor tag not working in IE */
        							
        							var canvas = document.getElementById('canvas4export'), ctx = canvas.getContext('2d');
        							while (canvas.hasChildNodes()){
        								canvas.removeChild(canvas.lastChild);
        						    }
        							var tempImg = new Image();
        							tempImg.onload = function() {
        								ctx.drawImage(this, 0, 0, canvas.width, canvas.height);
        								canvas.toBlob(function(blob) {
        								    saveAs(blob, savefilename.indexOf("ext_")!=-1? savefilename : "notAvailable.png");
        								});
    									// Store the current transformation matrix
    									ctx.save();
    									// Use the identity matrix while clearing the canvas
    									ctx.setTransform(1, 0, 0, 1, 0, 0);
    									ctx.clearRect(0, 0, canvas.width, canvas.height);
    									// Restore the transform
    									ctx.restore();
    									
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
	        		              	margin: 200,
	        		              	gravity: 'n',
	        		              	opacity: 0.5,
	        		              	outputWidth: 'auto',
	        		    			outputHeight: 'auto',
	        		    			outputType: 'png',
	    			    			done: function(imgURL) {
 	    			    			/* 	
 	    			    				var meCanvas = $('<canvas/>', { id: 'canvas4export'});
 	    			    				meCanvas.css('display', 'none');
 	    			    				meCanvas.css('width', 965);
 	    			    				meCanvas.css('height', 629);
	    			    				$('#idGoesHere').append(meCanvas);  */
	    			    				
	    			    				
	    								var canvas = document.getElementById('canvas4export')
	    								var ctx = canvas.getContext('2d');
	    								var tempImg = new Image();
	    								tempImg.onload = function() {
	    									ctx.drawImage(this, 0, 0, canvas.width, canvas.height);
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
	    									
	    									
	    									// Store the current transformation matrix
	    									ctx.save();
	    									// Use the identity matrix while clearing the canvas
	    									ctx.setTransform(1, 0, 0, 1, 0, 0);
	    									ctx.clearRect(0, 0, canvas.width, canvas.height);
	    									// Restore the transform
	    									ctx.restore();
	    									
	    								/* 	$('#canvas4export').remove(); */
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
	<!--dateChoooooser--> 
	<!--dateChoooooser--> 




		
	<!-- Page Content -->
    <div class="container"   id="contentWrapperDiv">
		 			
		<div align="center">
		
			<div class="row">
			
            	<p class="col-lg-12">
			<!-- 
               		<h4 class="page-header">ice graphic goes here ext / rou</h4>
			 -->
            	</p>
            	
	            <div class="col-md-12">
	            	<div class="hbox" id="idGoesHere">
						<p>
							<span class="zoom" id="meSpan">
								<img id="monthlyPrediction"  alt="해빙전망공간분포그래픽" class="img-responsive watermark" style="width:85%; height:auto;">
							</span>	
						</p>
						<p>※ 해빙전망은 매월 20일경 업데이트 됩니다.</p>
					</div>
					<!-- 
					 -->
					<canvas width="965" height="629" id="canvas4export" style="display: none;"></canvas>
	            </div>
	            
	            
			</div>		
	 	</div>
		
	</div>
	
	
    <!-- Footer -->
	<div id="meFooter">
		<c:import url="/arcticPageLink.do?link=main/inc/meFooter" />
	</div>	 	
</body>

</html>