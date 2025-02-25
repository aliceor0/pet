<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <form id="posterForm" action="/catchWrite" method="Post">
    	<input type="hidden" class="post-id" name="postId" value="${catchInfo[0].id}">
    	<input type="hidden" class="animal-select" value="${catchInfo[0].type}">
    	<input type="hidden" class="area-select" value="${catchInfo[0].area}">
    	<input type="hidden" class="state-select" value="${catchInfo[0].state}">
        <label for="animal">발견동물 종류</label>
        <select class="animal" name="type">
            <option value="강아지">강아지</option>
            <option value="고양이">고양이</option>
            <option value="반려동물">그 외</option>
        </select>
        
        유형
        <label for="f_type">목격</label>
    	<input type="radio" name="state" class="watch" onclick="selectType()" value="목격" checked>
    	<label for="f_type">보호</label>
    	<input type="radio" name="state" class="protect" onclick="selectType()" value="보호">


        <label for="photoInput">사진첨부</label>
        <input type="file" onchange="readURL(this)" name="img">
        <img class="catch-image" >
        
                <label for="lostDateInput">발견/목격 날짜</label>
        <input type="date" class="catch-date-input" name="date" value="${catchInfo[0].date}" required>

        <label for="lostInfoInput">발견/목격 장소</label>
        <select class="area" name="area">
            <option value="">지역</option>
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
        <input type="text" class="catch-place-input" name="place" value="${catchInfo[0].place}" placeholder="예시)고양시 일산동구 xx마트 근처 등 " required>

        <label for="breedInfoInput">제목</label>
        <input type="text" class="title" name="title" value="${catchInfo[0].title}" required>

        <label for="situationInput">상세설명</label>
        <textarea class="content" name="content" rows="4" required>${catchInfo[0].content}</textarea>

        <label for="phoneNumberInput">연락처</label>
        <input type="text" class="phone-number-input" name="phoneNumber" value="${catchInfo[0].phone_number}" placeholder="010-1234-5678" required>

        <input type="submit" value="작성완료"><input type="button" value="취소">
    </form>
    <%@ include file="../include/footer.jsp" %>
</body>

<script>
$(document)
.ready(function(){
	selectType();
	
    let animalSetting = $('.animal-select').val();
    $('.animal option').filter(function() {
        return $(this).val() === animalSetting;
    }).prop('selected', true);
    
    let areaSetting = $('.area-select').val();
    $('.area option').filter(function() {
        return $(this).val() === areaSetting;
    }).prop('selected', true);
    
    let stateSetting = $('.state-select').val();
    $('input[name="state"]').filter(function() {
        return $(this).val() === stateSetting;
    }).prop('checked', true);
    
})

function readURL(input) {
    if (input.files && input.files[0]) {
        let reader = new FileReader();
        reader.onload = function(e) {
            $('.catch-image').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        $('.catch-image').attr('src', '');
    }
}

function selectType() {
    if ($('.watch').is(':checked')) {
        $('.title').prop('placeholder', "예시)흰색 말티즈 목격했습니다.");
        $('.content').prop('placeholder', "예시)오후 1시경 고양시 일산동구 xx마트 주차장에서 흰색 말티즈를 목격했습니다. 외관이 깨끗하고 목줄도 새것인걸로 보아 유기견이 아니라 애완견같습니다.");
    } else if ($('.protect').is(':checked')) {
        $('.title').prop('placeholder', "예시)흰색 말티즈 보호하고있습니다.");
        $('.content').prop('placeholder', "예시)오후 1시경 고양시 일산동구 xx마트 주차장에서 흰색 말티즈가 위험하게 차량사이로 돌아다녀 임시보호 중에있습니다. 주인분은 아래연락처로 연락주시기바랍니다.");
    }
}

</script>
</html>