<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../include/head.jsp" %>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
    <style>
        /* 간단한 스타일링을 추가할 수 있습니다. */
body {
    font-family: Arial, sans-serif;
    margin: 20px;
    text-align: center;
}

.main-write-box {
    display: flex;
    justify-content: center; /* 가운데 정렬 */
    align-items: flex-start; /* 위로 정렬 */
    margin: 50px auto;
    padding: 20px;
    width: 80%;
    border: 1px solid #ccc;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.lost-poster, .witness-info {
    width: 45%;
    margin: 0 2.5%;
    float: left;
}

.lost-poster table {
    width: 100%;
    border-collapse: collapse;
}

.lost-poster table h1.title {
    font-size: 4em;
    color: #333;
    text-align: center;
}

.lost-poster table img.poster-image {
    width: 100%;
    height: 270px;
    object-fit: contain;
    border-radius: 10px;
}

.lost-poster table h2.description, 
.lost-poster table h3.date_and_place, 
.lost-poster table h2.phone-number {
    font-size: 1.5em;
    color: #555;
    text-align: center;
}

.lost-poster table td {
    padding: 0;  /* 패딩 제거 */
    margin: 0;  /* 마진 제거 */
    text-align: center;
    word-wrap: break-word;
}

.lost-poster table td:last-child {
    font-weight: bold;
    vertical-align: middle;
}

@media screen and (max-width: 1250px) {
    .lost-poster, .witness-info {
        width: 100%;
        float: none;
        margin: 2.5% 0;
    }
}

    .comment-list {
        background-color: #f7f7f7;
        border-radius: 8px;
        margin-bottom: 20px;
    }

    .comment {
        border-bottom: 1px solid #e0e0e0;
        margin-bottom: 15px;
    }

    .comment-header {
        background-color: #2a8890;
        color: white;
        display: flex;
        align-items: center;
        padding: 10px;
        border-radius: 8px 8px 0 0;
    }

    .comment-name {
        flex: 1;
        text-align: left;
    }

    .comment-actions {
        flex: 1;
        text-align: right;
    }

    .comment-date {
        background-color: #f0f0f0;
        padding: 10px;
        text-align: left;
        border-radius: 0 0 8px 8px;
    }

    .comment-content {
        padding: 20px;
        margin-top: 15px;
        border-radius: 8px;
        background-color: #ffffff;
        text-align: left;
    }

    .content-input {
        flex: 4;
        width: 90%;
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 10px;
    }

    .btn-comment {
        flex: 1;
        width: 10%;
        background-color: #2a8890;
        border: none;
        border-radius: 5px;
        color: white;
        cursor: pointer;
    }

    #showpage {
        text-align: center;
        margin-top: 20px;
    }

    #showpage button {
        margin: 0 5px;
        padding: 5px 15px;
        background-color: #2a8890;
        border: none;
        border-radius: 5px;
        color: white;
        cursor: pointer;
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
    
	<div class="main-write-box">
	<input type="hidden" class="post-id" value="${animalInfo[0].id}">
	<input type="hidden" class="category-id" value="2">
	
       <div class="lost-poster" style="width: 700px; height: 100%;">
       	<img src="image_lost/final_img/3p.jpg" style="width: 700px; height: auto;">
          <%-- div style="background-image: url('/image/title-part.jpg'); background-size: 100% auto; background-size: cover;  width: 600px; height: 110px;">
          	<table>
            <tr style="height: 110px;">
            	<td colspan="3"  style="vertical-align: middle;">
                	<h1 class="title">${animalInfo[0].type}</h1>
                </td>
            </tr>
            </table>
          </div>
			<div style="background-image: url('/image/img-part.jpg'); overflow: hidden; background-size: 100% auto; background-size: cover;  width: 600px; height: 270px;">
			    <table style="width: 100%; height: 270px;">
			        <tr style="height: 100%;">
			            <td colspan="2" style="height: 100%;"><img class="poster-image" src="{animalInfo[0].img}"></td>
			        </tr>
			    </table>
			</div>
			<div style="background-image: url('/image/title-part.jpg'); background-size: 100% auto; background-position: center; width: 600px; height: 70px;">
				<table>
					<tr style="height: 40px;">
		                <td colspan="2"><h2 class="description">${animalInfo[0].description}</h2></td>
		            </tr>
		            <tr style="height: 10px;">
		                <td colspan="2"><h3 class="date_and_place">${animalInfo[0].date_and_place}</h3></td>
		            </tr>
				</table>
			</div>
            <div style="background-image: url('/image/img-part.jpg'); background-size: 100% auto; background-position: center; width: 600px; height: 200px;">
            	<table>
		            <tr style="height: 25px;">
		                <td style="width: 25%">실종날짜</td>
		                <td class="date">${animalInfo[0].date}</td>
		            </tr>
		            <tr style="height: 25px;">
		                <td>실종장소</td>
		                <td class="place">${animalInfo[0].place}</td>
		            </tr>
		        	<c:if test="${animalInfo[0].reward != null}">
		            <tr style="height: 25px;">
		                <td>사례금</td>
		                <td class="reward">${animalInfo[0].reward}</td>
		            </tr>
		            </c:if>
		            <tr style="height: 90px;">
		                <td>특징 및 경위</td>
		                <td class="content">${animalInfo[0].content}</td>
		            </tr>
		            <tr style="height: 20px;">
		                <td colspan="2">가족들이 애타게 찾고있습니다. 목격하시면 꼭 연락부탁드려요</td>
		            </tr>
            	</table>
            </div>
			<div style="background-image: url('/image/title-part.jpg'); background-size: 100% auto; background-position: center; width: 600px; height: 100px;">
				<table>
					<tr style="height: 60px;">
		            	<td colspan="2"><h2 class="phone-number">${animalInfo[0].phone_number}</h2></td>
		            </tr>
		            <tr style="height: 25px;">
		            	<td colspan="2"><h4>비슷한 강아지를 보신 분 꼭 연락 바랍니다.</h4></td>
		            </tr>
	          </table>
			</div> --%>
      </div>
        <div class="witness-info">
<!--         <button id="printButton">인쇄하기</button> -->
            <div>
                <%@ include file="../include/comment.jsp" %>
            </div>
        </div>
    </div>
</body>
<script>


/*     $(document).ready(function() {
        console.log("Document is ready.");
    });
    
    $(document).on('click', '#printButton', function() {
        console.log("진입");
        
        let content = $('.lost-poster').html();
        console.log(content);
        let popupWin = window.open('', '_blank', 'width=600,height=600');
        popupWin.document.open();
        popupWin.document.write(`
            <html>
            <head>
            <style>
            <style>

            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                text-align: center;
            }
            
            h1, h2, h3, h4, h5, h6, h7 {
                font-weight: 500;
                letter-spacing: -0.025em;
                margin: 0;
            }
            
            .main-write-box {
                display: flex;
                justify-content: center;
                align-items: flex-start;
                margin: 50px auto;
                padding: 20px;
                width: 80%;
                border: 1px solid #ccc;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .lost-poster {
                width: 45%;
                margin: 0 2.5%;
            }
            
            .lost-poster table {
                width: 100%;
                border-collapse: collapse;
            }

            .lost-poster table h1.title {
                font-size: 4em;
                color: #333;
                text-align: center;
            }

            .lost-poster table img.poster-image {
                width: 100%;
                height: 270px;
                object-fit: contain;
                border-radius: 10px;
            }

            .lost-poster table h2.description, 
            .lost-poster table h3.dateAndPlace, 
            .lost-poster table h2.phoneNumber {
                font-size: 1.5em;
                color: #555;
                text-align: center;
            }

            .lost-poster table td {
                padding: 0;
                margin: 0;
                text-align: center;
                word-wrap: break-word;
            }

            .lost-poster table td:last-child {
                font-weight: bold;
                vertical-align: middle;
            }


            @media print {
                body {
                    margin: 0;
                    padding: 0;
                }

                .main-write-box {
                    width: 100%;
                    margin: 0;
                    border: none;
                    box-shadow: none;
                }

                .lost-poster {
                    width: 100%;
                    margin: 0;
                }

                .lost-poster table h1.title {
                    font-size: 3em;
                }

                .lost-poster table img.poster-image {
                    height: auto;
                    max-width: 100%;
                }

                .lost-poster table h2.description, 
                .lost-poster table h3.dateAndPlace, 
                .lost-poster table h2.phoneNumber {
                    font-size: 1em;
                }

                .lost-poster table td {
                    padding: 5px;
                    margin: 0;
                    text-align: left;
                }

                .lost-poster table td:last-child {
                    font-weight: normal;
                }
            }
        </style>
        </style>
            </head>
            <body>${content}</body>
            </html>
        `);
        popupWin.document.body.innerHTML = content;
        popupWin.document.close();
        popupWin.print();
        popupWin.close();
    }); */
</script>
</html>