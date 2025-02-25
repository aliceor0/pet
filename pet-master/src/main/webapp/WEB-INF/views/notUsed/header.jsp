<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String) session.getAttribute("name");
String id = (String) session.getAttribute("id");
%>
<div>
    <div style="text-align: right;padding: 0 30px 0 0;">
        <% if (name == null) { %>
        <a href="/login" class="menuBar">로그인</a>
        <a href="/signup" class="menuBar">회원가입</a>
        <% } else { %>
        <a><%=name%>님 반갑습니다.</a>
        <a href="#" class="menuBar" id=do_logout>로그아웃</a>
        <% } %>
    </div>
    <div style="text-align: center;">
        <h1><a href="/Jhome">유기통</a></h1>
    </div>
</div>
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
    $(document)
        .on('click', '#do_logout', function() {
            $.ajax({
                type: 'post',
                url: '/logout',
                data: {},
                dataType: 'text',
                success: function(data) {
                    if (data == '1') {
                        location.href = "/Jhome";
                    }
                }
            })
            return false;
        })
</script>