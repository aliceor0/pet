<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp" %>
    <style>

    .card {
        display: flex;
        flex-direction: row;
        border: 1px solid #ccc; /* 카드 테두리 */
        border-radius: 8px; /* 카드 모서리 둥글게 */
        overflow: hidden;
         box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
   		 background-color: #fff;
        transition: transform 0.3s ease;
    }
	    .card:hover {
	    transform: translateY(-5px);
	}

    .card-img {
        flex: 0 0 auto; /* 유연한 크기로 설정하지 않음 */
        width: 300px; /* 이미지 원래 크기 유지 */
        height: 350px; /* 이미지 높이 자동 조절 */
        border-radius: 8px 8px 8px 8px; /* 왼쪽 모서리만 둥글게 */
    }

	/* 카드 본문 */
    .card-body {
        flex: 1; /* 나머지 영역을 채우기 위해 확장 */
        display: flex; /* 내용을 가로로 정렬하기 위해 */
        flex-direction: column; /* 세로로 배치하기 위해 */
        justify-content: center; /* 내용을 수직 가운데로 정렬하기 위해 */
        padding: 20px; /* 내부 여백 */
    }
    
        /* 카드 제목 */
    .card-body p:first-child {
        font-size: 24px; /* 제목 글꼴 크기 */
        font-weight: bold; /* 제목 글꼴 두껍게 */
        margin-bottom: 10px; /* 제목 아래 여백 */
    }
 
        .footer-links {
        text-align: right; /* 링크 우측 정렬 */
    }

    .footer-links a {
        margin-left: 20px; /* 링크 간격 조절 */
    }

</style>
</head>
<body>

<!-- 상단 네비게이션바 정보 헤더에 포함 -->
<%@ include file="../include/header.jsp" %>
<!-- 우측 햄버거버튼에 관한 정보 -->
<%@ include file="../include/sitemap.jsp" %>
<!-- 중간 nav역할 -->
<%@ include file="../include/mallHeader.jsp" %>

<div class="container">
    <div class="row">
        <!-- 서버에서 받은 정보를 반복하여 출력 -->
        <c:forEach var="partner_board" items="${alpartner}">
            <!-- 각각의 정보를 카드 형식으로 출력 -->
            <c:if test="${partner_board.category == 16}">
                <div class="card">
                    <img class="card-img" src="${partner_board.title_img}" alt="${partner_board.title}">
                    <div class="card-body">
                        <p>${partner_board.title}</p>
                        <p>${partner_board.content}</p>
                    </div>
                    <!-- 수정 링크 -->
                   <%--  <a href="/editPartner?id=${partner_board.id}">수정</a> &nbsp;&nbsp; --%>
                    <!-- 삭제 링크 -->
                    <a href="/partnerDelete_4?id=${partner_board.id}">삭제</a>&nbsp;
                </div>
            </c:if>
        </c:forEach>
    </div>

    <div class="footer-links">
        <a href="/partnerWrite_4">글쓰기</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="/partnerMain_4">제휴업체 리스트</a>
    </div>
</div>
<!-- 데이터 호출 -->
<!-- <div class="container mt-5"></div> -->


<%@ include file="../include/footer.jsp" %>
</body>


<script>



</script>
</html>
립니다.