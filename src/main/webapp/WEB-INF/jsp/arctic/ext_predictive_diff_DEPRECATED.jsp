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
    
    <!-- modal popup -->
    <script src="<c:url value="/js/modal/bootstrap-modalmanager.js"/>"></script>   
    <script src="<c:url value="/js/modal/bootstrap-modal.js"/>"></script>   
    <link href="<c:url value="/css/bootstrap-modal-bs3patch.css"/>" rel="stylesheet">
    <link href="<c:url value="/css/bootstrap-modal.css"/>" rel="stylesheet">
    
    <!-- pan n zoom -->   
    <script src="<c:url value="/js/scalable/panzoom/jquery.panzoom.js"/>"></script>
    <script src="<c:url value="/js/scalable/panzoom/jquery.mousewheel.js"/>"></script>
    
    <style type="text/css">
    img.img-thumbnail { width: 100%;height: auto;cursor: pointer; }
    img.img-responsive { display: inline-block; }
    .line-head { vertical-align: middle !important; }
    /* @media (min-width: 1200px) {
        #modalDialog.modal.container {
            width: 1370px !important;margin-left: -685px !important;
        }
    } */
    #modalDialog.modal.container { width: 70%;margin-left:-35%; }
    #modalDialogTs.modal.popup { width: 40%;margin-left:-20%; }
    #meModalBody .col-md-4 { padding-left: 3px;padding-right: 3px; }
    .table-striped>tbody>tr:nth-of-type(odd) { background-color: #fff; }
    .table-striped>tbody>tr:nth-of-type(even) { background-color: #f9f9f9; }
    .page-header { margin-bottom: 5px;margin-top: 15px;color: #0b56a8; }
    </style>
    
    <script>
    $(document).ready(function() {
        //
    });
    
    Date.prototype.customFormat = function(formatString) {
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
    };
    </script>

    <script>
    function meRequest(meDateObj) {
        changeImgSrc(meDateObj.format('YYYYMM'));
    }
    
    function changeImgSrc(dateStr) {
        var f = document.createElement('form');
        
        var objs = document.createElement('input'); 
        objs.setAttribute('type', 'hidden'); 
        objs.setAttribute('name', 'lateststuff'); 
        objs.setAttribute('value', dateStr);
        f.appendChild(objs);
        
        var objs2 = document.createElement('input'); 
        objs2.setAttribute('type', 'hidden'); 
        objs2.setAttribute('name', 'interval'); 
        objs2.setAttribute('value', $('#retrievalRangeSelector .selected').attr('value'));
        f.appendChild(objs2);
        
        f.setAttribute('method', 'post'); 
        f.setAttribute('action', '<c:url value="/arctic/monthlyPredictionDiff.do" />'); 
        
        document.body.appendChild(f); 
        f.submit();
    }
    
    var minDate = new Date(2015,5,01);
    var recentStuffArr = "${mostRecentStuff.lateststuff4Cal}".split('-');
    var mostRecentDate = new Date(recentStuffArr[0],recentStuffArr[1]*1 -1,recentStuffArr[2]);
    
    function getDateCalculated(whichOperator) {
        var dStrArr =  $("#meDemo").val().split('-');      
        var currDate = new Date(dStrArr[0],dStrArr[1]-1,dStrArr[2]);
        var dateTarget = getRetrievalInterval(whichOperator,currDate);
        
        if (dateTarget.getTime() < minDate.getTime()) {
            alert("자료 제공 범위는 2015-06-01 부터   ${mostRecentStuff.lateststuff4Cal}까지 입니다.");
            $('#meDemo').data('daterangepicker').setStartDate(moment(minDate).format('YYYY-MM-DD'));
            $('#meDemo').data('daterangepicker').setEndDate(moment(minDate).format('YYYY-MM-DD'));
            $('#meDemo').val(moment(minDate).format('YYYY-MM-DD'));
            meRequest(moment(minDate));
        } else if (dateTarget.getTime() > mostRecentDate.getTime()) {
            alert("자료 제공 범위는 2015-06-01 부터   ${mostRecentStuff.lateststuff4Cal}까지 입니다.");
            $("#btn_getMostRecentOne").trigger( "click" );
        } else {
            $('#meDemo').data('daterangepicker').setStartDate(moment(dateTarget).format('YYYY-MM-DD'));
            $('#meDemo').data('daterangepicker').setEndDate(moment(dateTarget).format('YYYY-MM-DD'));
            $('#meDemo').val(moment(dateTarget).format('YYYY-MM-DD'));
            meRequest(moment(dateTarget));
        }
    }
    
    function getRetrievalInterval(operator,currDate) {
        var dateCalculated = currDate;
        var interval = $('#retrievalRangeSelector .selected').attr('value');
        var math_it_up={ 'btn_next': function (x, y) { return (x + y) },
                         'btn_prev': function (x, y) { return (x - y) }
        };
        
        if (interval=='DAY') {
             dateCalculated.setDate(math_it_up[operator](dateCalculated.getDate(),1));
        } else if (interval=='WEEK') {
             dateCalculated.setDate(math_it_up[operator](dateCalculated.getDate(),7));
        } else if (interval=='MONTH') {
             var addOrSubtractMonth= (operator=='btn_prev')? -1:1; //31 Jan + 1 month = 28 Feb
             dateCalculated = new Date(dateCalculated).add(addOrSubtractMonth).month();
        } else if (interval=='YEAR') {
             dateCalculated = new Date(dateCalculated).add((operator=='btn_prev')? -1:1).year();
        }
        return dateCalculated;
    }
    
    function viewPopup(imgIdx, leadTime) {
        moveLeadtime(imgIdx, leadTime);
        $('#modalDialog').modal('show');
    }
    
    function moveLeadtime(imgIdx, leadTime) {
        var btnIdx = (imgIdx >= 4) ? (imgIdx-4) : imgIdx;
        $('.btn-lead').removeClass('btn-primary').addClass('btn-default');
        $('#btn-lead-'+btnIdx).removeClass('btn-default').addClass('btn-primary');
        $('.inverted-contain').hide();
        $('#inverted-contain_' + leadTime).show();
    }
    
    function showTimeSeries() {
        <c:if test="${empty timeseriesDiffOPWebPath}">alert('시계열 이미지가 없습니다.');</c:if>
        <c:if test="${not empty timeseriesDiffOPWebPath}">$('#modalDialogTs').modal('show');</c:if>
    }
    </script>
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
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-5 demo vcenter">
                    <input type="text" id="meDemo" class="form-control" readonly="readonly">
                    <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                </div>
                
                <div class="vcenter">
                    <div class="pull-left" style="margin-right: 15px;">
                        <button  type="button" class="meBtn meBtn-primary meBtn-lg outline" style="margin-top:2px;" id="btn_getMostRecentOne">최근</button>
                    </div>
                    
                    <div class="pull-left">
                        <button  id="btn_prev" type="button" class="meBtn meBtn-primary fa fa-chevron-left" onclick="getDateCalculated(this.id)"></button>
                    </div>
                    
                    <div id="retrievalRangeSelector" class="dropdown select pull-left" style="margin-left: 3px;margin-right: 3px">
                        <button class="  btn-small dropdown-toggle " type="button" id="menu1" data-toggle="dropdown" style="margin-top:6px;">
                            <c:if test="${interval eq 'MONTH'}"><span class="selected" id="2" value="MONTH">1개월</span><span class="caret"></span></c:if>
                            <c:if test="${interval eq 'YEAR'}"><span class="selected" id="3" value="YEAR">1년</span><span class="caret"></span></c:if>
                        </button>
                        <ul class="dropdown-menu option" role="menu" >
                            <li id="2" role="presentation" value="MONTH"><a role="menuitem" tabindex="-1" href="#">1개월</a></li>
                            <li id="3" role="presentation" value="YEAR"><a role="menuitem" tabindex="-1" href="#">1년</a></li>
                        </ul>
                    </div>
                    
                    <div class="pull-left">
                        <button  id="btn_next" type="button" class="meBtn meBtn-primary fa fa-chevron-right" onclick="getDateCalculated(this.id)"></button>
                    </div>
                </div>
                
                <div class="pull-right" style="padding-right:50px;"> 
                    <ul id="breadcrumbs-one" class="pull-right vcenter" >
                        <li><a href="<c:url value='/cmm/main/mainPage.do'/>">Home</a></li>
                        <li><a>해빙전망</a></li>
                        <li><a>해빙전망 검증</a></li>
                    </ul>
                </div>
            </div>
            
            <script type="text/javascript">
            $('#retrievalRangeSelector').on('click','.option li',function() {
                var i = $(this).parents('.select').attr('id');
                var v = $(this).children().text();
                var o = $(this).attr('id');
                var valStr = $(this).attr('value'); // (WEEK || MONTH || YEAR)
                $('#'+i+' .selected').attr('id',o);
                $('#'+i+' .selected').text(v);
                $('#'+i+' .selected').attr('value',valStr);
            });
            
            $('#btn_getMostRecentOne').click(function() {
                //change the selected date range of that picker
                $('#meDemo').data('daterangepicker').setStartDate('<c:out value="${mostRecentStuff.lateststuff4Cal}" />');
                $('#meDemo').data('daterangepicker').setEndDate('<c:out value="${mostRecentStuff.lateststuff4Cal}" />');
                
                $('#meDemo').val('<c:out value="${searchCondtion.lateststuff4Cal}" />');
                //click event는 발생안하네                 
                changeImgSrc('');
            });
            
            $('#meDemo').daterangepicker({
                locale: {
                    format: 'YYYY-MM-DD'
                }, 
                "singleDatePicker": true,
                "showDropdowns": true,
                "startDate": "<c:out value="${searchCondtion.lateststuff4Cal}" />", 
                "endDate" : "<c:out value="${searchCondtion.lateststuff4Cal}" />",
                "minDate": "2015-06-01",
                "maxDate": "<c:out value="${mostRecentStuff.lateststuff4Cal}" />"     //today
            }, function(start, end, label) {
                    meRequest(start);
            });
            </script>
        </div>
    </header>
    <!--dateChoooooser-->
    
    <!-- Page Content -->
    <div class="container" >
        <div class="col-lg-12">
            <h3 class="page-header">해빙전망 검증</h3>
        </div>
        <div align="center">
            <div class="row">
                <div class="col-lg-12">
                    <button class="btn btn-primary pull-right" onclick="showTimeSeries()">시계열</button>
                </div>
            </div>
            <table class="table table-striped" style="margin-top: 10px;">
                <colgroup>
                    <col width="4%">
                    <col width="32%">
                    <col width="32%">
                    <col width="32%">
                </colgroup>
                <thead>
                <tr class="info">
                    <th>&nbsp;</th><th>전망</th><th>관측</th><th>차이</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th class="line-head">1개월</th>
                    <td><c:if test="${not empty preExt01WebPath}">
                        <img id="predictive-01" border="0" alt="전망1개월" class="img-thumbnail" src="${preExt01WebPath}" onclick="viewPopup(0,'01')" /></c:if>
                    </td>
                    <td><c:if test="${not empty obsExt01WebPath}">
                        <img id="predictive-obs-01" border="0" alt="관측1개월" class="img-thumbnail" src="${obsExt01WebPath}" onclick="viewPopup(0,'01')" /></c:if>
                    </td>
                    <td><c:if test="${not empty diffOP01WebPath}">
                        <img id="predictive-diff-01" border="0" alt="차이1개월" class="img-thumbnail" src="${diffOP01WebPath}" onclick="viewPopup(0,'01')" /></c:if>
                    </td>
                </tr>
                <tr>
                    <th class="line-head">2개월</th>
                    <td><c:if test="${not empty preExt02WebPath}">
                        <img id="predictive-02" border="0" alt="전망2개월" class="img-thumbnail" src="${preExt02WebPath}" onclick="viewPopup(1,'02')" /></c:if>
                    </td>
                    <td><c:if test="${not empty obsExt02WebPath}">
                        <img id="predictive-obs-02" border="0" alt="관측2개월" class="img-thumbnail" src="${obsExt02WebPath}" onclick="viewPopup(1,'02')" /></c:if>
                    </td>
                    <td><c:if test="${not empty diffOP02WebPath}">
                        <img id="predictive-diff-02" border="0" alt="차이2개월" class="img-thumbnail" src="${diffOP02WebPath}" onclick="viewPopup(1,'02')" /></c:if>
                    </td>
                </tr>
                <tr>
                    <th class="line-head">3개월</th>
                    <td><c:if test="${not empty preExt03WebPath}">
                        <img id="predictive-03" border="0" alt="전망3개월" class="img-thumbnail" src="${preExt03WebPath}" onclick="viewPopup(2,'03')" /></c:if>
                    </td>
                    <td><c:if test="${not empty obsExt03WebPath}">
                        <img id="predictive-obs-03" border="0" alt="관측3개월" class="img-thumbnail" src="${obsExt03WebPath}" onclick="viewPopup(2,'03')" /></c:if>
                    </td>
                    <td><c:if test="${not empty diffOP03WebPath}">
                        <img id="predictive-diff-03" border="0" alt="차이3개월" class="img-thumbnail" src="${diffOP03WebPath}" onclick="viewPopup(2,'03')" /></c:if>
                    </td>
                </tr>
                <tr>
                    <th class="line-head">4개월</th>
                    <td><c:if test="${not empty preExt04WebPath}">
                        <img id="predictive-04" border="0" alt="전망4개월" class="img-thumbnail" src="${preExt04WebPath}" onclick="viewPopup(3,'04')" /></c:if>
                    </td>
                    <td><c:if test="${not empty obsExt04WebPath}">
                        <img id="predictive-obs-04" border="0" alt="관측4개월" class="img-thumbnail" src="${obsExt04WebPath}" onclick="viewPopup(3,'04')" /></c:if>
                    </td>
                    <td><c:if test="${not empty diffOP04WebPath}">
                        <img id="predictive-diff-04" border="0" alt="차이4개월" class="img-thumbnail" src="${diffOP04WebPath}" onclick="viewPopup(3,'04')" /></c:if>
                    </td>
                </tr>
                </tbody>
            </table>
            <%-- <div class="row">
                <div class="col-md-12">
                    <div class="hbox">
                        <p>※ 검증은 매월 20일경 업데이트 됩니다.</p>
                    </div>
                </div>
            </div> --%>
        </div>
    </div>
    
    <!-- Footer -->
    <div id="meFooter">
        <c:import url="/arcticPageLink.do?link=main/inc/meFooter" />
    </div>
    
    <!-- Modal -->
    <div id="modalDialog" class="modal container fade" tabindex="-1" style="display: none;">
        <div id="modalHeader" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <div class="buttons">
                <button class="btn btn-default btn-lead" id="btn-lead-0" onclick="moveLeadtime(0, '01')">lead: +1</button>
                <button class="btn btn-default btn-lead" id="btn-lead-1" onclick="moveLeadtime(1, '02')">lead: +2</button>
                <button class="btn btn-default btn-lead" id="btn-lead-2" onclick="moveLeadtime(2, '03')">lead: +3</button>
                <button class="btn btn-default btn-lead" id="btn-lead-3" onclick="moveLeadtime(3, '04')">lead: +4</button>
            </div>
        </div>
        <div id="meModalBody" class="modal-body">
            <section class="inverted-contain" id="inverted-contain_01">
                <div class="row">
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty preExt01WebPath}">
                        <img class="img-responsive" src="${preExt01WebPath}" /></c:if>
                    </div>
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty obsExt01WebPath}">
                        <img class="img-responsive" src="${obsExt01WebPath}" /></c:if>
                    </div>
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty diffOP01WebPath}">
                        <img class="img-responsive" src="${diffOP01WebPath}" /></c:if>
                    </div>
                </div>
            </section>
            <section class="inverted-contain" id="inverted-contain_02">
                <div class="row">
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty preExt02WebPath}">
                        <img class="img-responsive" src="${preExt02WebPath}" /></c:if>
                    </div>
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty obsExt02WebPath}">
                        <img class="img-responsive" src="${obsExt02WebPath}" /></c:if>
                    </div>
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty diffOP02WebPath}">
                        <img class="img-responsive" src="${diffOP02WebPath}" /></c:if>
                    </div>
                </div>
            </section>
            <section class="inverted-contain" id="inverted-contain_03">
                <div class="row">
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty preExt03WebPath}">
                        <img class="img-responsive" src="${preExt03WebPath}" /></c:if>
                    </div>
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty obsExt03WebPath}">
                        <img class="img-responsive" src="${obsExt03WebPath}" /></c:if>
                    </div>
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty diffOP03WebPath}">
                        <img class="img-responsive" src="${diffOP03WebPath}" /></c:if>
                    </div>
                </div>
            </section>
            <section class="inverted-contain" id="inverted-contain_04">
                <div class="row">
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty preExt04WebPath}">
                        <img class="img-responsive" src="${preExt04WebPath}" /></c:if>
                    </div>
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty obsExt04WebPath}">
                        <img class="img-responsive" src="${obsExt04WebPath}" /></c:if>
                    </div>
                    <div class="col-xs-4 col-md-4"><c:if test="${not empty diffOP04WebPath}">
                        <img class="img-responsive" src="${diffOP04WebPath}" /></c:if>
                    </div>
                </div>
            </section>
        </div>
        <div class="modal-footer">
            <button type="button" data-dismiss="modal" class="btn">Close</button>
        </div>
    </div>
    
    <!-- Modal Timeseries -->
    <div id="modalDialogTs" class="modal popup fade" tabindex="-1" style="display: none;">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">시계열</h4>
        </div>
        <div class="modal-body">
            <div style="padding-left: 6%;padding-right: 12%;"><c:if test="${not empty timeseriesDiffOPWebPath}">
                <img class="img-responsive" src="${timeseriesDiffOPWebPath}" /></c:if>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" data-dismiss="modal" class="btn">Close</button>
        </div>
    </div>
</body>
</html>