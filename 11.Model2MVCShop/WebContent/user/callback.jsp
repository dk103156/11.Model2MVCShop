<!doctype html>
<html lang="ko">
<head>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
</head>
<body>
<script type="text/javascript">

$( function(){
	
});

  var userId2;
  var userName2;
  var password2;
  
  var naver_id_login = new naver_id_login("HRPq2PQ8gvZlJdjui680", "http://192.168.0.61:8080/user/callback.jsp");
  // 접근 토큰 값 출력
  //alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");

  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	  
    userId2 = naver_id_login.getProfileData('email').split('@')[0];
    userName2 = naver_id_login.getProfileData('name');
    password2 = naver_id_login.getProfileData('id');
    
    $("input[name='userId']").val( userId2 );
    $("input[name='password']").val( password2 );
    
    $("form").attr("method" , "POST").attr("action" , "/user/login").submit();
    	
    	//네이버 아이디 등록    	
 				$.ajax(
					{
						url : "/user/json/addUser",
						method : "POST",
						data : JSON.stringify({
								userId : userId2,
								userName : userName2,
								password : password2
							}),
						contentType:'application/json; charset=utf-8',
						dataType : "json",
						success : function(serverData, status) {
							
						}
				
					}
				); 	

    	
    	
    	
  }
</script>

	<form>
		<input name="userId" type="hidden" value="">
		<input name="password" type="hidden" value="">	
	</form>
</body>
</html>