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
    
    <!-- modal popup -->
    <script src="<c:url value="/js/modal/bootstrap-modalmanager.js"/>"></script>   
    <script src="<c:url value="/js/modal/bootstrap-modal.js"/>"></script>   
    <link href="<c:url value="/css/bootstrap-modal-bs3patch.css"/>" rel="stylesheet">
    <link href="<c:url value="/css/bootstrap-modal.css"/>" rel="stylesheet">
    
    <!-- datepicker -->
    <link href="<c:url value="/js/polarmap/css/datepicker.css"/>" rel="stylesheet">
    
    <!-- leaflet -->
    <link href="<c:url value="/js/polarmap/css/leaflet.css"/>" rel="stylesheet">
    
    <!-- pan n zoom -->   
    <script src="<c:url value="/js/scalable/panzoom/jquery.panzoom.js"/>"></script>
    <script src="<c:url value="/js/scalable/panzoom/jquery.mousewheel.js"/>"></script>
    
    <style type="text/css">
    img.img-thumbnail { width: 100%;height: auto;cursor: pointer; }
    img.img-responsive { display: inline-block; }
    .line-head { vertical-align: middle !important; }
    
    #xmap { width: 700px;height: 700px; }
    #controls { width: 390px;height: 700px; }
    .page-header { margin-bottom: 0;margin-top: 15px;color: #0b56a8; }
    table.table-condensed td.day:not(.disabled) { background-color: #E7EBF4; }
    .modal-body-img { padding-left: 12%;padding-right: 6%;padding-top:6px;display: none; }
    div.btn-group .btn-primary { background-color: #a0b8ce; }
    div.btn-group .btn-primary.active { background-color: #286090; }
    div.btn-group .btn-info { background-color: #a0b8ce; }
    div.btn-group .btn-info.active { background-color: #31b0d5; }
    div.btn-group .btn-warning { background-color: #f1c280; }
    div.btn-group .btn-warning.active { background-color: #ec971f; }
    div.colorBarArea { height: 66px; }
    table.colorBar { width: 390px; }
    table.colorBar td { height: 30px;width: 16px;font-size: 10px !important;padding: 0;text-align: center; }
    table.colorBar tr.number td { height: 18px; }
    table.colorBar tr.bar td { border-bottom: 1px solid #bbb;border-top: 1px solid #bbb; }
    table.colorBar tr.bar td.first { border-bottom: 1px solid #fff;border-top: 1px solid #fff;border-left: 1px solid #fff;border-right: 1px solid #bbb; }
    table.colorBar tr.bar td.last { border-bottom: 1px solid #fff;border-top: 1px solid #fff;border-left: 1px solid #bbb;border-right: 1px solid #fff; }
    table.colorBar td span { font-size: 10px; }
    </style>
</head>
<body id="fabulousbdtc">
    <noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>   
    <!-- 전체 레이어 시작 -->

    <!-- header-->
    <div id="meHeader">
        <c:import url="/arcticPageLink.do?link=main/inc/meNavTop" />
    </div>

    <!--dateChoooooser-->
    <header class="meControllPanel">
        <div class="container" align="left">
            <div class="row form-horizontal">
                <div class="pull-right" style="padding-right:50px;"> 
                    <ul id="breadcrumbs-one" class="pull-right vcenter" >
                        <li><a href="<c:url value='/cmm/main/mainPage.do'/>">Home</a></li>
                        <li><a>해빙전망</a></li>
                        <li><a>계절예측</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>
    <!--dateChoooooser-->
    
    <!-- Page Content -->
    <div class="container" >
        <div class="col-lg-12">
            <h3 class="page-header">계절예측</h3>
        </div>
        <div align="center">
            <table>
                <tr>
                    <td>
                        <div id="xmap"></div>
                    </td>
                    <td>
                        <div id="controls">
                            <div class="input-group" data-toggle="buttons"><!-- 달력 -->
                                <input type="text" id="searchDate" class="form-control input-sm" style="width: 100px;cursor: pointer;">
                                &nbsp;<button class="btn btn-primary btn-sm" id="btn-search" onclick="search()">조회</button>
                                &nbsp;<button type="button" class="meBtn meBtn-primary meBtn-lg outline" onclick="searchRecentDate()">최근</button>
                            </div>
                            
                            <p style="margin-bottom: 4px;margin-top: 10px;font-weight: bold;font-size: 15px;">변수 선택</p>
                            <div class="btn-group" data-toggle="buttons" style="width: 100%;"><!-- 변수 버튼 -->
                                <label class="btn btn-info btn-sm btn-variableType btn-variableType-mslp active" id="label-variableType-mslp" style="width: 25%;">
                                    <input type="checkbox" id="variableType-mslp" name="variableType" value="mslp" checked="checked">해면기압
                                </label>
                                <label class="btn btn-info btn-sm btn-variableType btn-variableType-t15m active" id="label-variableType-t15m" style="width: 25%;">
                                    <input type="checkbox" id="variableType-t15m" name="variableType" value="t15m" checked="checked">기온(1.5m)
                                </label>
                                <label class="btn btn-info btn-sm btn-variableType btn-variableType-tsfc active" id="label-variableType-tsfc" style="width: 27%;">
                                    <input type="checkbox" id="variableType-tsfc" name="variableType" value="tsfc" checked="checked">기온(지표면)
                                </label>
                                <label class="btn btn-info btn-sm btn-variableType btn-variableType-wind active" id="label-variableType-wind" style="width: 23%;">
                                    <input type="checkbox" id="variableType-wind" name="variableType" value="wind" checked="checked">바람
                                </label>
                            </div>
                            
                            <div class="btn-group" data-toggle="buttons" style="width: 100%;margin-top: 10px;"><!-- 컬러바 -->
                                <div class="colorBarArea colorBar-mslp">
                                    <p style="margin: 0;">해면기압 (hPa)</p>
                                    <table class="colorBar mslp">
                                        <tr class="bar">
                                            <td style="background-color: #fff;" class="first"></td>
                                            <td style="background-color: #6c3e07;"></td>
                                            <td style="background-color: #824b09;"></td>
                                            <td style="background-color: #955910;"></td>
                                            <td style="background-color: #aa6e1f;"></td>
                                            <td style="background-color: #bf802d;"></td>
                                            <td style="background-color: #ca9749;"></td>
                                            <td style="background-color: #dab972;"></td>
                                            <td style="background-color: #e4cb8e;"></td>
                                            <td style="background-color: #eddaaa;"></td>
                                            <td style="background-color: #f5e8c4;"></td>
                                            <td style="background-color: #f5edd8;"></td>
                                            <td style="background-color: #f5f2ea;"></td>
                                            <td style="background-color: #ebf2f1;"></td>
                                            <td style="background-color: #d9eeeb;"></td>
                                            <td style="background-color: #c6e9e4;"></td>
                                            <td style="background-color: #c6e9e4;"></td>
                                            <td style="background-color: #8fd3c8;"></td>
                                            <td style="background-color: #75c5ba;"></td>
                                            <td style="background-color: #4faaa0;"></td>
                                            <td style="background-color: #32958d;"></td>
                                            <td style="background-color: #20837b;"></td>
                                            <td style="background-color: #0a6e66;"></td>
                                            <td style="background-color: #005c54;"></td>
                                            <td style="background-color: #004c42;"></td>
                                            <td style="background-color: #fff;" class="last"></td>
                                        </tr>
                                        <tr class="number">
                                            <td colspan="2"><span>940</span></td>
                                            <td colspan="2"><span>950</span></td>
                                            <td colspan="2"><span>960</span></td>
                                            <td colspan="2"><span>970</span></td>
                                            <td colspan="2"><span>980</span></td>
                                            <td colspan="2"><span>990</span></td>
                                            <td colspan="2"><span>1000</span></td>
                                            <td colspan="2"><span>1010</span></td>
                                            <td colspan="2"><span>1020</span></td>
                                            <td colspan="2"><span>1030</span></td>
                                            <td colspan="2"><span>1040</span></td>
                                            <td colspan="2"><span>1050</span></td>
                                            <td colspan="2"><span>1060</span></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="colorBarArea colorBar-t15m colorBar-tsfc">
                                    <p style="margin: 0;">기온 (℃)</p>
                                    <table class="colorBar t15m">
                                        <tr class="bar">
                                            <td style="background-color: #ff;" class="first"></td>
                                            <td style="background-color: #1616ff;"></td>
                                            <td style="background-color: #2a2aff;"></td>
                                            <td style="background-color: #3b3bff;"></td>
                                            <td style="background-color: #5252ff;"></td>
                                            <td style="background-color: #6666ff;"></td>
                                            <td style="background-color: #7777ff;"></td>
                                            <td style="background-color: #9191ff;"></td>
                                            <td style="background-color: #a5a5ff;"></td>
                                            <td style="background-color: #babaff;"></td>
                                            <td style="background-color: #cdcdff;"></td>
                                            <td style="background-color: #e2e2ff;"></td>
                                            <td style="background-color: #f4f4ff;"></td>
                                            <td style="background-color: #fff4f4;"></td>
                                            <td style="background-color: #ffdfdf;"></td>
                                            <td style="background-color: #ffcccc;"></td>
                                            <td style="background-color: #ffb8b8;"></td>
                                            <td style="background-color: #ffa3a3;"></td>
                                            <td style="background-color: #ff9191;"></td>
                                            <td style="background-color: #ff7777;"></td>
                                            <td style="background-color: #ff6464;"></td>
                                            <td style="background-color: #ff5252;"></td>
                                            <td style="background-color: #ff3b3b;"></td>
                                            <td style="background-color: #ff2828;"></td>
                                            <td style="background-color: #ff1313;"></td>
                                            <td style="background-color: #fff;" class="last"></td>
                                        </tr>
                                        <tr class="number">
                                            <td colspan="2"><span>-40</span></td>
                                            <td colspan="2"><span>-30</span></td>
                                            <td colspan="2"><span>-20</span></td>
                                            <td colspan="2"><span>-12</span></td>
                                            <td colspan="2"><span>-7</span></td>
                                            <td colspan="2"><span>-3</span></td>
                                            <td colspan="2"><span>0</span></td>
                                            <td colspan="2"><span>3</span></td>
                                            <td colspan="2"><span>7</span></td>
                                            <td colspan="2"><span>12</span></td>
                                            <td colspan="2"><span>20</span></td>
                                            <td colspan="2"><span>30</span></td>
                                            <td colspan="2"><span>40</span></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="colorBarArea colorBar-wind">
                                    <p style="margin: 0;">풍속 (m/s)</p>
                                    <table class="colorBar tsfc">
                                        <tr class="bar">
                                            <td style="background-color: #fff;" class="first"></td>
                                            <td style="background-color: #eaf7e4;"></td>
                                            <td style="background-color: #eaf7e4;"></td>
                                            <td style="background-color: #dff2da;"></td>
                                            <td style="background-color: #dff2da;"></td>
                                            <td style="background-color: #d5eecf;"></td>
                                            <td style="background-color: #d5eecf;"></td>
                                            <td style="background-color: #caeac4;"></td>
                                            <td style="background-color: #caeac4;"></td>
                                            <td style="background-color: #b8e3bc;"></td>
                                            <td style="background-color: #b8e3bc;"></td>
                                            <td style="background-color: #a6dcb5;"></td>
                                            <td style="background-color: #a6dcb5;"></td>
                                            <td style="background-color: #8fd3bd;"></td>
                                            <td style="background-color: #8fd3bd;"></td>
                                            <td style="background-color: #78cac4;"></td>
                                            <td style="background-color: #78cac4;"></td>
                                            <td style="background-color: #65bfcb;"></td>
                                            <td style="background-color: #65bfcb;"></td>
                                            <td style="background-color: #4eb3d2;"></td>
                                            <td style="background-color: #4eb3d2;"></td>
                                            <td style="background-color: #3c9fc8;"></td>
                                            <td style="background-color: #3c9fc8;"></td>
                                            <td style="background-color: #2b8cbe;"></td>
                                            <td style="background-color: #2b8cbe;"></td>
                                            <td style="background-color: #197ab5;"></td>
                                            <td style="background-color: #197ab5;"></td>
                                            <td style="background-color: #0868ac;"></td>
                                            <td style="background-color: #0868ac;"></td>
                                            <td style="background-color: #085496;"></td>
                                            <td style="background-color: #085496;"></td>
                                            <td style="background-color: #fff;" class="last"></td>
                                        </tr>
                                        <tr class="number">
                                            <td colspan="2"><span>0</span></td>
                                            <td colspan="2"><span>1</span></td>
                                            <td colspan="2"><span>2</span></td>
                                            <td colspan="2"><span>3</span></td>
                                            <td colspan="2"><span>4</span></td>
                                            <td colspan="2"><span>5</span></td>
                                            <td colspan="2"><span>6</span></td>
                                            <td colspan="2"><span>7</span></td>
                                            <td colspan="2"><span>8</span></td>
                                            <td colspan="2"><span>9</span></td>
                                            <td colspan="2"><span>10</span></td>
                                            <td colspan="2"><span>12</span></td>
                                            <td colspan="2"><span>15</span></td>
                                            <td colspan="2"><span>20</span></td>
                                            <td colspan="2"><span>30</span></td>
                                            <td colspan="2"><span>50</span></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            
                            <p style="margin-bottom: 4px;margin-top: 20px;font-weight: bold;font-size: 15px;">월 선택</p>
                            <div class="btn-group" data-toggle="buttons" style="width: 100%;"><!-- 월 버튼 -->
                                <label class="btn btn-primary btn-sm btn-monthType btn-monthType-m01 active" style="width: 33%;">
                                    <input type="radio" id="monthType-m01" name="monthType" value="m01" autocomplete="off" checked="checked">+01mon
                                </label>
                                <label class="btn btn-primary btn-sm btn-monthType btn-monthType-m02" style="width: 34%;">
                                    <input type="radio" id="monthType-m02" name="monthType" value="m02" autocomplete="off">+02mon
                                </label>
                                <label class="btn btn-primary btn-sm btn-monthType btn-monthType-m03" style="width: 33%;">
                                    <input type="radio" id="monthType-m03" name="monthType" value="m03" autocomplete="off">+03mon
                                </label>
                            </div>
                            
                            <p style="margin-bottom: 4px;margin-top: 30px;font-weight: bold;font-size: 15px;">해역 정보</p>
                            <div class="btn-group" data-toggle="buttons" style="width: 100%;"><!-- 해역 버튼 -->
                                <label class="btn btn-warning btn-sm btn-seaAreaType" id="label-seaAreaType-BRNT" style="width: 75%;">바렌츠해(Barent)</label>
                                <label class="btn btn-success btn-sm btn-seaAreaTs" onclick="showTimeSeries('BRNT', '바렌츠해(Barent)')" style="width: 25%;">시계열</label>
                                <br/><br/>
                                <label class="btn btn-warning btn-sm btn-seaAreaType" id="label-seaAreaType-KARA" style="width: 75%;">카라해(Kara)</label>
                                <label class="btn btn-success btn-sm btn-seaAreaTs" onclick="showTimeSeries('KARA', '카라해(Kara)')" style="width: 25%;">시계열</label>
                                <br/><br/>
                                <label class="btn btn-warning btn-sm btn-seaAreaType" id="label-seaAreaType-LPTV" style="width: 75%;">랍테프해(Laptev)</label>
                                <label class="btn btn-success btn-sm btn-seaAreaTs" onclick="showTimeSeries('LPTV', '랍테프해(Laptev)')" style="width: 25%;">시계열</label>
                                <br/><br/>
                                <label class="btn btn-warning btn-sm btn-seaAreaType" id="label-seaAreaType-ESBR" style="width: 75%;">동시베리아해(East siberian)</label>
                                <label class="btn btn-success btn-sm btn-seaAreaTs" onclick="showTimeSeries('ESBR', '동시베리아해(East siberian)')" style="width: 25%;">시계열</label>
                                <br/><br/>
                                <label class="btn btn-warning btn-sm btn-seaAreaType" id="label-seaAreaType-CHKC" style="width: 75%;">척치해(Chukchi)</label>
                                <label class="btn btn-success btn-sm btn-seaAreaTs" onclick="showTimeSeries('CHKC', '척치해(Chukchi)')" style="width: 25%;">시계열</label>
                                <br/><br/>
                                <label class="btn btn-warning btn-sm btn-seaAreaType" id="label-seaAreaType-BRNG" style="width: 75%;">베링해(Bering)</label>
                                <label class="btn btn-success btn-sm btn-seaAreaTs" onclick="showTimeSeries('BRNG', '베링해(Bering)')" style="width: 25%;">시계열</label>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
    <!-- Footer -->
    <div id="meFooter">
        <c:import url="/arcticPageLink.do?link=main/inc/meFooter" />
    </div>
    
    <!-- Modal Timeseries -->
    <div id="modalDialogTs" class="modal popup fade" tabindex="-1" style="display: none;">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title"><span id="modalDialogTs-title"></span> 시계열</h4>
        </div>
        <div class="modal-body">
            <div class="buttons" style="text-align: center;">
                <button class="btn btn-info btn-sm btn-modal-seaAreaTs" id="btn-modal-seaAreaTs-mslp" onclick="changeTimeSeries('mslp')">해면기압</button>
                <button class="btn btn-info btn-sm btn-modal-seaAreaTs" id="btn-modal-seaAreaTs-t15m" onclick="changeTimeSeries('t15m')">기온(1.5m)</button>
                <button class="btn btn-info btn-sm btn-modal-seaAreaTs" id="btn-modal-seaAreaTs-tsfc" onclick="changeTimeSeries('tsfc')">기온(지표면)</button>
                <button class="btn btn-info btn-sm btn-modal-seaAreaTs" id="btn-modal-seaAreaTs-wind" onclick="changeTimeSeries('wind')">바람</button>
            </div>
            <div class="modal-body-img" id="modal-body-img-mslp-BRNT"><c:if test="${not empty webPath_ts_BRNT_mslp}">
                <img class="img-responsive" src="${webPath_ts_BRNT_mslp}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-t15m-BRNT"><c:if test="${not empty webPath_ts_BRNT_t15m}">
                <img class="img-responsive" src="${webPath_ts_BRNT_t15m}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-tsfc-BRNT"><c:if test="${not empty webPath_ts_BRNT_tsfc}">
                <img class="img-responsive" src="${webPath_ts_BRNT_tsfc}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-wind-BRNT"><c:if test="${not empty webPath_ts_BRNT_wind}">
                <img class="img-responsive" src="${webPath_ts_BRNT_wind}" /></c:if>
            </div>
            
            <div class="modal-body-img" id="modal-body-img-mslp-KARA"><c:if test="${not empty webPath_ts_KARA_mslp}">
                <img class="img-responsive" src="${webPath_ts_KARA_mslp}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-t15m-KARA"><c:if test="${not empty webPath_ts_KARA_t15m}">
                <img class="img-responsive" src="${webPath_ts_KARA_t15m}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-tsfc-KARA"><c:if test="${not empty webPath_ts_KARA_tsfc}">
                <img class="img-responsive" src="${webPath_ts_KARA_tsfc}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-wind-KARA"><c:if test="${not empty webPath_ts_KARA_wind}">
                <img class="img-responsive" src="${webPath_ts_KARA_wind}" /></c:if>
            </div>
            
            <div class="modal-body-img" id="modal-body-img-mslp-LPTV"><c:if test="${not empty webPath_ts_LPTV_mslp}">
                <img class="img-responsive" src="${webPath_ts_LPTV_mslp}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-t15m-LPTV"><c:if test="${not empty webPath_ts_LPTV_t15m}">
                <img class="img-responsive" src="${webPath_ts_LPTV_t15m}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-tsfc-LPTV"><c:if test="${not empty webPath_ts_LPTV_tsfc}">
                <img class="img-responsive" src="${webPath_ts_LPTV_tsfc}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-wind-LPTV"><c:if test="${not empty webPath_ts_LPTV_wind}">
                <img class="img-responsive" src="${webPath_ts_LPTV_wind}" /></c:if>
            </div>
            
            <div class="modal-body-img" id="modal-body-img-mslp-ESBR"><c:if test="${not empty webPath_ts_ESBR_mslp}">
                <img class="img-responsive" src="${webPath_ts_ESBR_mslp}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-t15m-ESBR"><c:if test="${not empty webPath_ts_ESBR_t15m}">
                <img class="img-responsive" src="${webPath_ts_ESBR_t15m}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-tsfc-ESBR"><c:if test="${not empty webPath_ts_ESBR_tsfc}">
                <img class="img-responsive" src="${webPath_ts_ESBR_tsfc}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-wind-ESBR"><c:if test="${not empty webPath_ts_ESBR_wind}">
                <img class="img-responsive" src="${webPath_ts_ESBR_wind}" /></c:if>
            </div>
            
            <div class="modal-body-img" id="modal-body-img-mslp-CHKC"><c:if test="${not empty webPath_ts_CHKC_mslp}">
                <img class="img-responsive" src="${webPath_ts_CHKC_mslp}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-t15m-CHKC"><c:if test="${not empty webPath_ts_CHKC_t15m}">
                <img class="img-responsive" src="${webPath_ts_CHKC_t15m}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-tsfc-CHKC"><c:if test="${not empty webPath_ts_CHKC_tsfc}">
                <img class="img-responsive" src="${webPath_ts_CHKC_tsfc}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-wind-CHKC"><c:if test="${not empty webPath_ts_CHKC_wind}">
                <img class="img-responsive" src="${webPath_ts_CHKC_wind}" /></c:if>
            </div>
            
            <div class="modal-body-img" id="modal-body-img-mslp-BRNG"><c:if test="${not empty webPath_ts_BRNG_mslp}">
                <img class="img-responsive" src="${webPath_ts_BRNG_mslp}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-t15m-BRNG"><c:if test="${not empty webPath_ts_BRNG_t15m}">
                <img class="img-responsive" src="${webPath_ts_BRNG_t15m}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-tsfc-BRNG"><c:if test="${not empty webPath_ts_BRNG_tsfc}">
                <img class="img-responsive" src="${webPath_ts_BRNG_tsfc}" /></c:if>
            </div>
            <div class="modal-body-img" id="modal-body-img-wind-BRNG"><c:if test="${not empty webPath_ts_BRNG_wind}">
                <img class="img-responsive" src="${webPath_ts_BRNG_wind}" /></c:if>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" data-dismiss="modal" class="btn">Close</button>
        </div>
    </div>

    <!-- Load required libraries -->
<%--     <script src="<c:url value="/js/polarmap/js/jquery.js"/>"></script> --%>
    <script src="<c:url value="/js/polarmap/js/leaflet.js"/>"></script>
    <script src="<c:url value="/js/polarmap/js/proj4.js"/>"></script>
    <script src="<c:url value="/js/polarmap/js/proj4leaflet.js"/>"></script>
    
    <!-- Load PolarMap.js -->
    <script src="<c:url value="/js/polarmap/dist/polarmap.js"/>"></script>
    
    <script src="<c:url value="/js/polarmap/js/Leaflet.ImageOverlay.Rotated.js"/>"></script>
    
    <!-- Bootstrap datepicker JavaScript -->
    <script src="<c:url value="/js/polarmap/js/bootstrap-datepicker.js"/>"></script>
    <script src="<c:url value="/js/polarmap/js/bootstrap-datepicker.kr.js"/>" charset="UTF-8"></script>
    
    <script>
    var map;
    var defaultLayer;
    
    //Create object to define tile provider settings and transformations. Supports
    //all Leaflet TileLayer options.
    var projectedTiles = {
        "EPSG:3575 Europe" : L.PolarMap.layer3575
    };
    
    var GS5_IMAGES = {
        'mslp.m01' : '${webPath_mslp_m01}',
        'mslp.m02' : '${webPath_mslp_m02}',
        'mslp.m03' : '${webPath_mslp_m03}',
        't15m.m01' : '${webPath_t15m_m01}',
        't15m.m02' : '${webPath_t15m_m02}',
        't15m.m03' : '${webPath_t15m_m03}',
        'tsfc.m01' : '${webPath_tsfc_m01}',
        'tsfc.m02' : '${webPath_tsfc_m02}',
        'tsfc.m03' : '${webPath_tsfc_m03}',
        'wind.m01' : '${webPath_wind_m01}',
        'wind.m02' : '${webPath_wind_m02}',
        'wind.m03' : '${webPath_wind_m03}',
    };
    
    var GS5_INDEX = {
         'mslp': 0, 't15m': 1, 'tsfc': 2, 'wind': 3
    };
    
    var SEA_AREA_LOCATION = {
        'BRNT' : [[65, 20], [65, 60], [80, 60], [80, 20]],
        'KARA' : [[70, 60], [70, 100], [80, 100], [80, 60]],
        'LPTV' : [[70, 100], [70, 135], [80, 135], [80, 100]],
        'ESBR' : [[70, 135], [70, 180], [80, 180], [80, 135]],
        'CHKC' : [[65, -180], [65, -150], [75, -150], [75, -180]],
        'BRNG' : [[55, -180], [55, -160], [65, -160], [65, -180]]
    };
    
    var SEA_AREA_POLYGON = [];
    
    var SEA_AREA_CODE = [
        'BRNT', 'KARA', 'LPTV', 'ESBR', 'CHKC', 'BRNG'
    ];
    
    var LAT_FIX = 24.5;
    var LATLNG_BOTTOMLEFT = [LAT_FIX, -35];
    var LATLNG_TOPLEFT = [LAT_FIX, -125];
    var LATLNG_TOPRIGHT = [LAT_FIX, 55];
    
    var imageLayerOpacity = 0.5;
    
    //이미지 [보이기|감추기|변경하기]
    function toggleImage(pVariableTypeArry, pMonthType) {
        $('img.leaflet-image-layer').hide();
        $('img.leaflet-image-layer:eq(0)').attr('src', GS5_IMAGES['mslp.' + pMonthType]);
        $('img.leaflet-image-layer:eq(1)').attr('src', GS5_IMAGES['t15m.' + pMonthType]);
        $('img.leaflet-image-layer:eq(2)').attr('src', GS5_IMAGES['tsfc.' + pMonthType]);
        $('img.leaflet-image-layer:eq(3)').attr('src', GS5_IMAGES['wind.' + pMonthType]);
        
        for (var idx = 0; idx < pVariableTypeArry.length; idx++) {
            var targetName = pVariableTypeArry[idx];
            $('img.leaflet-image-layer:eq(' + GS5_INDEX[targetName] + ')').show();
            $('img.leaflet-image-layer').css('opacity', (imageLayerOpacity - (0.05 * idx)));
        }
    }
    
    //해역영역 [보이기|감추기]
    var isModal = false;
    function toggleSeaArea(pSeaAreaType) {
        for (var idx = 0; idx < SEA_AREA_CODE.length; idx++) {
            if (SEA_AREA_CODE[idx] == pSeaAreaType) {
                if (map.hasLayer(SEA_AREA_POLYGON[idx])) {
                    if (!isModal) {
                        $('#label-seaAreaType-' + pSeaAreaType).addClass('active'); //왜 add를 해야하는지 모르겠음...
                        map.removeLayer(SEA_AREA_POLYGON[idx]);
                    }
                } else {
                    map.addLayer(SEA_AREA_POLYGON[idx]);
                    
                    var centroid = getCentroid(SEA_AREA_LOCATION[SEA_AREA_CODE[idx]]);
                    map.setZoomAround(centroid, defaultLayer.options.zoom+1);
                    map.panTo(centroid);
                }
            } else {
                map.removeLayer(SEA_AREA_POLYGON[idx]);
            }
        }
        isModal = false;
    }
    
    //Polygon 중심값 반환
    var getCentroid = function (arr) { 
        return arr.reduce(function (x,y) {
            return [x[0] + y[0]/arr.length, x[1] + y[1]/arr.length];
        }, [0,0]);
    };
    
    var recentSeaAreaTypeVal = '';
    function showTimeSeries(pSeaAreaType, pSeaAreaName) {
        isModal = true;
        recentSeaAreaTypeVal = pSeaAreaType;
        changeTimeSeries('mslp');
        $('#label-seaAreaType-' + pSeaAreaType).click();
        $('#modalDialogTs-title').text(pSeaAreaName);
        $('#modalDialogTs').modal('show');
    }
    
    function changeTimeSeries(pVariableType) {
        $('.btn-modal-seaAreaTs').removeClass('active');
        $('#btn-modal-seaAreaTs-' + pVariableType).addClass('active');
        $('.modal-body-img').hide();
        $('#modal-body-img-' + pVariableType + '-' + recentSeaAreaTypeVal).show();
    }
    
    var recentDate = '${recentDate}';
    function search() {
        var f = document.createElement('form');
        
        var objs = document.createElement('input'); 
        objs.setAttribute('type', 'hidden'); 
        objs.setAttribute('name', 'searchDate');
        objs.setAttribute('value', $('#searchDate').val());
        f.appendChild(objs);
        
        f.setAttribute('method', 'post'); 
        f.setAttribute('action', '<c:url value="/arctic/monthlyPredictionMap.do" />'); 
        
        document.body.appendChild(f); 
        f.submit();
    }
    
    function searchRecentDate() {
        var recentDateObj = new Date(recentDate.replace(/-/g, '/'));
        $('#searchDate').datepicker('setDate', recentDateObj);
        search();
    }
    
    //Initialization
    $(document).ready(function() {
        // Load PolarMap
        defaultLayer = projectedTiles["EPSG:3575 Europe"];
        map = L.PolarMap.map('xmap', {
            baseLayer: defaultLayer,
            center: defaultLayer.options.center,
            zoom: defaultLayer.options.zoom-1,
            minZoom: defaultLayer.options.zoom-1,
            maxZoom: defaultLayer.options.zoom+2
        });
        
        var imageBounds = [ LATLNG_BOTTOMLEFT, LATLNG_TOPLEFT, LATLNG_TOPRIGHT ];  //bottomleft | topleft | topright
        
        var imageUrl1 = GS5_IMAGES['mslp.m01']; //해면기압
        L.imageOverlay(imageUrl1, imageBounds).addTo(map);
        $('img.leaflet-image-layer').css('opacity', imageLayerOpacity);
        
        var imageUrl2 = GS5_IMAGES['t15m.m01']; //기온(1.5m)
        L.imageOverlay(imageUrl2, imageBounds).addTo(map);
        $('img.leaflet-image-layer').css('opacity', (imageLayerOpacity - 0.05));
        
        var imageUrl3 = GS5_IMAGES['tsfc.m01']; //기온(지표면)
        L.imageOverlay(imageUrl3, imageBounds).addTo(map);
        $('img.leaflet-image-layer').css('opacity', (imageLayerOpacity - 0.1));
        
        var imageUrl4 = GS5_IMAGES['wind.m01']; //바람
        L.imageOverlay(imageUrl4, imageBounds).addTo(map);
        $('img.leaflet-image-layer').css('opacity', (imageLayerOpacity - 0.15));
        
        //해역영역 Polygon 정보 배열에 담기
        for (var idx = 0; idx < SEA_AREA_CODE.length; idx++) {
            var location = SEA_AREA_LOCATION[SEA_AREA_CODE[idx]];
            var polygonGroup = L.layerGroup([
                L.polygon([ location ], { fillOpacity: 0.15, weight: 2 })
            ]);
            SEA_AREA_POLYGON.push(polygonGroup);
        }
        
        //변수 클릭시
        $('.btn-variableType').click(function() {
            var objVal = this.id;
            objVal = objVal.replace('label-variableType-', '');
            if ($(this).hasClass("active")) {
                $('#variableType-' + objVal).attr('checked', false);
                if (objVal == 't15m') {
                    if (!$('#variableType-tsfc').attr('checked')) {
                        $('.colorBar-' + objVal).css('visibility', 'hidden');
                    }
                } else if (objVal == 'tsfc') {
                    if (!$('#variableType-t15m').attr('checked')) {
                        $('.colorBar-' + objVal).css('visibility', 'hidden');
                    }
                } else {
                    $('.colorBar-' + objVal).css('visibility', 'hidden');
                }
            } else {
                $('#variableType-' + objVal).attr('checked', true);
                $('.colorBar-' + objVal).css('visibility', 'visible');
            }
        });
        //월 클릭시
        $('.btn-monthType').click(function() {
            if ($(this).hasClass("disabled")) {
                return false;
            }
        });
        //해역 클릭시
        $('.btn-seaAreaType').click(function() {
            $('.btn-seaAreaType').removeClass('active');
            var objVal = this.id;
            objVal = objVal.replace('label-seaAreaType-', '');
            toggleSeaArea(objVal);
        });
        
        //변수 변경시
        $('input[name="variableType"]').change(function() {
            var variableTypeValArry = new Array();
            $('input[name="variableType"]').each(function() {
                if ($(this).attr('checked')) {
                    variableTypeValArry.push($(this).val());
                }
            });
            var monthTypeVal = $('input[name="monthType"]:checked').val();
            
            toggleImage(variableTypeValArry, monthTypeVal);
        });
        //월 변경시
        $('input[name="monthType"]').change(function() {
            var variableTypeValArry = new Array();
            $('input[name="variableType"]').each(function() {
                if ($(this).attr('checked')) {
                    variableTypeValArry.push($(this).val());
                }
            });
            var monthTypeVal = $('input[name="monthType"]:checked').val();
            
            toggleImage(variableTypeValArry, monthTypeVal);
        });
        
        $('#searchDate').datepicker({
            format: 'yyyy-mm-dd', autoclose: true, startDate: '2016-04-01', endDate: '+0d', language: 'kr', startView: 0, daysOfWeekDisabled: [0,2,3,4,5,6]
        }).on('changeDate', function(e) {
            //
        });
        
        var searchDateVal = '${searchDate}';    //yyyy-MM-dd
        var nowDateSplits = (searchDateVal).split('-');
        $('#searchDate').datepicker('setDate', new Date(nowDateSplits[0] + '/' + nowDateSplits[1] + '/' + nowDateSplits[2]));
        
        $('#modalDialogTs').on('shown', function() {
            $('.btn-seaAreaTs').removeClass('active');
        });
    });
    </script>
    
</body>
</html>
