<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/head.jsp" %>
<style>
    .container.main {
        max-width: 1200px;
        font-family: 'Arial', sans-serif;
    }
    
    .card {
        flex: 0 0 calc(23% - 20px);
        border: 1px solid #ccc;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        transition: transform 0.3s ease;
    }
    
    .card:hover {
        transform: translateY(-5px);
    }
    
    .card-body {
        height: 250px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .card-body img {
        object-fit: cover;
        max-width: 100%;
        max-height: 100%;
    }

    .card-content p {
        font-size: 20px; /* 글씨 크기 조절 */
        color: #333;
        font-weight: bold;
        padding: 10px; /* 패딩 추가 */
    }
	
</style>
</head>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp" %>
	<!-- 중간 nav역할 -->
    <%@ include file="../include/informationHeader.jsp" %>
<div class="container mt-4">
    <div class="row">
        <!-- 서버에서 받은 정보를 반복하여 출력 -->
        <c:forEach var="board" items="${alinfo}">
        <div class="col-lg-3 col-md-6 mb-4">
            <!-- 각각의 정보를 카드 형식으로 출력 -->
            <c:if test="${board.category eq '13'}">
			    <a href="/information/animal/${board.id}" class="text-decoration-none">
			</c:if>
			<c:if test="${board.category eq '14'}">
			    <a href="/information/traning/${board.id}" class="text-decoration-none">
			</c:if>
            <div class="card h-100" style="border: 1px solid #ccc; margin-top: 15px;"> 
                <div class="card-body d-flex flex-column justify-content-center align-items-center" style="height: 250px;">
                    <img style="object-fit: contain; height: auto; width: 100%; max-height: 100%;" src="${board.title_img}" alt="${board.title}">
                </div>    
                <div class="card-content p-3 d-flex flex-column justify-content-center align-items-center" style="border-top: 1px solid #ccc; height: 100px; padding-left: 15px; padding-right: 15px;">
               		<p>${board.title}</p>
                </div> <!-- 제목과 링크 -->
            </div>
            </a>
           </div>
        </c:forEach>
    </div>

     <a href="/information/new">글쓰기</a>
     <a href="/information">훈련 및 정보 메인</a>
</div>
		<%@ include file="../include/footer.jsp" %>
</body>

<script>
    // 필요에 따라 JavaScript 코드 추가
</script>
</html>