<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/head.jsp" %>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<style>
    .viewVol {
        margin-top: 20px;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .volunteer-info-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .volunteer-info-table td {
        padding: 10px;
        border: 1px solid #ddd;
    }

    .poster-image {
        max-width: 400px;
        max-height: 300px;
        width: auto;
        height: auto;
    }

    .volunteer-label {
        font-weight: bold;
    }

    .complete-button {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .complete-button:hover {
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
<div class="viewVol container">
    <table class="volunteer-info-table">
        <tr>
            <td class="volunteer-label">제목</td>
            <td>${Info[0].title}</td>
            <td class="volunteer-label">대표이미지</td>
            <td>
                <img class="poster-image" src="${Info[0].img}">
            </td>
        </tr>
        <tr>
            <td class="volunteer-label">모집기관</td>
            <td>${Info[0].agent}</td>
            <td class="volunteer-label">주소</td>
            <td>${Info[0].adress}</td>
        </tr>
        <tr>
            <td class="volunteer-label">담당자 이름</td>
            <td>${Info[0].name}</td>
            <td class="volunteer-label">담당자 연락처</td>
            <td>${Info[0].phone_number}</td>
        </tr>
        <tr>
            <td class="volunteer-label">모집기간</td>
            <td>${Info[0].recruitPeriod}</td>
            <td class="volunteer-label">봉사기간</td>
            <td>${Info[0].volunteerPeriod}</td>
        </tr>
        <tr>
            <td class="volunteer-label">활동가능일</td>
            <td>${Info[0].date}</td>
            <td class="volunteer-label">활동가능시간</td>
            <td>${Info[0].time}</td>
        </tr>
        <tr>
            <td class="volunteer-label">홍보페이지</td>
            <td colspan="3">${Info[0].home_page}</td>
        </tr>
        <tr>
            <td colspan="4" class="volunteer-label">상세설명</td>
        </tr>
        <tr>
            <td colspan="4">${Info[0].content}</td>
        </tr>
    </table>
    <button class="complete-button">모집완료</button>
</div>
    	<%@ include file="../include/footer.jsp" %>
</body>
</html>