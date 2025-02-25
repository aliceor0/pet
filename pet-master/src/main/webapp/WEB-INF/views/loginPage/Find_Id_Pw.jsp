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
        <h2>아이디찾기</h2>
        <div id="mainContent">
            <table>
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
        .on('click', '.AuthBtn', function() { //인증코드 성공시 이메일보여주는코드
            if ($('.auth_msg.msg').text() == "이메일 인증 성공!") {//만약 이메일인증성공이란 텍스트로 바뀌지않았다면 false
                $.ajax({
                    type: 'post',
                    url: '/getMail',
                    data: {
                        mail: $('#input_email').val()
                    },
                    dataType: 'text',
                    success: function(data) {
                        if (data == "1") { //컨트롤러에서 1을 반환하면 이메일은 있지만 비밀번호가없으면 sns로그인인걸 확인
                            alert("sns로그인으로 등록된 이메일입니다 알맞은 사이트에서 찾아주세요")
                            location.href = "/login";
                        } else if (data == "3") { //컨트롤러에서 3을반환하면 현 이메일로 가입한 아이디가없음
                            alert("이 이메일로 가입된 아이디가 없습니다")
                            location.href = "/login";
                        } else { //정상적인 입력 *로 가려진 아이디를 alert알림으로 띄워줌
                            alert("당신의 아이디는" + data + "입니다. 보안상 중간은 가려져있습니다")
                            location.href = "/login";
                        }
                    }//function
                })//ajax
            }//첫if문 END
        })//on click
</script>

</html>