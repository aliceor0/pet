<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 임시</title>
</head>
<body>
<table>
<tr><td>ID</td><td><input type="text" id=userid></td></tr>
<tr><td>PW</td><td><input type="password" id=userpw></td></tr>
<tr><td colspan=2><input type="button" id="btnlogin" value="로그인"></td></tr>
</table>
<br>
<a href="/">메인으로</a>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)
.on('click','#btnlogin',function(){
	$.ajax({
		type:'post',
		url:"/doLogin",
		data:{id:$('#userid').val(),pw:$('#userpw').val()},
		dataType:'text',
		success:function(data){
			if(data == 1){
				console.log("login",data);
				var previousPage = document.referrer;
				location.href = previousPage || "/defaultFallbackPage";
			} else {
				alert("잘못 입력하셨습니다")
				$('#userid,#userpw').val('')
			}
			
		}
	})
})

</script>
</html>