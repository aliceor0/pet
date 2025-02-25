<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp" %>
<style>

.main .img {
    display: flex;
    justify-content: center;
    margin-bottom: 30px;
}

.main h2 {
    text-align: left; /* h2만 left로 변경 */
    margin-bottom: 30px;
}

.main ul {
    text-align: left;
    width: 80%;
    max-width: 800px;
    margin-bottom: 30px;
}

.main ul li {
    list-style-type: none;
    margin-bottom: 10px;
    font-size: 16px;
}

.main img {
    max-width: 100%;
    height: auto;
    margin-bottom: 30px;
}
</style>
</head>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
		<%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
		<%@ include file="../include/sitemap.jsp" %>
		<!-- 중간 nav역할 -->
    <%@ include file="../include/adoptionHeader.jsp" %>
<div class="container main">
<h2>| 입양자격</h2>
<ul>
  <li>책임입양이 가능한 18세 이상 신원확인 가능한 성인</li><br>
  <li>경제적 능력이 있고 반려동물을 사랑하는 가정</li><br>
  <li>입양후 1년간 5회 이내로 아이의 생활사진을 보내주실 수 있는 분</li><br>
</ul>
<br><br>
<h2>| 입양 전 체크리스트</h2>
<div class="img">
<img src="/img/AdoptionCheckList.jpg" style="width:800px">
  <!-- <ul>
    <li>반려동물을 맞이할 환경적 준비, 마음의 각오는 되어 있습니까?</li><br>
    <li>개, 고양이는 10년 이상 삽니다. 결혼, 임신,유학,이사 등으로 가정환경이 바뀌어도 한번 인연 맺은 동물은 끝까지 책임지고 보살피겠다는 결심이 섰습니까?</li><br>
    <li>모든 가족과의 합의는 되어 있습니까?</li><br>
    <li>반려동물을 기른 경험이 있습니까?</li><br>
    <li>내 반려동물을 위해 공부할 각오가 되어 있습니까?</li><br>
    <li>아플 때 적절한 치료를 해주고, 중성화수술(불임수술)을 실천할 수 있습니까?</li><br>
    <li>입양으로 인한 경제적 부담을 짊어질 의사와 능력이 있습니까?</li><br>
    <li>우리 집에서 키우는 다른 동물과 잘 어울릴 수 있을지 고민해보았습니까?</li><br>
  </ul> -->
<br><br>
<!-- 이미지로 변경할 것(.../resources/static/img/AdoptionProces.jpg) -->
</div>
<h2>| 입양절차</h2>
<div class="img">

<img src="/img/AdoptionProcess.jpg" style="width:800px">
  <!-- <ol>
    <li>공고확인</li><br>
    <li>방문상담</li><br>
    <li>아이와의 만남</li><br>
    <li>책임분양 계약서 작성</li>
  </ol> -->
<br><br><br>
<!-- 이미지로 변경할 것(.../resources/static/img/AdoptionCheckList.jpg) -->

<!-- 책임비(?) -->
<!-- <h2>| 책임비 안내</h2>
  <p>
    &emsp;책임비는 수익목적재분양, 재유기파양, 생산출산업자, 식용도용, 재정능력 없는 가정을 필터링하기 위한<br> &emsp;최소한의 장치입니다.<br>
    &emsp;책임비는 파양동물 보호 및 케어, 입양장려 캠페인, 유기견방지 캠페인 등에 쓰여집니다.<br>
    &emsp;아이에 따라 무료분양 또는 소정의 책임비가 부여됩니다.<br>
    &emsp;충분한 신뢰를 입증한 재입양 회원은 책임비가 면제될 수 있습니다.
  </p> -->
  </div>
  </div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>