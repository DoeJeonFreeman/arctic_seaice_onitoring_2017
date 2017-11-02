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

    <script type="text/javascript">

	    function fn_main_headPageMove(menuNo, url){
		    document.selectOne.menuNo.value=menuNo;
		    document.selectOne.link.value=url;
		    document.selectOne.action = "<c:url value='/arcticPageLink.do'/>";
		    //alert(document.selectOne.action);
		    document.selectOne.submit();
	    }
	    
	    function fn_main_headPageMove_bbs(url){
	        document.selectOne.action = "<c:url value='/' />"+url;
	        document.selectOne.method = "get";
		    document.selectOne.submit();
	    }
	    
	    function fn_main_headPageAction(menuNo, url){
	        document.selectOne.menuNo.value=menuNo;
	        document.selectOne.link.value="";
	        document.selectOne.action = "<c:url value='/' />"+url;
	        document.selectOne.method = "post";
	        //alert(document.selectOne.action);
	        document.selectOne.submit();
	    }
    
	</script>
    
    
</head>

<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
<!-- 전체 레이어 시작 -->

	<!-- header-->
	<div id="meHeader">
	    <c:import url="/arcticPageLink.do?link=main/inc/meNavTop" />
	</div>
	

    <!-- Page Content -->
    <div class="contentWrapper">

        <!-- Reference Section -->
        <div class="container">
            <div class="col-lg-12">
                <h2 class="page-header">Site map</h2>
            </div>
            
            
            
            
            <div class="col-md-12">
            
            
            	<div id="">
					<div class="sitemapWrap">
						<div class="sitemapList02">
							<h3>01&nbsp;&nbsp;<spring:message code="nav.monitoring"/></h3>
							<div class="sitemapListWrap">
								<h5><spring:message code="nav.monitoring"/></h5>
								<ul>
									<li><a href="<c:url value='/arctic/spatialDistribution.do'/>"><spring:message code="global.main.distribution.ext.title"/></a></li>
									<li><a href="<c:url value='/arctic/spatialDistribution.do'/>"><spring:message code="global.main.distribution.rou.title"/></a></li>
								</ul>
							</div>
							<div class="sitemapListWrap">
								<h5><spring:message code="nav.monitoring.trend.current"/></h5>
								<ul>
									<li><a href="<c:url value='/arctic/timeseries/uptodate.do'/>"><spring:message code="trend.recent.titile"/></a></li>
								</ul>
							</div>
							<div class="sitemapListWrap">
								<h5><spring:message code="nav.monitoring.trend.longrange"/></h5>
								<ul>
									<li><a href="<c:url value='/arctic/timeseries/trend.do'/>"><spring:message code="trend.annual.ext"/></a></li>
									<li><a href="<c:url value='/arctic/timeseries/trend.do'/>"><spring:message code="trend.annual.rou"/></a></li>
									<li><a href="<c:url value='/arctic/timeseries/trend.do'/>"><spring:message code="trend.long.range.ext"/></a></li>
									<li><a href="<c:url value='/arctic/timeseries/trend.do'/>"><spring:message code="trend.long.range.rou"/></a></li>
								</ul>
							</div>
							<div class="sitemapListWrap">
								<h5><spring:message code="nav.monitoring.ocean"/></h5>
								<ul>
									<li><a href="<c:url value='/arctic/ocean.do'/>"><spring:message code="oceans.barents.title"/></a></li>
									<li><a href="<c:url value='/arctic/ocean.do'/>"><spring:message code="oceans.bering.title"/></a></li>
									<li><a href="<c:url value='/arctic/ocean.do'/>"><spring:message code="oceans.hudson.title"/></a></li>
								</ul>
							</div>
						</div>
						<div class="sitemapList01">
							<h3>02&nbsp;&nbsp;<spring:message code="nav.prediction"/></h3>
							<ul>
								<li><a href="<c:url value='/arctic/monthlyPredictionNew.do'/>"><spring:message code="nav.prediction.fcst"/></a></li>
								<li><a href="<c:url value='/arctic/monthlyPredictionDiff.do'/>"><spring:message code="nav.prediction.fcst.verification"/></a></li>
								<li><a href="<c:url value='/arctic/monthlyPredictionMap.do'/>"><spring:message code="nav.prediction.seasonal.prediction"/></a></li>
							</ul>
						</div>
						<div class="sitemapList01">
							<h3>03&nbsp;&nbsp;<spring:message code="nav.routes"/></h3>
							<ul>
								<li><a href="<c:url value='/arctic/passage.do'/>"><spring:message code="global.main.distribution.ext.title"/></a></li>
								<li><a href="<c:url value='/arctic/passage.do'/>"><spring:message code="trend.annual.ext"/></a></li>
								<li><a href="<c:url value='/arctic/passage.do'/>"><spring:message code="trend.annual.rou"/></a></li>
							</ul>
						</div>
					</div>
					<div class="sitemapWrap">
						<div class="sitemapList01 first">
							<h3>04&nbsp;&nbsp;<spring:message code="nav.board"/></h3>
							<ul>
								<li><a href="<c:url value='/bbs/list?boardCd=notice&curPage=1'/>"><spring:message code="bbs.board.notice"/></a></li>
								<li><a href="<c:url value='/bbs/list?boardCd=anal&curPage=1'/>"><spring:message code="bbs.board.anal"/></a></li>
								<li><a href="<c:url value='/bbs/list?boardCd=refs&curPage=1'/>"><spring:message code="bbs.board.refs"/></a></li>
							</ul>
						</div>
						<div class="sitemapList01">
							<h3>05&nbsp;&nbsp;<spring:message code="nav.system.summary"/></h3>
							<ul>
								<li><a href="#" onclick="javascript:fn_main_headPageMove('51','cmm/sysSummary')"><spring:message code="systemsummary.summary"/></a></li>
								<li><a href="#" onclick="javascript:fn_main_headPageMove('51','cmm/sysSummary')"><spring:message code="systemsummary.extent"/></a></li>
								<li><a href="#" onclick="javascript:fn_main_headPageMove('51','cmm/sysSummary')"><spring:message code="systemsummary.roughness"/></a></li>
								<li><a href="#" onclick="javascript:fn_main_headPageMove('51','cmm/sysSummary')"><spring:message code="systemsummary.changes"/></a></li>
								<li><a href="#" onclick="javascript:fn_main_headPageMove('51','cmm/sysSummary')"><spring:message code="systemsummary.fcst"/></a></li>
								<li><a href="#" onclick="javascript:fn_main_headPageMove('51','cmm/sysSummary')"><spring:message code="systemsummary.passage"/></a></li>
							</ul>
						</div>
						<div class="sitemapList01">
							<h3>06&nbsp;&nbsp;<spring:message code="nav.related.site"/></h3>
							<ul>
								<li><a href="#" onclick="javascript:fn_main_headPageMove('61','cmm/reference')"><spring:message code="nav.related.site.title"/></a></li>
							</ul>
						</div>
					</div>
				</div>
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

