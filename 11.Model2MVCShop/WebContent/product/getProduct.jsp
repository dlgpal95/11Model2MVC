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
 	    .left-box {
		  float: left;
		  width: 50%;
		}
		.right-box {
		  float: right;
		  width: 50%;
		}
		#btn-buy{
		background: #38393A;
		border:  #fff;
		color:#fff;
		height:50px;
		width:500px;
		}
		#btn-cart{
		background: #fff;
        border:2px solid #38393A;
		color:#000;
		height:50px;
		width:250px;
		}
		#btn-wish{
		background: #fff;
        border:2px solid #38393A;
		color:#000;
		height:50px;
		width:250px;
		}		
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	 $(function() {

		 
			 $( "td.ct_btn01:contains('�ı⺸��')" ).on("click" , function() {
				self.location="/review/listReview?prod_no=${product.prodNo}"
			});

			//============= "����"  Event ó�� ��  ���� =============
			 $( "#btn-buy" ).on("click" , function() {
				 var count = ${product.count};
				 if(count==0){
					 alert("��� ���� �����Ҽ� �����ϴ�.")
					 return;
				 }else{
					// alert($(".spinner").val());
					self.location="/purchase/addPurchase?prod_no=${product.prodNo}&prodCount="+$(".spinner").val()
				 } 

				});
			//============= "��ٱ���"  Event ó�� ��  ���� =============
			 $( "#btn-cart" ).on("click" , function() {
				 alert("��ٱ��Ͽ� �����ϴ�. (��ٱ����ڳʿ��� Ȯ��!)")
				 self.location="/cart/addCart?prod_no=${product.prodNo}"
			});
			
		});
	
	 $(function() {
		 
 		if(${product.count}==0){
		 $( ".spinner" ).spinner({ //���ǳʸ� ������ش�.
			 min: 0,//���ǳʷ� ���� �� �ִ� �ּ� ��
			 max: ${product.count} ,  //���ǳʷ� �ø� �� �ִ� �ִ� ��
			 step: 1  //�ѹ� Ŭ���� �����Ǵ� ��
		 });
		}else{
			 $( ".spinner" ).spinner({ //���ǳʸ� ������ش�.
				 min: 1,//���ǳʷ� ���� �� �ִ� �ּ� ��
				 max: ${product.count} ,  //���ǳʷ� �ø� �� �ִ� �ִ� ��
				 step: 1  //�ѹ� Ŭ���� �����Ǵ� ��
			 });			
		} 
		 
		 $(".spinner").spinner({
			    stop: function (event, ui) {
			    	//alert(parseInt($(this).val()))
			    	//alert(${product.count})
			    	if(${product.count} <= parseInt($(this).val())){
			    		alert(${product.count}+"�� �̻� �����Ҽ� �����ϴ�.(������)")
			    		return;
			    	}
			    	$('#prodCount').html(parseInt($(this).val())*${product.price}+" won");
			    }
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
	
		<div class="page-header" >
	       <h3 class=" text-info">��ǰ����ȸ</h3>
	       <h5 class="text-muted">�����Ͻ�  <strong class="text-danger">��ǰ</strong>�� ��ȸ�Դϴ�.</h5>
	    </div>
	
		<div class="left-box">
			<div class="col-xs-8 col-md-4"><img
					src="/images/uploadFiles/${product.fileName}" width="500px;" height="500px;" /></div>
		</div>
		
		<div class="right-box">
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${ product.prodName}</div>
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
			<div class="col-xs-8 col-md-4">${product.price} won</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
			<div class="col-xs-8 col-md-4"><input class="spinner" name="count" value="${product.count eq 0 ? 0 : 1}"></div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><p>TOTAL</p></div>
			<div class="col-xs-8 col-md-4"><span id="prodCount">${product.price} won</span></div>
		</div>
		
		<hr/>				
		<div class="row">
	  			<button type="button" id="btn-buy">BUY IT NOW</button>
		</div>		
		
		<br/>
				
		<div class="row">
	  			<button type="button" id="btn-cart">ADD TO CART</button>
	  			<button type="button" id="btn-wish">WISH LIST</button>
		</div>		
		<hr/>
		
		</div>
		
		<br/>
		
 	</div>
 	
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
 	
 	<div>
    <jsp:include page="/review/listReview?prod_no=${product.prodNo}" />
	</div>


 	<div>
    <jsp:include page="/qa/listQa?prod_no=${product.prodNo}" />
	</div>
</body>

</html>



