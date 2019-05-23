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
	
	<!--  ///////////////////////// �����ȣ CDN ////////////////////////// -->	
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
/* 	���� �ļո�  */
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= "����"  Event ���� =============
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		
		//============= "���"  Event ó�� ��  ���� =============
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	
	
		
		function fncAddUser() {
			
			var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
			
			
			if(id == null || id.length <1){
				alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(name == null || name.length <1){
				alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			if( pw != pw_confirm ) {				
				alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
				$("input:text[name='password2']").focus();
				return;
			}
				
			var value = "";	
			if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
				var value = $("option:selected").val() + "-" 
									+ $("input[name='phone2']").val() + "-" 
									+ $("input[name='phone3']").val();
			}
			$("input:hidden[name='phone']").val( value );
			
			var email = "";
			if( $("input:text[name='textEmail']").val() != ""  &&  $("select[name='selectEmail']").val() != ""){
				var email =  $("input:text[name='textEmail']").val()+"@"+$("select[name='selectEmail']").val();
			}
			$("input:hidden[name='email']").val( email );	
			
			$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		}
		

/* 		//==>"�̸���" ��ȿ��Check  Event ó�� �� ����
		 $(function() {
			 
			 $("input[name='email']").on("change" , function() {
				
				 var email=$("input[name='email']").val();
			    
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
			    	alert("�̸��� ������ �ƴմϴ�.");
			     }
			});
			 
		});	 */
		
		
	   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	   //==> �ֹι�ȣ ��ȿ�� check �� ����������....
		function checkSsn() {
			var ssn1, ssn2; 
			var nByear, nTyear; 
			var today; 
	
			ssn = document.detailForm.ssn.value;
			// ��ȿ�� �ֹι�ȣ ������ ��츸 ���� ��� ����, PortalJuminCheck �Լ��� CommonScript.js �� ���� �ֹι�ȣ üũ �Լ��� 
			if(!PortalJuminCheck(ssn)) {
				alert("�߸��� �ֹι�ȣ�Դϴ�.");
				return false;
			}
		}
	
		function PortalJuminCheck(fieldValue){
		    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
			var num = fieldValue;
		    if (!pattern.test(num)) return false; 
		    num = RegExp.$1 + RegExp.$2;
	
			var sum = 0;
			var last = num.charCodeAt(12) - 0x30;
			var bases = "234567892345";
			for (var i=0; i<12; i++) {
				if (isNaN(num.substring(i,i+1))) return false;
				sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
			}
			var mod = sum % 11;
			return ((11 - mod) % 10 == last) ? true : false;
		}
		 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		 
		//==>"ID�ߺ�Ȯ��" 
		 $(function() {
			 
			$("input[name='userId']").on('input' , function() {
				
				 var inputed = $("input[name='userId']").val();			
				//alert("�Է�  : "+inputed);
			 		   
		        $.ajax({
		        	url : "/user/json/checkDuplication",
		            method :  "POST" ,
		            dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
		        	data : JSON.stringify({
						userId : inputed,
					}),
					
		             success : function(JSONData) {
		         		//alert(JSONData); 
		         		//alert(typeof(JSONData));
				
		                if(JSONData && inputed!="" ) {
		                	$("#check").children("strong").remove();
							$("#check").append("<strong class=\"text-success\">��� �����մϴ�.</strong>");
		                } else {
		                	$("#check").children("strong").remove();
							$("#check").append("<strong  class=\"text-danger\">��� �Ұ����մϴ�.</strong>");
		                } 
		    			if(inputed=="" ){
		                	$("#check").children("strong").remove();
		    				$("#check").append("<strong class=\"text-muted\">���̵� �Է����ּ���.</strong>");    				
		    			}
		            } 
				});  
			});
			
		});
		
		/* �ּҷ� */
		 function sample6_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

		                // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
		                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
		                var addr = ''; // �ּ� ����
		                var extraAddr = ''; // �����׸� ����

		                //����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
		                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
		                    addr = data.roadAddress;
		                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
		                    addr = data.jibunAddress;
		                }

		                // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����׸��� �����Ѵ�.
		                if(data.userSelectedType === 'R'){
		                    // ���������� ���� ��� �߰��Ѵ�. (�������� ����)
		                    // �������� ��� ������ ���ڰ� "��/��/��"�� ������.
		                    if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // ���յ� �����׸��� �ش� �ʵ忡 �ִ´�.
		                    $("input[id='sample6_extraAddress']").val(extraAddr);
		                
		                } else {
		                	 $("input[id='sample6_extraAddress']").val('');
		                }
		               
		                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
		                $("input[id='sample6_postcode']").val( data.zonecode);
		                $("input[id='addr']").val(addr);
		                // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.		                
		                $("input[id='sample6_detailAddress']").focus();

		            }
		        }).open();
		    }
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
	
		<h1 class="bg-primary text-center">ȸ �� �� ��</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�� �� ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" placeholder="�� �� ��"  >
		       <span id="check" >
				<strong class="text-muted">���̵� �Է����ּ���.</strong>
		      </span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ Ȯ��</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="��й�ȣ Ȯ��">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="ȸ���̸�">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�ֹι�ȣ</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="ssn" name="ssn" placeholder="�ֹι�ȣ">
		      <span id="helpBlock" class="help-block">
		      	 <strong class="text-danger">" -  " ���� 13�ڸ��Է��ϼ���</strong>
		      </span>
		    </div>
		  </div>
		  
		  <div class="form-group">	
		  <label for="addr" class="col-sm-offset-1 col-sm-3 control-label">�ּ�</label>	
		   <div class="col-sm-2" >  
			<input type="text" class="form-control" id="sample6_postcode" placeholder="�����ȣ">
			</div>
			<input type="button" onclick="sample6_execDaumPostcode()" value="�����ȣ ã��"><br>
			</div>

		  <div class="form-group ">
		   <div class="col-sm-4"  >  
		   </div>		  				
		   <div class="col-sm-4"  >  
			<input type="text" class="form-control " id="addr" name="addr"  placeholder="�ּ�"><br>
			</div>
			</div>
			
		  <div class="form-group">		
		  <div class="col-sm-4"  >  
		   </div>						
			<div class="col-sm-4" >  
			<input type="text" class="form-control" id="sample6_detailAddress" placeholder="���ּ�">
			</div> <div class="col-sm-4" >  
			<input type="text" class="form-control" id="sample6_extraAddress" placeholder="�����׸�">
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�޴���ȭ��ȣ</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="phone1" id="phone1">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select>
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="��ȣ">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="��ȣ">
		    </div>
		    <input type="hidden" name="phone"  />
		  </div>
		  
		   <div class="form-group">
		    <label for="textEmail" class="col-sm-offset-1 col-sm-3 control-label">�̸���</label>	    	
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="textEmail" name="textEmail" placeholder="�̸���">
		    </div>
		    <div class="col-sm-1">
		      @
		    </div>
		    <div class="col-sm-2">		    
		    <select class="form-control" name="selectEmail" id="selectEmail"> 
		    <option value="1">�����Է�</option> 
		    <option value="naver.com" selected>naver.com</option> 
		    <option value="hanmail.net">hanmail.net</option> 
		    <option value="hotmail.com">hotmail.com</option> 
		    <option value="nate.com">nate.com</option>  
		    <option value="gmail.com">gmail.com </option> 
		    <option value="paran.com">paran.com</option> 
		    <option value="mvc.com">mvc.com</option> 
		    </select>
		    </div>
		     <input type="hidden" name="email"  />
		  </div>
		  
		  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
</body>

</html>