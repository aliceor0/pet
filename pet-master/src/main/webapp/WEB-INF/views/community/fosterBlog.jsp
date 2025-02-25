<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/head.jsp" %>
	<style>
.main {
    max-width: 1200px;
    margin: 50px auto;
    padding: 20px;
    background-color: #f4f4f4;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    
}

.page-box {
    text-align: center;
    margin-top: 30px;
    margin-bottom: 30px;
}

.page-box button {
    padding: 10px 20px;
    margin: 0 5px;
    background-color: #2a8890;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

.page-box button:hover {
    background-color: #0056b3;
}

.card {
    flex: 0 0 calc(20% - 20px);
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
    height: 70px;
    
}

#title {
    width: 80%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 18px;
}

#category {
    width: 19%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 18px;
}

#titlefileInput,
#fileInput {
    margin-bottom: 20px;
}

#titleImagePreview {
    max-width: 100%;
    height: auto;
    margin-top: 10px;
}

#imageContainer {
    margin-bottom: 20px;
}

#txtContent {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    resize: vertical;
}

#se2_sample input[type="button"] {
    padding: 10px 20px;
    background-color: #2a8890;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 18px;
    transition: background-color 0.3s ease;
}

#se2_sample input[type="button"]:hover {
    background-color: #0056b3;
}

.divTitle {
    text-align: center;
    margin-bottom: 30px;
}

.title1 h1 {
    font-size: 36px;
    margin: 0;
}

.title1 p {
    font-size: 24px;
    margin: 0;
}

.search-box {
    background-color: #f4f4f4;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-top: 30px;
}

.search-box p {
    margin-bottom: 10px;
}

.search-box input[type="radio"] {
    margin-right: 10px;
}

.search-box button {
    padding: 10px 20px;
    background-color: #2a8890;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 18px;
    transition: background-color 0.3s ease;
}

.search-box button:hover {
    background-color: #0056b3;
}

@media (max-width: 768px) {
    #title, #category {
        font-size: 16px;
    }

    #txtContent, #se2_sample input[type="button"] {
        font-size: 14px;
    }
}
#home, #parcelWrite {
    padding: 10px 20px;
    background-color: #2a8890;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

#home:hover,
#parcelWrite:hover {
    background-color: #0056b3;
}
</style>
</head>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp" %>
		<!-- 중간 nav역할 -->
    <%@ include file="../include/communityHeader.jsp" %>
	
<div class="container mt-4">
    <div class="row">
        <!-- 상품 아이템 추가 -->
        <c:forEach items="${blogList}" var="list">
        <div class="col-lg-3 col-md-6 mb-4">
            <a href="view?id=${list.id}" class="text-decoration-none">
            <div class="card h-100" style="border: 1px solid #ccc; margin-top: 15px;"> <!-- 수정된 부분: border와 margin-top 추가 -->
                <div class="card-body d-flex flex-column justify-content-center align-items-center" style="height: 250px;"> <!-- 수정된 부분: height 추가 및 d-flex, justify-content-center, align-items-center 추가 -->
                    <img style="object-fit: contain; height: auto; width: 100%; max-height: 100%;" src="${list.title_img}" alt="블로그"/> <!-- 수정된 부분: height, width, max-height 추가 -->
                </div>
                <div class="card-content p-3 d-flex flex-column justify-content-center align-items-center" style="border-top: 1px solid #ccc; padding-left: 15px; padding-right: 15px;"> <!-- 수정된 부분: text-center, padding, d-flex, flex-column, justify-content-center, align-items-center, padding-left, padding-right 추가 및 border-top 추가 -->
                    <p>${list.title}</p>
                </div>
            </div>
            </a>
        </div>
        </c:forEach>
    </div>
    <a href="/community/new">글 작성하기</a>
</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>