<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

		 
			 $( "td.ct_btn01:contains('�ı⺸��')" ).on("click" , function() {
				self.location="/review/listReview?prod_no=${product.prodNo}"
			});
			//============= "����"  Event ó�� ��  ���� =============
			 $( "button.btn.btn-success" ).on("click" , function() {
					history.go(-1);
				});
			//============= "����"  Event ó�� ��  ���� =============
			 $( "button.btn.btn-primary" ).on("click" , function() {
				 var count = ${product.count};
				 if(count==0){
					 alert("��� ���� �����Ҽ� �����ϴ�.")
					 return;
				 }else{
					self.location="/purchase/addPurchase?prod_no=${product.prodNo}"
				 } 

				});
			//============= "��ٱ���"  Event ó�� ��  ���� =============
			 $( "button.btn.btn-warning" ).on("click" , function() {
				 alert("��ٱ��Ͽ� �����ϴ�. (��ٱ����ڳʿ��� Ȯ��!)")
				 self.location="/cart/addCart?prod_no=${product.prodNo}"
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
	       <h3 class=" text-info">��ǰ����ȸ</h3>
	       <h5 class="text-muted">�����Ͻ�  <strong class="text-danger">��ǰ</strong>�� ��ȸ�Դϴ�.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${ product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${ product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-4"><img
					src="/images/uploadFiles/${product.fileName}" width="300px;" height="300px;" /></div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<hr/>

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���</strong></div>
			<div class="col-xs-8 col-md-4">${product.count}</div>
		</div>

		<hr/>
			
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>	
			
		<hr/>
	 	
		<div class="row">
			 <div class="col-md-2 text-center">
	  			<button type="button" class="btn btn-success">PREVIOUS</button>		
	  		</div> 		
	  		<div class="col-md-10 text-center">
	  			<button type="button" class="btn btn-primary">BUY NOW</button>
	  			<button type="button" class="btn btn-warning">ADD TO CART</button>
	  		</div> 		
	 	</div>
		
		<br/>
		
 	</div>
 	
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
 	
 	<div>
    <jsp:include page="/review/listReview?prod_no=${product.prodNo}" />
	</div>

</body>

</html>



