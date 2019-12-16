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
            padding-top : 0px;
        }
     </style>
     
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//============= "구매"  Event 연결 =============
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary" ).on("click" , function() {
			self.location = "/purchase/addPurchase?prodNo=${ product.prodNo }"
		});
	 });	
	

	//============= "이전"  Event 연결 =============
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-danger" ).on("click" , function() {
				//history.go(-1);
			self.location = "/product/listProduct?menu=search"
		});
	 });	
	
	</script>

</head>

<body>


	<!-- ToolBar Start /////////////////////////////////////-->
	<c:if test ="${ empty user }">
		<div class="navbar  navbar-default">
	        <div class="container">
	        	<a class="navbar-brand" href="/index.jsp" style="padding: 0px;">
	        		<img alt="" src="../images/uploadFiles/Disney.png" style="width: 90px; height: 55px;">
	        	</a>
	   		</div>
	   	</div>
   	</c:if>
   	<!-- ToolBar End /////////////////////////////////////-->


	<!-- ToolBar Start /////////////////////////////////////-->
	<c:if test ="${ ! empty user }">
		<jsp:include page="/layout/toolbar.jsp" />
	</c:if>
   	<!-- ToolBar End /////////////////////////////////////-->
	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
<c:if test ="${ ! empty user }">
	<div class="container" style="padding-top: 50px;">
</c:if>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
			<div class="page-header">
		       <h3 class=" text-info">상품 상세조회</h3>
		       <h5 class="text-muted">구매를 원하시면 <strong class="text-danger">구매</strong> 버튼을 클릭해 주세요.</h5>
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
								<img src="/images/uploadFiles/${i}" width="350px" height="450px"/>
					</c:forEach>
				</div>
			</div>
			
			<hr/>	
			
	
			<div class="row">
		  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
				<div class="col-xs-8 col-md-4" style="width: 60%">${ product.prodDetail }</div>
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
		  		<c:if test ="${ ! empty user }">
		  		  <button type="button" class="btn btn-primary"  >구 매</button>
		  		</c:if>
			      <button type="button" class="btn btn-danger"  >이 전</button>
			    </div>
			</div>		
			
			<br/>

		</form>
		<!-- form End /////////////////////////////////////-->
		
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
</body>

</html>