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
   	<!--  ///////////////////////// �����ȣ CDN ////////////////////////// -->	
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
   	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	function fncAddPurchase() {
		/* document.addPurchase.submit(); */
		
		var divyDate = $("input[name='divyDate']").val();
		
		if(divyDate==null || divyDate.length <1){
			alert("��������¥�� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		$("form").attr("method","POST").attr("action","/purchase/addCartPurchase").submit();
	}
	
	$(function(){	
		
	    $("#allCheck").click(function(){
	        //Ŭ���Ǿ�����
	        if($("#allCheck").prop("checked")){
	            //input�±��� name�� chk�� �±׵��� ã�Ƽ� checked�ɼ��� true�� ����
	            $("input[name=productCheck]").prop("checked",true);
	            //Ŭ���� �ȵ�������
	        }else{
	            //input�±��� name�� chk�� �±׵��� ã�Ƽ� checked�ɼ��� false�� ����
	            $("input[name=productCheck]").prop("checked",false);
	        }
	    });
	    
	});
	
	$(function() {
		//============= "����"  Event ó�� ��  ���� =============
		$( "button.btn.btn-primary"  ).on("click" , function() {
			fncAddPurchase();
		});
		//============= "���"  Event ó�� ��  ���� =============
		$("button.btn.btn-warning").on("click",function(){
			history.go(-1);
		});
	});
	
	$( function() {
		   
	    $( "#divyDate" ).datepicker( { dateFormat: 'yy-mm-dd' });
	 
	} );
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
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	 	<form class="form-horizontal">
	<div class="container">
	
		<div class="page-header text-info">
				<h3>��ǰ ����</h3> 
	    </div>
	      
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left" >��ǰ�̹���</th>
			<th align="left">��ǰ������</th>   	
			<th align="left" >��ǰ ����</th>   		
            <th align="left">�հ�</th>
          </tr>
        </thead>
       
 		<tbody>				
		  <c:set var="i" value="0" />
		  <c:forEach var="cart" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			   <input type="hidden" name="cartNo" value="${cart.cartNo}" />	
			<tr>		
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : ��ǰ���� Ȯ��">${cart.cartProd.prodName}		  
			  </td>
			  <td align="left">
					<c:if test="${ empty cart.cartProd.fileName }">
						 <img src="/images/uploadFiles/no_image.gif" width="100px;" height="100px;"/>						    
					 </c:if>
					<c:if test="${ !(empty cart.cartProd.fileName)}">						    
						      <img src="/images/uploadFiles/${cart.cartProd.fileName}"  width="100px;" height="100px;"/>
					</c:if>			  
			  </td>			  
			  <td align="left">${cart.cartProd. prodDetail}</td>		
			  <td align="left">${cart.cartCount }</td>					 		  
			  <td align="left">${cart.cartProd.price * cart.cartCount } won</td> 
			  
			</tr>
           </c:forEach>       
        </tbody> 
      
      </table>
	  <!--  table End /////////////////////////////////////--> 
 	<hr/>
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
  <div class="form-group">

  <input type="hidden" name="prodNo" value="${prodNo }" />
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
		    <div class="col-sm-4">
	   		 ${purchase.buyer.userId}
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		   
		    <div class="col-sm-2">   
			<div class="form-group">	    
			<select class="form-control" name="paymentOption">						
			<option value="1" selected >���ݱ���</option>
			<option value="2" >�ſ뱸��</option>
			</select>
			</div>		
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    <div class="col-sm-4">
		     <input type="text" class="form-control" value="${purchase.buyer.userName}" id="receiverName" name="receiverName" placeholder="�������̸�">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control"  value="${purchase.buyer.phone}" id="receiverPhone" name="receiverPhone" placeholder="�����ڿ���ó">
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
			<input type="text" class="form-control " id="addr" name="addr" value="${purchase.buyer.addr }" placeholder="�ּ�"><br>
			</div>
			</div>
			
		  <div class="form-group">		
		  <div class="col-sm-4"  >  
		   </div>						
			<div class="col-sm-2" >  
			<input type="text" class="form-control" id="sample6_detailAddress" placeholder="���ּ�">
			</div> <div class="col-sm-2" >  
			<input type="text" class="form-control" id="sample6_extraAddress" placeholder="�����׸�">
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="���ſ�û����">
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="����������">
		    </div>
		  </div>		  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
				<button type="button" class="btn btn-primary">����</button>
	  			<button type="button" class="btn btn-warning">���</button>
		    </div>
		  </div>
		</form>	
 	<br/><br/>
	
</body>

</html>