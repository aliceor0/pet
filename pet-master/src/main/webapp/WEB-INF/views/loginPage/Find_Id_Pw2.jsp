<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


    input[type="text"] {
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    
    .RFCBtn {
            width: 100%;
            padding: 10px;
            background-color: #2a8890;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
    

    #main h2 {
        text-align: center;
        margin-bottom: 20px;
    }

    a {
        color: #6c757d; /* 회색으로 변경 */
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
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
        <h2>비밀번호 찾기</h2>
        <div id="mainContent">
            <table>
                <tr>
                    <td><input id="Input_Id" type="text" placeholder="본인의 아이디를 입력해주세요"></td>
                </tr>
                <tr>
                    <td><%@ include file="SendMail2.jsp" %></td>
                </tr>
            </table>

        </div>
    </main>
    </div>
    <footer id="footer">
        <%@ include file="../include/footer.jsp" %>
    </footer>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {

        })
        .on('click', '.AuthBtn', function() { //SendMail2.jsp 에 담긴 버튼함수 마지막 인증하기버튼임
            // 인증코드 성공시 비밀번호 초기화
            if ($('.auth_msg.msg').text() == "이메일 인증 성공!") { //이메일을보내고 인증코드가 맞을경우
                $.ajax({
                    type: 'post',
                    url: '/Check_Mail_Id',
                    data: {
                        mail: $('#input_email').val(),
                        id: $('#Input_Id').val()
                    },
                    dataType: 'text',
                    success: function(data) { //data에서 1을반환할경우 아이디와 인증된이메일이 db에 담겨있다
                        if (data == 1) {
                            if (confirm("비밀번호를 초기화 시키겠습니까?")) { //비밀번호 초기화,아니요 시 로그인페이지로
                                let newpass = prompt("새로운비밀번호는?");
                                $.ajax({
                                    type: 'post',
                                    url: '/resetPass',
                                    data: {
                                        id: $('#Input_Id').val(),
                                        newPass: newpass
                                    },
                                    dataType: 'text',
                                    success: function(data) {
                                        location.href = "/login";
                                    }
                                })
                            } else {
                                location.href = "/login";
                            }
                        } else { //아이디 혹은 이메일이 맞지않을경우
                            alert("아이디 혹은 이메일을 다시확인해주세요")
                            location.href = "/Find_Id_Pw?key=2";
                        }
                    }//function(data)
                })//ajax문
            }//첫if문
        })//onclick
</script>

</html>