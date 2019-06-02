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
		.write{
		background: #fff;
        border:1px solid #b9babb;       
		margin:3px;
		padding:3px;
        width : 100px;
		}
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  

function fncGetList(currentPage) {
   	$("#currentPage").val(currentPage)
	$("form").attr("method" , "POST").attr("action" , "/product/getProduct?prodNo="+$("#prodNo").val()+"&menu=${param.menu}").submit();

}
	
	

$(function(){


	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
	//============= "���Ǻ���"  Event ó�� ��  ���� =============	
	$( ".qaTitle" ).on("click" , function() {
		
		var qaNo = $(this).children("input").val();
		//alert(qaNo);
		
		 $.ajax( 			
				{
			    	url : "/qa/json/getQa/"+qaNo,
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
						if(JSONData.pwCheck == 1){
						 var displayValue = "<h6>"
													+"�� �� �� : "+JSONData.buyer.userId+"<br/>"
													+"���� : "+JSONData.title+"<br/>"
													+"���� : "+JSONData.qaText+"<br/>"; 
													
						if(JSONData.fileName != null){
							displayValue += "�̹��� : <img src=/images/uploadFiles/"+JSONData.fileName+" width=\"300px\" height=\"300px\"/> <br/></h6>";
						}else{
							displayValue += "</h6>";
						}
						}else{
							var displayValue ="<h6><br/>��й�ȣ : <input type=\"password\" id=\"pw\" name=\"pw\"/>"
											   +"<button type=\"button\" class=\"pwWrite\">Ȯ��</button>"
											   +"</h6>";
						}
						//Debug...									
						//alert(displayValue);
						$("h6").remove();
						$( "#"+qaNo+"" ).html(displayValue);
					}
			});		 
		
	}); 
	
	
	//============= "���Ǿ���"  Event ó�� ��  ���� =============
	 $( ".write" ).on("click" , function() {
		 //alert($("#prodNo").val())
			self.location="/qa/addQa?prodNo="+$("#prodNo").val();
		});
	 
/* 		//============= "���Ǽ���"  Event ó�� ��  ���� =============
	 $( 'i[class="glyphicon glyphicon-pencil"]' ).on("click" , function() {
			self.location="/review/getReview?reviewNo="+$(this).children("input").val()
		});	 */
		
		//============= "���Ǿ���"  Event ó�� ��  ���� =============
	 $( ".pwWrite" ).on("click" , function() {
		 alert("����")
			//self.location="/qa/addQa?prodNo="+$("#prodNo").val();
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

	      <br/> <h3 class=" text-info">���Ź��Ǹ��</h3><hr/>
	        <img  src="/images/uploadFiles/qa.PNG"  width="1100px;" height="300px"/>
	       <h5 class="text-muted">����  <strong class="text-danger">����</strong> ��ȸ�Դϴ�.</h5>
	      
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
            <th align="left" >����</th>
            <th align="left">�����ھ��̵�</th> 
<!-- 			<th align="left">�����ϱ�</th> -->
			<th align="left">�ۼ���</th>             			
          </tr>
        </thead>
       
 		<tbody>				
		  <c:set var="i" value="0" />
		  <c:forEach var="qa" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left" >${ i }</td>
			  <td align="left" class="qaTitle" >${qa.title}
			  <c:if test="${qa.pwCheck eq 2 }">
			  <img  src="/images/uploadFiles/padlock.png">
			  </c:if>
			 <div  id="${qa.qaNo}"></div>
			<input type="hidden" name="qaNo" id="qaNo" value="${qa.qaNo }" />			  
			  </td>  
			  <td align="left">${qa.buyer.userId}</td>	
<%-- 			  <td align="left">			  
			  	<i class="glyphicon glyphicon-pencil">
				<input type="hidden" value="${qa.qaNo }" /></i>
			  </td>	 --%>	
			  <td align="left">${qa.regDate}</td>				 
			</tr>
		<input type="hidden" id="prodNo" name="prodNo" value="${qa.qaProd.prodNo}"/>
          </c:forEach>
        
        </tbody> 
      
      </table>

	  <!--  table End /////////////////////////////////////--> 
		<div class="row">
			 <div class="col-md-12 text-right">
	  			<button type="button" class="write">WRITE</button>		
	  		</div> 				
	 	</div>
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>