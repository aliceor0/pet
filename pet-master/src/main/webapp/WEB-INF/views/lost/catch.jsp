<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../include/head.jsp" %>
</head>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp" %>
		<!-- 중간 nav역할 -->
    <%@ include file="../include/lostHeader.jsp" %>
<a href="catchWrite"><button>목격글작성</button></a>
	목격동물
	<select class="animal" name="type">
		<option value="">전 체</option>
		<option value="강아지를 찾습니다!">강아지</option>
		<option value="고양이를 찾습니다!">고양이</option>
		<option value="반려동물을 찾습니다!">그 외</option>
	</select>
	목격지역
    <select class="area" name="area">
        <option value="">지역전체</option>
        <option value="강원">강원도</option>
        <option value="경기">경기도</option>
        <option value="경남">경상남도</option>
        <option value="경북">경상북도</option>
        <option value="광주">광주광역시</option>
        <option value="대구">대구광역시</option>
        <option value="대전">대전광역시</option>
        <option value="부산">부산광역시</option>
        <option value="서울">서울특별시</option>
        <option value="세종">세종특별자치시</option>
        <option value="울산">울산광역시</option>
        <option value="인천">인천광역시</option>
        <option value="전남">전라남도</option>
        <option value="전북">전라북도</option>
        <option value="제주">제주특별자치도</option>
        <option value="충남">충청남도</option>
        <option value="충북">충청북도</option>
    </select>

<div class="container mt-4">
    <div class="row">
        <!-- 하나씩 추가 -->
        
        <c:forEach items="${catchList}" var="list">
        <c:if test="${list.category != 5}">
        <div class="col-lg-3 col-md-6 mb-4">
            <a href="catchPoster?id=${list.id}">
            <div class="card">
                <div class="card-body">
                    <img style="width: 100%; "src="/image_lost/title_img/${list.img}" alt="실종동물"/>
                </div>
                <div class="card-body">
                	<p>유형 : ${list.category}</p>
                    <p>지역 : ${list.area}</p>
                    <p>장소 : ${list.place}</p>
                    <p>날짜 : ${list.date}</p>
        			<p>제목 : ${list.title}</p>
                </div>
            </div>
            </a>
        </div>
        </c:if>
        </c:forEach>
    </div>
</div>

<!-- 부트스트랩 및 부트스트랩 JS 및 Popper.js 추가 -->

	<%@ include file="../include/footer.jsp" %>
</body>

</html>