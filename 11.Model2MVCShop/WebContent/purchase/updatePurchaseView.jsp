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
   
   <!-- Datepicker 달력 이벤트 -->
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
	
	
	//============= "수정"  Event 연결 =============
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary" ).on("click" , function() {
			fncUpdatePurchase();
		});
	 });	

	
	//============= "취소"  Event 처리 및  연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
		});
	});	
		
	
	 function fncUpdatePurchase() {
		$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase?tranNo=${ purchase.tranNo }&prodNo=${ purchase.purchaseProd.prodNo }").submit();
	}
		 
	
		
		// 달력 이벤트
		$( function() {
			    $( "#datepicker" ).datepicker({
			    	dateFormat: "yy-mm-dd",
			    	dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
			    	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			    });
		} );	
	
	</script>
		
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<div class="page-header text-center">
	       <h3 class=" text-info">구매 정보 수정</h3>
	       <h5 class="text-muted">구매 정보 수정을 원하시면 <strong class="text-danger">수정</strong> 버튼을 클릭해 주세요.</h5>
	    </div>	
	    
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm">	  
		
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyerId" name="buyerId" value="${ purchase.buyer.userId }" readonly>
		    </div>
		  </div>				  


		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매 방법</label>
		    <div class="col-sm-4">
				<select 	name="paymentOption"	 class="form-control">
													
					<c:choose>
					
						<c:when test="${ purchase.paymentOption.trim().equals('1') }">
							<option value="1" selected="selected">현금구매</option>
							<option value="2">신용구매</option>
						</c:when>
						
						<c:otherwise>
							<option value="1" >현금구매</option>
							<option value="2" selected="selected">신용구매</option>
						</c:otherwise>
						
					</c:choose>		
						
				</select>
		    </div>
		  </div>		
		  

		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자 이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${ purchase.receiverName }">
		    </div>
		  </div>	
		  

		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${ purchase.receiverPhone }">
		    </div>
		  </div>			 
		  

		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자 주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${ purchase.divyAddr }">
		    </div>
		  </div>			
		  

		  <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매 요청사항</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${ purchase.divyRequest }">
		    </div>
		  </div>				  	  
		  
		   		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="datepicker" name="divyDate" value="${ purchase.divyDate }" readonly>
		    </div> 
		  </div>		


		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수 정</button>
			  <a class="btn btn-danger btn" href="#" role="button">취 소</a>
		    </div>
		  </div>



		</form>
		<!-- form End /////////////////////////////////////-->
	    
 	</div>
	<!--  화면구성 div End /////////////////////////////////////-->
 	
</body>

</html>