<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/head.jsp" %>
					<style>
    .main {
        max-width: 1200px;
        margin: 50px auto;
        padding: 20px;
        background-color: #f4f4f4;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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

    #middle_area2 {
        width: 100%;
        margin: 0 auto;
        padding: 0 15px;
    }

    @media (max-width: 768px) {
        #title {
            font-size: 16px;
        }

        #category {
            font-size: 16px;
        }

        #txtContent {
            font-size: 14px;
        }

        #se2_sample input[type="button"] {
            font-size: 16px;
        }
    }
    </style>
</head>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp" %>
		<!-- 중간 nav역할 -->
  <%@ include file="../include/mallHeader.jsp" %>

<main>
    <div class="container mt-4">
        <div id="middle_top">
            <h1 class="middle_top_title">Pet Mall</h1>
            <hr class="middle_top_hr">
        </div>
        <div id="middle_area2">
            <div class="row" style="width: 100%; margin: 0 auto; padding: 0 15px;">
                <section class="module-small">
                    <c:forEach items="${petAll}" var="item">
                        <a href="/detail?id=${item.id}">
                            <div class="col-lg-3 col-md-6 mb-4" item="${item.id}">
                                <div class="card h-100" style="border: 1px solid #ccc; margin-top: 15px;">
                                    <div class="card-body d-flex flex-column justify-content-center align-items-center" style="height: 250px;">
                                        <img style="object-fit: contain; height: auto; width: 100%; max-height: 100%;" src="/image_mall/title_img/${item.img1}" alt="상품이미지"/>
                                    </div>
                                    <div class="card-content p-3 d-flex flex-column justify-content-center align-items-center" style="border-top: 1px solid #ccc; height: 100px; padding-left: 15px; padding-right: 15px;">
									    <div style="padding-top: 20px;">
									        <h4 class="shop-item-title font-alt">${item.title}</h4>
									    </div>
									    <div style="padding-top: 20px;">
									        ₩ <fmt:formatNumber pattern="###,###,###" value="${item.price}"/>
									    </div>
                                    </div> <!-- 제목과 링크 -->
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </section>
            </div>
        </div>
    </div>
</main>
  <footer>
	<%@ include file="../include/footer.jsp"%>
</footer>
</body>
</html>