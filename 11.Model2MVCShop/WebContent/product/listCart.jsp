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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
        .thumbnail{
        	width : 350px;
        	height : 550px;
        }
		.btn-delete{
		background: #fff;
        border:1px solid #b9babb;
		margin:3px;
		padding:3px;
        width : 100px;
		}    
		.btn-delete22{
		background: #fff;
        border:1px solid #b9babb;
		margin:3px;
		padding:3px;
        width : 100px;
		}   		
		.btn-wish{
		background: #fff;
        border:1px solid #b9babb;       
		margin:3px;
		padding:3px;
        width : 100px;
		} 		    
		.btn-buy{
		background: #38393A;
		border:  #fff;
		color:#fff;
		margin:3px;
		padding:3px;
        width : 100px;		
		}
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  

function fncGetList(currentPage) {

   	$("#currentPage").val(currentPage)
   	$("form").attr("method" , "POST").attr("action" , "/cart/listCart").submit();
 
}
	

$(function(){

		
		$( " td:nth-child(6):contains('ǰ��')" ).css("color" , "red");

		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		//============= "getProduct"  Event   ó�� =============
		$( "td:nth-child(4)" ).on("click",function(){
			self.location ="/product/getProduct?prodNo="+$(this).children("input").val()+"&menu=${param.menu}";
		});
  		//============= "��ư���� ����"  Event ó�� ��  ���� =============
		 $( ".btn-delete" ).on("click" , function() {
			//alert($(this).parent().parent().children("input").val())
			self.location ="/cart/deleteCart?cartNo="+$(this).parent().parent().children("input").val();
		 });		 
	
		//============= "üũ�ؼ� ����"  Event ó�� ��  ���� =============
		 $( ".btn-delete22" ).on("click" , function() {
			 var checkArray2 = [];
			 $("input[name=productCheck]:checked").each(function() { 
				 var check2 = $(this).val();
				 checkArray2.push(check2);
				
			 });
			   // alert(checkArray)
				 self.location ="/cart/deleteCart?cartNo="+checkArray2;
			 
		});
  		//============= "����"  Event ó�� ��  ���� =============
		 $( ".btn-buy" ).on("click" , function() { 
			 	var checkArray = [];
				$("input[name=productCheck]:checked").each(function() {
					
					var check = $(this).val();
					//alert(check)

					 checkArray.push(check);
					 //alert(checkArray)
				});
				if(checkArray ==""){
					alert("������ ��ǰ�� �����ϴ�.")
					return;
				}
				self.location="/purchase/addCartPurchase?cartNo="+checkArray
 
			});   
	  		//============= "üũ�ڽ� ��ü���� ��ü����"  Event ó�� ��  ���� ============= 		
				    $("#allCheck").click(function(){
				        //Ŭ���Ǿ�����
				        if($("#allCheck").not(":disabled").prop("checked")){
				            //input�±��� name�� chk�� �±׵��� ã�Ƽ� checked�ɼ��� true�� ����
				            $("input[name=productCheck]").not(":disabled").prop("checked",true);
				            //Ŭ���� �ȵ�������
				        }else{
				            //input�±��� name�� chk�� �±׵��� ã�Ƽ� checked�ɼ��� false�� ����
				            $("input[name=productCheck]").not(":disabled").prop("checked",false);
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
	
		<div class="page-header text-info">
				<h3>��ٱ��� �����ȸ</h3>
	    </div>
	      
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	      
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-5 text-right">
			    <form class="form-inline" name="detailForm">
			 <input type="hidden" id="currentPage" name="currentPage" value=""/>	 
				</form>
	    	</div>

		</div>  	
	    
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
          	<th align="right"><input type="checkbox" id="allCheck" ></th>
            <th align="left">No</th>
            <th align="left" >PRODUCT</th>
            <th align="left" >IMAGE</th>
            <th align="left">PRICE</th>
            <th align="left">STATE</th> 
			<th align="left">QTY</th>   
			<th align="center">CHOICE</th>        			
          </tr>
        </thead>
       
 		<tbody>				
		  <c:set var="i" value="0" />
		  <c:forEach var="cart" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>	
			  <td >
			  <c:if test="${cart.cartProd.count eq 0}">
			  <input type="checkbox" name="productCheck" value="${cart.cartNo}" disabled>		
			  </c:if>  
			  <c:if test="${!(cart.cartProd.count eq 0)}">
			  <input type="checkbox" name="productCheck" value="${cart.cartNo}" >		
			  </c:if>  			  
			  </td>
			  <td align="left">${ i }</td>
			  <td align="left"  title="Click : ��ǰ���� Ȯ��"><strong class="text-secondary">${cart.cartProd.prodName}</strong></td>	
			  <td align="left" >
			  <input type="hidden" name="prodNo" value="${cart.cartProd.prodNo}" />
			<c:if test="${ empty cart.cartProd.fileName }">
				 <img src="/images/uploadFiles/no_image.gif"/>						    
			</c:if>
			 <c:if test="${ !empty cart.cartProd.fileName}">						    
				<img src="/images/uploadFiles/${cart.cartProd.fileName}" width="150px;" height="150px;"/>
			 </c:if>
			  </td>			  	  
			  <td align="left">${cart.cartProd.price}</td>
			  <td align="left">
				<c:if test="${cart.cartProd.count eq 0 }">
						ǰ�� 
				</c:if>			
				<c:if test="${!(cart.cartProd.count eq 0) }">
						������� 
				</c:if>					
			</td>				  
			  
			  <td align="left"> ${cart.cartCount} </td>
			  <td align="left">
			  <input type="hidden" value="${cart.cartNo}" />
			  <div><button type="button" class="btn-wish">WHISLIST</button></div>			  
			  <div><button type="button" class="btn-delete">DELETE</button></div>
			  </td> 
			</tr>
          </c:forEach>
        
        </tbody> 
      
      </table>
	  <!--  table End /////////////////////////////////////--> 
	  
		<div class="row">
			 <div class="col-md-2 text-center">
	  			<button type="button" class="btn-delete22">DELETE</button>		
	  		</div> 		
	  		<div class="col-md-10 text-center">
	  			<button type="button" class="btn-buy">BUY NOW</button>
	  		</div> 		
	 	</div>
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>