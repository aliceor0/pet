<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
<style>
.main {
    max-width: 1200px;
    margin: 50px auto;
    padding: 20px;
    background-color: #f4f4f4;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.page-box {
    text-align: center;
    margin-top: 30px;
    margin-bottom: 30px;
}

.page-box button {
    padding: 10px 20px;
    margin: 0 5px;
    background-color: #2a8890;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

.page-box button:hover {
    background-color: #0056b3;
}

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
    font-size: 20px; /* 글씨 크기 조절 */
    color: #333;
    font-weight: bold;
    padding: 10px; /* 패딩 추가 */
}

#title {
    width: 80%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 18px;
}

#category {
    width: 19%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 18px;
}

#titlefileInput,
#fileInput {
    margin-bottom: 20px;
}

#titleImagePreview {
    max-width: 100%;
    height: auto;
    margin-top: 10px;
}

#imageContainer {
    margin-bottom: 20px;
}

#txtContent {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    resize: vertical;
}

#se2_sample input[type="button"] {
    padding: 10px 20px;
    background-color: #2a8890;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 18px;
    transition: background-color 0.3s ease;
}

#se2_sample input[type="button"]:hover {
    background-color: #0056b3;
}

.divTitle {
    text-align: center;
    margin-bottom: 30px;
}

.title1 h1 {
    font-size: 36px;
    margin: 0;
}

.title1 p {
    font-size: 24px;
    margin: 0;
}

.search-box {
    background-color: #f4f4f4;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-top: 30px;
}

.search-box p {
    margin-bottom: 10px;
}

.search-box input[type="radio"] {
    margin-right: 10px;
}

.search-box button {
    padding: 10px 20px;
    background-color: #2a8890;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 18px;
    transition: background-color 0.3s ease;
}

.search-box button:hover {
    background-color: #0056b3;
}

@media (max-width: 768px) {
    #title, #category {
        font-size: 16px;
    }

    #txtContent, #se2_sample input[type="button"] {
        font-size: 14px;
    }
}
#home, #parcelWrite {
    padding: 10px 20px;
    background-color: #2a8890;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

#home:hover,
#parcelWrite:hover {
    background-color: #0056b3;
}
</style>
</head>

<body id="page-top">
	<!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp"%>
	<!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp"%>
	<%@ include file="../include/parcelOutHeader.jsp"%>
<div class="container mt-4">
	
	<input type=hidden value="${page}" id="goNext">
	<input type=hidden value="${page}" id="goBefore">
	<input type=hidden value="${lastpage}" id="goLast">
	
	
<div class="search-box">
    <form action="/parcelOutList" method="Get">
        <p>
            <input type="radio" name="type" value="1" <c:if test="${empty sessionScope.type}">checked</c:if>>전체
            <input type="radio" name="type" value="강아지" <c:if test="${sessionScope.type == '강아지'}">checked</c:if>>강아지
            <input type="radio" name="type" value="고양이" <c:if test="${sessionScope.type == '고양이'}">checked</c:if>>고양이
        </p>
        <p>
            <input type="radio" name="category" value="1" <c:if test="${empty sessionScope.category}">checked</c:if>>전체
            <input type="radio" name="category" value="2" <c:if test="${sessionScope.category == 2}">checked</c:if>>분양중
            <input type="radio" name="category" value="3" <c:if test="${sessionScope.category == 3}">checked</c:if>>예약중
            <input type="radio" name="category" value="4" <c:if test="${sessionScope.category == 4}">checked</c:if>>분양종료
        </p>
        <button>검색</button>
    </form>
</div>
<%-- 	<c:if test="${sessionScope.name != null}"> --%>
<!-- 		<div> -->
<!-- 			<button id="chat">회원 채팅하기</button> -->
<!-- 		</div> -->

<%-- 	</c:if> --%>
<div class="container mt-4">
	<div class="row">
			<c:forEach items="${alist}" var="list">
			<div class="col-lg-3 col-md-6 mb-4">
				 <div id="${list.id}" class="card h-100" style="border: 1px solid #ccc; margin-top: 15px;">
					<div class="card-body d-flex flex-column justify-content-center align-items-center" style="height: 250px; display: flex;">
						<img src="${list.image}" style="object-fit: contain; height: auto; width: 100%; max-height: 100%;">
					</div>
					<div class="card-content p-3 d-flex flex-column justify-content-center align-items-center" style="border-top: 1px solid #ccc; padding-left: 15px; padding-right: 15px;">
						<c:if test="${list.category==2}">
							<span style="background-color: #FFCCCC;display: inline-block; text-align: center; width: 100%;"><b>분양중</b></span>
						</c:if>
						<c:if test="${list.category==3}">
							<span style="background-color: #FFDDDD;display: inline-block; text-align: center; width: 100%;"><b>예약중</b></span>
						</c:if>
						<c:if test="${list.category==4}">
							<span style="background-color: #E0E0E0;display: inline-block; text-align: center; width: 100%;"><b>분양종료</b></span>
						</c:if>
						<p>종류: ${list.type}</p>
						<p>성별: ${list.gender}</p>
<%-- 						<p>몸무게: ${list.weight}</p> --%>
						<p>나이: ${list.age}</p>
						<p>색상: ${list.color}</p>
						<p>예비이름: ${list.temporary_name}</p>
					</div>
				</div>
			</div>
			</c:forEach>
	</div>
</div>
	
	
<div class="page-box">
    <button id="first" value="1">처음으로</button>
    
    <c:if test="${page != 1}">
        <button id="before" value="${page - 1}">이전</button>
    </c:if>
    
    <c:forEach var="num" items="${pageNumber}">
        <c:choose>
            <c:when test="${empty sessionScope.type and empty sessionScope.category}">
                <a href="/parcelOutList?page=${num}"><b>${num}</b></a>
            </c:when>
            <c:otherwise>
                <a href="/parcelOutList?page=${num}&type=${sessionScope.type}&category=${sessionScope.category}"><b>${num}</b></a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    
    <c:if test="${page != lastpage}">
        <button id="next" value="${page + 1}">다음</button>
    </c:if>
    
    <button id="last" value="${lastpage}">마지막</button>
</div>

	<div>
		<p>
			<button id="home">홈으로</button>
			<c:if test="${sessionScope.name != null}">
				<button id="parcelWrite">분양 등록하기</button>
			</c:if>
		</p>
	</div>
	</div>
<footer>
	<%@ include file="../include/footer.jsp"%>
</footer>
</body>

<script>
$(document)
.ready(function() {
    $("#first").on("click", function() {
        movePage(1);
    });
    
    $("#before").on("click", function() {
        movePage(parseInt($(this).val()));
    });
    
    $("#next").on("click", function() {
        movePage(parseInt($(this).val()));
    });
    
    $("#last").on("click", function() {
        movePage(parseInt($(this).val()));
    });
    
})


	//분양 등록 하기
	.on("click", "#parcelWrite", function() {
		location.href = '/parcelWrite'
	})
	
	//자세히 보기
  .on('click', '.card', function() {
      let str = $(this).attr('id');
      console.log(str);
      location.href = '/showDetail?id=' + str
   })

	.on("click", "#home", function() {
		location.href = '/'
	})
	.on('click', '#chat', function() {
		openChat()
	})
	
function movePage(page) {
    let type = "${sessionScope.type}";
    let category = "${sessionScope.category}";
    
    let url = '/parcelOutList?page='+page
    
    if (type && category) {
        url += '&type='+type + '&category='+category
    }
    
    location.href = url;
}

	function openChat() {
		// 팝업 창을 띄우는 함수
		let url = '/room'
		var popup = window.open(url, "Popup", "width=800,height=800");
	}
</script>
</html>