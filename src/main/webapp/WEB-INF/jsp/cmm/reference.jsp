<%--
--%>
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

    
    
    
</head>

<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
<!-- 전체 레이어 시작 -->

	<!-- header-->
	<div id="meHeader">
	    <c:import url="/arcticPageLink.do?link=main/inc/meNavTop" />
	</div>
	
	<!--dateChoooooser--> 
	<!--dateChoooooser--> 
	<!--dateChoooooser
	<header class="meControllPanel">
		<div class="container" align="left">
            <div class="row form-horizontal">
           		<div class="pull-right" style="padding-right:50px;"> 
	            	<ul id="breadcrumbs-one" class="pull-right vcenter" >
						<li><a href="<c:url value='/cmm/main/mainPage.do'/>">Home</a></li>
						<li><a>관련사이트</a></li>
					</ul>
            	</div>
            </div>
		        
		</div>
	</header>
	--> 
	<!--dateChoooooser--> 
	<!--dateChoooooser--> 
	<!--dateChoooooser--> 
	
	

    <!-- Page Content -->
    <div class="contentWrapper">

        <!-- Reference Section -->
        <div class="container">
            <div class="col-lg-12">
                <h2 class="page-header"><spring:message code="nav.related.site.title"/></h2>
            </div>
            <div class="col-md-12">
                <ul id="references">
                    <li>
                    	<a href="http://nsidc.org" target="_blank">&nbsp;USA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;National Snow &amp; Ice Data Center<strong></strong></a>
                    </li>
                    <li>
                    	<a href="http://www.arctic.noaa.gov" target="_blank">&nbsp;USA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;National Oceanic and Atmospheric Administration : Arctic theme page</a>
                    </li>
                    <li><a href="http://arctic.arh.noaa.gov/ice_anal.php" target="_blank">&nbsp;USA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;National Weather Service : Arctic Weather Support</a></li>
                    <li><a href="http://polarview.met.no" target="_blank">&nbsp;Norway&nbsp;&nbsp;&nbsp;European Arctic Node</a></li>
                    <li><a href="http://www.myocean.eu.org" target="_blank">&nbsp;Europe&nbsp;&nbsp;&nbsp;&nbsp;Ocean Monitoring and Forecasting</a></li>
                    <li><a href="http://www.ijis.iarc.uaf.edu/cgi-bin/seaice-monitor.cgi?lang=e" target="_blank">&nbsp;Japan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IARC-JAXA Information System : Arctic Sea ice Monitor</a></li>
                    <li><a href="http://arctic.atmos.uiuc.edu/cryosphere/" target="_blank">&nbsp;USA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UIUC Polar Research Group : The Cryosphere Today</a></li>
                    <li><a href="http://psc.apl.washington.edu/wordpress/" target="_blank">&nbsp;USA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Polar Science Center</a></li>
                </ul>
            <!-- 
                <ul id="references">
                    <li>
                    	<a href="http://nsidc.org" target="_blank">미국 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;National Snow &amp; Ice Data Center<strong></strong></a>
                    </li>
                    <li>
                    	<a href="http://www.arctic.noaa.gov" target="_blank">미국 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;National Oceanic and Atmospheric Administration : Arctic theme page</a>
                    </li>
                    <li><a href="http://arctic.arh.noaa.gov/ice_anal.php" target="_blank">미국 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;National Weather Service : Arctic Weather Support</a></li>
                    <li><a href="http://polarview.met.no" target="_blank">노르웨이 &nbsp;&nbsp;European Arctic Node</a></li>
                    <li><a href="http://www.myocean.eu.org" target="_blank">유럽 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ocean Monitoring and Forecasting</a></li>
                    <li><a href="http://www.ijis.iarc.uaf.edu/cgi-bin/seaice-monitor.cgi?lang=e" target="_blank">일본 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IARC-JAXA Information System : Arctic Sea ice Monitor</a></li>
                    <li><a href="http://arctic.atmos.uiuc.edu/cryosphere/" target="_blank">미국 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UIUC Polar Research Group : The Cryosphere Today</a></li>
                    <li><a href="http://psc.apl.washington.edu/wordpress/" target="_blank">미국 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Polar Science Center</a></li>
                </ul>
             -->
            </div>
        </div>
        <!-- /.container -->


    </div>
    <!-- /contents wrapper -->
	
	
	
	
	
	
    <!-- Footer-->
	<div id="meFooter">
		<c:import url="/arcticPageLink.do?link=main/inc/meFooter" />
	</div>
	

<!-- //전체 레이어 끝 -->
</body>
</html>

