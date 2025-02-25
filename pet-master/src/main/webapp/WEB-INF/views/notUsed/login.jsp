<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="include/head.jsp" %>
</head>
<style>
p {
  /* 수평 중앙 정렬하기 */
   text-align: center;
  
}
table tr td {
}
</style>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
		<%@ include file="include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
		<%@ include file="include/sitemap.jsp" %>
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    <main id="main">
        <div id="mainContent">
<table >
    <tr>
        <td>
            <!-- 첫 번째 테이블 시작 -->
            <table id="tblLogin">
                <tr>
                    <td>Login ID</td>
                    <td><input type="text" id="loginId"></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="password" id="password"></td>
                </tr>
                <tr style="color: red; display: none;" id="error">
                    <td colspan="2">아이디 또는 비밀번호를 잘못 입력했습니다.<br>입력하신 내용을 다시 확인해주세요.</td>
                </tr>
                <tr>
                    <td><a href="#">비밀번호찾기</a></td>
                </tr>
                <tr>
                    <td colspan="2"><button id="btnLogin">로그인</button></td>
                </tr>
                <tr>
                    <td colspan="2"><button id="btnSignup" onclick="location.href='/signup'">회원가입</button></td>
                </tr>
            </table>
            <!-- 첫 번째 테이블 끝 -->
        </td>
    </tr>
    <tr>
        <td>
            <!-- 두 번째 테이블 시작 -->
            <table style="width: 100%;">
                <tr>
                    <td style="text-align: center;"><%@ include file="include/googleLogin.jsp" %></td>
                    <td><p><%@ include file="include/kakaoLogin.jsp" %></p></td>
                </tr>
            </table>
            <!-- 두 번째 테이블 끝 -->
        </td>
    </tr>
</table>

        </div>
<%--         <div><%@ include file="include/naverlogin_2.jsp" %></div> --%>
    </main>
    <footer id="footer">
        <%@ include file="include/footer.jsp" %>
    </footer>
</body>

<script type="text/javascript">
    $(document)
        .ready(function() {
            $('#loginId').focus(); // 시작시 로그인에 포커스
            sessionStorage.clear(); // 혹시모를 session초기화 어처피 들어올땐 session값이없어야함
        })
        .on('click', '#btnLogin', function() { //로그인버튼을 눌렀을때의 코드
            $.ajax({
                type: 'Post',
                url: '/doLogin_3',
                data: {
                    user_id: $('#loginId').val(),
                    passwd: $('#password').val()
                },
                dataType: 'text',
                success: function(data) {
                    if (data == 1) {
                        location.href = "/";
                    } else {
                        $('#error').show();
                        $('#loginId,#password').val('');
                        $('#loginId').focus();
                    }
                }
            })
            return false;
        })
        .on('click', '#btnSignup', function() { //회원가입을 눌렀을때의 코드
            location.href = "/signup";
        })
         .on('keypress','#password',function(e,u){ //(편의성)비밀번호에서 엔터시 로그인버튼 누르는코드
         if(e.keyCode == 13) {$('#btnLogin').trigger('click')}
   })
</script>

</html>