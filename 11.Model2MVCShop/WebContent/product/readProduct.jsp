<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">	
	<title>Walt Disney</title>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
     </style>
     
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	 //============= "확인"  Event 연결 =============
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary" ).on("click" , function() {
			self.location = "/product/listProduct?menu=manage"
		});
	 });		
	
	</script>

</head>

<body>


	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">   	


		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">

			<div class="page-header">
		       <h3 class=" text-info">상품 상세조회</h3>
		       <h5 class="text-muted">수정을 완료 하셨으면 <strong class="text-danger">확인</strong> 버튼을 클릭해 주세요.</h5>
		    </div>			
		    

			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
				<div class="col-xs-8 col-md-4">${ product.prodNo }</div>
			</div>	    
			
			<hr/>	
			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
				<div class="col-xs-8 col-md-4">${ product.prodName }</div>
			</div>	    
			
			<hr/>		
			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
				<div class="col-xs-8 col-md-4">
					<c:forEach var="i" items="${product.fileNameList}">
								<img src="/images/uploadFiles/${i}" width="250" height="200"/>
					</c:forEach>
				</div>
			</div>
			
			<hr/>			
			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
				<div class="col-xs-8 col-md-4">${ product.prodDetail }</div>
			</div>
			
			<hr/>			
			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
				<div class="col-xs-8 col-md-4">${ product.manuDate }</div>
			</div>
			
			<hr/>											


			<div class="row">
		  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
				<div class="col-xs-8 col-md-4">${ product.price }</div>
			</div>
			
			<hr/>		
			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
				<div class="col-xs-8 col-md-4">${ product.regDate }</div>
			</div>
			
			<hr/>							


			<div class="row">
		  		<div class="col-sm-offset-4  col-sm-4 text-center">
		  		  <button type="button" class="btn btn-primary"  >확 인</button>
			    </div>
			</div>		
			
			<br/>

		</form>
		<!-- form End /////////////////////////////////////-->
		
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
</body>
</html>