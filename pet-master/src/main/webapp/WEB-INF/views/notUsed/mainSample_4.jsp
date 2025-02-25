<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
		<%@ include file="../include/head.jsp" %>
		<style>
        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .card {
            flex: 0 0 calc(23% - 20px); /* 카드 너비를 조정하여 4개의 카드가 균등하게 배치됨 */
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .card-img {
            width: 100%;
            height: auto;
            border-radius: 5px 5px 0 0;
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
    <div class="container">
    <div class="row">
        <!-- 서버에서 받은 정보를 반복하여 출력 -->
        <c:forEach var="infoMain_4" items="${alinfo}">
            <!-- 각각의 정보를 카드 형식으로 출력 -->
            <div class="card">
                <a href="/infoView_4?info_id=${infoMain_4.info_id}">
                    <img class="card-img" src="${infoMain_4.title_img}" alt="${infoMain_4.info_title}">
                    <div class="card-body"><p>${infoMain_4.info_title}</p></div> <!-- 제목과 링크 -->
                </a>
            </div>
        </c:forEach>
    </div>

     <a href="/infoWrite_4">강아지훈련정보등록하기</a>
    <a href="/">infoMain</a>
    </div>
		<%@ include file="../include/footer.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
    
<script>
    // 필요에 따라 JavaScript 코드 추가
</script>
</html>


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
		<%@ include file="../include/head.jsp" %>
	<style>
    .post-wrap-row {
        display: flex;
    }  
    .card-body {
        margin: 10px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .card-img {
        background-size: contain;
        background-position: center;
        width: 8cm;
        height: 8cm;
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
    <!-- 서버에서 받은 정보를 반복하여 출력 -->
    <c:forEach var="information_board" items="${alinfo}" varStatus="loop">
        <!-- 4개의 요소를 가진 그룹을 생성 -->
          
	        <c:if test="${loop.index % 4 == 0}">
	            <div class="post-wrap-row">
	        </c:if>

	        <div class="card-body">
	            <a href="/infoView_4?id=${information_board.id}">
	                <div class="card-img" style="background-image: url(${information_board.title_img})"></div>
	                <div class="card-list">${information_board.title}
	                </div> <!-- 제목과 링크 -->
	            </a>
	        </div>

        <!-- 그룹 닫기 -->
        <c:if test="${loop.index % 4 == 3 or loop.last}">
            </div>
        </c:if>   
    
    </c:forEach>

    <a href="/infoWrite_4">정보등록하기</a>
    
    <a href="/">메인</a>
    
    <a href="/hospital">병원</a>
    

    <!-- JavaScript 라이브러리 추가 -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script>
        // 추가 스크립트 코드
    </script>
  	<%@ include file="../include/footer.jsp" %>
</body>
</html> --%>