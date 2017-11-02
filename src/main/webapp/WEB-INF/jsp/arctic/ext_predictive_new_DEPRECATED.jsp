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
    <!-- imageMapResizer -->
    <script type="text/javascript" src="<c:url value="/js/imageMapResizer.min.js"/>"></script>
    
    <!-- modal popup -->
    <script src="<c:url value="/js/modal/bootstrap-modalmanager.js"/>"></script>   
    <script src="<c:url value="/js/modal/bootstrap-modal.js"/>"></script>   
    <link href="<c:url value="/css/bootstrap-modal-bs3patch.css"/>" rel="stylesheet">
    <link href="<c:url value="/css/bootstrap-modal.css"/>" rel="stylesheet">
    
    <!-- pan n zoom -->   
    <script src="<c:url value="/js/scalable/panzoom/jquery.panzoom.js"/>"></script>
    <script src="<c:url value="/js/scalable/panzoom/jquery.mousewheel.js"/>"></script>
    
    <style type="text/css">
    .page-header { margin-bottom: 0;margin-top: 15px;color: #0b56a8; }
    </style>
    
    <script>
    $(document).ready(function() {
        //console.log('mostRecentStuff.lateststuff:: ${mostRecentStuff.lateststuff}');
        //var path_img = "<c:url value='/data/IMG/PRD/'/>" + "fig_ext_${mostRecentStuff.lateststuff}.png";
        var path_img = "/data/IMG/FCST/" + "seaice_pre_ext_ano_${mostRecentStuff.lateststuff}.png";
        $("#predictive").attr("src", path_img);
        $('map').imageMapResize();
    }); //JCV good to go sir
    
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
        //alert(dateStr);
        var path = "/data/IMG/FCST/" + "seaice_pre_ext_ano_"+dateStr+".png";
        $("#predictive").attr("src", path);
        $('map').imageMapResize();
    }
    
    //var minDate = 20070101;
    //var mostRecent = "${sdist.compbegindateInString}" * 1;
    var minDate = new Date(2015,5,01);
    var recentStuffArr = "${mostRecentStuff.lateststuff4Cal}".split('-');
    var mostRecentDate = new Date(recentStuffArr[0],recentStuffArr[1]*1 -1,recentStuffArr[2]);
    /* console.log(mostRecentDate instanceof Date && !isNaN(mostRecentDate.valueOf())) */
    
    function getDateCalculated(whichOperator) {
        var dStrArr =  $("#meDemo").val().split('-');      
        //var currDate = $('#meDemo').data('daterangepicker').startDate;    ---> not a date obj
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
        
        //$('#datepicker').datepicker("setDate", currDate);
        
        //updateSelectedDate( $("#datepicker").val().split('-').join(''));
    }
    
    function getRetrievalInterval(operator,currDate) {
        var dateCalculated = currDate;
        //var interval = $('#retrievalIntervalChooser').find(":selected").val()+'';
        var interval = $('#retrievalRangeSelector .selected').attr('value');
        var math_it_up={ 'btn_next': function (x, y) { return x + y },
                         'btn_prev': function (x, y) { return x - y }
        };
        
        if (interval=='DAY') {
             dateCalculated.setDate(math_it_up[operator](dateCalculated.getDate(),1));
        } else if (interval=='WEEK') {
             dateCalculated.setDate(math_it_up[operator](dateCalculated.getDate(),7));
        } else if (interval=='MONTH') {
             //dateCalculated.setMonth(math_it_up[operator](dateCalculated.getMonth(),1));
             var addOrSubtractMonth= (operator=='btn_prev')? -1:1; //31 Jan + 1 month = 28 Feb
             dateCalculated = new Date(dateCalculated).add(addOrSubtractMonth).month();
        } else if (interval=='YEAR') {
             dateCalculated = new Date(dateCalculated).add((operator=='btn_prev')? -1:1).year();
        }
        return dateCalculated;
    }
    
    function viewPopup(imgIdx, leadTime) {
        //$('#popupTitle').text($("#meDemo").val());
        moveLeadtime(imgIdx, leadTime);
        $('#modalDialog').modal('show');
    }
    
    function moveLeadtime(imgIdx, leadTime) {
        var btnIdx = (imgIdx >= 5) ? (imgIdx-5) : imgIdx;
        $('.btn-lead').removeClass('btn-primary').addClass('btn-default');
        $('#btn-lead-'+btnIdx).removeClass('btn-default').addClass('btn-primary');
        var path = $("#predictive").attr("src");   // /data/IMG/PRD/seaice_pre_ext_ano_201604.png201604.png
        var split = path.split('/');
        var name = split[split.length-1];   //seaice_pre_ext_ano_201604.png201604.png
        var nameExt = name.replace('seaice_pre_ext_ano', 'seaice_pre_ext');
        nameExt = nameExt.replace('.png', leadTime +  '.png');
        var nameAno = name.replace('seaice_pre_ext_ano', 'seaice_pre_ano');
        nameAno = nameAno.replace('.png', leadTime +  '.png');
        var pathExt = "/data/IMG/FCST/" + nameExt;   //seaice_pre_ext_201604_00.png
        var pathAno = "/data/IMG/FCST/" + nameAno;   //seaice_pre_ano_201604_00.png
        $("#icePopup-ext").attr("src", pathExt);
        $("#icePopup-ano").attr("src", pathAno);
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
                        <button  type="button" class="meBtn meBtn-primary meBtn-lg outline " style="margin-top:2px;" id="btn_getMostRecentOne">최근</button>
                    </div>
                    
                    <div class="pull-left">
                        <button  id="btn_prev" type="button" class="meBtn meBtn-primary  fa fa-chevron-left" onclick="getDateCalculated(this.id)"></button>
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
                        <button  id="btn_next" type="button" class="meBtn meBtn-primary fa fa-chevron-right" onclick="getDateCalculated(this.id)"></button>
                    </div>
                </div>
                
                <div class="pull-right" style="padding-right:50px;"> 
                    <ul id="breadcrumbs-one" class="pull-right vcenter" >
                        <li><a href="<c:url value='/cmm/main/mainPage.do'/>">Home</a></li>
                        <li><a>해빙전망</a></li>
                        <li><a>해빙전망</a></li>
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
            </script>
        </div>
    </header>
    <!--dateChoooooser--> 
    
    <!-- Page Content -->
    <div class="container" >
        <div class="col-lg-12">
            <h3 class="page-header">해빙전망</h3>
        </div>
        <div align="center">
            <div class="row">
                <p class="col-lg-12">
                <!-- 
                    <h4 class="page-header">ice graphic goes here ext / rou</h4>
                -->
                </p>
                <div class="col-md-12">
                    <div class="hbox">
                        <!-- <img id="predictive"  alt="해빙전망공간분포그래픽" class="img-responsive" style="width:85%; height:auto;"> -->
                        <div class="well well-sm">
                            <img id="predictive" border="0" width="1200" height="760" orgWidth="1200" orgHeight="760" usemap="#image-maps" alt="해빙전망공간분포그래픽" class="img-thumbnail" style="width:100%; height:auto;" />
                            <map name="image-maps" id="map-seaice">
                                <area href="javascript:viewPopup(0, '_00');" shape="rect" coords="36,99,251,307" style="outline:none;" target="_self" alt="" title="" />
                                <area href="javascript:viewPopup(1, '_01');" shape="rect" coords="270,102,485,310" style="outline:none;" target="_self" alt="" title="" />
                                <area href="javascript:viewPopup(2, '_02');" shape="rect" coords="506,101,721,309" style="outline:none;" target="_self" alt="" title="" />
                                <area href="javascript:viewPopup(3, '_03');" shape="rect" coords="741,100,956,308" style="outline:none;" target="_self" alt="" title="" />
                                <area href="javascript:viewPopup(4, '_04');" shape="rect" coords="976,99,1191,307" style="outline:none;" target="_self" alt="" title="" />
                                <area href="javascript:viewPopup(5, '_00');" shape="rect" coords="35,418,250,626" style="outline:none;" target="_self" alt="" title="" />
                                <area href="javascript:viewPopup(6, '_01');" shape="rect" coords="270,418,485,626" style="outline:none;" target="_self" alt="" title="" />
                                <area href="javascript:viewPopup(7, '_02');" shape="rect" coords="505,418,720,626" style="outline:none;" target="_self" alt="" title="" />
                                <area href="javascript:viewPopup(8, '_03');" shape="rect" coords="741,417,956,625" style="outline:none;" target="_self" alt="" title="" />
                                <area href="javascript:viewPopup(9, '_04');" shape="rect" coords="975,417,1190,625" style="outline:none;" target="_self" alt="" title="" />
                                <area shape="rect" coords="1198,758,1200,760" alt="Image Map" style="outline:none;" title="Image Map" href="javascript:alert(-999);" />
                            </map>
                        </div>
                        <p>※ 해빙전망은 매월 20일경 업데이트 됩니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <div id="meFooter">
        <c:import url="/arcticPageLink.do?link=main/inc/meFooter" />
    </div>
    
    <div id="modalDialog" class="modal container fade" tabindex="-1" style="display: none;">
        <div id="modalHeader" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <!-- <h4 id="popupTitle"></h4> -->
            <div class="buttons">
                <button class="btn btn-default btn-lead" id="btn-lead-0" onclick="moveLeadtime(0, '_00')">lead: +0</button>
                <button class="btn btn-default btn-lead" id="btn-lead-1" onclick="moveLeadtime(1, '_01')">lead: +1</button>
                <button class="btn btn-default btn-lead" id="btn-lead-2" onclick="moveLeadtime(2, '_02')">lead: +2</button>
                <button class="btn btn-default btn-lead" id="btn-lead-3" onclick="moveLeadtime(3, '_03')">lead: +3</button>
                <button class="btn btn-default btn-lead" id="btn-lead-4" onclick="moveLeadtime(4, '_04')">lead: +4</button>
            </div>
        </div>
        <div id="meModalBody" class="modal-body ">
            <section id="inverted-contain">
                <div class="row">
                    <div class="col-xs-6 col-md-6">
                        <img id="icePopup-ext" class="img-responsive" style="display: inline-block;"/>
                    </div>
                    <div class="col-xs-6 col-md-6">
                        <img id="icePopup-ano" class="img-responsive" style="display: inline-block;"/>
                    </div>
                </div>
            </section>
        </div>
        <div class="modal-footer">
            <button type="button" data-dismiss="modal" class="btn">Close</button>
        </div>
    </div>
</body>
</html>