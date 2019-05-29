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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">


	$(function() {
		
			//============= Ȯ�� Event  ó�� =============	
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "button.btn.btn-primary" ).on("click" , function() {
					self.location = "/product/listProduct?menu=manage"
				});

				//============= ���� ��� Event  ó�� =============	
				$( "button.btn.btn-warning" ).on("click" , function() {
					self.location = "/purchase/listPurchase";
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
	
		<div class="page-header">
	       <h3 class=" text-info">�� ǰ �� ��</h3>
	       <h5 class="text-muted">��ǰ�� <strong class="text-danger">����</strong>�߽��ϴ�.</h5>
	    </div>
	    
  <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
             <th align="left" >��ǰ�̹���</th>
			<th align="left">��ǰ������</th>  
			<th align="left">���ż���</th>  
			<th align="left">�հ�</th>  
          </tr>
        </thead>
       
 		<tbody>		
 		
			<c:set var="i" value="0" />	  
		  <c:forEach var="purchase" items="${purchase2}">
	 	  <c:set var="i" value="${ i+1 }" />
			<tr>		
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : ��ǰ���� Ȯ��">${purchase.purchaseProd.prodName}		  
			  </td>
			  <td align="left">
					<c:if test="${ empty purchase.purchaseProd.fileName }">
						 <img src="/images/uploadFiles/no_image.gif" width="100px;" height="100px;"/>						    
					 </c:if>
					<c:if test="${ !empty purchase.purchaseProd.fileName}">						    
						      <img src="/images/uploadFiles/${purchase.purchaseProd.fileName}"  width="100px;" height="100px;"/>
					</c:if>			  
			  </td>			  
			  <td align="left">${purchase.purchaseProd.prodDetail}</td>		
							 	
			  <td align="left">${purchase.count}</td>	
			  <td align="left">${purchase.purchaseProd.price * purchase.count } won</td>	  
			</tr>
			  </c:forEach>	  
			
<!--  	  <c:set var="i" value="0" />	  
		  <c:set var="doneLoop" value="false"/> 
		   <c:set var="num" value="0"/>
		  
		  <c:forEach var="product" items="${list}">
	 	  <c:set var="i" value="${ i+1 }" />
		   
		  <c:set var="doneLoop" value="false"/>
			 <c:forEach var="purchase" items="${purchase2}" begin="${num }" >
		  	<c:if test="${not doneLoop}"> 
			<tr>		
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : ��ǰ���� Ȯ��">${purchase.purchaseProd.prodName}		  
			  </td>
			  <td align="left">
					<c:if test="${ empty product.fileName }">
						 <img src="/images/uploadFiles/no_image.gif" width="100px;" height="100px;"/>						    
					 </c:if>
					<c:if test="${ !empty product.fileName}">						    
						      <img src="/images/uploadFiles/${product.fileName}"  width="100px;" height="100px;"/>
					</c:if>			  
			  </td>			  
			  <td align="left">${product.prodDetail}</td>		
							 	
			  <td align="left">${purchase.count}</td>	
			  <td align="left">${purchase.purchaseProd.price * purchase.count } won</td>	
			  <c:set var="doneLoop" value="true"/> 
		   <c:set var="num" value="${num+1 }"/>			  
			</tr>
			</c:if>
			  </c:forEach>	  
			
          </c:forEach>
 -->	       
        </tbody> 
      
      </table>
	  <!--  table End /////////////////////////////////////--> 
 	<hr/>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�����ھ��̵�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���Ź��</strong></div>
			<div class="col-xs-8 col-md-4">
			<c:set var="code" value="${fn:substring(purchase.paymentOption,0,1)}"/>
			
			<c:if test="${code eq 1 }">
					���ݱ���
			</c:if>
			<c:if test="${code eq 2 }">
					�ſ뱸��
			</c:if>			
			
			</div>
		</div>
			
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������̸�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ڿ���ó</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�������ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ſ�û����</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
		</div>
		
		<hr/>		
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����������</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
		</div>
				
		<hr/>

		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >Ȯ&nbsp;��</button>
		      <button type="button" class="btn btn-warning"  >���� ��� ����</button>
		    </div>
		  </div>
		
		<br/>
		<br/>
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>