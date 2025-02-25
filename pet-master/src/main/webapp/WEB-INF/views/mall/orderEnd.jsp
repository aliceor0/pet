<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈</title>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
<%@ include file="../include/head.jsp"%>
</head>

<body>
<div id="container">
	<%@ include file="../include/header.jsp"%>
	<!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp"%>
  </div>
  <main id="main">
    <div id="mainContent"> 
    각 html바디부분 여기서부터 붙여넣으시면 됩니다.body태그말고요
        <div style="width: 100%; text-align: center; font-size: 40px;">
        <a href="/">홈으로</a>
        <a href="/myOrderList">주문내역보기</a>
    </div>
	</div>
  </main>
  
  <footer>
	<%@ include file="../include/footer.jsp"%>
</footer>
</body>
</html>