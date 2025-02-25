<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
    <%@ include file="../include/head.jsp" %>
    <style>
         #mainContent {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            margin-top: 50px;
        }

        .tbl-login {
            width: 100%;
            max-width: 400px;
        }

        .tbl-login td {
            padding: 10px;
        }

        .tbl-login input[type="text"],
        .tbl-login input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        #main h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        #btnLogin,
        #btnSignup {
            width: 100%;
            padding: 10px;
            background-color: #2a8890;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        #btnLogin:hover,
        #btnSignup:hover {
            background-color: #0056b3;
        }

        #error {
            color: red;
            display: none;
        }

        a {
            color: #6c757d; /* 회색으로 변경 */
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        /* 두 번째 테이블 스타일 */
        .tbl-social {
            width: 100%;
        }

        .tbl-social td {
            text-align: center;
            padding: 10px;
        }

        p {
            margin: 0;
        }

    </style>
</head>
<body id="page-top">
    <!-- 상단 네비게이션바 정보 헤더에 포함 -->
    <%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
    <%@ include file="../include/sitemap.jsp" %>
<div class="subBody" style="top:120px; margin-bottom:40px;">
	<div class="sub-visual-box bgImage07" data-aos="fade" data-aos-duration="1000">
		<div class="container">
			<div class="page-head-title research-head">
				<h2 class="sub-title" data-aos="fade-up" data-aos-delay="200" data-aos-duration="1000">
				로그인</h2>
				<p class="page-explain" data-aos="fade-up" data-aos-delay="400" data-aos-duration="1000"></p>
			</div>
		</div>
	</div>
</div>
<div class="container">
    <main id="main">
        <div id="mainContent">
        <h1>로그인</h1>
            <table class="tbl-login">
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
                        <table class="tbl-social">
                            <tr>
                                <td style="text-align: center;"><%@ include file="../include/googleLogin.jsp" %></td>
                                <td>
                                    <p><%@ include file="../include/kakaoLogin.jsp" %></p>
                                </td>
                            </tr>
                        </table>
                        <!-- 두 번째 테이블 끝 -->
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">
                    	<a href="Find_Id_Pw?key=1">아이디 찾기</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    	<a href="Find_Id_Pw?key=2">비밀번호 찾기</a>
                    </td>
                </tr>
            </table>

        </div>
        <%--         <div><%@ include file="include/naverlogin_2.jsp" %></div> --%>
    </main>
    </div>
    <footer id="footer">
        <%@ include file="../include/footer.jsp" %>
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
                success: function(data) { //1을반환하면 로그인성공
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
        .on('keypress', '#password', function(e, u) { //(편의성)비밀번호에서 엔터시 로그인버튼 누르는코드
            if (e.keyCode == 13) {
                $('#btnLogin').trigger('click')
            }
        })
</script>

</html>