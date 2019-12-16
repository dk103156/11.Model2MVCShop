<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	<title>Walt Disney</title>
	
	<!-- 네이버 로그인 -->
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body{
		padding-bottom: 30px;
		}
		
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
            margin-bottom: 30px;
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
		

		/*네온 효과*/  
		@font-face {
		  font-family: neon;
		  src: url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/707108/neon.ttf);
		}
		
		.neon {
		  font-family: neon;
		  color: #FB4264;
		  font-size: 9vw;
		  line-height: 9vw;
		  text-shadow: 0 0 3vw #F40A35;
		}
		
		.flux {
		  font-family: neon;
		  color: #426DFB;
		  font-size: 9vw;
		  line-height: 9vw;
		  text-shadow: 0 0 3vw #2356FF;
		}
		
		.neon {
		  animation: neon 1s ease infinite;
		  -moz-animation: neon 1s ease infinite;
		  -webkit-animation: neon 1s ease infinite;
		}
		
		@keyframes neon {
		  0%,
		  100% {
		    text-shadow: 0 0 1vw #FA1C16, 0 0 3vw #FA1C16, 0 0 10vw #FA1C16, 0 0 10vw #FA1C16, 0 0 .4vw #FED128, .5vw .5vw .1vw #806914;
		    color: #FED128;
		  }
		  50% {
		    text-shadow: 0 0 .5vw #800E0B, 0 0 1.5vw #800E0B, 0 0 5vw #800E0B, 0 0 5vw #800E0B, 0 0 .2vw #800E0B, .5vw .5vw .1vw #40340A;
		    color: #806914;
		  }
		}
		
		.flux {
		  animation: flux 2s linear infinite;
		  -moz-animation: flux 2s linear infinite;
		  -webkit-animation: flux 2s linear infinite;
		  -o-animation: flux 2s linear infinite;
		}
		
		@keyframes flux {
		  0%,
		  100% {
		    text-shadow: 0 0 1vw #1041FF, 0 0 3vw #1041FF, 0 0 10vw #1041FF, 0 0 10vw #1041FF, 0 0 .4vw #8BFDFE, .5vw .5vw .1vw #147280;
		    color: #28D7FE;
		  }
		  50% {
		    text-shadow: 0 0 .5vw #082180, 0 0 1.5vw #082180, 0 0 5vw #082180, 0 0 5vw #082180, 0 0 .2vw #082180, .5vw .5vw .1vw #0A3940;
		    color: #146C80;
		  }
		}		
		/*네온 효과*/  
		   
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		//============= "로그인"  Event 연결 =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});	
		
		
		//============= 회원원가입화면이동 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
		
		//==> Enter 키 로그인
		$( function() {
			$("input[name='password']").on("keydown" , function(event) {						
				if(event.keyCode == '13'){
					$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
				}
			});
		});	
		
	</script>		
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
	        	<a class="navbar-brand" href="/index.jsp" style="padding: 0px;">
	        		<img alt="" src="../images/uploadFiles/Disney.png" style="width: 90px; height: 55px;">
	        	</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
					<img src="../images/uploadFiles/BG-Disney.jpg" class="img-rounded" style="width: 550px; height: auto; max-width: 100%; padding-top: 70px; padding-bottom: 0px;"/>
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">
		 	 			<span class="neon" style="font-size: 45px;">꿈과 환상의 나라<br/></span>
		 	 			<span class="flux" style="font-size: 50px;">디즈니 랜드로 Let's Go!</span>
		 	 		</h1>
		 	 		
				
		 	 		<br/>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">아 이 디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
  <br/>
  <br/>                      
  <!-- 네이버아이디로로그인 버튼 노출 영역 -->
  <div id="naver_id_login" style="padding-left: 33px;"></div>
  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
  <script type="text/javascript">
  	var naver_id_login = new naver_id_login("HRPq2PQ8gvZlJdjui680", "http://192.168.0.61:8080/user/callback.jsp");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("green", 3, 35);
  	naver_id_login.setDomain("http://192.168.0.61:8080/user/loginView.jsp");
  	naver_id_login.setState(state);
  	//naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
  </script>					      
					    </div>
					  </div>
			
					</form>
			   	 </div>
			
			</div>
			
  	 	</div>
  	 	<!--  row End /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

</body>

</html>