<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../include/head.jsp" %>
	<style>
		
		.card {
		    flex: 0 0 calc(23% - 20px);
		    border: 1px solid #ccc;
		    border-radius: 10px;
		    overflow: hidden;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    background-color: #fff;
		    transition: transform 0.3s ease;
		}
		
		.card:hover {
		    transform: translateY(-5px);
		}
		
		.card-body {
		    height: 250px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
		
		.card-body img {
		    object-fit: cover;
		    max-width: 100%;
		    max-height: 100%;
		}
		
		.card-content p {
		    font-size: 18px;
		    color: #333;
		    padding: 5px;
		}
		
		table {
		    width: 100%;
		    border-collapse: collapse;
		    margin: 0 auto;
		}
		
		table, th, td {
		    border: 1px solid #ccc;
		}
		
		th, td {
		    padding: 10px;
		    text-align: left;
		}
		
		.filter-radio {
		    display: none;
		}
		
		.filter-label {
		    display: inline-block;
		    padding: 5px 15px;
		    cursor: pointer;
		    background-color: #e0e0e0;
		    border-radius: 5px;
		    transition: background-color 0.3s;
		}
		
		.filter-radio:checked + .filter-label {
		    background-color: #2a8890;
		    color: white;
		}
		
		.filter-select {
		    appearance: none;
		    -webkit-appearance: none;
		    -moz-appearance: none;
		    background-color: #ffffff;
		    border: 1px solid #ccc;
		    font-size: 16px;
		    border-radius: 5px;
		    cursor: pointer;
		    outline: none;
		    transition: border-color 0.3s, box-shadow 0.3s;
		}
		
		.filter-select:hover {
		    border-color: #2a8890;
		}
		
		.filter-select:focus {
		    border-color: #2a8890;
		    box-shadow: 0 0 5px rgba(42, 136, 144, 0.5);
		}
		
		.filter-select::-ms-expand {
		    display: none;
		}
		
		.filter-select::before {
		    content: '\25BC';
		    position: absolute;
		    right: 10px;
		    top: 50%;
		    transform: translateY(-50%);
		    color: #555;
		}
		
		.filter-select option:checked {
		    background-color: #e0e0e0;
		}
		
		.reset, .search {
		    color: white;
		    display: inline-block;
		    padding: 5px 15px;
		    cursor: pointer;
		    background-color: #2a8890;
		    border: none;
		    border-radius: 5px;
		    transition: background-color 0.3s;
		}
		
		.reset {
		    color: black;
		    background-color: #e0e0e0;
		}
		
		.page-box {
		    display: flex;
		    margin-top: 40px;
		    margin-bottom: 20px;
		}
		
		.search-box {
		margin-bottom: 40px;
		}
		
		.page-section {
		    flex: 1;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
		
		.page-section.left-section {
		    justify-content: flex-end;
		}
		
		.page-section.center-section {
		    justify-content: center;
		}
		
		.page-section.right-section {
		    justify-content: flex-start;
		}
		
		.page-btn {
		    padding: 5px;
		    background-color: #2a8890;
		    border: none;
		    border-radius: 5px;
		    height: 30px;
		    color: #FFFFFF;
		    margin: 0 5px;
		    text-decoration: none;
		}
		
		.page-btn.prev-next {
		    background-color: #3a9abf;
		}
		
		.page-btn.first-last {
		    background-color: #4aa9e0;
		}
		
		.current-page {
		    margin-right: 10px;
		    margin-left: 10px;
		}
		
		.now-page {
		    font-size: 120%;
		    font-weight: bold;
		    text-decoration: underline;
		    margin-right: 10px;
		    margin-left: 10px;
		}
	</style>
</head>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp" %>
		<!-- 중간 nav역할 -->
    <%@ include file="../include/lostHeader.jsp" %>


<div class="container mt-4">
	<div class="search-box">
		<form action="/lost" method="Get">
			<table>
			    <tr>
			        <td>상태</td>
			        <td>
			            <input type="radio" id="status_all" name="status" value="전체" class="filter-radio" ${status == null || status == '전체' ? 'checked' : ''}>
			            <label for="status_all" class="filter-label">전체</label>
			            <input type="radio" id="status_lost" name="status" value="5" class="filter-radio" ${status == '5' ? 'checked' : ''}>
			            <label for="status_lost" class="filter-label">실종</label>
			            <input type="radio" id="status_found" name="status" value="6" class="filter-radio" ${status == '6' ? 'checked' : ''}>
			            <label for="status_found" class="filter-label">찾음</label>
			        </td>
			        <td>실종동물</td>
			        <td>
			            <input type="radio" id="animal_all" name="animal" value="전체" class="filter-radio" ${animal == null || animal == '전체' ? 'checked' : ''}>
			            <label for="animal_all" class="filter-label">전체</label>
			            <input type="radio" id="animal_dog" name="animal" value="강아지" class="filter-radio" ${animal == '강아지' ? 'checked' : ''}>
			            <label for="animal_dog" class="filter-label">강아지</label>
			            <input type="radio" id="animal_cat" name="animal" value="고양이" class="filter-radio" ${animal == '고양이' ? 'checked' : ''}>
			            <label for="animal_cat" class="filter-label">고양이</label>
			            <input type="radio" id="animal_other" name="animal" value="그 외" class="filter-radio" ${animal == '그 외' ? 'checked' : ''}>
			            <label for="animal_other" class="filter-label">그 외</label>
			        </td>
			        <td>실종지역</td>
			        <td>
			            <select class="filter-select" name="area">
			                <c:set var="areas" value="전체,강원도,경기도,경상남도,경상북도,광주광역시,대구광역시,대전광역시,부산광역시,서울특별시,세종특별자치시,울산광역시,인천광역시,전라남도,전라북도,제주특별자치도,충청남도,충청북도"/>
			                <c:forEach var="areaName" items="${areas}">
			                    <option value="${areaName}" ${area == areaName ? 'selected' : ''}>${areaName}</option>
			                </c:forEach>
			            </select>
			        </td>
			        <td>정렬</td>
			        <td>
			            <select class="filter-select" name="sort">
			                <option value="newest" ${sort == 'newest' ? 'selected' : ''}>최신순</option>
			                <option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>오래된순</option>
			            </select>
			        </td>
			        <td>
			            <button class="search">검색</button>
			            <button class="reset">초기화</button>
			        </td>
			    </tr>
			</table>
		</form>
	</div>
<div style="text-align: right;">
    <a href="lostWrite">
        <button style="padding:5px; background-color:#2a8890; border:none; border-radius: 5px; height: 30px; color:#FFFFFF; ">실종글작성</button>
    </a>
</div>
    <div class="row">
        <!-- 상품 아이템 추가 -->
        <c:forEach items="${lostList}" var="list">
        <c:if test="${list.category == 5 or list.category == 6}">
        <div class="col-lg-3 col-md-6 mb-4">
            <a href="lostPoster?id=${list.id}" class="text-decoration-none">
            <div class="card h-100" style="border: 1px solid #ccc; margin-top: 15px;"> <!-- 수정된 부분: border와 margin-top 추가 -->
                <div class="card-body d-flex flex-column justify-content-center align-items-center" style="height: 250px;"> <!-- 수정된 부분: height 추가 및 d-flex, justify-content-center, align-items-center 추가 -->
                    <img style="object-fit: contain; height: auto; width: 100%; max-height: 100%;" src="${list.img}" alt="실종동물"/> <!-- 수정된 부분: height, width, max-height 추가 -->
                </div>
                <div class="card-content p-3 d-flex flex-column justify-content-center align-items-center" style="border-top: 1px solid #ccc; padding-left: 15px; padding-right: 15px;"> <!-- 수정된 부분: text-center, padding, d-flex, flex-column, justify-content-center, align-items-center, padding-left, padding-right 추가 및 border-top 추가 -->
                    <p><b>지&nbsp;&nbsp;&nbsp;&nbsp;역</b>&nbsp;&nbsp;${list.area}</p>
                    <p><b>장&nbsp;&nbsp;&nbsp;&nbsp;소</b>&nbsp;&nbsp;${list.place}</p>
                    <p><b>날&nbsp;&nbsp;&nbsp;&nbsp;짜</b>&nbsp;&nbsp;${list.date}</p>
                    <c:if test="${list.reward != null}">
										    <fmt:formatNumber value="${list.reward}" pattern="###,###" var="formattedReward"/>
										    <p style="color:red;"><b>사례금</b>&nbsp;&nbsp;${formattedReward}원</p>
                    </c:if>
                    <c:if test="${list.reward == null}">
                        <p>&nbsp;</p>
                    </c:if>
                </div>
            </div>
            </a>
        </div>
        </c:if>
        </c:forEach>
    </div>
<div class="page-box">
    <!-- 첫 번째 영역: 오른쪽 정렬 -->
    <div class="page-section left-section">
        <c:if test="${page != 1}">
            <button id="first" class="page-btn first-last" value="1">처음으로</button>
        </c:if>
        
        <c:if test="${page != 1}">
            <button id="before" class="page-btn prev-next" value="${page}">이전</button>
        </c:if>
    </div>

    <!-- 두 번째 영역: 가운데 정렬 -->
    <div class="page-section center-section">
        <c:forEach var="num" items="${pageNumber}">
            <c:choose>
                <c:when test="${num == page}">
                    <div class="now-page">${num}</div>
                </c:when>
                <c:otherwise>
                    <a href="/lost?page=${num}" class="current-page">${num}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>

    <!-- 세 번째 영역: 왼쪽 정렬 -->
    <div class="page-section right-section">
        <c:if test="${page != lastpage}">
            <button id="next" class="page-btn prev-next" value="${page}">다음</button>
        </c:if>
        
        <c:if test="${page != lastpage}">
            <button id="last" class="page-btn first-last" value="${lastpage}">마지막</button>
        </c:if>
    </div>
</div>
</div>

<!-- 부트스트랩 및 부트스트랩 JS 및 Popper.js 추가 -->
	<%@ include file="../include/footer.jsp" %>
</body>
<script>
$(document).ready(function() {
    $('.card-body').each(function() {
        let cardHeight = $(this).outerHeight();
        let imgHeight = $(this).find('img').outerHeight();

        if (imgHeight < cardHeight) {
            var padding = (cardHeight - imgHeight) / 2;
            $(this).css('padding-top', padding + 'px');
            $(this).css('padding-bottom', padding + 'px');
        }
    });

    $("#first").on("click", function() {
        movePage(1);
    });
    
    $("#before").on("click", function() {
        let currentPage = parseInt($("#before").attr('value'));
        if (currentPage > 1) {
            movePage(currentPage - 1);
        }
    });
    
    $("#next").on("click", function() {
        let currentPage = parseInt($("#next").attr('value'));  // 이 부분을 확인해주세요.
        let lastPage = parseInt($("#last").attr('value'));
        if (currentPage < lastPage) {
            movePage(currentPage + 1);
        }
    });
    
    $("#last").on("click", function() {
        let lastPage = parseInt($("#last").attr('value'));
        movePage(lastPage);
    });
});

$(".reset").on("click", function() {
	$("#status_all").prop("checked", true);
	$("#animal_all").prop("checked", true);
	$(".filter-select[name='area']").val('전체');
	$(".filter-select[name='sort']").val('전체');
	location.href = '/lost';
});

function movePage(pageNum) {
    let status = "${sessionScope.status}";
    let animal = "${sessionScope.animal}";
    let area = "${sessionScope.area}";
    let sort = "${sessionScope.sort}";
    console.log(pageNum)
    let url = '/lost?page=' + pageNum; 
    
    if (status !== '') url += '&status=' + status;
    if (animal !== '') url += '&animal=' + animal;
    if (area !== '') url += '&area=' + area;
    if (sort !== '') url += '&sort=' + sort;
    
    location.href = url;
}
</script>
</html>