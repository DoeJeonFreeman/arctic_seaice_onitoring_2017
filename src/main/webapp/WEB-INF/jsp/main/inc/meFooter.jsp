<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <!-- clipboard.js
 <script src="https://cdn.jsdelivr.net/clipboard.js/1.5.3/clipboard.min.js"></script>
 -->	
	
<link href="${pageContext.request.contextPath}/js/ctxmenu/toastr.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
<script src="${pageContext.request.contextPath}/js/clipper/clipboard.js"></script>
<script src="${pageContext.request.contextPath}/js/ctxmenu/toastr.js"></script>
     
        
    <p id="back-to-top">
      <a class="visible-xs" href="#top">Back to top</a>
    </p>
    
    
    <footer role="contentinfo" id="solstice-footer">

      <div class="container">
          <div id="copyright"> 
            <div class="container">
              	 <img src="${pageContext.request.contextPath}/mestrap/assets/ci/footer_kma_kr_en.png" alt="kma.go.kr logo" width="160" id="logo-kma-white"/>
	             <div style="float: left;padding-left: 10px; padding-top: 5px;">
	              	 <div>Copyright &copy; 2015 NMSC. All Rights Reserved.&nbsp;&nbsp;&nbsp;우.27803 충청북도 진천군 광혜원면 구암길 64-18</div>
	              	 <!-- 
    	          	 <div>우.27803 충청북도 진천군 광혜원면 구암길 64-18</div>
	              	  -->
	             </div> 	 	
	             
	            
	             <div style="float: left;padding-left: 15px;">
	             	<ul class="list-inline">
	             		<li>
	             			<button id="urlcopy" class="meLinkBtn meLinkBtn outline" >
	             			<i class="fa fa-link"></i>&nbsp;URL 복사
             				</button>
<!-- 	             			<button title="URL 복사" href="#" id="urlcopy" class="meBtn meBtn-primary outline"  data-clipboard-text="">
	             			URL 복사
             				</button>
 -->	             		</li>
	             		<li>
	             		</li>
	             	</ul>
	             	
	             	
	             </div> 	 
	             
	             
	             
	             <!--
	            
	             <div style="float: left;padding-left: 15px;">
	             	<ul class="list-inline social-media">
	             		<li>
	             			<a href="https://twitter.com/doejeonfreeman">
	             				<i class="fa fa-twitter-square"></i>
             				</a>
	             		</li>
	             		<li>
	             			<a href="https://www.facebook.com/ArcticSeaice2016">
	             				<i class="fa fa-facebook-square"></i>
             				</a>
	             		</li>
	             	</ul>
	             </div> 	 
	             -->
	             
	             
            </div>
          </div>
        
       	  <a href="#" class="scrollup">Back to top</a>
       	
       	  <script>
	       	var clipboard = new Clipboard('#urlcopy');
	       	clipboard.on('success', function(e) {
	       		toastr.info('URL이 클립보드에 복사되었습니다.');
	       		e.clearSelection();
	       	});
	       	
	    	var query = '${requestScope['javax.servlet.forward.query_string']}';
    		if (query.length==0){
    			query = '';
    		}else{
    			query = '?' + query;
    		}
 //   		data-clipboard-text="http://seaice.kma.go.kr${requestScope['javax.servlet.forward.request_uri']}?${requestScope['javax.servlet.forward.query_string']}"
	       	$('#urlcopy').attr('data-clipboard-text', "http://seaice.kma.go.kr${requestScope['javax.servlet.forward.request_uri']}"+query);
	
	      /*  	clipboard.on('success', function(e) {
	       	    console.info('Action:', e.action);
	       	    console.info('Text:', e.text);
	       	    console.info('Trigger:', e.trigger);
	
	       	    e.clearSelection();
	       	});
	
	       	clipboard.on('error', function(e) {
	       	    console.error('Action:', e.action);
	       	    console.error('Trigger:', e.trigger);
	       	}); */
       	  </script>	  
        </div>
        
        
        
    </footer>
