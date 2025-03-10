<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
String id=(String)session.getAttribute("id"); // session 설정있음
String mail = session.getAttribute("mail") == null ? "" : (String) session.getAttribute("mail"); // session 설정있음
%>

<head id="header">
    <%@ include file="../include/head.jsp" %>
<style>
    #mainContent {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        margin-top: 50px;
    }

    #ltblSignup {
        width: 100%;
        max-width: 600px;
    }

    #tblSignup td {
        padding: 10px;
    }

    #tblSignup input[type="text"],
    #tblSignup input[type="password"],
    #tblSignup input[type="date"],
    #tblSignup input[type="number"],
    #tblSignup input[type="tel"],
    #tblSignup input[type="email"] {
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    #main h1 {
        text-align: center;
        margin-bottom: 20px;
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

    /* 추가된 부분 */
    input[type=radio] {
        margin-right: 10px;
    }
    
      #ADRshow,
       .RFCBtn,
       #signup,
       #cancel {
            width: 100%;
            padding: 10px;
            background-color: #2a8890;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        #ADRshow:hover,
        .RFCBtn:hover,
        #signup:hover,
        #cancel:hover {
            background-color: #0056b3;
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
				회원가입</h2>
				<p class="page-explain" data-aos="fade-up" data-aos-delay="400" data-aos-duration="1000"></p>
			</div>
		</div>
	</div>
</div>
<div class="container">
    <main id="main">
        <div id="mainContent">
            <h1>회원가입</h1>
            <hr>
            <table id="tblSignup">
                <tr style="display:none;">
                    <td>로그인 API 아이디</td>
                    <td><input type="text" id="userApiId" maxlength="12" readonly value=<%= id%>></td>
                    <td></td>
                </tr>
                <% if (id == null) { %>
                <tr>
                    <td>로그인 아이디</td>
                    <td><input type="text" id="userId" maxlength="12"></td>
                    <td></td>
                </tr>
                <tr style="display: none;">
                    <td><input type="text" id="userIdCheck"></td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" id="password" maxlength="12"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td><input type="password" id="passwordCheck" maxlength="12"></td>
                    <td></td>
                </tr>
                <% } else { %>
                <h2>sns회원가입중</h2>
                <% } %>
                <tr>
                    <td>이름</td>
                    <td><input type="text" id="userName"></td>
                </tr>
                <tr>
                    <td>닉네임</td>
                    <td><input type="text" id="userNickname"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>생년월일</td>
                    <td><input type="date" id="birth" min="1900-01-01"></td>
                </tr>
                <tr>
                    <td rowspan="3">주소 </td>
                    <td> <input type="number" id="zipcode" placeholder="우편번호" style="width:70%">&nbsp;<button id=ADRshow style="width: 29%">주소검색</button></td>
                </tr>
                <tr>
                    <td><input type="text" id="adress" placeholder="기본주소"></td>
                </tr>
                <tr>
                    <td><input type="text" id="ADR_SangSoo" placeholder="상세주소"></td>
                </tr>
                <tr>
                    <td>핸드폰 번호 </td>
                    <td><input type="tel" id="mobile" placeholder="010-0000-0000" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required></td>
                    <td></td>
                </tr>
				<% if (id != null) { %>
    			<tr>
        			<td>E-mail </td>
        			<td><input type="email" id="mail" value="<%= mail %>" readonly></td>
    			</tr>
				<% } else { %>
    			<tr>
        			<td>인증테스트중</td>
        			<td><%@ include file="SendMail2.jsp" %></td>
    			</tr>
				<% } %>
                <tr>
                    <td>성별 </td>
                    <td><input type=radio name=gender value=male>남성 &nbsp; <input type=radio name=gender value=female>여성 </td>
                </tr>
                <tr>
                    <td colspan="2"><button id="signup" class="tosign">회원가입</button></td>
                </tr>
                <tr>
                    <td colspan="2"><button id="cancel" class="tosign" style="background-color: gray;">취소</button></td>
                </tr>
            </table>
        </div>
        <!-- <input id="anibtn" type="button" value="확인용"> 지워도되는확인용 -->
    </main>
    <div>
    </div>
    </div>
        <footer id="footer">
            <%@ include file="../include/footer.jsp" %>
        </footer>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
   		$(document).ready(function() {
   		 let mail = '<%= mail %>';   //처음에 설정된 session mail 변수선언
   	    if (mail == null || mail == "") {
   	        $('#mail').prop('readonly', false);	//mail을 가진 sns로그인이라면 메일을넣고readonly 없다면 풀기 
   	    }
        	focusOnEmptyInput();
        	$('#mail').val('<%= mail %>');
    	})
/*         .on('click', '#anibtn', function() {	//지워도되는확인용
            alert($('.auth_msg.msg').text());
        }) */

        .on('click', '#signup', function() {	//회원가입 버튼눌렀을때의 실행되는코드
            if ($('#userApiId').val() == "null" || $('#userApiId').val() == "") {	//sns로그인이 아닐때
                if ($('#userId').val() != $('#userIdCheck').val() || $('#userId').val() == "") { //id가 중복인경우
                    alert("ID 중복 확인해주세요.");
                    $("#userId").focus();
                } else if ($("#password").val().length < 4) { //비번이 짧을경우
                    alert("비밀번호가 너무 짧습니다. 4~12자");
                    $("#password").focus();
                } else if ($("#password").val() != $("#passwordCheck").val()) { //비번확인이 안맞을경우
                    alert("비밀번호 확인해주세요.");
                    $("#password,#passwordCheck").val('');
                    $("#password").focus();
                } else if ($('#userId').val() === '' ||
                    $('#password').val() === '' ||
                    $('#userName').val() === '' ||
                    $('#mobile').val() === '' ||
                    $('#input_email').val() === '' ||
                    $('#birth').val() === '' ||
                    $('#adress').val() === '' ||
                    $('#ADR_SangSoo').val() === '' ||
                    $('#zipcode').val() === '' ||
                    $('input[name="gender"]:checked').length === 0	//비어잇는칸이 있을경우
                ) {
                    alert("빈칸에 값을 입력해주세요.");
                    focusOnEmptyInput();
                } else if ($('.auth_msg.msg').text() != "이메일 인증 성공!") {	//메일인증이 안되어있을경우
                    alert("이메일 인증을 해주세요")
                } else {	//모든경우가 통과됫을경우 회원가입
                    singup();
                    alert("회원가입 완료")
                    location.href = "/login";
                } //첫if문의 끝
            } else {	
                if ($('#userName').val() === '' ||
                    $('#mobile').val() === '' ||
                    $('#birth').val() === '' ||
                    $('#adress').val() === '' ||
                    $('#mail').val() === '' ||
                    $('#zipcode').val() === '' ||
                    $('input[name="gender"]:checked').length === 0) {//sns로그인일 경우
                    alert("빈칸에 값을 입력해주세요.");
                } else {
                    singup();
                    alert("회원가입 완료")
                    location.href = "/login";
                }
            }
        })
        .on('keyup', '#input_email', function() {	//숨어있는 email input에 따라서치기
            $('#mail').val($('#input_email').val())
        })
        .on('click', '#cancel', function() { //취소하고 메인홈피로 돌아가는코드
            location.href = "/";
        })
        .on('click', '#ADRshow', function() { //주소창나오는 코드
            ADRshow();
        })
        .on('keyup', '#userId', function() { //아이디 중복체크
            idcheck();
        })
        .on('keyup', '#passwordCheck', function() { //비밀번호 비밀번호확인 같은지 확인체크
            pswcheck();
        })
        .on('keyup', '#userNickname', function() { //중복닉네임체크
            Nicknamecheck();
        })
        .on('click', '#header', function() { //헤더로 홈페이지갈경우 sns회원가입에 담긴 session값 날리기
        	<% session.invalidate(); %>
            $.ajax({
                type: 'post',
                url: '/logout',
                data: {},
                dataType: 'text',
                success: function(data) {}
            })
        })

    function idcheck() { //아이디중복체크 함수
        $.ajax({
            type: 'post',
            url: '/idcheck',
            data: {
                user_id: $('#userId').val()
            },
            dataType: 'text',
            success: function(data) {
                if ($("#userId").val().length < 4) {	//아이디가4글자보다 짧을경우
                    let str = '<td style="color: red; text-align:center;"> Id가 너무 짧습니다. 4 ~ 12자</td>';
                    $('#tblSignup tr:eq(1) td:eq(2)').after(str);
                } else {
                    if (data == 1) { //아이디가 중복일경우
                        let str = '<td style="color: red; text-align:center;"> 이미 사용중인 아이디입니다.</td>';
                        $('#tblSignup tr:eq(1) td:eq(2)').after(str);
                    } else if (data == 0 && $('#userId').val() == "") {  //아이디input이 공백일 경우
                        let str = '<td style="color: red; text-align:center;"> 값을 입력해주세요.</td>';
                        $('#tblSignup tr:eq(1) td:eq(2)').after(str);
                    } else { //정상일경우
                        let str = '<td style="color: green; text-align:center;"> 가입가능한 아이디입니다.</td>';
                        $('#tblSignup tr:eq(1) td:eq(2)').after(str);
                        $('#userIdCheck').val($('#userId').val());
                    }
                }
                $('#tblSignup tr:eq(1) td:eq(2)').remove(); //밑에 trtd생성후 지우기
            }
        })
    }

    function Nicknamecheck() { //닉네임중복체크 함수
        if ($('#userApiId').val() != "null" || $('#userApiId').val() != "") { //sns회원가입인지 체크
            $.ajax({
                type: 'post',
                url: '/nicknamecheck',
                data: {
                    userNickname: $('#userNickname').val()
                },
                dataType: 'text',
                success: function(data) {
                    if ($("#userNickname").val().length < 3) { //닉네임이 3글자미만일때
                        let str = '<td style="color: red; text-align:center;"> 닉네임이 너무 짧습니다. 3 ~ 10자</td>';
                        $('#tblSignup tr:eq(2) td:eq(2)').after(str);
                    } else {
                        if (data == 1) { //닉네임이 중복일때
                            let str = '<td style="color: red; text-align:center;"> 이미 사용중인 닉네임입니다.</td>';
                            $('#tblSignup tr:eq(2) td:eq(2)').after(str);
                        } else if (data == 0 && $('#userNickname').val() == "") { //아무것도 입력을 안했을때
                            let str = '<td style="color: red; text-align:center;"> 값을 입력해주세요.</td>';
                            $('#tblSignup tr:eq(2) td:eq(2)').after(str);
                        } else { //정상적인입력
                            let str = '<td style="color: green; text-align:center;"> 가입가능한 아이디입니다.</td>';
                            $('#tblSignup tr:eq(2) td:eq(2)').after(str);
                        }
                    }
                    $('#tblSignup tr:eq(2) td:eq(2)').remove();
                } //function(data)
            }) //ajax
        } //첫if문
        $.ajax({ //sns전용 닉네임체크
            type: 'post',
            url: '/nicknamecheck',
            data: {
                userNickname: $('#userNickname').val()
            },
            dataType: 'text',
            success: function(data) {
                if ($("#userNickname").val().length < 3) {
                    let str = '<td style="color: red; text-align:center;"> 닉네임이 너무 짧습니다. 3 ~ 10자</td>';
                    $('#tblSignup tr:eq(6) td:eq(2)').after(str);
                } else {
                    if (data == 1) {
                        let str = '<td style="color: red; text-align:center;"> 이미 사용중인 닉네임입니다.</td>';
                        $('#tblSignup tr:eq(6) td:eq(2)').after(str);
                    } else if (data == 0 && $('#userNickname').val() == "") {
                        let str = '<td style="color: red; text-align:center;"> 값을 입력해주세요.</td>';
                        $('#tblSignup tr:eq(6) td:eq(2)').after(str);
                    } else {
                        let str = '<td style="color: green; text-align:center;"> 가입가능한 아이디입니다.</td>';
                        $('#tblSignup tr:eq(6) td:eq(2)').after(str);
                    }
                }
                $('#tblSignup tr:eq(6) td:eq(2)').remove();
            }
        })
    }

    function pswcheck() { //비밀번호체크
        if ($("#password").val() !== $("#passwordCheck").val()) { //비밀번호와 비밀번호확인이 일치하는지 체크
            let str = '<td style="color: red; text-align:center;"> 확인 비밀번호가 일치하지 않습니다.</td>';
            $('#tblSignup tr:eq(3) td:eq(2)').after(str);
        } else {
            let str = '<td style="color: green; text-align:center;"> 확인 비밀번호가 일치합니다.</td>';
            $('#tblSignup tr:eq(3) td:eq(2)').after(str);
        }
        $('#tblSignup tr:eq(3) td:eq(2)').remove();
    }

    function focusOnEmptyInput() { //빈input에 focus두는 함수
        $('#tblSignup input').each(function() {
            if ($(this).val() === '') {
                $(this).focus();
                return false;
            }
        });
    }

    function singup() { //회원가입 함수
        console.log($('#userApiId').val()) //)(테스트용)들어왔을때 sns로그인인지확인
        if ($('#userApiId').val() == "null" || $('#userApiId').val() == "") { //sns로그인이 아닐때
            $.ajax({
                type: 'post',
                url: '/doSignup_3',
                data: {
                    user_id: $('#userId').val(),
                    password: $('#password').val(),
                    name: $('#userName').val(),
                    userNickname: $('#userNickname').val(),
                    mobile: $('#mobile').val(),
                    mail: $('#input_email').val(),
                    birth: $('#birth').val(),
                    adress: $('#adress').val(),
                    zipcode: $('#zipcode').val(),
                    gender: $('input[name=gender]:checked').val(),
                    adress2: $('#ADR_SangSoo').val()
                },
                dataType: 'text',
                success: function(data) {
                    if (data == 1) {
                        $('#userId,#password,#userNickname,#passwordCheck,#userName,#birth,#zipcode,#address,#mobile,#mail').val('');
                    } else {
                        alert("회원가입 실패");
                        $('#userId,#password,#passwordCheck,#userName,#birth,#zipcode,#address,#mobile,#mail').val('');
                    }
                }
            })
        } else if ($('#userApiId').val() != null || $('#userApiId').val() != "") { //sns로그인일때
            $.ajax({
                type: 'post',
                url: '/doApiSignup_3',
                data: {
                    user_id: $('#userApiId').val(),
                    password: $('#password').val(),
                    name: $('#userName').val(),
                    userNickname: $('#userNickname').val(),
                    mobile: $('#mobile').val(),
                    mail: $('#mail').val(),
                    birth: $('#birth').val(),
                    adress: $('#adress').val(),
                    zipcode: $('#zipcode').val(),
                    gender: $('input[name=gender]:checked').val(),
                    adress2: $('#ADR_SangSoo').val()
                },
                dataType: 'text',
                success: function(data) {
                    if (data == 1) {
                        $('#userId,#password,#passwordCheck,#userName,#birth,#zipcode,#address,#mobile,#mail').val('');
                    } else {
                        alert("회원가입 실패");
                        $('#userId,#password,#passwordCheck,#userName,#birth,#zipcode,#address,#mobile,#mail').val('');
                    }
                }
            })
        }
    }

    function ADRshow() {
        new daum.Postcode({
            oncomplete: function(data) {
                console.log(data);
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var jibunAddr = data.jibunAddress; // 지번 주소 변수
                $('#zipcode').val(data.zonecode) // 우편번호 넣는코드
                if (roadAddr !== '') {
                    $('#adress').val(roadAddr)
                } else if (jibunAddr !== '') {
                    $('#adress').val(jibunAddr) //도로명이 없을경우 지번을 넣는다
                }
            }
        }).open();
    }
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 다음카카오 주소API 스크립트 -->

</html>