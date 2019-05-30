<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


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
	
	<!--  /////////////////////////īī���α���////////////////// -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
		        
		.pink {
		  background-color: #F9A0A0;
		  color: #fff;
		}
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= "�α���"  Event ���� =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID �� �Է����� �����̽��ϴ�.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('�н����带 �Է����� �����̽��ϴ�.');
					$("#password").focus();
					return;
				}
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});	
		
		
		//============= ȸ��������ȭ���̵� =============
		$( function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
	</script>		
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">��Hyemi Shop��</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
					<img src="/images/uploadFiles/1111.gif" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">LOGIN</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">ID</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="���̵�" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">PASSWORD</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="�н�����" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button"  class="pink" >�� &nbsp;�� &nbsp;��</button>
					      <button type="button" class="pink">ȸ &nbsp;�� &nbsp;�� &nbsp;��</button>
					    <a id="kakao-login-btn"></a>
						<a href="http://developers.kakao.com/logout"></a>
						    <script type='text/javascript'>
						        //<![CDATA[
						        // ����� ���� JavaScript Ű�� ������ �ּ���.
						        Kakao.init('25d322a4d604775797962e898c93dcb8');
						        // īī�� �α��� ��ư�� �����մϴ�.
								 Kakao.Auth.createLoginButton({								
								   container: '#kakao-login-btn',								
								   success: function(authObj) {								
								     Kakao.API.request({								
								       url: '/v1/user/me',							
								       success: function(res) {							
								    	   alert(res.properties['nickname']+"�� ȯ���մϴ� ^^.\n(��� ���������� user01�� �α������ּ���~~)")
/* 								             alert(JSON.stringify(res)); //<---- kakao.api.request ���� �ҷ��� ����� json���·� ���
								             alert(JSON.stringify(authObj)); //<----Kakao.Auth.createLoginButton���� �ҷ��� ����� json���·� ���
								             console.log(res.id);//<---- �ܼ� �α׿� id ���� ���(id�� res�ȿ� �ֱ� ������  res.id �� �ҷ��´�)								
								             console.log(res.kaccount_email);//<---- �ܼ� �α׿� email ���� ��� (������� �˰���?)					
								             console.log(res.properties['nickname']);//<---- �ܼ� �α׿� �г��� ���(properties�� �ִ� nickname ���� 								
								         // res.properties.nickname���ε� ���� ���� )								
								             console.log(authObj.access_token);//<---- �ܼ� �α׿� ��ū�� ��� */
								    	     location.href="/index.jsp";
								           }
								
								         })
								
								       },
								
								       fail: function(error) {
								
								         alert(JSON.stringify(error));
								
								       }
								
								     });
								
								//]]>
						        
/* 								 var request = JSON.stringify(res.kaccount_email);

								 $(function(){

								   $('#tocken').val(request);

								   var value = $('input[name=tocken]').val();

								    console.log(value);

								   });



								     <input type="hidden" id="tocken" name="tocken" value="0"> */


						    </script>
			  			  </div>
					  </div>
			
					</form>
			   	 </div>
			
			</div>
			
  	 	</div>
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>

</html>