<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="../include/head.jsp" %>
        <style>
          table {
            border-collapse: collapse;
            width: 100%;
          }
        
          th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
          }
        
          th {
            background-color: #f2f2f2;
          }

	</style>
</head>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp" %>
		<!-- 중간 nav역할 -->
    <%@ include file="../include/lostHeader.jsp" %>
    <input type="hidden" class="category-id" value="2">
        <table>
          <tr>
            <td>발견동물 종류</td>
            <td>${animalInfo[0].type}</td>
            <td>유형</td>
            <td>${animalInfo[0].state}</td>
          </tr>
          <tr>
            <td>발견날짜</td>
            <td>${animalInfo[0].date}</td>
            <td>지역, 상세장소</td>
            <td>${animalInfo[0].area}${animalInfo[0].place}</td>
          </tr>
          <tr>
            <td>등록인</td>
            <td>${animalInfo[0].user_id}</td>
            <td>등록인 연락처</td>
            <td>${animalInfo[0].phone_number}</td>
          </tr>
          <tr>
            <td>제목</td>
            <td colspan="3">${animalInfo[0].title}</td>
          </tr>
          <tr>
            <td>사진</td>
            <td colspan="3"><img src="${animalInfo[0].date}"></td>
          </tr>
          <tr>
            <td>상세설명</td>
            <td colspan="3">${animalInfo[0].content}</td>
          </tr>
          <tr>
          	<td colspan="4">
          		<a href="/catch"><button>홈으로</button></a>
           		<!-- <form action="/catchWrite" method="GET"> -->
          			<input type="hidden" class="post-id" name="postId" value="${animalInfo[0].id}">
	          		<button name="update" value="1">수정</button>
	          		<button name="delete" value="2">삭제</button>
          		<!-- </form> -->
          </tr>
		</table>
		<%@ include file="../include/comment.jsp" %>

    <footer>
    	<%@ include file="../include/footer.jsp" %>
    </footer>
</body>
</html>