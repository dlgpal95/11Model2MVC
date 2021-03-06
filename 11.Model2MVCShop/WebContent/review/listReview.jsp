<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
        .picture{
          color: #ff0000; 
        }
 		.reviewWrite{
		background: #fff;
        border:1px solid #b9babb;       
		margin:3px;
		padding:3px;
        width : 100px;
		}
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  

function fncGetList(currentPage) {
   	$("#currentPage").val(currentPage)
   	//$("form").attr("method" , "POST").attr("action" , "/review/listReview?prod_no="+$("#prodNo").val()).submit();
	$("form").attr("method" , "POST").attr("action" , "/product/getProduct?prodNo="+$("#prodNo").val()+"&menu=${param.menu}").submit();

}
	
	

$(function(){


	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
	$( ".reviewGet" ).on("click" , function() {	
		self.location ="/review/getReview?reviewNo="+$("#reviewNo").val()
	});
	
	//============= "후기쓰기"  Event 처리 및  연결 =============
	 $( ".reviewWrite" ).on("click" , function() {
		 //alert($("#prodNo").val())
			self.location="/review/addReview?prodNo="+$("#prodNo").val();
		});
	 
		//============= "후기수정"  Event 처리 및  연결 =============
	 $( 'i[class="glyphicon glyphicon-pencil"]' ).on("click" , function() {
			self.location="/review/getReview?reviewNo="+$(this).children("input").val()
		});	
	
	
	//============= "후기보기"  Event 처리 및  연결 =============	
	$( ".reviewTitle" ).on("click" , function() {
		//alert($(this).children("input").val());
		 //self.location ="/review/getReview?reviewNo="+$(this).children("input").val()
		var reviewNo = $(this).children("input").val();
		//alert(reviewNo);
		$.ajax( 			
				{
			    	url : "/review/json/getReview/"+reviewNo,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {

						//Debug...
						//alert(status);
						//Debug...
						//alert("JSONData : \n"+JSONData);
						//alert(JSONData.reviewNo);
						
						var eval=null;
						if(JSONData.evaluation==1){
							eval="대만족";
						}else if(JSONData.evaluation==2){
							eval="만족";
						}else if(JSONData.evaluation==3){
							eval="보통";
						}else if(JSONData.evaluation==4){
							eval="불만족";
						}
						
						 var displayValue = "<h6>"
													+"구매 후기 번호 : "+JSONData.reviewNo+"<br/>"
													+"상품 번호 : "+JSONData.reviewProd.prodNo+"<br/>"
													+"구 매 자 : "+JSONData.buyer.userId+"<br/>"
													+"제목 : "+JSONData.title+"<br/>"
													+"내용 : "+JSONData.reviewText+"<br/>"		
													+"선호도 : "+eval+"<br/>"; 
													
						if(JSONData.fileName != null){
							displayValue += "이미지 : <img src=/images/uploadFiles/"+JSONData.fileName+" width=\"300px\" height=\"300px\"/> <br/></h6>";
						}else{
							displayValue += "</h6>";
						}
						//Debug...									
						//alert(displayValue);
						$("h6").remove();
						$( "#"+reviewNo+"" ).html(displayValue);
					}
			});		
		
	}); 
	

});
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
	      <br/> <h3 class=" text-info">구매후기목록</h3><hr/>
	        <img  src="/images/uploadFiles/review.PNG"  width="1100px;" height="400px"/>
	       <h5 class="text-muted">구매  <strong class="text-danger">후기</strong> 조회입니다.</h5>
	      
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	      
	    <div class="row">
	    
		    <div class="col-md-3 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		     <form class="form-inline" name="detailForm">
			 <input type="hidden" id="currentPage" name="currentPage" value=""/>
			 </form>	
		   		   
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
 	
	<hr/>
	
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >후기제목</th>
            <th align="left">선호도</th>
            <th align="left">구매자아이디</th> 
			<th align="left">수정하기</th>
			<th align="left">등록일</th>             			
          </tr>
        </thead>
       
 		<tbody>				
		  <c:set var="i" value="0" />
		  <c:forEach var="review" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left" class="reviewGet" >${ i }</td>
			  <td align="left" class="reviewTitle" >${review.title}
			  <c:if test="${review.fileName != null }">
			  <img  src="/images/uploadFiles/picture_icon.gif">
			  </c:if>
			  <p  id="${review.reviewNo}"></p>
			  
			  <input type="hidden" name="reviewNo" id="reviewNo" value="${review.reviewNo }" /></td>		  
				<td align="left"><strong class="text-danger">
				<c:if test="${review.evaluation eq 1 }">
						★★★★★
				</c:if>
				<c:if test="${review.evaluation eq 2}">
						★★★★
				</c:if>
				<c:if test="${review.evaluation eq 3 }">
						★★
				</c:if>
				<c:if test="${review.evaluation eq 4}">
						★
				</c:if>
				</strong></td>
			  <td align="left">${review.buyer.userId}</td>	
			  <td align="left">			  
			  	<i class="glyphicon glyphicon-pencil">
				<input type="hidden" value="${review.reviewNo }" /></i>
			  </td>		
			  <td align="left">${review.regDate}</td>				 
			</tr>
		<input type="hidden" id="prodNo" name="prodNo" value="${review.reviewProd.prodNo}"/>
          </c:forEach>
        
        </tbody> 
      
      </table>
     <input type="hidden" id="prodNo" value="${product.prodNo}" />	

	  <!--  table End /////////////////////////////////////--> 
		<div class="row">
			 <div class="col-md-12 text-right">
	  			<button type="button" class="reviewWrite">WRITE</button>		
	  		</div> 				
	 	</div>
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>