<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
        .picture{
          color: #ff0000; 
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  

function fncGetList(currentPage) {
   	$("#currentPage").val(currentPage)
   	//$("form").attr("method" , "POST").attr("action" , "/review/listReview?prod_no="+$("#prodNo").val()).submit();
	$("form").attr("method" , "POST").attr("action" , "/product/getProduct?prodNo="+$("#prodNo").val()+"&menu=${param.menu}").submit();

}
	
	

$(function(){


	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
	$( "td:nth-child(1)" ).on("click" , function() {	
		self.location ="/review/getReview?reviewNo="+$("#reviewNo").val()
	});
	
	//============= "�ı⾲��"  Event ó�� ��  ���� =============
	 $( "button.btn.btn-info" ).on("click" , function() {
		 //alert($("#prodNo").val())
			self.location="/review/addReview?prodNo="+$("#prodNo").val();
		});
	 
		//============= "�ı����"  Event ó�� ��  ���� =============
	 $( 'i[class="glyphicon glyphicon-pencil"]' ).on("click" , function() {
			self.location="/review/getReview?reviewNo="+$(this).children("input").val()
		});	
	
	
	//============= "�ı⺸��"  Event ó�� ��  ���� =============	
	$( "td:nth-child(2)" ).on("click" , function() {
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
							eval="�븸��";
						}else if(JSONData.evaluation==2){
							eval="����";
						}else if(JSONData.evaluation==3){
							eval="����";
						}else if(JSONData.evaluation==4){
							eval="�Ҹ���";
						}
						
						 var displayValue = "<h6>"
													+"���� �ı� ��ȣ : "+JSONData.reviewNo+"<br/>"
													+"��ǰ ��ȣ : "+JSONData.reviewProd.prodNo+"<br/>"
													+"�� �� �� : "+JSONData.buyer.userId+"<br/>"
													+"���� : "+JSONData.title+"<br/>"
													+"���� : "+JSONData.reviewText+"<br/>"		
													+"��ȣ�� : "+eval+"<br/>"; 
													
						if(JSONData.fileName != null){
							displayValue += "�̹��� : <img src=/images/uploadFiles/"+JSONData.fileName+" width=\"300px\" height=\"300px\"/> <br/></h6>";
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
	      <br/> <h3 class=" text-info">�����ı���</h3><hr/>
	       <h5 class="text-muted">����  <strong class="text-danger">�ı�</strong> ��ȸ�Դϴ�.</h5>
	      
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	      
	    <div class="row">
	    
		    <div class="col-md-3 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		     <form class="form-inline" name="detailForm">
			 <input type="hidden" id="currentPage" name="currentPage" value=""/>
			 </form>	
		   		   
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
 	
	<hr/>
	
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >�ı�����</th>
            <th align="left">��ȣ��</th>
            <th align="left">�����ھ��̵�</th> 
			<th align="left">�����ϱ�</th>         			
          </tr>
        </thead>
       
 		<tbody>				
		  <c:set var="i" value="0" />
		  <c:forEach var="review" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left" >${ i }</td>
			  <td align="left" >${review.title}
			  <c:if test="${review.fileName != null }">
			  <img  src="/images/uploadFiles/picture_icon.gif">
			  </c:if>
			  <p  id="${review.reviewNo}"></p>
			  
			  <input type="hidden" name="reviewNo" id="reviewNo" value="${review.reviewNo }" /></td>		  
				<td align="left"><strong class="text-danger">
				<c:if test="${review.evaluation eq 1 }">
						�ڡڡڡڡ�
				</c:if>
				<c:if test="${review.evaluation eq 2}">
						�ڡڡڡ�
				</c:if>
				<c:if test="${review.evaluation eq 3 }">
						�ڡ�
				</c:if>
				<c:if test="${review.evaluation eq 4}">
						��
				</c:if>
				</strong></td>
			  <td align="left">${review.buyer.userId}</td>	
			  <td align="left">			  
			  	<i class="glyphicon glyphicon-pencil">
				<input type="hidden" value="${review.reviewNo }" /></i>
			  </td>					 
			</tr>
		<input type="hidden" id="prodNo" name="prodNo" value="${review.reviewProd.prodNo}"/>
          </c:forEach>
        
        </tbody> 
      
      </table>
     <input type="hidden" id="prodNo" value="${product.prodNo}" />	

	  <!--  table End /////////////////////////////////////--> 
		<div class="row">
			 <div class="col-md-12 text-right">
	  			<button type="button" class="btn btn-info">WRITE</button>		
	  		</div> 				
	 	</div>
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>