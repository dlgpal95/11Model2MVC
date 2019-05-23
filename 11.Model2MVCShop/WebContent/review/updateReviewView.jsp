<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- ////////////////////�޷� /////////////////////////////-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
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
	<script type="text/javascript" >
	
	function fncUpdatePurchase() {

		$("form").attr("method","POST").attr("action","/review/updateReview?reviewNo=${review.reviewNo}").attr("enctype","multipart/form-data").submit();
	}
	
	 $(function() {
			//============= ���� Event  ó�� =============	
		 $( "button.btn.btn-primary"  ).on("click" , function() {
			 fncUpdatePurchase();
			});
			//============= ��� Event  ó�� =============		 
		 $( "button.btn.btn-warning" ).on("click" , function() {
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
			
				<div class="page-header text-center">
			       <h3 class=" text-info">�ı���������</h3>
			       <h5 class="text-muted">��ǰ �ı� ������ <strong class="text-danger"> ����</strong>�� �ּ���.</h5>
			    </div>
			    
			    <!-- form Start /////////////////////////////////////-->
				<form class="form-horizontal">
				
				  <div class="form-group">
				    <label for="reviewNo" class="col-sm-offset-1 col-sm-3 control-label">���Ź�ȣ</label>
				    <div class="col-sm-4">
				     ${review.reviewNo}
				    </div>
				  </div>
				
				  <div class="form-group">
				    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
				    <div class="col-sm-4">
				     ${review.reviewProd.prodNo }
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
				    <div class="col-sm-4">
					${review.buyer.userId }				      
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="title" class="col-sm-offset-1 col-sm-3 control-label">����</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" id="title" name="title" value="${review.title }" placeholder="����">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="evaluation" class="col-sm-offset-1 col-sm-3 control-label">��ȣ��</label>
				    <div class="col-sm-4">
					 <select name="evaluation"  class="form-control">
					<option value="1" ${ review.evaluation eq 1 ? "selected" : "" } >�븸��</option>
					<option value="2" ${ review.evaluation eq 2 ? "selected" : "" }>����</option>
					<option value="3" ${ review.evaluation eq 3 ? "selected" : "" }>����</option>
					<option value="4" ${ review.evaluation eq 4 ? "selected" : "" }>�Ҹ���</option>
					</select>
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label for="reviewText" class="col-sm-offset-1 col-sm-3 control-label">�ı⳻��</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" id="reviewText" name="reviewText"  value="${review.reviewText }" placeholder="�ı⳻��">
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">�ı��̹���</label>
				    <div class="col-sm-4">
				     <input type="file" class="form-control" id="uploadFile" name="uploadFile" >
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="col-sm-offset-4  col-sm-4 text-center">
			  			<button type="button" class="btn btn-primary">����</button>
			  			<button type="button" class="btn btn-warning">���</button>
				    </div>
				  </div>

				</form>
				<!-- form Start /////////////////////////////////////-->
			    
		 	</div>
			<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
		 	
		</body>

		</html>