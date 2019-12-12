<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
              
        /*블리 블링 효과*/
		.blinking{
			-webkit-animation:blink 1.5s ease-in-out infinite alternate;
		    -moz-animation:blink 1.5s ease-in-out infinite alternate;
		    animation:blink 1.5s ease-in-out infinite alternate;
		}
		@-webkit-keyframes blink{
		    0% {opacity:0;}
		    100% {opacity:1;}
		}
		@-moz-keyframes blink{
		    0% {opacity:0;}
		    100% {opacity:1;}
		}
		@keyframes blink{
		    0% {opacity:0;}
		    100% {opacity:1;}
		}
		/*블리 블링 효과*/
		
        .ui-autocomplete {
	            max-height: 150px;
	            overflow-y: auto;
	            overflow-x: hidden;
	            padding-right: 20px;
	    } 		
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">	
	
	//AutoComplete
	$(function() {
		
		$("#searchKeyword").autocomplete({
			
			source : function( request , response ) {
				var searchCondition = $("select[name='searchCondition']").val();
				var type = '';
				var restUrl = "/product/json/autoProduct";
				
				if ( searchCondition == '0' ) {
					type = "prodNo";
				}
				if ( searchCondition == '1' ) {
					type = "prodName";
				}
				if ( searchCondition == '2' ) {
					type = "price";
				}
				
				$.ajax(
					{
						url : restUrl , 
						method : "POST" , 
						dataType : "json" , 
						headers : {
							"Accept" : "application/json" , 
							"Content-Type" : "application/json"
						} , 
						data : JSON.stringify({ 
							dataName : request.term , // 박스 내에 입력된 값
							dataType : type 
						}) , 
						success : function( result ) {
							response (
								$.map(result , function(item){
									return {
										label : item ,
										value : item
									}
								})	
							);
						}
					}	
				)
			},
            focus : function(event, ui) {    //포커스 가면
                return false; //한글 에러 잡기용도로 사용됨
            }
		});

	});	
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetList(currentPage, listing){
			$("#currentPage").val(currentPage)
			$("#listing").val(listing);
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${ param.menu == 'manage' ? 'manage' : 'search' }").submit();
		}
		
		 //============= "검색"  Event  처리 =============	
		 $(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			 });
		 });
		 
		
		 //============= 상품정보보기  Event  처리(Click) =============	
		 $(function() {
		
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( ".thumbnail img" ).on("click" , function() {
				 var prodNo = $(this).parent().parent().children("input[name=prodNo]").val();
				 self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${ param.menu == 'manage' ? 'manage' : 'search' }";		
			});
								
		});			
		 
		 	
		$(function() {				
			
			//==> Enter 키 검색
			$("input[name='searchKeyword']").on("keydown" , function(event) {						
				if(event.keyCode == '13'){
					fncGetList(1);
				}
			});
			//==> 높은가격순 정렬
			$("span:contains('HIGH PRICE')").on("click", function() {
				fncGetList('1', 'high');
			});
			//==> 낮은가격순 정렬
			$("span:contains('LOW PRICE')").on("click", function() {
				fncGetList('1', 'low');
			});			
				
		});
		

		//스크롤 페이징
		var page = 1;

		 $(function() {
				$(window).data('ajaxready', true).scroll(function() {
					var maxHeight = $(document).height();
					var currentScroll = $(window).scrollTop() + $(window).height();
					var searchCondition = $("select[name='searchCondition']").val();
					var searchKeyword = $("input[name='searchKeyword']").val();
					var listing = $("input[name='listing']").val();
					
					if($(window).data('ajaxready') == false) return;
					if (maxHeight <= currentScroll) {
					if (page <= 100) {
						$(window).data('ajaxready', false);
						page++;
						console.log('page : ' + page);
							
						$.ajax({
							url : "/product/json/getProductList",
							method : "POST",
							dataType : "json",
							data : JSON.stringify({
								searchCondition : searchCondition,
								searchKeyword : searchKeyword,
								listing : listing,
								currentPage : page
							}),
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success: function(data) {
								
								for (var i = 0; i < data.list.length; i++) {
									console.log("data.list[i].prodName:"+data.list[i].prodName);
									console.log("data.list.length:"+data.list.length);
									var menu =  $("input[name='menu']").val();
									var user =  $("input[name='user']").val();
									console.log("user:"+user);
									
									var addData = "";
									
									addData +="<div class='col-sm-6 col-md-4'>" ;
									addData +="<div class='thumbnail' style='width: 300px;'>";
									addData +="<a href='/product/getProduct?prodNo="+data.list[i].prodNo+"&menu=${ param.menu == 'manage' ? 'manage' : 'search' }'>";
									addData +="<img src='../images/uploadFiles/"+data.list[i].fileNameList[0]+"' class='img-rounded' style='width:200px; height:270px; margin-top: 10px;'/>";
									addData +="</a>";
									addData +="<input type='hidden' name='prodNo' value='"+data.list[i].prodNo+"'>";
									addData +="<div class='caption' align='center'>";
									addData +="<h4 style='font-size: 16px;'><b>"+ data.list[i].prodName +"</b></h4>";
									addData +="<h5>";
									addData +="<p>￦"+ data.list[i].price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") +"</p>";
									addData +="</h5>";
									addData +="<p>";
									addData +="<a href='/product/getProduct?prodNo="+data.list[i].prodNo+"&menu=${ param.menu == 'manage' ? 'manage' : 'search' }' class='btn btn-primary' role='button'>";
									addData +="${ param.menu == 'manage' ? '상품 수정' : '상세보기' }";
									addData +="</a>&nbsp;&nbsp;";
								if(user != "" && menu == "search"){
									addData +="<a href='/purchase/addPurchase?prodNo="+data.list[i].prodNo+"' class='image blinking'>";	
									addData +="<button type='button' class='btn btn-danger'>바로 구매</button>";
									addData +="</a>";
								}
									addData +="</p>";
									addData +="<a href='#' class='image blinking'>";
									addData +="<button type='button' class='btn btn-success' style='padding: 0px 7px;'>상영중</button>";
									addData +="</a>";							
									addData +="</div>";
									addData +="</div>";
									addData +="</div>";
										
									$(addData).appendTo("#loadList");
								}
								
								$(window).data('ajaxready', true);
							}
						});
					}
					}
				})
			})				
		
		
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
	
		<div class="page-header">
	       <h3 class=" text-info">${ param.menu == 'manage' ? "상품 관리" : "상품 목록조회" }</h3>
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
			    
				 <div class="form-group">
					<span><a href="#" style="color: black;">HIGH PRICE▲</a></span>&nbsp;
					<span><a href="#" style="color: black;">LOW PRICE▼</a></span> 
					<input type="hidden" id="listing" name="listing" value="${! empty search.listing ? search.listing : '' }"/>
				 </div>	
						    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
					<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" title="대소문자를 구별합니다." placeholder="검색어"
						value=""  > 
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->	    	

		<!-- 썸네일 형식의 리스트 -->
		<div class="row" style="margin-top: 30px" id="loadList">
			<c:set var="i" value="0" />
			<c:set var="purchase" value="${ list2 }" />
			<c:forEach var="product" items="${list}" begin="0" varStatus="status">
			<c:set var="i" value="${ i+1 }" />
			
			  <div class="col-sm-6 col-md-4">
			    <div class="thumbnail" style="width: 300px;">
			    
			      <a href="#">
			    	<img src="/images/uploadFiles/${product.fileName}" alt="이미지를 준비중입니다." class="img-rounded" style="width: 200px; height: 270px; margin-top: 10px;">
			      </a>
			      	<input type="hidden" name="prodNo" value="${ product.prodNo }">
			      	<input type="hidden" name="menu" value="${ param.menu }">
			      	<input type="hidden" name="user" value="${ user.role }">
			    	
			      <div class="caption" align="center">
			        <h4 style="font-size: 16px;"><b>${product.prodName}</b></h4>
			        <h5>
			        	<fmt:formatNumber value="${product.price}" type="currency" currencySymbol="￦"/>
			        </h5>
			        <p>
			        	<a href="/product/getProduct?prodNo=${ product.prodNo }&menu=${ param.menu == 'manage' ? 'manage' : 'search' }" class="btn btn-primary" role="button">
			        		${ param.menu == 'manage' ? '상품 수정' : '상세보기' }
			        	</a>&nbsp;&nbsp;
				        <c:if test= "${! empty user && param.menu == 'search'}">				      
				       	 	<a href="/purchase/addPurchase?prodNo=${ product.prodNo }" class="image blinking">
				       	 		<button type="button" class="btn btn-danger">바로 구매</button>
				       	 	</a>
				        </c:if>				        	
			        </p>
					
						<a href="#" class="image blinking">
							<button type="button" class="btn btn-success" style="padding: 0px 7px;">상영중</button>
						</a>
				
			      </div>
			      
			    </div>
			  </div>
			  
			</c:forEach>	
		</div>	   
			 			  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

 	<!-- PageNavigation Start... -->
	<%-- <jsp:include page="../common/pageNavigator_new.jsp"/> --%>
	<!-- PageNavigation End... -->
	
</body>

</html>