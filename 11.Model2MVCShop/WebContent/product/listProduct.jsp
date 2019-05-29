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
	.thumbnail-wrappper { width: 25%; } 
	.thumbnail { position: relative; padding-top: 100%; /* 1:1 ratio */ overflow: hidden; } 
	.thumbnail .centered { position: absolute; top: 0; left: 0; right: 0; bottom: 0; -webkit-transform: translate(50%,50%); -ms-transform: translate(50%,50%); transform: translate(50%,50%); } 
	.thumbnail .centered img { position: absolute; top: 0; left: 0; max-width: 100%; height: auto; -webkit-transform: translate(-50%,-50%); -ms-transform: translate(-50%,-50%); transform: translate(-50%,-50%); }
	
	.soldout{
		background-color: #ca273c;
		color:white;
		margin: 8px;
	}
	.good{
	    background-color: #9a9192;;
		color:white;
		margin: 8px;	    
	}


    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============
	function fncGetList(currentPage) {
	   	
	   	$("#currentPage").val(currentPage)
	   	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu }").submit();
	 
	}
		
	function fncGetList2(currentPage,priceSort) {
	   	
	   	$("#currentPage").val(currentPage)
	    $("#priceSort").val(priceSort) 
	   	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu }").submit();
	}
	
	$(function(){
	
			//============= "�˻�"  Event  ó�� =============	
			 $( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
			
			//============= "��������"  Event  ó�� =============	
			 $( 'i[class="glyphicon glyphicon-arrow-up"]' ).on("click" , function() {
				 fncGetList2('1','high');
			});
			 $( 'i[class="glyphicon glyphicon-arrow-down"]' ).on("click" , function() {
				 fncGetList2('1','low');
			});
			 
			//============= color  ó�� =============
			$( ".state:contains('ǰ��')" ).css("color" , "red");
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");			
			$( "td:nth-child(2)" ).css("color" , "blue");
			
			//============= "ǰ������"  Event   ó�� =============
			$( "#shippingCondition" ).change(function(){
				fncGetList('1');
			});
			 
			//============= "getProduct"  Event   ó�� =============
			$( ".thumbnail" ).on("click",function(){
				self.location ="/product/getProduct?prodNo="+$(this).children("input").val()+"&menu=${param.menu}";
			});
		
			//============= ����������  Event  ó�� (Click)=============
			 $(  'i[class="glyphicon glyphicon-ok"]' ).on("click" , function() {
				 var prodNo = $(this).children("input").val();
					$.ajax( 
							{
								url : "/product/json/getProduct/"+prodNo ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {
	
									//Debug...
									//alert(status);
									//Debug...
									//alert("JSONData : \n"+JSONData);
									
									var displayValue = "<h6>"
																+"��ǰ��ȣ : "+JSONData.prodNo+"<br/>"
	 															+"��ǰ�� : "+JSONData.prodName+"<br/>"
																+"�̹��� : <img src=/images/uploadFiles/"+JSONData.fileName+" id=\"imgclick\" /> <br/>"
																+"��ǰ������ : "+JSONData.prodDetail+"<br/>"
																+"�������� : "+JSONData.manuDate+"<br/>" 
																+"���� : "+JSONData.price+"<br/>" 
																+"��� : "+JSONData.count+"<br/>" 
																+"������� : "+JSONData.regDate+"<br/>" 
																+"</h6>";
									//Debug...									
									//alert(displayValue);
									$("h6").remove();
									$( "#"+prodNo+"" ).html(displayValue);
								}
						});
			
			}); 
		 
				$("input[name='searchKeyword']").on('input' , function() {
					//alert("zz");
					
					
				});
				
				var availableTags = [
				      "admin",
				      "jinhee",
				      "Asp",
				      "BASIC",
				      "C",
				      "C++",
				      "Clojure",
				      "COBOL",
				      "ColdFusion",
				      "Erlang",
				      "Fortran",
				      "Groovy",
				      "Haskell",
				      "Java",
				      "JavaScript",
				      "Lisp",
				      "Perl",
				      "PHP",
				      "Python",
				      "Ruby",
				      "Scala",
				      "Scheme"
				    ];
				
			    $("input[name='searchKeyword']").autocomplete({
			        source: availableTags
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
				<c:if test = "${param.menu eq 'manage'}">			
					<h3>��ǰ����</h3>
				</c:if>
				<c:if test = "${param.menu eq 'search'}">
					<h3>��ǰ ��� ����</h3>
				</c:if>	
	    </div>
	      
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	      
	    <div class="row">
	    
		    <div class="col-md-3 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-2 text-left">
		    		<i class ="glyphicon glyphicon-arrow-up">���ݳ�����</i>
		    </div>	
		    
		    <div class="col-md-2 text-left">
		    		<i class ="glyphicon glyphicon-arrow-down">���ݳ�����</i>
		    </div>	 
			 	    
		    <div class="col-md-5 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
					<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
					<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
					<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
		   		  <input type="hidden" id="priceSort" name="priceSort"  value=${ ! empty search.priceSort ? search.priceSort : "" } />
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				 
				 <hr/>
				  <div class="form-group">
				    <select class="form-control" id="shippingCondition" name="shippingCondition" >
							<option value="9"  ${ ! empty search.shippingCondition && search.shippingCondition==9 ? "selected" : "" }>��κ���</option>
							<option value="0"  ${ ! empty search.shippingCondition && search.shippingCondition==0 ? "selected" : "" }>�Ǹ���</option>
							<option value="8"  ${ ! empty search.shippingCondition && search.shippingCondition==8 ? "selected" : "" }>ǰ��</option>
					</select>   
				  </div>
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
 	
	<hr/>
	
				<div class="row">
				 	 <c:set var="i" value="0" />
				 	 <c:forEach var="product" items="${list}">
						  <div class="col-sm-4 col-md-3 text-center" >
							<c:set var="i" value="${ i+1 }" />	
							<br/>				
						    <a href="#" class="thumbnail" >

						    <input type="hidden" value="${product.prodNo }" />
						    <c:if test="${ empty product.fileName }">
						    <div class="centered">
						      <img src="/images/uploadFiles/no_image.gif" />						    
						     </div>
						    </c:if>
						    <c:if test="${ !empty product.fileName}">	
						     <div class="centered">					    
						      <img src="/images/uploadFiles/${product.fileName}" />
						      </div>
						     </c:if>
							</a>
						        <strong>${product.prodName}</strong>
						        <br/>
						        <p class="text-muted">${product.prodDetail}</p>
						        <strong >${product.price} won</strong>
						         <br/>
						         
							<c:set var="code" value="${fn:substring(product.proTranCode,0,1)}"/>
							<div class="col-sm-4 " >
							</div>
 							<div class="col-sm-4 " >
								<c:if test = "${product.count eq 0}">
									<p class="soldout" >ǰ��</p>
								</c:if>	
								<c:if test = "${!(product.count eq 0)}">
									<p class="good" >��õ</p>
								</c:if>
							<c:if test = "${param.menu eq 'manage'}">	
							<p>��� : ${product.count }</p>
							</c:if>									
							</div>				
					</div>
					
			 		</c:forEach>         	
					</div>	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>