<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../include/head.jsp" %>
<style>
    .viewVolun {
        margin-top: 20px;
        padding: 20px;
        background-color: #f9f9f9;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .volunteer-table {
        width: 90%;
        border-collapse: collapse;
        margin-bottom: 20px;
        margin: auto;
    }

    .volunteer-table td {
        padding: 10px;
        border: 1px solid #ddd;
    }

    .volunteer-image {
        height: 150px;
        width: auto;
        max-width: 100%;
        margin: auto;
    }

    .volunteer-label {
        font-weight: bold;
    }

    .volunteer-value {
        color: #666;
    }

    .volunteer-title-cell,
    .volunteer-content-cell {
        padding: 15px;
        vertical-align: top;
    }

    .volunteer-link {
        text-decoration: none;
        color: inherit;
    }

    .volunteer-write-link {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #2a8890;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
        text-decoration: none;
    }

    .volunteer-write-link:hover {
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
<div class="viewVolun">
    <c:forEach items="${volunteerList}" var="list">
        <a href="volunteerView?page=${list.id}" class="volunteer-link">
            <table class="volunteer-table">
                <tr>
                    <td rowspan="4" class="volunteer-image-cell" style="width:200px; text-align: center; ">
                        <img src="../${list.img}" class="volunteer-image">
                    </td>
                    <td class="volunteer-label" style="width:15%;">지역</td>
                    <td class="volunteer-value" style="width:25%;">${list.adress}</td>
                    <td class="volunteer-label" style="width:15%;">모집단체</td>
                    <td class="volunteer-value" style="width:25%;">${list.agent}</td>
                </tr>
                <tr>
                    <td class="volunteer-label" style="width:15%;">모집기간</td>
                    <td class="volunteer-value" style="width:25%;">${list.recruitPeriod}</td>
                    <td class="volunteer-label" style="width:15%;">봉사기간</td>
                    <td class="volunteer-value" style="width:25%;">${list.volunteerPeriod}</td>
                </tr>
                <tr>
                    <td colspan="4" class="volunteer-title-cell">
                        ${list.title}
                    </td>
                </tr>
            </table>
        </a>
    </c:forEach>

    <a href="volunteerWrite" class="volunteer-write-link">등록하기</a>
</div>
	<%@ include file="../include/footer.jsp" %>
</body>

</html>