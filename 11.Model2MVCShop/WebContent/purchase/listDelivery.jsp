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
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
	 	$("#currentPage").val(currentPage)
	 	$("form").attr("method" , "POST").attr("action" , "/purchase/listDelivery").submit();		 
	}
	
	
	$(function(){
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		
		//============= userId �� ȸ����������  Event  ó��(Click) =============
		$( "td:nth-child(2)" ).on("click" , function() {
			 self.location ="/user/getUser?userId="+$(this).text().trim();			
		}); 
		$( "td:nth-child(2)" ).css("color" , "blue");
		
		//============= �����������  Event  ó��(Click) =============		
		$( "td:nth-child(5)" ).on("click" , function() {
			 self.location ="/purchase/getPurchase?tranNo="+$(this).children("input").val()	
		}); 
		$( "td:nth-child(5)" ).css("color" , "green");	
		
		//============= ����ϱ�  Event  ó��(Click) =============		
		$( "td:nth-child(6)" ).on("click" , function() {
			if($($(this).children("input")[3]).val()==1){
			 self.location ="/purchase/updateTranCodeByProd?tranNo="
				 +$($(this).children("input")[0]).val()+"&tranCode="+$($(this).children("input")[1]).val()+"&currentPage="+$($(this).children("input")[2]).val()
			}
		}); 
		$( "td:nth-child(6):contains('����ϱ�')" ).css("color" , "red");	
		
		//============= "��󺸱�"  Event   ó�� =============
		$( "#shippingCondition" ).change(function(){
			fncGetList('1');
		});
		
		
		//============= ����������  Event  ó��(Click) =============	
		 $( "td:nth-child(7)" ).on("click" , function() {
					 var tranNo = $(this).children("input").val();
						$.ajax( 
								{
									url : "/purchase/json/getPurchase/"+tranNo ,
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
										var payOpt=null;
										if(JSONData.paymentOption==1){
											payOpt="���ݱ���";
										}else{
											payOpt="�ſ뱸��";
										}
										
										var displayValue = "<h6>"
																	+"��ǰ��ȣ : "+JSONData.purchaseProd.prodNo+"<br/>"
		 															+"�����ھ��̵� : "+JSONData.buyer.userId+"<br/>"
		 															+"���Ź�� : "+payOpt+"<br/>"
																	+"�������̸� : "+JSONData.receiverName+"<br/>"
																	+"�����ڿ���ó : "+JSONData.receiverPhone+"<br/>" 
																	+"�������ּ� : "+JSONData.divyAddr+"<br/>" 
																	+"���ſ�û���� : "+JSONData.divyRequest+"<br/>" 
																	+"�������� : "+JSONData.divyDate+"<br/>" 
																	+"�ֹ��� : "+JSONData.orderDate+"<br/>" 
																	+"</h6>";
										//Debug...									
										//alert(displayValue);
										$("h6").remove();
										$( "#"+tranNo+"" ).html(displayValue);
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
	
		<div class="page-header text-info">
				<h3>��� ��ǰ ����</h3>
	    </div>
	      
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	      
	    <div class="row">
	    
		    <div class="col-md-10 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		     <form class="form-inline" name="detailForm">
			 <input type="hidden" id="currentPage" name="currentPage" value=""/>

	    	<div class="col-md-2 text-right">
 				  <div class="form-group">
				    <select class="form-control" id="shippingCondition" name="shippingCondition" >
					<option value="9"  ${ ! empty search.shippingCondition && search.shippingCondition==9 ? "selected" : "" }>��κ���</option>
					<option value="1"  ${ ! empty search.shippingCondition && search.shippingCondition==1 ? "selected" : "" }>���ſϷ�</option>
					<option value="2"  ${ ! empty search.shippingCondition && search.shippingCondition==2 ? "selected" : "" }>�����</option>
					<option value="3"  ${ ! empty search.shippingCondition && search.shippingCondition==3 ? "selected" : "" }>��ۿϷ�</option>
					</select>   
				  </div>
			</div>	 
			</form> 
		</div>  	
	    
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >ȸ��ID</th>
            <th align="left">�������̸�</th>
            <th align="left">�����ڹ�ȣ</th>
			<th align="left">�����Ȳ</th>
            <th align="left">�������
			</th> 
			<th align="left">��������</th>         			
          </tr>
        </thead>
       
 		<tbody>				
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : ȸ������ Ȯ��">${purchase.buyer.userId} 		  
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>	
			  <td align="left">
			  	<input type="hidden" name="tranNo" value="${purchase.tranNo}" />
				<c:set var="code" value="${fn:substring(purchase.tranCode,0,1)}"/>
				
				<c:if test="${code eq '1' }">
					���� ���ſϷ� �����Դϴ�.
				</c:if>
				<c:if test="${code eq '2' }">
					���� ����� �����Դϴ�.
				</c:if>
				<c:if test="${code eq '3' }">
					���� ��ۿϷ� �����Դϴ�.
				</c:if>			  		  
			  </td>		
			  <td align="left">
		
				<input type="hidden" name="tranNo"  value="${purchase.tranNo}" />
				<input type="hidden" name="tranCode" value="${code+1}" />
				<input type="hidden" name="currentPage" value="${resultPage.currentPage}" />
				<input type="hidden" name="code" value="${code}" />
			
				<c:if test="${code eq '1' }">
					����ϱ�
				</c:if>	
				<c:if test="${code eq '2' }">
					�����
				</c:if>
				<c:if test="${code eq '3' }">
					��ۿϷ�
				</c:if>	
						
			</td>				  
			  
			  <td align="left">			  
				<input type="hidden" value="${purchase.tranNo }" />
			  	<i class="glyphicon glyphicon-ok" id= "${purchase.tranNo }"></i>
			  </td>
			</tr>
          </c:forEach>
        
        </tbody> 
      
      </table>
	  <!--  table End /////////////////////////////////////--> 
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>