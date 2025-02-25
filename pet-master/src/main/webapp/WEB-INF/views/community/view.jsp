<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../include/head.jsp" %>
        <style>

        .main {
            max-width: 1200px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }


        .card {
            width: 100%;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .card-body {
            padding: 20px;
            text-align: center;
        }


        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .card-body {
                padding: 15px;
            }
        }
        </style>
</head>
<body id="page-top">
    <%-- 상단 네비게이션바 정보 헤더에 포함 --%>
    <%@ include file="../include/header.jsp" %>
    <%-- 우측 햄버거버튼에 관한 정보 --%>
    <%@ include file="../include/sitemap.jsp" %>
    <%-- 중간 nav역할 --%>
    <%@ include file="../include/communityHeader.jsp" %>
<body>
<div class="container main">
<div class="post-wrap-row">

		<div class="card">
            <div class="card-body">${blogView[0].title}</div> <!-- 이미지 표시 위치 -->
            <div class="card-body">${blogView[0].content}</div> <!-- 제목과 링크 -->
        </div>
 </div>
 <a href="/fosterBlog">목록으로</a>
	</div>
		<%@ include file="../include/footer.jsp" %>
</body>
</html>