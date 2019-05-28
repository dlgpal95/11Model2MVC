<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

			 
			 $( "button.btn.btn-primary" ).on("click" , function() {
				 
				 var password = $("input[name='password']").val();
				 var reviewNo = $("#reviewNo").text().trim();
				 
				 if(password == null || password.length <1){
						alert("��й�ȣ�� �ݵ�� �Է��ϼž� �մϴ�.");
						$("input[name='password']").focus();
						return;
				 }
				 //alert(reviewNo);
				 
				 $.ajax( 
							{
								url : "/review/json/PWCheckReview",
								method : "POST" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								data : JSON.stringify({
									reviewNo : reviewNo,
									password : password
								}),
								success : function(JSONData , status) {

									//Debug...
									//alert(status);
									//alert("JSONData : \n"+JSONData);
									//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
									//alert( JSONData != null );
									
									if(JSONData){
										alert("��й�ȣ�� �����ʽ��ϴ�.");
										//self.location="/review/updateReview?reviewNo=${review.reviewNo}"
									}else{
										self.location="/review/updateReview?reviewNo=${review.reviewNo}"
										//alert("���̵� , �н����带 Ȯ���Ͻð� �ٽ� �α���...");
									}
								}
						}); 	
				 
				 
				 
				 
				  // alert("${review.buyer.userId}")
					//self.location="/review/updateReview?reviewNo=${review.reviewNo}"
				});
			
			 
			 $( "btn btn-warning" ).on("click" , function() {
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
	       <h3 class=" text-info">�ı����ȸ</h3>
	       <h5 class="text-muted">�����Ͻ�  <strong class="text-danger">�ı��ǰ</strong>�� ��ȸ�Դϴ�.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�ı��ȣ</strong></div>
			<div class="col-xs-8 col-md-4" id="reviewNo">${review.reviewNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${review.reviewProd.prodNo }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ھ��̵�</strong></div>
			<div class="col-xs-8 col-md-4">${review.buyer.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ȣ��</strong></div>
			<div class="col-xs-8 col-md-4">
			<c:if test="${review.evaluation eq 1 }">
					�븸��
			</c:if>
			<c:if test="${review.evaluation eq 2}">
					����
			</c:if>
			<c:if test="${review.evaluation eq 3 }">
					����
			</c:if>
			<c:if test="${review.evaluation eq 4}">
					�Ҹ���
			</c:if>			
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�ı�����</strong></div>
			<div class="col-xs-8 col-md-4">${review.title}</div>
		</div>		
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�ı⳻��</strong></div>
			<div class="col-xs-8 col-md-4">${review.reviewText}</div>
		</div>
		
		<hr/>
		
		<c:if test="${review.fileName != null }">
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ı��̹���</strong></div>
			<div class="col-xs-8 col-md-4"><img src="/images/uploadFiles/${review.fileName}" width="400px;" height="400px;" /></div>
		</div>
		<hr/>
		</c:if>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��й�ȣ</strong></div>
			<div class="col-xs-8 col-md-4">
			 <input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ">
			</div>
		</div>

 		<hr/>
 			
		<div class="row">	
	  		<div class="col-md-10 text-center">
	  		 <h5 class="text-muted">�����ϽǷ���  <strong class="text-danger">��й�ȣ��</strong>�Է����ּ���.</h5>
	  			<button type="button" class="btn btn-primary">����</button>
	  			<button type="button" class="btn btn-warning">����</button>
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

