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
            padding-top : 0px;
        }
        
       th {
      		text-align : center;
       }      
              
        /*�� �� ȿ��*/
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
		/*�� �� ȿ��*/
		
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
							dataName : request.term , // �ڽ� ���� �Էµ� ��
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
            focus : function(event, ui) {    //��Ŀ�� ����
                return false; //�ѱ� ���� ���뵵�� ����
            }
		});

	});	
	
		//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============	
		function fncGetList(currentPage, listing){
			$("#currentPage").val(currentPage)
			$("#listing").val(listing);
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${ param.menu == 'manage' ? 'manage' : 'search' }").submit();
		}
		
		 //============= "�˻�"  Event  ó�� =============	
		 $(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			 });
		 });
		 
		
		 //============= ��ǰ��������  Event  ó��(Click) =============	
		 $(function() {
		
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( ".thumbnail img" ).on("click" , function() {
				 var prodNo = $(this).parent().parent().children("input[name=prodNo]").val();
				 self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${ param.menu == 'manage' ? 'manage' : 'search' }";		
			});
								
		});			
		 
		 	
		$(function() {				
			
			//==> Enter Ű �˻�
			$("input[name='searchKeyword']").on("keydown" , function(event) {						
				if(event.keyCode == '13'){
					fncGetList(1);
				}
			});
			//==> �������ݼ� ����
			$("span:contains('HIGH PRICE')").on("click", function() {
				fncGetList('1', 'high');
			});
			//==> �������ݼ� ����
			$("span:contains('LOW PRICE')").on("click", function() {
				fncGetList('1', 'low');
			});			
				
		});
		

		//��ũ�� ����¡
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
									addData +="<p>��"+ data.list[i].price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") +"</p>";
									addData +="</h5>";
									addData +="<p>";
									addData +="<a href='/product/getProduct?prodNo="+data.list[i].prodNo+"&menu=${ param.menu == 'manage' ? 'manage' : 'search' }' class='btn btn-primary' role='button'>";
									addData +="${ param.menu == 'manage' ? '��ǰ ����' : '�󼼺���' }";
									addData +="</a>&nbsp;&nbsp;";
								if(user != "" && menu == "search"){
									addData +="<a href='/purchase/addPurchase?prodNo="+data.list[i].prodNo+"' class='image blinking'>";	
									addData +="<button type='button' class='btn btn-danger'>�ٷ� ����</button>";
									addData +="</a>";
								}
									addData +="</p>";
									addData +="<a href='#' class='image blinking'>";
									addData +="<button type='button' class='btn btn-success' style='padding: 0px 7px;'>����</button>";
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
   	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
<c:if test ="${ ! empty user }">
	<div class="container" style="padding-top: 50px;">
</c:if>
	
		<div class="page-header">
	       <h3 class=" text-info">${ param.menu == 'manage' ? "��ǰ ����" : "��ǰ �����ȸ" }</h3>
	    </div>	   	

	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				 <div class="form-group">
					<span><a href="#" style="color: black;">HIGH PRICE��</a></span>&nbsp;
					<span><a href="#" style="color: black;">LOW PRICE��</a></span> 
					<input type="hidden" id="listing" name="listing" value="${! empty search.listing ? search.listing : '' }"/>
				 </div>	
						    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
					<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" title="��ҹ��ڸ� �����մϴ�." placeholder="�˻���"
						value=""  > 
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->	    	

		<!-- ����� ������ ����Ʈ -->
		<div class="row" style="margin-top: 30px" id="loadList">
			<c:set var="i" value="0" />
			<c:set var="purchase" value="${ list2 }" />
			<c:forEach var="product" items="${list}" begin="0" varStatus="status">
			<c:set var="i" value="${ i+1 }" />
			
			  <div class="col-sm-6 col-md-4">
			    <div class="thumbnail" style="width: 300px;">
			    
			      <a href="#">
			    	<img src="/images/uploadFiles/${product.fileName}" alt="�̹����� �غ����Դϴ�." class="img-rounded" style="width: 200px; height: 270px; margin-top: 10px;">
			      </a>
			      	<input type="hidden" name="prodNo" value="${ product.prodNo }">
			      	<input type="hidden" name="menu" value="${ param.menu }">
			      	<input type="hidden" name="user" value="${ user.role }">
			    	
			      <div class="caption" align="center">
			        <h4 style="font-size: 16px;"><b>${product.prodName}</b></h4>
			        <h5>
			        	<fmt:formatNumber value="${product.price}" type="currency" currencySymbol="��"/>
			        </h5>
			        <p>
			        	<a href="/product/getProduct?prodNo=${ product.prodNo }&menu=${ param.menu == 'manage' ? 'manage' : 'search' }" class="btn btn-primary" role="button">
			        		${ param.menu == 'manage' ? '��ǰ ����' : '�󼼺���' }
			        	</a>&nbsp;&nbsp;
				        <c:if test= "${! empty user && param.menu == 'search'}">				      
				       	 	<a href="/purchase/addPurchase?prodNo=${ product.prodNo }" class="image blinking">
				       	 		<button type="button" class="btn btn-danger">�ٷ� ����</button>
				       	 	</a>
				        </c:if>				        	
			        </p>
					
						<a href="#" class="image blinking">
							<button type="button" class="btn btn-success" style="padding: 0px 7px;">����</button>
						</a>
				
			      </div>
			      
			    </div>
			  </div>
			  
			</c:forEach>	
		</div>	   
			 			  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->

 	<!-- PageNavigation Start... -->
	<%-- <jsp:include page="../common/pageNavigator_new.jsp"/> --%>
	<!-- PageNavigation End... -->
	
</body>

</html>