<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>Walt Disney</title>

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
   
   <!-- Datepicker �޷� �̺�Ʈ -->
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <link rel="stylesheet" href="/resources/demos/style.css">
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>   
   	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
        
 		body {
            padding-top : 50px;
        }                
    </style>	

    <!--  ///////////////////////// JavaScript ////////////////////////// -->	
	<script type="text/javascript" src="../javascript/calendar.js"></script>	

	<script type="text/javascript">
	
		//============= "����"  Event ���� =============
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncUpdateProduct();
			});
		 });	
	
		//============= "���"  Event ó�� ��  ���� =============
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});			

	

		 
		 function fncUpdateProduct() {
				
				//Form ��ȿ�� ����	
				var name = $("input[name='prodName']").val();
				var detail = $("textarea[name='prodDetail']").val();
				var manuDate = $("input[name='manuDate']").val();
				var price = $("input[name='price']").val();
			
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
			
				$("form").attr("method" , "POST").attr("action" , "/product/updateProduct?prodNo=${product.prodNo}&menu=manage").attr("enctype","multipart/form-data").submit();
		}
		 
		 
		// �޷� �̺�Ʈ
		$( function() {
			    $( "#datepicker" ).datepicker({
			    	dateFormat: "yy-mm-dd",
			    	dayNamesMin: ['��', '��', 'ȭ', '��', '��', '��', '��'],
			    	monthNames: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��']
			    });
		} );	
	
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<div class="page-header text-center">
	       <h3 class=" text-info">��ǰ ����</h3>
	       <h5 class="text-muted">��ǰ ������ ���Ͻø� <strong class="text-danger">����</strong> ��ư�� Ŭ���� �ּ���.</h5>
	    </div>				
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${ product.prodName }">
		    </div>
		  </div>		
		  
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <textarea  class="form-control" id="prodDetail" name="prodDetail"
		      style="width: 358px; height: 200px; padding: 10px;">${ product.prodDetail }</textarea>
		    </div>
		  </div>			  
		
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="datepicker" name="manuDate" value="${ product.manuDate }" readonly>
		    </div> 
		  </div>	


		  <div class="form-group">		  
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
			<div class="col-sm-3">					   
				<div class="input-group">
					<span class="input-group-addon">��</span>
						<input type="text" class="form-control" aria-label="Amount (to the nearest dollar)" name="price" value="${ product.price }"
						style="position: static">
					<span class="input-group-addon">��</span>
				</div>
			</div>
		  </div>


		  <div class="form-group">
		    <label for="uploadFiles" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="uploadFiles" name="uploadFiles" value="../images/uploadFiles/${product.fileName}" multiple="multiple"
		      style="border-width: 0px; padding: 0px; left: 0px;"/>
		    </div> 
		  </div>	


		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� ��</button>
			  <a class="btn btn-danger btn" href="#" role="button">�� ��</a>
		    </div>
		  </div>



		</form>
		<!-- form End /////////////////////////////////////-->
	    
 	</div>
	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
</body>

</html>