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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 0px;
        }
        
       th {
      		text-align : center;
       }             
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetList(currentPage){
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
		}
		
		
		$(function(){
			
			//==> tranNo(배송번호) LINK Event 연결처리
			$( "td:nth-child(2)" ).on("click" , function() {
					self.location ="/purchase/getPurchase?tranNo="+$( this ).text().trim();									
			});
			
			//==> userId(회원ID) LINK Event 연결처리
			$( "td:nth-child(3)" ).on("click" , function() {
					self.location ="/user/getUser?userId="+$( this ).text().trim();									
			});
			
			//==> 물건도착 LINK Event 연결처리
			$(  "td:nth-child(7) button" ).on("click" , function() {
				var tranNo = $(this).parent().children("input[name=tranNo]").val();
				var tranCode = $(this).parent().children("input[name=tranCode]").val();
				self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=3&currentPage=${search.currentPage}";
			});
			
			//==> tranNo(배송번호), userId(회원ID) LINK Event 색깔 !!!
			$( "td:nth-child(2)" ).css("color" , "#3DB7CC");
			$( "td:nth-child(3)" ).css("color" , "red");
						
			
			//$("tr:nth-child(2n+2)" ).css("background-color" , "whitesmoke");	
			
		});		
	
	</script>
	
</head>

<body>


	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container" style="padding-top: 50px;">
	

		<div class="page-header text-info">
	       <h3>구매 목록조회</h3>
	    </div>

	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			   				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->	    	
		

      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="center" >배송번호</th>
            <th align="center">회원ID</th>
            <th align="center">회원명(구매시)</th>
            <th align="center">전화번호(구매시)</th>
            <th align="center" >배송현황</th>
            <th align="center" >정보수정</th>
          </tr>
        </thead>      

		<tbody>
		
		<c:set var="i" value="0" />
		<c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
				<tr class="ct_list_pop">
					<td align="center">${ i }</td>
					<td align="center">							
							<b>${ purchase.tranNo }</b>
					</td>
					<td align="center">
							<b>${ purchase.buyer.userId }</b>
					</td>
					<td align="center">${ purchase.receiverName }</td>
					<td align="center">${ purchase.receiverPhone }</td>
					<td align="center">
						<c:choose>
							<c:when test="${ purchase.tranCode.trim().equals('1') }">
									현재 구매완료 상태입니다.
							</c:when>
							<c:when test="${ purchase.tranCode.trim().equals('2') }">
									현재 배송중 상태입니다.
							</c:when>						
							<c:otherwise>
									현재 배송완료 상태입니다.
							</c:otherwise>												
						</c:choose>
					</td>
					<td class="tranCode" align="center">
						<c:if test="${ purchase.tranCode.trim().equals('2') }">
								<input type="hidden" name="tranNo" value="${purchase.tranNo}">
								<input type="hidden" name="tranCode" value="${purchase.tranCode.trim()}">
								<button type="button" class="btn btn-danger" style="padding: 0px 7px;">물건도착</button>
						</c:if>	
					</td>
				</tr>
		</c:forEach>		
		
		</tbody>
		
      </table>
	  <!--  table End /////////////////////////////////////-->		      

 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>