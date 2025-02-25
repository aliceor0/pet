<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../include/head.jsp" %>
</head>
<body id="page-top">
    <%-- 상단 네비게이션바 정보 헤더에 포함 --%>
    <%@ include file="../include/header.jsp" %>
    <%-- 우측 햄버거버튼에 관한 정보 --%>
    <%@ include file="../include/sitemap.jsp" %>
    <%-- 중간 nav역할 --%>
    <%@ include file="../include/informationHeader.jsp" %>
<body>
<div class="container">
<div class="post-wrap-row">

		<div class="card">
            <div class="card-body">${view.title}</div> <!-- 이미지 표시 위치 -->
            <div class="card-body">${view.content}</div> <!-- 제목과 링크 -->
        </div>
 </div>
 <a href="/">강아지 훈련정보 리스트</a>
 	<a href="/infoUpdate_4?id=${board.id}">수정</a>
	<a href="/infoDelete_4?id=${board.id}">삭제</a>
	</div>
		<%@ include file="../include/footer.jsp" %>
</body>
</html>