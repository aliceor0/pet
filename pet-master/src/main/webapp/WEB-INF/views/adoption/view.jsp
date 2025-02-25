<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../include/head.jsp" %>
    <style>
			.btn-back, .btn-modify, .btn-delete {
	        padding: 10px 20px;
	        background-color: #2a8890;
	        color: white;
	        border: none;
	        border-radius: 4px;
	        cursor: pointer;
	        font-size: 18px;
	        transition: background-color 0.3s ease;
	    }
    </style>
</head>
<body id="page-top">
    <%-- 상단 네비게이션바 정보 헤더에 포함 --%>
    <%@ include file="../include/header.jsp" %>
    <%-- 우측 햄버거버튼에 관한 정보 --%>
    <%@ include file="../include/sitemap.jsp" %>
    <%-- 중간 nav역할 --%>
    <%@ include file="../include/adoptionHeader.jsp" %>
<input type=hidden value="1" class="category-id">
<input type=hidden value="${view.id}" class="post-id">
<div class="container mt-4" style="padding-left: 10px; padding-right: 10px;">
		<div class="title" style="font-size: 170%; font-weight: bold; margin-top: 30px;">
		    ${view.title}
		</div>
		<div class="info" style="display: flex; margin-top: 15px; margin-bottom: 5px;">
		    <div class="writer" style="flex: 1;">${view.nickname}</div>
		    <div class="created" style="flex: 1; text-align: right;">작성일 : ${view.created}</div>
		</div>
    <hr style="margin-top: 0; margin-bottom: 80px;">
    <div class="content" style="margin: auto;">
        ${view.content}
    </div>
    <hr>
    <%@ include file="../include/comment.jsp" %>
		<div style="display: flex; justify-content: space-between;">
		    <button class="btn-back" onclick="history.back()">돌아가기</button>
		    <div>
		        <c:if test="${sessionScope.name == view.nickname}">
		            <button class="btn-modify" style="margin-left: 10px;"><a href="/adoption/edite/${view.id}">수정</a></button>
		            <button class="btn-delete" style="margin-left: 10px;"><a href="/infoDelete_4?id=${view.id}">삭제</a></button>
		        </c:if>
		    </div>
		</div>
</div>
		<%@ include file="../include/footer.jsp" %>
</body>
</html>