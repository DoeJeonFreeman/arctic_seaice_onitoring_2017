<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<%
String url = "";
String english = "";
String korean = "";
String qs = request.getQueryString();
if (qs != null) {
    if (qs.indexOf("&lang=") != -1) {
        qs = qs.substring(0, qs.indexOf("&lang="));
    }
    if (qs.indexOf("lang=") != -1) {
        qs = qs.substring(0, qs.indexOf("lang="));
    }
    if (!qs.equals("")) {
        String decodedQueryString = java.net.URLDecoder.decode(request.getQueryString(), "UTF-8");
        url = "?" + decodedQueryString;
        if (url.indexOf("&lang=") != -1) {
            url = url.substring(0, url.indexOf("&lang="));
        } 
        english = url + "&lang=en";
        korean = url + "&lang=ko";
    } else {
        english = url + "?lang=en";
        korean = url = "?lang=ko";
    }
} else {
    english = url + "?lang=en";
    korean = url = "?lang=ko";
}

pageContext.setAttribute("english", english);
pageContext.setAttribute("korean", korean);
%>



<c:set var="localeCode" value="${requestContext.locale.language}" />
<input id="localeCode" type="hidden" value="${localeCode}"/>


<script type="text/javascript">

	
	var isLocal = ($('#localeCode').val().toUpperCase()=='KO')? true : false;
	
	
	var isVERBOSE = false; 
	
	function sysout(str) {
		if(!isVERBOSE) return;
		if(window['console']!='undefined') console.log(str);
	}
	
	function systime(str, flag) {
		if(!isVERBOSE) return;
		if(window['console']!='undefined' &&flag=='begin') console.time(str);
		if(window['console']!='undefined' &&flag=='end') console.timeEnd(str);
	}


    function fn_main_headPageMove(menuNo, url){
	    document.selectOne.menuNo.value=menuNo;
	    document.selectOne.link.value=url;
	    document.selectOne.action = "${pageContext.request.contextPath}/arcticPageLink.do";
	    //alert(document.selectOne.action);
	    document.selectOne.submit();
    }
    
    function fn_main_headPageMove_bbs(url){
        document.selectOne.action = "${pageContext.request.contextPath}/"+url;
        document.selectOne.method = "get";
	    document.selectOne.submit();
    }
    
    function fn_main_headPageAction(menuNo, url){
        document.selectOne.menuNo.value=menuNo;
        document.selectOne.link.value="";
        document.selectOne.action = "${pageContext.request.contextPath}/"+url;
        document.selectOne.method = "post";
        //alert(document.selectOne.action);
        document.selectOne.submit();
    }
    
    
    function getProperCi(){
    		return (isLocal)? '${pageContext.request.contextPath}/mestrap/assets/ci/kma_main_ci_kr_en.png' : '${pageContext.request.contextPath}/mestrap/assets/ci/kma_main_ci_en.png';
    }
    
    
</script>

<form name="selectOne" action="#LINK">
	<input name="menuNo" type="hidden" />
	<input name="link" type="hidden" />
</form>


<canvas width="100%" height="100%" id="screenShotGoesHere" style="display: none;"></canvas> <!-- style="display: none;" -->

  <!-- toolbar top -->
<div class="me-toolbar">
  
    <div class="container">
        	
		    <div class="text-right">
         		<div class="col-md-24">
            		<ul class="list-inline">
            		
	            		<security:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
							<security:authentication property="principal.username" var="check" />
						</security:authorize>
            		<!--  
            		
            			<li>
	            			<a href="${korean }">Korean</a>
            			</li>
            			<li>
	            			<a href="${english }">English</a> 
            			</li>
            		-->
            		
            			<li>
            				<a onclick="javascript:fn_main_headPageMove('8318','cmm/sitemap')"><i class="fa fa-sitemap fa-fw"></i> Site map </a>
            			</li>
              			<c:choose>
							<c:when test="${empty check}">
              				</c:when>	
		    				<c:otherwise>
							<!-- 
              					<li><a href="${pageContext.request.contextPath}/path/to/somewhere.do"><i class="fa fa-sign-in fa-fw"></i> Log in</a></li>
							 -->
		    				
						        <li><a onclick=""><i class="fa fa-cog fa-spin"></i> "${check}" 님</a> 관리자로 로그인하셨습니다.</li>
						        <li><a href="${pageContext.request.contextPath}/j_spring_security_logout"><i class="fa fa-sign-out fa-fw"></i> Log out</a></li>
		    				</c:otherwise>
		    			</c:choose>	
                    </ul>
          		</div>
      	 	 </div>
      	 	 
	         <div class="hidden-xs row vcenter">
	           	<a href="${pageContext.request.contextPath}/cmm/main/mainPage.do" id="arcticSysTitle" style="color:#555555 ;font-size:20px; font-weight:bold; text-decoration:none;">
	           	<!-- 
	           		<img src="${pageContext.request.contextPath}/mestrap/assets/ci/logo_1.gif" alt="kma.go.kr logo"  width="105px;"  style="padding-bottom:10px;"/>&nbsp; 북극해빙감시시스템
	           		<img src="${pageContext.request.contextPath}/mestrap/assets/ci/kma_main_ci_kr_xs.png" alt="kma.go.kr logo"  width="223px;"  style="padding-bottom:5px;"/>&nbsp; 북극해빙감시시스템
	           		<img src="${pageContext.request.contextPath}/mestrap/assets/ci/kma_main_ci_kr_xs2.png" alt="kma.go.kr logo"  width="207px;"  style="padding-bottom:5px;"/>&nbsp; 북극해빙감시시스템
	           		
	           		
	           		<img src="${pageContext.request.contextPath}/mestrap/assets/ci/kma_main_ci_kr_xs_krOnly.png" alt="kma.go.kr logo"  width="124px;"  style="padding-bottom:5px;"/>&nbsp; 북극해빙감시시스템
	           		<img src="${pageContext.request.contextPath}/mestrap/assets/ci/kma_main_ci_kr.png" alt="kma.go.kr logo"  width="223px;"  style="padding-bottom:10px;"/>&nbsp; 북극해빙감시시스템
	           	 -->
<%-- 	           		<img src="${pageContext.request.contextPath}/mestrap/assets/ci/kma_main_ci_kr_en.png" alt="kma.go.kr logo"  height="55px;"  style="padding-bottom:5px;"/>&nbsp; <spring:message code="global.main.title"/> --%>
<%-- 	           		<img src="${pageContext.request.contextPath}/mestrap/assets/ci/kma_main_ci_en.png" alt="kma.go.kr logo"  height="55px;"  style="padding-bottom:5px;"/>&nbsp; <spring:message code="global.main.title"/> --%>
	           		<img  src="${pageContext.request.contextPath}/mestrap/assets/ci/kma_main_ci_en.png" onload="this.onload=null; this.src=getProperCi();" alt="kma.go.kr logo"  height="55px;"  style="padding-bottom:5px;"/>&nbsp; <spring:message code="global.main.title"/>
	       	 	</a>              
	         </div>		    
	</div>
	
	
</div>
 <nav class="navbar navbar-default navbar-static-top" role="navigation" id="meNavbar">
     <div class="container">
         <!-- Brand and toggle get grouped for better mobile display -->
         <div class="navbar-header">
             <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-mecollapse">
                 <span class="sr-only">Toggle navigation</span>
                 <span class="icon-bar"></span>
                 <span class="icon-bar"></span>
                 <span class="icon-bar"></span>
             </button>
             <!-- navbar-brand visible-xs -->
	             <a class="navbar-brand visible-xs" href="${pageContext.request.contextPath}/cmm/main/mainPage.do" >
	             	<img style="height:60px; margin-top: -19px;" src="${pageContext.request.contextPath}/mestrap/assets/ci/kma_ci_without_sysName.png"> 
	           	 </a> 
	           	 <a class="navbar-brand visible-xs" style="color:#;font-size:14px; margin-top: 0px; font-weight:bold; text-decoration:none;"><spring:message code="global.main.title"/></a>
         </div>
         <!-- Collect the nav links, forms, and other content for toggling -->
         <div class="collapse navbar-collapse" id="navbar-mecollapse">
             <ul class="nav navbar-nav navbar-right">
             
             	  <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown"><spring:message code="nav.monitoring"/><b class="caret"></b></a>
                     <ul class="dropdown-menu" id="meDropdown-mnt">
                         <li>
                             <a href="#LINK" onclick="javascript:fn_main_headPageAction('11','arctic/spatialDistribution.monthly')" ><spring:message code="nav.monitoring.sdist"/></a>
                         </li>
                         <li>
                             <a href="#LINK" onclick="javascript:fn_main_headPageAction('12','arctic/timeseries/extent.do')" ><spring:message code="nav.monitoring.trend.current"/></a>
                         </li>
                         <li>
                             <a href="#LINK" onclick="javascript:fn_main_headPageAction('13','arctic/timeseries/trend.do')" ><spring:message code="nav.monitoring.trend.longrange"/></a>
                         </li>
                         <li>
                             <a href="#LINK" onclick="javascript:fn_main_headPageAction('14','arctic/ocean.do')" ><spring:message code="nav.monitoring.ocean"/></a>
                         </li>
                     </ul>
                 </li>
            	<!-- 
                 <li>
                     <a href="#LINK" onclick="javascript:fn_main_headPageAction('21','arctic/monthlyPrediction.do')" >해빙전망</a>
                 </li>
            	 -->
             	 
             	 <li>
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown"><spring:message code="nav.prediction"/><b class="caret"></b></a>
                     <ul class="dropdown-menu" id="meDropdown-mnt">
                         <li>
                             <a href="#LINK" onclick="javascript:fn_main_headPageAction('21','arctic/monthlyPredictionNew.do')" ><spring:message code="nav.prediction.fcst"/></a>
                         </li>
                         <li>
                             <a href="#LINK" onclick="javascript:fn_main_headPageAction('22','arctic/monthlyPredictionDiff.do')" ><spring:message code="nav.prediction.fcst.verification"/></a>
                         </li>
                         <li>
                             <a href="#LINK" onclick="javascript:fn_main_headPageAction('23','arctic/monthlyPredictionMap.do')" ><spring:message code="nav.prediction.seasonal.prediction"/></a>
                         </li>
                     </ul>
                 </li>
             	 
                 <li>
                     <a href="#LINK" onclick="javascript:fn_main_headPageAction('31','arctic/passage.do')" ><spring:message code="nav.routes"/></a>
                 </li>
                 <li class="dropdown">
                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown"><spring:message code="nav.board"/> <b class="caret"></b></a>
                     <ul class="dropdown-menu" id="meDropdown-bbs">
                         <li>
                         	<a href= '${pageContext.request.contextPath}/bbs/list?boardCd=notice&curPage=1'><spring:message code="bbs.board.notice"/></a>
                         </li>
                         <li>
                             <a href= '${pageContext.request.contextPath}/bbs/list?boardCd=anal&curPage=1'><spring:message code="bbs.board.anal"/></a>
                         </li>
                         <li>
                             <a href= '${pageContext.request.contextPath}/bbs/list?boardCd=refs&curPage=1'><spring:message code="bbs.board.refs"/></a>
                         </li>
                     </ul>
                 </li>
                 <li>
                     <a href="#LINK" onclick="javascript:fn_main_headPageMove('51','cmm/sysSummary')" ><spring:message code="nav.system.summary"/></a>
                 </li>
                 <li>
                     <a href="#LINK" onclick="javascript:fn_main_headPageMove('61','cmm/reference')" ><spring:message code="nav.related.site"/></a>
                 </li>
             </ul>
         </div>
         <!-- navbar-collapse -->
     </div>
     <!-- container -->
 </nav>
<!-- topmenu end -->

	
	