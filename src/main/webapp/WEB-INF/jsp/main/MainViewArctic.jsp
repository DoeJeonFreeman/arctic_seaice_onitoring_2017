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
	
	<script src="${pageContext.request.contextPath}/js/jquery/jquery-1.9.1.js"></script>	
    <script src="${pageContext.request.contextPath}/mestrap/js/bootstrap.min.js"></script>
	
    <!-- Bootstrap Core CSS -->
    <link href="${pageContext.request.contextPath}/mestrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/mestrap/css/modern-business.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="${pageContext.request.contextPath}/mestrap/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <link href="${pageContext.request.contextPath}/mestrap/css/modern-business.css" rel="stylesheet">
    
    
	<!-- LOGGER TRACKING SCRIPT V.30 FOR seaice.kma.go.kr seaice.nimr.go.kr / 56 : FAIL-SAFE TYPE / DO NOT ALTER THIS SCRIPT. -->
	<script type="text/javascript">/* LOGGER TRACKING SCRIPT V.30 : 56 *//*X*//* COPYRIGHT 2002-2014 BIZSPRING INC. *//*X*//* DO NOT MODIFY THIS SCRIPT. *//*X*/var _TRK_DOMAIN="logger.kma.go.kr";var _trk_bMSIE=(document.all)?true:false;var _trk_bJS12=(window.screen)?true:false;function _trk_escape(_str) { var str, ch; var bEncURI = "N"; eval("try{bEncURI=encodeURI('Y');}catch(_e){ }" ); if( bEncURI == "Y" ) str=encodeURI(_str); else str = escape(_str); str=str.split("+").join("%2B"); str=str.split("/").join("%2F"); str=str.split("&").join("%26"); str=str.split("?").join("%3F"); str=str.split(":").join("%3A"); str=str.split("#").join("%23"); return str;}function _trk_setCookie(name,value,expire) { var today=new Date(); today.setTime(today.getTime()+ expire ); document.cookie=name+"="+value+"; path=/; expires="+today.toGMTString()+";";}function _trk_getCookie(name) { var cookieName=name+"="; var x=0; while(x<=document.cookie.length) { var y=(x+cookieName.length); if(document.cookie.substring(x,y)==cookieName) {  if((endOfCookie=document.cookie.indexOf(";",y))==-1) endOfCookie=document.cookie.length;  return unescape(document.cookie.substring(y,endOfCookie)); } x=document.cookie.indexOf(" ",x)+1; if(x == 0) break; } return "";}function _trk_getParameter(name) { var paraName=name+"="; var URL=""+self.document.location.search; var tURL=""; eval("try{ tURL=top.document.location.search; }catch(_e){}"); URL=URL+"&"+tURL; if(URL.indexOf(paraName)!=-1) { var x=URL.indexOf(paraName)+paraName.length; var y=URL.substr(x).indexOf("&"); if(y!=-1) return URL.substring(x,x+y); else return URL.substr(x); } return "";}function _trk_make_code(_TRK_SERVER,_TRK_U) { var dt=document.title.toString(); dt=dt.substr(0,128); var dr=self.document.referrer; var tdr=""; eval("try{ tdr=top.document.referrer; }catch(_e){}"); var tdu=""; eval("try{ tdu=top.document.location.href; }catch(_e){}"); var bFrm=false; if(dr==tdu) { dr=tdr; bFrm=true; } if(dr=="undefined") dr=""; var du=self.document.location.href; if(du.substr(0,4)=="file") return ""; var adKeyVal = ""; if(bFrm) { adKeyVal=_trk_getParameter("OVKEY"); if(adKeyVal!="" && du.indexOf("OVKEY=")<0) {  if(du.indexOf("?")!=-1) du=du+"&OVKEY="+adKeyVal; else du=du+"?OVKEY="+adKeyVal;  adKeyVal=_trk_getParameter("OVRAW");  if(adKeyVal!="" && du.indexOf("OVRAW=")<0 ) if(du.indexOf("?")!=-1) du=du+"&OVRAW="+adKeyVal; else du=du+"?OVRAW="+adKeyVal; } else {  adKeyVal=_trk_getParameter("netpia");  if(adKeyVal!="" && du.indexOf("netpia=")<0 ) if(du.indexOf("?")!=-1) du=du+"&netpia="+adKeyVal; else du=du+"?netpia="+adKeyVal; } adKeyVal=_trk_getParameter("logger_kw"); if(adKeyVal!="" && du.indexOf("logger_kw=")<0 )  if(du.indexOf("?")!=-1) du=du+"&logger_kw="+adKeyVal; else du=du+"?logger_kw="+adKeyVal; adKeyVal=_trk_getParameter("source"); if(adKeyVal!="" && du.indexOf("source=")<0 )  if(du.indexOf("?")!=-1) du=du+"&source="+adKeyVal; else du=du+"?source="+adKeyVal; } var ce=navigator.cookieEnabled?"Y":"N"; var je=navigator.javaEnabled()?"Y":"N"; var ss=""; var cd = ""; if(_trk_bJS12) { ss=screen.width+"x"+screen.height; cd=screen.colorDepth; } if(!dt) dt=""; if(!dr) dr=""; if(!du) du=""; if(!ce) ce=""; if(!je) je=""; var t = new Date; var tye=(_trk_bMSIE)?(t.getYear()):(t.getFullYear()); var tmo=t.getMonth()+1; var tda=t.getDate(); var tho=t.getHours(); var tmi=t.getMinutes(); var tse=t.getSeconds(); var tzo=t.getTimezoneOffset(); var tc = ""; var prtcl=document.location.protocol.indexOf("https")!=-1?"https://":"http://"; if(prtcl=="https://") _TRK_SERVER="ssl."+_TRK_DOMAIN; tc=tc+prtcl+_TRK_SERVER; var bPNF=((typeof _TRK_PI)!="undefined" && _TRK_PI=="PNF")?true:false; if(bPNF) tc=tc+"/tracker_click.tsp"; else tc=tc+"/tracker.tsp"; tc=tc+"?u="+_TRK_U+"&XU=&EXEN="+_EXEN; if(bPNF) { tc=tc+"&rnd="+Math.random()+"&CKFL="+_TRK_PI+"&CKDATA="+_trk_escape(du); } else { tc=tc+"&dr="+_trk_escape(dr)+"&XDR="+"&dt="+_trk_escape(dt)+"&du="+_trk_escape(du); if((typeof _TRK_CP)!="undefined" && _TRK_CP!="") tc=tc+"&CP="+_trk_escape(_TRK_CP)+"&XCP="; if((typeof _TRK_PI)!="undefined" && _TRK_PI!="") tc=tc+"&PI="+_TRK_PI; if((typeof _TRK_PN)!="undefined" && _TRK_PN!="") tc=tc+"&PN="+_trk_escape(_TRK_PN); if((typeof _TRK_MF)!="undefined" && _TRK_MF!="") tc=tc+"&MF="+_trk_escape(_TRK_MF); if((typeof _TRK_OA)!="undefined" && _TRK_OA!="") tc=tc+"&OA="+_TRK_OA; if((typeof _TRK_OP)!="undefined" && _TRK_OP!="") tc=tc+"&OP="+_trk_escape(_TRK_OP); if((typeof _TRK_OE)!="undefined" && _TRK_OE!="") tc=tc+"&OE="+_TRK_OE; if((typeof _TRK_CC)!="undefined" && _TRK_CC!="") tc=tc+"&CC="+_TRK_CC; if((typeof _TRK_RK)!="undefined" && _TRK_RK!="") tc=tc+"&RK="+_trk_escape(_TRK_RK); if((typeof _TRK_SX)!="undefined" && _TRK_SX!="") tc=tc+"&SX="+_TRK_SX; if((typeof _TRK_AG)!="undefined" && _TRK_AG!="") tc=tc+"&AG="+_TRK_AG; if((typeof _TRK_IK)!="undefined" && _TRK_IK!="") tc=tc+"&IK="+_trk_escape(_TRK_IK); tc=tc+"&js=Y"+"&ss="+escape(ss)+"&cd="+cd+"&ce="+ce+"&je="+je+"&tzo="+tzo+"&tye="+tye+"&tmo="+tmo+"&tda="+tda+"&tho="+tho+"&tmi="+tmi+"&tse="+tse; } return tc;}var _TRK_LIFE=_trk_getParameter("_L_");if(_TRK_LIFE=="") _TRK_LIFE=14;_TRK_LIFE = parseInt(_TRK_LIFE)*24*60*60*1000;var _TRK_U="";var _TRK_U_P=_trk_getParameter("_U_");var _TRK_U_C= _trk_getCookie("_TRK_U");if(_TRK_U_C!="") _TRK_U=_TRK_U_C;if(_TRK_U_P!="") _TRK_U=_TRK_U_P;if(_TRK_U!="" && _TRK_U_P!="") _trk_setCookie("_TRK_U",_TRK_U,_TRK_LIFE);var _TRK_CC_C=_trk_getCookie("_TRK_CC");var _TRK_CC_P=_trk_getParameter("_C_");if((typeof _TRK_CC)!="undefined" && _TRK_CC!="") _TRK_CC_P=_TRK_CC;if(_TRK_CC_C!="") _TRK_CC=_TRK_CC_C;if(_TRK_CC_P!="") _TRK_CC=_TRK_CC_P;if((typeof _TRK_CC)!="undefined" && _TRK_CC!="" && _TRK_CC_P!="") _trk_setCookie("_TRK_CC",_TRK_CC,_TRK_LIFE);var _TRK_RK_C=_trk_getCookie("_TRK_RK");var _TRK_RK_P=_trk_getParameter("_R_");if((typeof _TRK_RK)!="undefined" && _TRK_RK!="") _TRK_RK_P=_TRK_RK;if(_TRK_RK_C!="") _TRK_RK=_TRK_RK_C;if(_TRK_RK_P!="") _TRK_RK=_TRK_RK_P;if((typeof _TRK_RK)!="undefined" && _TRK_RK!="" && _TRK_RK_P!="") _trk_setCookie("_TRK_RK",_TRK_RK,_TRK_LIFE);var _SS_LIFE = 30*60*1000;var _EXEN = _trk_getCookie("_EXEN");if( _EXEN == "" ) _EXEN = 0; _EXEN ++;_trk_setCookie("_EXEN",_EXEN,_SS_LIFE);var _trk_code_base=_trk_make_code("logger.kma.go.kr","56");var _trk_code_chan="";if(_TRK_U!="") _trk_code_chan=_trk_code_base.replace(/\?u=56&XU=/g,"?u="+_TRK_U+"&XU=");var _trk_img_base=new Image();var _trk_img_chan=new Image();var _trk_img_base_click=new Image();var _trk_img_chan_click=new Image();if(_trk_bJS12==true) { if(_trk_bMSIE) { _trk_img_base.src=_trk_code_base; if(_TRK_U!="") _trk_img_chan.src=_trk_code_chan; } else { setTimeout("_trk_img_base.src=_trk_code_base;",1); if(_TRK_U!="") setTimeout("_trk_img_chan.src=_trk_code_chan;",1); }} else { if(_trk_bMSIE) document.write('<div style=\"display: none\">'); document.write('<img src=\"'+_trk_code_base+'\" height=\"0\" width=\"0\">'); if(_TRK_U!="") document.write('<img src=\"'+_trk_code_chan+'\" height=\"0\" width=\"0\">'); if(_trk_bMSIE) document.write('</div>');}function _trk_flashContentsView(_TRK_CP) { var _trk_code_flash=_trk_code_base; _trk_code_flash=_trk_code_flash.replace(/&CP=.*&XCP=/g,"&XCP="); _trk_code_flash=_trk_code_flash.replace(/&dr=.*&XDR=/g,"&XDR="); _trk_img_base_click.src=_trk_code_flash+"&dr=&CP="+_trk_escape(_TRK_CP)+"&rnd="+Math.random(); if(_TRK_U!="") { _trk_code_flash=_trk_code_flash.replace(/\?u=56&XU=/g,"?u="+_TRK_U+"&XU="); _trk_img_chan_click.src=_trk_code_flash+"&dr=&CP="+_trk_escape(_TRK_CP)+"&rnd="+Math.random(); }}function _trk_clickTrace(_TRK_CKFL,_TRK_CKDATA) { var _trk_code_click=_trk_code_base.substr(0,_trk_code_base.indexOf("tracker.tsp")); _trk_code_click=_trk_code_click+"tracker_click.tsp?rnd="+Math.random()+"&CKFL="+_TRK_CKFL+"&CKDATA="+_trk_escape(_TRK_CKDATA); _trk_img_base_click.src=_trk_code_click+"&u=56"; if(_TRK_U!="") _trk_img_chan_click.src=_trk_code_click+"&u="+_TRK_U;}function _trk_adClick( adSvr, svcCode, adCode ) { var ac = ""; var prtcl=document.location.protocol.indexOf("https")!=-1?"https://":"http://"; if(prtcl=="https://") adSvr="ssl."+_TRK_DOMAIN; ac=ac+prtcl+adSvr; _trk_img_base_click.src=ac+"/tracker_ad.tsp?u="+svcCode+"&mode=C&adCode="+adCode;}</script>
	<!-- 
	 -->
	<!-- END OF LOGGER TRACKING SCRIPT -->
    
    <script type="text/javascript">
	    /**
	     * returns version of IE or false, if browser is not Internet Explorer
	     */
	    function detectIE() {
	    	 
	    	 	
	    	 	
	        var ua = window.navigator.userAgent;
	        var msie = ua.indexOf('MSIE ');
	        if (msie > 0) {
	            // IE 10 or older => return version number
	            return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
	        }
	
 			var trident = ua.indexOf('Trident/');
	        if (trident > 0) {
	            // IE 11 => return version number
	            var rv = ua.indexOf('rv:');
	            return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
	        }
	
	        var edge = ua.indexOf('Edge/');
	        if (edge > 0) {
	           // IE 12 => return version number
	           return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
	        }
	        
	        // other browser
	        return false;
	    }
	    
	    var isIE = detectIE();
	    if(isIE!=false && isIE<8){
		    //alert('IE ' + isIE);
		    document.location.href='${pageContext.request.contextPath}/arcticPageLink.do?link=cmm/error/unsupported';
	    }else{
		    //alert('Other browser haha');
	    }
	    
		function getProperKMABanner(){
			return (isLocal)? '${pageContext.request.contextPath}/mestrap/assets/ci/banner_kma_kr_en.png' : '${pageContext.request.contextPath}/mestrap/assets/ci/banner_kma.png';
		}
		
		function getProperNMSCBanner(){
			return (isLocal)? '${pageContext.request.contextPath}/mestrap/assets/ci/nmsc_ci_creGothicB_sm.png' : '${pageContext.request.contextPath}/mestrap/assets/ci/banner_nmsc.png';
		}
		
	    
    </script>
    
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
    
</head>



<body id="fabulousbdtc">
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
<!-- 전체 레이어 시작 -->


	<!-- navTop-->
	<div id="meHeader">
	    <c:import url="/arcticPageLink.do?link=main/inc/meNavTop" />
	</div>
	
	
    <!-- Header -->
    <header class="meBGCover">
        <div class="container">
            <div class="intro-text">
                <div class="col-md-10 col-md-offset-2">
            		<div class="intro-heading text-left visible-lg visible-md">&nbsp; </div>
                	<div class="col-md-4 visible-lg visible-md visible-sm">
	            		<div class="intro-heading text-left"><spring:message code="global.main.distribution.title"/> </div>
    	        		<h4 class="text-left" style="white-space: nowrap;"> ${mostRecentStuff.compbegindate4Main}</h4>
                	</div>
                	
                	<div class="col-md-3" >
	                	<div class="">
							<div align="center" class=""> 
								<div><h4><spring:message code="global.main.distribution.ext.title"/></h4></div>
								<p>${mostRecentStuff.compbegindate4View}</p>
							</div>
							<p  align="center">
								<span class="mePopup">
									<a href="${pageContext.request.contextPath}/arctic/spatialDistribution.do">
										<img class="img-responsive" style="width:320px; height:auto;" 
											src="${pageContext.request.contextPath}/data/IMG/SEAICE/Y${fn:substring(mostRecentStuff.compbegindateInString,0,4) }/dmsp_ssmis_ice_${mostRecentStuff.compbegindateInString}.png"
											alt="해빙 면적 공간분포 이미지">
									</a>		
								</span>	
							</p>
                   		    <div class="center-block">${mostRecentStuff.extentInkmSquared} ㎢</div>
						</div>
                	</div>
                	
                	<div class="col-md-3"  style=" min-height: 280px;">
	                	<div class="">
							<div align="center" class=""> 
								<div><h4 style="white-space: nowrap;"><spring:message code="global.main.distribution.rou.title"/></h4></div>
								<p>${mostRecentStuff.compbegindate4View}</p>
							</div>
							<p  align="center">
								<span class="mePopup">
									<a href='${pageContext.request.contextPath}/arctic/spatialDistribution.do'>
										<img class="img-responsive" style="width:320px; height:auto;" 
										    src="${pageContext.request.contextPath}/data/IMG/ROUGH/Y${fn:substring(mostRecentStuff.compbegindateInString,0,4) }/dmsp_ssmis_rou_${mostRecentStuff.compbegindateInString}.png" 
											alt="해빙 표면거칠기 공간분포 이미지">
									</a>	
								</span>	
							</p>
							<!--
		                 	<a class="btn btn-link-2" href="#">
		                  		<i class="">해빙분포보기</i>
		                 	</a>
							-->
						</div>
                	</div>
                </div>
                	<p>&nbsp;</p>
                	<p>&nbsp;</p>
                	<p>&nbsp;</p>
                	<p>&nbsp;</p>
            </div>

        </div>
    </header>
    

    <!-- Page Content -->
    <div class="container">


   </div>
   <!-- /.container -->
	
	
<div style="background-color: #f3f3f4; padding-bottom: 15px;">
	<div class="container">
		 	<section id="footer-useful-links"  class="col-md-5">
            	<h5 class="section-title"><i class="fa fa-list-ul fa-fw"></i>Notice</h5>
           		<ul class="nav">
					<c:forEach var="result" items="${notices}" varStatus="status">
                    <li>
                    	<span class="text-left">
                          <a class="" href="${pageContext.request.contextPath}/bbs/list?boardCd=notice&curPage=1" >
                            <c:choose>
                                <c:when test="${result.title!=null }">
                                	<img src="${pageContext.request.contextPath}/assets/btn_skin_notice.png"/>
                                    <c:out value="${fn:escapeXml(result.title)}" /> 
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${fn:escapeXml(result.title)}" />
                                </c:otherwise>
                            </c:choose>
                          </a>
                        </span>
                        <span class="" style="float:right"><c:out value="${result.regdateForList}"/></span>
                    </li>
                    </c:forEach>
				</ul>
            </section>
            
            <!-- 
	            notice 5
	            contact us 2 
	            links 2 
            -->
            <!--  
           	 <section id="footer-useful-links" class="col-md-2">
	            <h5 class="section-title"><i class="fa fa-envelope fa-fw"></i>Contact Us</h5>
	            <ul class="nav">
	              <li><a href="">seaice_kma@korea.kr</a></li>
	            </ul>
	          </section>
             -->
	
	          <section id="footer-other" class="col-md-5 col-md-offset-1">
	
	            <h5 class="section-title"><i class="fa fa-link fa-fw"></i>Links</h5>
	            <ul class="list-inline" style="padding-top:10px; padding-left:15px; line-height: 40px; ">
<%-- 	              <li style="padding-right:20px;"><a href="http://kma.go.kr" target="_blank"><img src="${pageContext.request.contextPath}/mestrap/assets/ci/banner_kma_kr_en.png" alt="KMA CI"  /></a></li>
	              <li><a href="http://nmsc.kma.go.kr" target="_blank"><img src="${pageContext.request.contextPath}/mestrap/assets/ci/nmsc_ci_creGothicB_sm.png" alt="NMSC CI" /></a></li> --%>
	              
	              <li style="padding-right:35px;"><a href="http://kma.go.kr" target="_blank"><img src="${pageContext.request.contextPath}/mestrap/assets/ci/banner_kma_kr_en.png"  
	              	onload="this.onload=null; this.src=getProperKMABanner();" alt="KMA CI"  /></a>
              	  </li>
	              <li><a href="http://nmsc.kma.go.kr" target="_blank"><img src="${pageContext.request.contextPath}/mestrap/assets/ci/nmsc_ci_creGothicB_sm.png"
	              	onload="this.onload=null; this.src=getProperNMSCBanner();" alt="NMSC CI" /></a>
	              </li>
	              
	            </ul>
	          </section>
          </div>
	</div>	
	
	
    <!-- Footer -->
	<div id="meFooter">
		<c:import url="/arcticPageLink.do?link=main/inc/meFooter" />
	</div>

	
	<!-- jQuery 
    <script src="<c:url value="/mestrap/js/jquery.js"/>"></script>
	-->

    <!-- Bootstrap Core JavaScript 
    <script src="<c:url value="/mestrap/js/bootstrap.min.js"/>"></script>
    -->
    
    <!-- auto hiding navbar -->
    <!-- Script to Activate the Carousel and AutoHidingNavbar -->
	

</body>
</html>

