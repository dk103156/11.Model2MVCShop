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
	
	 //============= "수정"  Event 연결 =============
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary" ).on("click" , function() {
			self.location = "/purchase/updatePurchase?tranNo=${ purchase.tranNo }"
		});
	 });		
	 
	
	 //============= "확인"  Event 연결 =============
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-success" ).on("click" , function() {
			history.go(-1);
			//self.location = "/purchase/listPurchase"
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

			<div class="page-header">
		       <h3 class=" text-info">구매 상세조회</h3>
		       		<h5 class="text-muted">구매 상세 <strong class="text-danger">조회</strong> 페이지 입니다.</h5>
		       <c:if test="${ purchase.tranCode.trim().equals('1') }">
		       		<h5 class="text-muted">수정을 원하시면 <strong class="text-danger">수정</strong> 버튼을 클릭해 주세요.</h5>
		       </c:if>
		    </div>		
		    
		    
			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>배송번호</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.tranNo }</div>
			</div>	    
			
			<hr/>			
			

			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.purchaseProd.prodNo }</div>
			</div>	    
			
			<hr/>				
			

			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>구매자아이디</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.buyer.userId }</div>
			</div>	    
			
			<hr/>
			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>구매방법</strong></div>
				<div class="col-xs-8 col-md-4">
					<c:choose>
						<c:when test="${ purchase.paymentOption.trim().equals('1') }">
							현금구매
						</c:when>			
						<c:otherwise>
							신용구매
						</c:otherwise>
					</c:choose>				
				</div>
			</div>	    
			
			<hr/>		
			

			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>구매자이름</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.receiverName }</div>
			</div>	    
			
			<hr/>		
			

			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>구매자연락처</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.receiverPhone }</div>
			</div>	    
			
			<hr/>			
			

			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>구매자주소</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.divyAddr }</div>
			</div>	    
			
			<hr/>		
			

			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>구매요청사항</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.divyRequest }</div>
			</div>	    
			
			<hr/>	
			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>배송희망일자</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.divyDate }</div>
			</div>	    
			
			<hr/>		
			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>주문일자</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.orderDate }</div>
			</div>	    
			
			<hr/>																		
													

			<div class="row">
		  		<div class="col-sm-offset-4  col-sm-4 text-center">
		  		<c:if test="${sessionScope.user.role == 'user'}">
			  		<c:if test="${ purchase.tranCode.trim().equals('1') }">
			  		  <button type="button" class="btn btn-primary"  >수 정</button>
			  		</c:if>
			      <!-- <button type="button" class="btn btn-success"  >확 인</button> -->
			    </c:if>
			    </div>
			</div>		
			
			<br/>
		
	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

</body>

</html>