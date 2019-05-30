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

			//============= "����"  Event ó�� ��  ���� =============			 
			 $( "button.btn.btn-primary" ).on("click" , function() {
				 
				var tranCode = ${purchase.tranCode};
				if(tranCode ==1){
					self.location="/purchase/updatePurchase?tranNo=${purchase.tranNo}";
				}else if(tranCode ==2){
					alert("�̹� ������̶� ������ �Ұ��մϴ�. \n 010-8410-0099�� ���� �ٶ��ϴ�.")
				}else {
					alert("�̹� ��ۿϷ�� ��ǰ�̶� ������ �Ұ��մϴ�.")
				}
				});
			
			//============= "Ȯ��"  Event ó�� ��  ���� =============			 
			 $("button.btn.btn-warning"  ).on("click" , function() {
				 history.go(-1);
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
	       <h3 class=" text-info">���Ż���ȸ</h3>
	       <h5 class="text-muted">�����Ͻ�  <strong class="text-danger">��ǰ</strong>�� ��ȸ�Դϴ�.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-4"> <img src="/images/uploadFiles/${purchase.purchaseProd.fileName}" width="130px;" height="130px;"/></div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>���ż���</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.count}��</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�����հ�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.price * purchase.count}��</div>
		</div>
		
		<hr/>		

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ھ��̵�</strong></div>
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
	  		<div class="col-xs-4 col-md-2"><strong>�����ڿ���ó</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
		</div>
		
		<hr/>

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ſ�û����</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
		</div>

		<hr/>
			
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
		</div>	
			
		<hr/>

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ֹ���</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
		</div>	
		
		
	 	
		<div class="row">	
	  		<div class="col-md-10 text-center">
	  			<button type="button" class="btn btn-primary">����</button>
	  			<button type="button" class="btn btn-warning">Ȯ��</button>
	  		</div> 		
	 	</div>
	 	
	 	<br/><br/>			
		<br/>
		
 	</div>
 	
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
 	
 	<div>
    <jsp:include page="/review/listReview?prod_no=${product.prodNo}" />
	</div>

</body>

</html>

