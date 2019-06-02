<%@ page contentType="text/html; charset=EUC-KR"%>

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
       body > div.container{
/* 	���� �ļո�  */
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    <!--  ///////////////////////// JavaScript ////////////////////////// --> 
<script type="text/javascript" >

function fncAddQa(){
	//Form ��ȿ�� ����

	var qaText = $("textarea[name='qaText']").val();
	var password = $("input[name='password']").val();
    var pwCheck = $('input[name="pwCheck"]:checked').val();
	
	if(qaText == null || qaText.length<1){
		alert("���ǳ����� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
        
   if(pwCheck == 2){
    		if(password == null || password.length<1){
    			alert("��й�ȣ�� �ݵ�� �Է��Ͽ��� �մϴ�.");
    			return;
    		}
    }


	$('form').attr("method","POST").attr("action","/qa/addQa").attr("enctype","multipart/form-data").submit();

}

	$( function(){
		//============= "���"  Event ó�� ��  ���� =============
		$("a[href='#' ]").on('click', function() {
			$('form')[0].reset();
		});
		
		//============= "���"  Event ���� =============
		$('button.btn.btn-primary').on('click', function(){
			fncAddQa();
		});
			
		
	});
	
	</script>
	</head>

	<body>

		<!-- ToolBar Start /////////////////////////////////////-->
		<div class="navbar  navbar-default">
		<jsp:include page="/layout/toolbar.jsp" />
		</div>
	   	<!-- ToolBar End /////////////////////////////////////-->

		<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
		<div class="container">
		
			<div class="page-header">	
			<h1 class="bg-primary text-center">�� ǰ �� ��  �� ��</h1>
		    </div>		
			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
			
			  <div class="form-group">
			    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">�� ǰ �� ȣ</label>
			    <div class="col-sm-4">
			    <input type="hidden" name="prodNo" value="${qa.qaProd.prodNo }" />
			    ${qa.qaProd.prodNo }
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
			    <div class="col-sm-4">
			    ${qa.buyer.userId }
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="evaluation" class="col-sm-offset-1 col-sm-3 control-label">����</label>
			    <div class="col-sm-4">
					<select name="title" >
					<option value="��ǰ/�������" selected>��ǰ/�������</option>
					<option value="�ڵ���" >�ڵ���</option>
					<option value="��۹���" >��۹���</option>
					<option value="�������ȯ/��ǰ����" >�������ȯ/��ǰ����</option>
					<option value="����ı�ȯ/��ǰ����" >����ı�ȯ/��ǰ����</option>
					<option value="�Ա�Ȯ��/��Ȯ���Ա���" >�Ա�Ȯ��/��Ȯ���Ա���</option>
					<option value="��Ÿ����" >��Ÿ����</option>					
					</select>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="qaText" class="col-sm-offset-1 col-sm-3 control-label">���ǳ���</label>
			    <div class="col-sm-6">
			      <textarea name="qaText" class="form-control" rows="5" ></textarea>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">÷������</label>
			    <div class="col-sm-4">
			      <input type="file" class="form-control" id="uploadFile" name="uploadFile" >
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="pwcheck" class="col-sm-offset-1 col-sm-3 control-label">��бۼ���</label>
			    <div class="col-sm-2">
				<input type="radio" name="pwCheck" value="1" checked>������
				<input type="radio" name="pwCheck" value="2">�������
			    </div>
			  </div>			  
			  
			  <div class="form-group">
			    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ</label>
			    <div class="col-sm-2">
			      <input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ">
			    </div>
			  </div>
			  		  
			  <div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary"  >��&nbsp;��</button>
				  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
			    </div>
			  </div>
			</form>
			<!-- form Start /////////////////////////////////////-->
			
	 	</div>
		<!--  ȭ�鱸�� div end /////////////////////////////////////-->
			
	</body>

	</html>
