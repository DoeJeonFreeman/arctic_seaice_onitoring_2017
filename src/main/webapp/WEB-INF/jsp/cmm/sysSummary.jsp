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
    
    
<style>
.blogShort{ border-bottom:1px solid #ddd;}
.add{background: #333; padding: 10%; height: 100%;}
.nav-sidebar { 
    width: 100%;
    padding: 30px 0; 
    border-right: 1px solid #ddd;
}
.nav-sidebar a {
    color: #333;
    -webkit-transition: all 0.08s linear;
    -moz-transition: all 0.08s linear;
    -o-transition: all 0.08s linear;
    transition: all 0.08s linear;
}
.nav-sidebar .active a { 
    cursor: default;
    background-color: #0b56a8; 
    color: #fff; 
}
.nav-sidebar .active a:hover {
    background-color: #E50000;   
}
.nav-sidebar .text-overflow a,
.nav-sidebar .text-overflow .media-body {
    white-space: nowrap;
    overflow: hidden;
    -o-text-overflow: ellipsis;
    text-overflow: ellipsis; 
}

.btn-blog {
    color: #ffffff;
    background-color: #E50000;
    border-color: #E50000;
    border-radius:0;
    margin-bottom:10px
}
.btn-blog:hover,
.btn-blog:focus,
.btn-blog:active,
.btn-blog.active,
.open .dropdown-toggle.btn-blog {
    color: white;
    background-color:#0b56a8;
    border-color: #0b56a8;
}
article h2{color:#333333;}
h2{color:#0b56a8;}
 .margin10{margin-bottom:10px; margin-right:10px;}
 
 .container .text-style
{
  text-align: justify;
  line-height: 23px;
  margin: 0 13px 0 0;
  font-size: 19px;
}
    
#refList{
	
}    	
    
    </style>
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
						<li><a>시스템개요</a></li>
					</ul>
            	</div>
            </div>
		        
		</div>
	</header>
	--> 
	<!--dateChoooooser--> 
	<!--dateChoooooser--> 
	<!--dateChoooooser--> 
	
    
    <!-- /.container -->
	<div class="container">
            <div class="col-lg-12">
                <h2 class="page-header"><spring:message code="nav.system.summary"/></h2>
            </div>

<!-- 
	<section class="col-md-2">
		<ul id="leftnav" class="ul-left-nav fa-ul hidden-print">
                  <li class="separator">
            <a class="separator" href="#">
             시스템 개요            </a>
          </li>
                  <li>
            <i class="fa fa-angle-double-right orange fa-fw"></i>
            <a href="" target="_self">
              해빙면적            </a>
          </li>
                  <li>
            <i class="fa fa-angle-double-right orange fa-fw"></i>
            <a href="" target="_self">
              해빙 표면거철기            </a>
          </li>
        
            </ul>
	</section>
 -->
	
	<!-- #0b56a8 -->
	<section class="col-md-10 col-md-offset-1">
		<h5><a name="about"><strong><spring:message code="systemsummary.summary"/></strong></a></h5>
	    <p><spring:message code="systemsummary.summary.content"/>
		</p>

		<h5><a name="history"><strong><spring:message code="systemsummary.extent"/></strong></a></h5>
      	<p><spring:message code="systemsummary.extent.content"/>
		</p>


		<h5><a name="history"><strong><spring:message code="systemsummary.roughness"/></strong></a></h5>
      	<p><spring:message code="systemsummary.roughness.content"/>
		</p>
			<ul>
	            <li><spring:message code="systemsummary.roughness.content.water"/></li>
	            <li><spring:message code="systemsummary.roughness.content.mixed"/></li>
	            <li><spring:message code="systemsummary.roughness.content.icesnow"/></li>
            </ul>        
            
            
            
         
		<h5><a name="history"><strong><spring:message code="systemsummary.changes"/></strong></a></h5>	
      	<p><spring:message code="systemsummary.changes.content"/>
		</p>
            
        <p align="center"> 
			<img src="<c:url value='/assets/arctic/summary_trend.png'/>" class="img-responsive"  alt="해빙변화경향 시계열차트"/>&lt;북극해빙면적(왼쪽)과 표면거칠기(오른쪽)의 장기변화 경향  &gt;   
        </p> 
        
		<h5><a name="history"><strong><spring:message code="systemsummary.fcst"/></strong></a></h5>
		<p><spring:message code="systemsummary.fcst.content"/>
		</p>
		
		<h5><a name="history"><strong><spring:message code="systemsummary.passage"/></strong></a></h5>
		<p><spring:message code="systemsummary.passage.content"/>
		</p>
		<!--		
        <h5><a name="history"><strong>북극해빙 지도</strong></a></h5>
        <p align="center"> 
			<img src="<c:url value='/assets/arctic/map.jpg'/>" class="img-responsive"  alt="북극해빙 지도 이미지"/>
        </p> 
        -->
	</section>
</div>	
	
	

	
	
	
<!-- 
	<div class="container">
		<section class="col-sm-2">
    		<nav class="nav-sidebar">
				<ul class="nav tabs">
		          <li class="active"><a href="#tab1" data-toggle="tab">Lorem ipsum</a></li>
		          <li class=""><a href="#tab2" data-toggle="tab">Dolor asit amet</a></li>
		          <li class=""><a href="#tab3" data-toggle="tab">Stet clita</a></li>                               
				</ul>
			</nav>
		</section>
		<section class="col-sm-8">
			<div class="tab-pane active text-style" id="tab1">
 				<h2>Lorem ipsum</h2>
       			<p>
         			Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's 
			         standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make 
			         a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining 
			         essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, 
			         and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
         			Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's 
			         standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make 
			         a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining 
			         essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, 
			         and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
         			
			    </p>
       			<hr>
      			<img src="http://placehold.it/350x250" class="img-rounded pull-right">   
			</div>
		</section>
	</div>
	
 -->
	
	

	
	
    <!-- Footer -->
    <!-- Footer -->
    <!-- Footer -->
	<div id="meFooter"  style="margin-top: 20px;">
		<c:import url="/arcticPageLink.do?link=main/inc/meFooter" />
	</div>
	
	<!-- jQuery 
    <script src="<c:url value="/mestrap/js/jquery.js"/>"></script>
	-->

    <!-- Bootstrap Core JavaScript 
    <script src="<c:url value="/mestrap/js/bootstrap.min.js"/>"></script>
    -->
    <!-- Bootstrap Core JavaScript -->
<!-- //전체 레이어 끝 -->
</body>
</html>

