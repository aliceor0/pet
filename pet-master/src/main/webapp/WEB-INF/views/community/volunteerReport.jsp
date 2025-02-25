<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/head.jsp" %>
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
        <c:forEach items="${lostList}" var="list">
        <div class="col-lg-3 col-md-6 mb-4">
            <a href="lostPoster?id=${list.id}" class="text-decoration-none">
            <div class="card h-100" style="border: 1px solid #ccc; margin-top: 15px;"> <!-- 수정된 부분: border와 margin-top 추가 -->
                <div class="card-body d-flex flex-column justify-content-center align-items-center" style="height: 250px;"> <!-- 수정된 부분: height 추가 및 d-flex, justify-content-center, align-items-center 추가 -->
                    <img style="object-fit: contain; height: auto; width: 100%; max-height: 100%;" src="/image/${list.img}" alt="실종동물"/> <!-- 수정된 부분: height, width, max-height 추가 -->
                </div>
                <div class="card-content p-3 d-flex flex-column justify-content-center align-items-center" style="border-top: 1px solid #ccc; padding-left: 15px; padding-right: 15px;"> <!-- 수정된 부분: text-center, padding, d-flex, flex-column, justify-content-center, align-items-center, padding-left, padding-right 추가 및 border-top 추가 -->
                    <p>지역 : ${list.area}</p>
                    <p>장소 : ${list.place}</p>
                    <p>날짜 : ${list.date}</p>
                    <c:if test="${list.reward != null}">
                        <p>사례금 : ${list.reward}</p>
                    </c:if>
                    <c:if test="${list.reward == null}">
                        <p>&nbsp;</p>
                    </c:if>
                </div>
            </div>
            </a>
        </div>
        </c:forEach>
    </div>
</div>
	
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>