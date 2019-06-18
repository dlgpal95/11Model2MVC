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
    
       #start { border:3px solid #0066cc; }

    </style>
    <!--  ///////////////////////// JavaScript ////////////////////////// --> 
<script type="text/javascript" >

function fncAddProduct(){
	//Form ��ȿ�� ����

	var name = $('input[name="prodName"]').val();
	var detail = $('input[name="prodDetail"]').val();
	var manuDate = $('input[name="manuDate"]').val();
	var price = $('input[name="price"]').val();
	var count = $('input[name="quantity"]').val();
	

	if(name == null || name.length<1){
		alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(price == null || price.length<1){
		alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(count == "" ) {
		alert("��ǰ������ �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}

	$('form').attr("method","POST").attr("action","/product/addProduct").attr("enctype","multipart/form-data").submit();

}

		function fnAddFile(fileNameArray) {
		   	$("#multiFile").val(fileNameArray)
		 
		}
		//============= "���"  Event ���� =============
			$(function() {
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "button.btn.btn-primary" ).on("click" , function() {
					fncAddProduct();
				});
			});	

		//============= "���"  Event ó�� ��  ���� =============
		$( function(){
			$("a[href='#' ]").on('click', function() {
				$('form')[0].reset();
			});
		
			
		
	});
	
		//============= "�޷�(��������)"  Event ó�� ��  ���� =============
		$( function() {
		   
		      $( "#manuDate" ).datepicker( { dateFormat: 'yy-mm-dd' });
		   
		  } );
		
		//============= "�������Ͼ��ε�"  Event ó�� ��  ���� =============		

		    //������ file object����
	        var files = {};
	        var previewIndex = 0;
	        var fileNameArray = new Array();
	 
	        // image preview ��� ����
	        // input = file object[]
	        function addPreview(input) {
	            if (input[0].files) {
	                //���� ������ ���������� ���� ����
	                for (var fileIndex = 0; fileIndex < input[0].files.length; fileIndex++) {
	                    var file = input[0].files[fileIndex];
	 
	                    if (validation(file.name))
	                        continue;

	        	        var fileName = file.name + "";   
	        	        var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
	        	        var fileNameExtension = fileName.toLowerCase().substring(fileNameExtensionIndex, fileName.length);       
	        	        
	 					var imgSelectName = "img";
	 
	 					if(fileNameExtension === 'mp4' || fileNameExtension === 'avi'){
	 						imgSelectName = "iframe";
	 					}	                        
	                    
	 
	                    var reader = new FileReader();
	                    reader.onload = function(img) {
	                        //div id="preview" ���� �����ڵ��߰�.
	                        //�� �κ��� �����ؼ� �̹��� ��ũ �� ���ϸ�, ������ ���� �ΰ������� �� �� ���� ���̴�.
	                        var imgNum = previewIndex++;
	                        
	                        var previewId = "";
	                       
	                        if(imgNum==0){
	                        	previewId = "start";
	                        }else{
	                        	previewId = "startNo";	
	                        }
                        
	                        $("#preview").append(
	                                        "<div class=\"preview-box\" id="+previewId+"  value=\"" + imgNum +"\"  style='display:inline;float:left;width:208px' >"
	                                                + "<"+imgSelectName+" class=\"thumbnail\" src=\"" + img.target.result + "\"\/ width=\"200px;\" height=\"200px;\"/>"
	                                                + "<a href=\"#\" value=\""
	                                                + imgNum
	                                                + "\" onclick=\"deletePreview(this)\">"
	                                                + "����" + "</a>" + "</div>");
	                        files[imgNum] = file;
	                        
	                        fileNameArray[imgNum]=file.name;
	                        fnAddFile(fileNameArray);
	                    };

	                    reader.readAsDataURL(file);
	                }
	            } else
	                alert('invalid file input'); // ÷��Ŭ�� �� ��ҽ��� ����å�� ������ �ʾҴ�.
	        }
	 
	        //preview �������� ���� ��ư Ŭ���� �ش� �̸������̹��� ���� ����
	        function deletePreview(obj) {
	            var imgNum = obj.attributes['value'].value;
	            delete files[imgNum];
	            $("#preview .preview-box[value=" + imgNum + "]").remove();
	            resizeHeight();
	        }
	 
	        //client-side validation
	        //always server-side validation required
	        function validation(fileName) {
	            fileName = fileName + "";
	            var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
	            var fileNameExtension = fileName.toLowerCase().substring(
	                    fileNameExtensionIndex, fileName.length);
	            if (!((fileNameExtension === 'jpg')|| (fileNameExtension === 'gif') || (fileNameExtension === 'png')||(fileNameExtension === 'avi')||(fileNameExtension === 'mp4'))) {
	                alert('jpg, gif, png, avi, mp4 Ȯ���ڸ� ���ε� �����մϴ�.');
	                return true;
	            } else {
	                return false;
	            }
	        }
	 
	   	 		$(document).ready(function() {
	            //submit ���. ������ submit type�� �ƴϴ�.
	   	 /*
	            $('.submit a').on('click',function() {                        
	                var form = $('#uploadForm')[0];
	                var formData = new FormData(form);
	    
	                for (var index = 0; index < Object.keys(files).length; index++) {
	                    //formData ������ files��� �̸����� ������ �߰��Ѵ�.
	                    //���ϸ����� ��� �߰��� �� �ִ�.
	                    formData.append('files',files[index]);
	                }

	                //ajax ������� multipart form�� �����Ѵ�.
	                $.ajax({
	                    type : 'POST',
	                    enctype : 'multipart/form-data',
	                    processData : false,
	                    contentType : false,
	                    cache : false,
	                    timeout : 600000,
	                    url : '/imageupload',
	                    dataType : 'JSON',
	                    data : formData,
	                    success : function(result) {
	                        //�� �κ��� �����ؼ� �پ��� �ൿ�� �� �� ������,
	                        //���⼭�� �����͸� ���۹޾Ҵٸ� �����ϰ� OK ���� ������� �Ͽ���.
	                        //-1 = �߸��� Ȯ���� ���ε�, -2 = �뷮�ʰ�, �׿� = ����(1)
	                        if (result === -1) {
	                            alert('jpg, gif, png, bmp Ȯ���ڸ� ���ε� �����մϴ�.');
	                            // ���� ���� ...
	                        } else if (result === -2) {
	                            alert('������ 10MB�� �ʰ��Ͽ����ϴ�.');
	                            // ���� ���� ...
	                        } else {
	                            alert('�̹��� ���ε� ����');
	                            // ���� ���� ...
	                        }
	                    }
	                    //���۽��п����� �ڵ鸵�� ������� ����
	                });
	            });
	            */
	            // <input type=file> �±� ��� ����
	            $('#attach input[type=file]').change(function() {
	                addPreview($(this)); //preview form �߰��ϱ�
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
		<h1 class="bg-primary text-center">�� ǰ �� ��</h1>
	    </div>		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�� ǰ ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="�� ǰ ��"  >
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="��ǰ������">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="��������">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="price" name="price" placeholder="����">
		    </div>
		    <strong>��</strong>
		  </div>
		  
		  <div class="form-group">
		    <label for="count" class="col-sm-offset-1 col-sm-3 control-label">��ǰ ����</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="count" name="count" placeholder="��ǰ ����">
		    </div>
		    <strong>��</strong>
		  </div>
		  
		  
		  
		   <input type="hidden" class="form-control" id="multiFile" name="multiFile" >
		   
		   
		   
		  <div class="form-group">
		    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="uploadFile" name="uploadFile" >
		    </div>
		  </div>
            <!-- ÷�� ��ư -->
            <div id="attach">
                <label class="waves-effect waves-teal btn-flat" for="uploadInputBox">����÷��(��ǥ�̹����� �Ķ��׵θ�)</label>
                <input id="uploadInputBox" style="display: none" type="file" name="filedata" multiple />
            </div>
            
            <!-- �̸����� ���� -->
            <div id="preview" class="content" style='display:inline;min-width:1200px;'></div>
            		  
            
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
