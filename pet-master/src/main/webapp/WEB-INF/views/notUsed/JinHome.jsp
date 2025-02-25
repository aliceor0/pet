<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시홈</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<div>
	<header id="herder">
   	 	<%@ include file="notUsed/header.jsp" %>
    </header>
    <nav id="nav">
  		<%@ include file="include/nav.jsp" %>
    </nav>
</div>
<div style="position:block;">
	<nav>
		<%@ include file="CatDog_1.jsp" %>
	</nav>
</div>
<div>
	<table>
		<tr>
			<td><p ><%@ include file="include/googleLogin.jsp" %></p></td>
			<td><%@ include file="CatDog_1.jsp" %></td>
			<td><%@ include file="CatDog_1.jsp" %></td>
			<td><%@ include file="CatDog_1.jsp" %></td>
		</tr>
				<tr>
			<td><%@ include file="CatDog_1.jsp" %></td>
			<td><%@ include file="CatDog_1.jsp" %></td>
			<td><%@ include file="CatDog_1.jsp" %></td>
		</tr>
				<tr>
			<td><%@ include file="CatDog_1.jsp" %></td>
			<td><%@ include file="CatDog_1.jsp" %></td>
			<td><%@ include file="CatDog_1.jsp" %></td>
		</tr>
	</table>
</div>

<div>
	<footer id="footer">
  		<%@ include file="include/footer.jsp" %>
  	</footer>
</div>
<div id="container" class="container">
	<div class="content">
		<div class="join_wrap">
			<form id="join_frm">
				<div class="join_title">회원가입</div>
				<div class="join_box">
					<input type="text" placeholder="아이디" name="id" id="id" style="margin: 0;">
					<span id="id_ck" class="dpn">이미 사용중인 아이디입니다.</span>
					<input type="text" placeholder="닉네임" name="nickname" id="nickname">
					<span id="nickname_ck" class="dpn">이미 사용중인 닉네임입니다.</span>
					<input type="password" placeholder="비밀번호" name="password" id="password">
					<input type="password" placeholder="비밀번호  확인" id="password_ck">				
					<div class="email_auth">
						<input type="text" placeholder="이메일" name="email" id="email" class="email">
						<button type="button" id="email_auth_btn" class="email_auth_btn">인증번호 받기</button>
					</div>
					<input type="text" placeholder="인증번호 입력" id="email_auth_key">
				</div>
				<button type="button" id="join" class="join_btn">가입하기</button>
			</form>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
/* var naver_id_login = new naver_id_login("8osdb1AtmWFJZbMrX6bu", "http://localhost:8081/Jhome");
  // 접근 토큰 값 출력
  alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    alert(naver_id_login.getProfileData('email'));
    alert(naver_id_login.getProfileData('nickname'));
    alert(naver_id_login.getProfileData('age'));
  } */
  function fn_join(){
		var f = $('#join_frm');
		var formData = f.serialize();
			
		$.ajax({
			type : "POST",
			url : "/join",
			data : formData,
			success: function(data){
				if(data == "Y"){
					alert("회원가입이 완료되었습니다.");	
					location.href="/"
				}else{
					alert("회원가입에 실패하였습니다.");
				}
			},
			error: function(data){
				alert("회원가입 에러 발생!");
				console.log(data);
			}
		});
	 }
	 
	 $(function() { 
	 	
	 	var email_auth_cd = '';
	 
		$('#join').click(function(){
			
			if($('#id').val() == ""){
				alert("아이디를 입력해주세요.");
				return false;
			}
			
			if($('#nickname').val() == ""){
				alert("닉네임을 입력해주세요.");
				return false;
			}
			
			if($('#password').val() == ""){
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			if($('#password').val() != $('#password_ck').val()){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			
			if($('#email_auth_key').val() != email_auth_cd){
				alert("인증번호가 일치하지 않습니다.");
				return false;
			}
		
			fn_join();
		});
		
		$(".email_auth_btn").click(function(){	     	 
	    	 var email = $('#email').val();
	    	 
	    	 if(email == ''){
	    	 	alert("이메일을 입력해주세요.");
	    	 	return false;
	    	 }
	    	 
	    	 $.ajax({
				type : "POST",
				url : "/emailAuth",
				data : {email : email},
				success: function(data){
					alert("인증번호가 발송되었습니다.");
					email_auth_cd = data;
				},
				error: function(data){
					alert("메일 발송에 실패했습니다.");
				}
			}); 
		});
		
		$('#id').focusout(function(){
			var id = $('#id').val();
		
			$.ajax({
				type : "POST",
				url : "/idCheck",
				data : {id : id},
				success: function(data){
					console.log(data);
					if(data == "Y"){
						$('#id_ck').removeClass("dpn");
					}else{
						$('#id_ck').addClass("dpn");
					}
				},
				error: function(data){
				}
			}); 
		});
		
		$('#nickname').focusout(function(){
			var nickname = $('#nickname').val();
		
			$.ajax({
				type : "POST",
				url : "/nicknameCheck",
				data : {nickname : nickname},
				success: function(data){
					if(data == "Y"){
						$('#nickname_ck').removeClass("dpn");
					}else{
						$('#nickname_ck').addClass("dpn");
					}
				},
				error: function(data){
				}
			}); 
		});
	 });
</script>
</html>