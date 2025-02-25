<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
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

		.page-box {
		    display: flex;
		    margin-top: 40px;
		    margin-bottom: 20px;
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
    <%@ include file="../include/adoptionHeader.jsp" %>
<!-- <header><a hred="/adoptionTmpLogin"></a>로그인</header> -->
<div class="container mt-4">
  <h2>입양사진 및 후기</h2>
  <!-- 검색버튼은 돋보기 이미지로 교체할 것 -->
<!--   <input type="text"><button>검색</button> -->
  <hr>
<div style="text-align: right;">
    <a href="/adoption/new">
        <button style="padding:5px; background-color:#2a8890; border:none; border-radius: 5px; height: 30px; color:#FFFFFF; ">글쓰기</button>
    </a>
</div>
  <!-- 페이지당 4x5 (20개)씩 -->
  <!-- table명 작성 후 ajax로 append(?) -->
    <div class="row">
        <!-- 상품 아이템 추가 -->
        <c:forEach items="${reviewList}" var="list">
      			<div class="col-lg-3 col-md-6 mb-4">
          			<a href="/adoption/reviews/${list.id}" class="text-decoration-none">
            			<div class="card h-100" style="border: 1px solid #ccc; margin-top: 15px;"> <!-- 수정된 부분: border와 margin-top 추가 -->
                			<div class="card-body d-flex flex-column justify-content-center align-items-center" style="height: 250px;"> <!-- 수정된 부분: height 추가 및 d-flex, justify-content-center, align-items-center 추가 -->
                    			<img style="object-fit: contain; height: auto; width: 100%; max-height: 100%;" src="${list.title_img}" alt="실종동물"/> <!-- 수정된 부분: height, width, max-height 추가 -->
                			</div>
                		<div class="card-content p-3 d-flex flex-column" style="border-top: 1px solid #ccc; height: 100px; padding-left: 7px; padding-right: 7px;"> <!-- 수정된 부분: text-center, padding, d-flex, flex-column, justify-content-center, align-items-center, padding-left, padding-right 추가 및 border-top 추가 -->
                    	  <table style="width: 100%;">
                    			<tr>
                    				<td colspan=2 style="height: 75px; vertical-align: top;">
                    					<p>${list.title}</p>
                    				</td>
                    			</tr>
                    			<tr>
                    				<td style="font-size: 80%;">
                    					${list.nickname}
                    				</td>
                    				<td style="text-align: right; font-size: 80%;">
                    					${list.created}
                    				</td>
                    			</tr>
                    		</table>
                		</div>
            		</div>
            		</a> 
        		</div>
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
                    <a href="/adoption/reviews?page=${num}" class="current-page">${num}</a>
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
 	<%@ include file="../include/footer.jsp" %>
</body>
<script>
$(document).ready(function() {
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

function movePage(pageNum) {
    let url = '/adoption/reviews?page=' + pageNum; 
    
    location.href = url;
}
</script>
</html>