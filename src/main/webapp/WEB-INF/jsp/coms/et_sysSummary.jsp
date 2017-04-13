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

<link rel="stylesheet" type="text/css" href="/nimrGlowEos/css/layout.css">

</head>

<body id="fabulousbdtc">

	<div class="hor-align" id="content" >
		
			<!-- 
			<div align="center">
				<p> <font style="font-weight: bold">위성 증발산량</font></p><br/>
			</div>
			 -->
			
			<div id="systemSummaryDiv"  align="left" style="padding-left: 10px">
				<div style="width: 750px">
					<p><font style="font-weight: bold">개요</font></p>
					 <div class="sysSumLvl2" style="margin: 0px">증발산은 지표면에서의 증발 작용과 식물기공을 통한 증산 작용에 의해 수증기가 대기 중으로 방출되는 현상이다. 증발산은 지구 물순환 및 에너지 순환을 이해하는데 매우 중요하다.</div>
					 <div  class="sysSumLvl2" style="margin: 0px">최근 기후변화 감시 및 수자원 분야에서 증발산량의 중요성이 증가하고 있으며, 국립기상과학원은 천리안위성 자료를 이용하여 위성증발산량을 산출하는 기술을 개발하였다.</div> 
					 <div style="text-align: center; padding-top: 10px;padding-bottom: 10px;"">
					 		<div class="hbox" style="vertical-align: bottom">
						 		<div>
									<img src="/nimrGlowEos/img/systemSummary/et_sum_01.png" alt="증발산의 정의" width="260">
						 		</div>
						 		<span>Fig. 1. 증발산의 정의</span>
						 	</div>
						 	<div class="hbox" style="vertical-align: bottom">
						 		<div>
									<img src="/nimrGlowEos/img/systemSummary/et_algorithme.png" alt="위성 증발산량 산출 알고리즘 개념도" width="450">
						 		</div>
						 		<span>Fig. 2. 위성 증발산량 산출 알고리즘 개념도</span>
						 	</div>
					 
					 
					 
					 
					 </div>
					
					
					<br/>
					<p><font style="font-weight: bold">위성 증발산량 산출 알고리즘 및 특징</font></p>
					 <div class="sysSumLvl2" style="margin: 0px">지표 에너지 수지식(Surface Energy Balance)을 기반으로 알고리즘을 개발하였다.</div>
					 <div class="sysSumLvl2" style="margin: 0px">국립기상과학원의 알고리즘은 천리안 위성자료를 주자료로 사용하고 SPOT/VGT 위성의 지면 및 식생정보를 보조자료로 사용하여  동아시아지역에서 시ㆍ공간에 따른 식생의 변화를 반영하였다. </div>
					
					
					<br/>
					<p><font style="font-weight: bold">위성 증발산량 해상도 및 기간, 특징</font></p>
					 <div class="sysSumLvl2" style="margin: 0px">산출영역: 동아시아(100~145 °E, 20~50 °N) 영역</div>
					 <div class="sysSumLvl2" style="margin: 0px">산출기간: 2011.4 ~ 현재  </div>
					 <div class="sysSumLvl2" style="margin: 0px">시간해상도: 1일 / 공간해상도: 1 km x 1 km</div>
					 <br/>
					 <div style="padding-left: 5px" ><font style="font-size: 12px">※ 본 홈페이지에서는 위성 일 증발산량을 월평균 합성한 월평균 위성 증발산량을 제공한다. 위성 증발산량은 사막과 도시 지역을 제외한 &nbsp;청천일 때 산출된다. 또한, 월평균 위성 증발산량은 매달 초에 업데이트하여 제공된다.</font></div>
					
					
					<br/>
					<p><font style="font-weight: bold">검증 자료</font></p>
					 <div class="sysSumLvl2" style="margin: 0px">지상관측:  국내Flux-Tower 자료를 사용하며 위성증발산량을 검증하는 중요한 자료이다.</div>
					 <div class="sysSumLvl2" style="margin: 0px">분석기간: 2011.4~ 2013.12</div>
					 <div style="text-align: center; padding-top: 10px;">
					 	<div class="hbox" >
						 		<div>
									<img src="/nimrGlowEos/img/systemSummary/et_obsSite_smc.png"  alt="설마천(혼효림)">
						 		</div>
						 		<span>설마천(혼효림)</span>
						 	</div>
					 	<div class="hbox" >
						 		<div>
									<img src="/nimrGlowEos/img/systemSummary/et_obsSite_marker.png" alt="설마천 청미천">
						 		</div>
						 </div>
					 	<div class="hbox" >
						 		<div>
									<img src="/nimrGlowEos/img/systemSummary/et_obsSite_cmc.png" alt="청미천(농경지)">
						 		</div>
						 		<span>청미천(농경지)</span>
						 </div>
					 </div>
					 <div style="padding-left: 15px; padding-top:15px; font-size: 12px;" >
					 	[플럭스 타워 관측자료 정보]
					 	<img src="/nimrGlowEos/img/systemSummary/et_table.png" alt="플럭스 타워 관측자료 정보">
					 	<br/>※ 본 홈페이지는 월평균 위성증발산량 정보를 제공한다. 위성증발산량은 사막과 도시적인 지역을 제외한 청천지역에서 산출한다.
				 	</div>
					<br/>					 
					 <div class="sysSumLvl2" style="margin: 0px">MOIIS 위성 : 미국 NASA에서 Aqua·Terra/MODIS 자료를 이용하여 생산한 위성증발산량을 이용하여 비교한다. <br/>NASA는 Penman-Monteith 식을 기반으로 증발산량을 산출하였으며 전 세계의 8일, 월, 년 합성 증발산량을 제공한다.  </div>
					 <div class="sysSumLvl2" style="margin: 0px">분석기간: 2011.4 ~ 2013.12</div>
					 <br/>
					 <div style="padding-left: 5px" ><font style="font-size: 12px">※ MODIS 위성 증발량은 년 1회 전년도 자료를 제공하기 때문에 실시간으로 제공하지 않음. </font></div>
						 
					
				</div>
				
				
			</div>
		</div>
</body>

</html>
