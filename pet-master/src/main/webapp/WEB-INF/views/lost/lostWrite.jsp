<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

	<%@ include file="../include/head.jsp" %>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<style>
    .main-write-box {
        display: flex;
        justify-content: center;
        align-items: center;;
        margin: 50px auto;
        padding: 20px;
        width: 80%;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .lost-poster{
        width: 45%;
        margin: 0 2.5%;
        
    }
    
    .lost-write {
    width: 45%;
    margin: 0 2.5%;
    padding: 20px;  /* 패딩 추가 */
	}
    
    .lost-poster table, 
    .lost-write table {
        width: 100%;
        border-collapse: collapse;
        
    }

    .lost-poster table h1.title {
        font-size: 4em;
        color: #333;
        text-align: center;
    }


    .lost-poster table img.poster-image {
        width: auto;
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
        padding: 0;  /* 패딩 제거 */
        margin: 0;  /* 마진 제거 */
        text-align: center;
    }

    .lost-poster table td:last-child {
        font-weight: bold;
        vertical-align: middle;
    }

	.lost-write form table td {
	    text-align: left;
	    border-bottom: 1px solid black;
	    margin-bottom: 10xp;  /* 아래쪽 간격 추가 */
	    word-wrap: break-word;
	}
	
	.lost-write p {
	    margin-top: 10px;
	}


	.lost-write form table td input[type="text"], 
	.lost-write form table td input[type="date"], 
	.lost-write form table td input[type="number"], 
	.lost-write form table td textarea,
	.lost-write form table td select {
	    width: 100%;  /* 너비 100%로 변경 */
	    border-radius: 5px;
	    border: 1px solid black;  /* 검정색 실선 */
	    margin-bottom: 15px;  /* 아래쪽 간격 추가 */
	}

	.lost-write form table td input[type="submit"], 
	.lost-write form table td input[type="button"] {
	    padding: 10px 20px;
	    border: none;
	    border-radius: 5px;
	    background-color: #007bff;
	    color: #fff;
	    cursor: pointer;
	    transition: background-color 0.3s;
	}

    .lost-write form table input[type="submit"]:hover, 
    .lost-write form table input[type="button"]:hover {
        background-color: #0056b3;
    }
    
    #saveButton
     {
        width: 48%;
        padding: 10px;
        background-color: #2a8890; /* 애용하는 초록색 */
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 10px;
    }
    
    #cancelButton{
        width: 48%;
        padding: 10px;
        background-color: gray;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 10px;
    }

    #cancelButton {
        margin-left: 10px;
    }
</style>
	
</head>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp" %>
	
    <!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp" %>
<% if (name == null) { %> 
	<c:redirect url="/login"></c:redirect>
<%} else {%>
		<!-- 중간 nav역할 -->
    <%@ include file="../include/lostHeader.jsp" %>
  <input type="hidden" class="category-id" value="5">
  <div class="main-write-box">
      <div class="lost-poster" style="width: 600px; height: 100%; ">
          <div style="background-image: url('/image/title-part.jpg'); background-size: 100% auto; background-size: cover;  width: 600px; height: 100%;">
          	<table>
            <tr style="height: 110px;">
            	<td colspan="3"  style="vertical-align: middle;">
                	<h1 class="title" style="color:white">강아지를 찾습니다</h1>
                </td>
            </tr>
            </table>
          </div>
			<div style="background-image: url('/image/img-part.jpg'); overflow: hidden; background-size: 100% auto; background-size: cover;  width: 600px; height: 270px;">
			    <table style="width: 100%; height: 270px;">
			        <tr style="height: 100%;">
			            <td colspan="2" style="height: 100%;"><img class="poster-image"></td>
			        </tr>
			    </table>
			</div>
			<div style="background-image: url('/image/title-part.jpg'); background-size: 100% auto; background-position: center; width: 600px; height: 100%;">
				<table>
					<tr style="height: 40px;">
		                <td colspan="2"><h2 class="description" style="color:white">품종(성별/나이/색상/이름)</h2></td>
		            </tr>
		            <tr style="height: 10px;">
		                <td colspan="2"><h3 class="dateAndPlace" style="color:white">xx월 xx일 어디에서 실종</h3></td>
		            </tr>
				</table>
			</div>
            <div style="background-image: url('/image/img-part.jpg'); background-size: 100% auto; background-position: center; width: 600px; height: 100%;">
            	<table>
		            <tr style="height: 25px;">
		                <td style="width: 25%">실종날짜</td>
		                <td class="date"></td>
		            </tr>
		            <tr style="height: 25px;">
		                <td>실종장소</td>
		                <td class="place"></td>
		            </tr>
		            <tr style="height: 25px;">
		                <td>사례금</td>
		                <td class="reward"></td>
		            </tr>
		            <tr style="height: 90px;">
		                <td>특징 및 경위</td>
		                <td class="content"></td>
		            </tr>
		            <tr style="height: 20px;">
		                <td colspan="2" style="color:white">가족들이 애타게 찾고있습니다. 목격하시면 꼭 연락부탁드려요</td>
		            </tr>
            	</table>
            </div>
			<div style="background-image: url('/image/title-part.jpg'); background-size: 100% auto; background-position: center; width: 600px; height: 100%;">
				<table>
					<tr style="height: 60px;">
		            	<td colspan="2"style="color:white"><h2 class="phoneNumber" style="color:white">010-1234-5678</h2></td>
		            </tr>
		            <tr style="height: 25px;">
		            	<td colspan="2" style="color:white"><h4>비슷한 강아지를 보신 분 꼭 연락 바랍니다.</h4></td>
		            </tr>
	          </table>
			</div>
      </div>
      <div class="lost-write">
        <form id="posterForm" action="/lostWrite" method="Post">
          <table>
            <tr>
              <td>
                <p><label for="animal">실종동물 종류</label></p>
                <select class="animal" name="type">
                  <option value="강아지를 찾습니다!">강아지</option>
                  <option value="고양이를 찾습니다!">고양이</option>
                  <option value="반려동물을 찾습니다!">그 외</option>
              </select>
              </td>
            </tr>
            <tr>
              <td>
                <p><label for="photoInput">사진첨부</label></p>
                <input type="file" onchange="readURL(this);" name="img">                
              </td>
            </tr>
            <tr>
              <td>
                <p><label for="breedInfoInput">눈에 띄는 특징</label></p>
                <input type="text" id="breedInfoInput" name="description" placeholder="품종/성별/나이/색상/이름 등" required>
              </td>
            </tr>
            <tr>
              <td>
                <p><label for="lostInfoInput">실종날짜/장소</label></p>
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
              <input type="text" id="lostInfoInput" name="dateAndPlace" placeholder="xx월 xx일 어디에서 실종" required>
              </td>
            </tr>
            <tr>
              <td>
                <p><label for="lostDateInput">실종날짜</label></p>
                <input type="date" id="lostDateInput" name="date" required>
              </td>
            </tr>
            <tr>
              <td>
                <p><label for="lostPlaceInput">구체적인 실종장소</label></p>
                <input type="text" id="lostPlaceInput" name="place" placeholder="어디어디아파트" required>
              </td>
            </tr>
            <tr>
              <td>
                <p><label for="rewardInput">사례금</label></p>
                <input type="radio" name="status" value="0" class="noReward" onclick="selectReward()" checked>없음
                <input type="radio" name="status" value="1" class="yesReward" onclick="selectReward()">있음
                <input type="number" id="rewardInput" name="reward" disabled required>만원
              </td>
            </tr>
            <tr>
              <td>
                <p><label for="contentInput">특징과 경위</label></p>
                <textarea id="contentInput" name="content" rows="4" placeholder="성별/나이/크기/색상/당시특징" required></textarea>
              </td>
            </tr>
            <tr>
              <td>
                <p><label for="phoneNumberInput">연락처</label></p>
                <input type="text" id="phoneNumberInput" name="phoneNumber" placeholder="010-1234-5678" required>
              </td>
            </tr>
            <tr>
              <td>
                <input type=button id="saveButton" value="작성완료"><a href="lost"></a> <input type="button" id="cancelButton" value="취소">
              </td>
            </tr>
          </table>
        </form>
      </div>
  </div>
  <footer>
  	<%@ include file="../include/footer.jsp" %>
  </footer>
    
 <%}%>
</body>

<script>
$(document).ready(function() {
    $('#saveButton').click(function() {
        html2canvas(document.querySelector(".lost-poster"), {
            logging: true,
            useCORS: true,
            scrollY: -window.scrollY,
            scrollX: -window.scrollX,
            scale: 1
        }).then(canvas => {
            let imageData = canvas.toDataURL("image/jpeg", 1.0).split(',')[1];  // set quality to 1.0

            $.ajax({
                url: '/save-image',
                type: 'POST',
                data: JSON.stringify({ imageData: imageData }),
                contentType: 'application/json',
                success: function(response) {
                    if (response.success) {
                        alert(response.message);
                        location.href = "/lost";
                    } else {
                        alert(response.message);
                    }
                },
                error: function() {
                    alert('Error saving the image');
                }
            });
        });
    });
})

/* $(document)
.ready(function(){
	
}) */

.on('change', '.animal', function() {
    $('.title').text($(this).val());
})

.on('keyup', '#breedInfoInput, #lostInfoInput, #lostDateInput, #lostPlaceInput, #rewardInput, #contentInput, #phoneNumberInput', function() {
    $('.description').text($('#breedInfoInput').val());
    $('.dateAndPlace').text($('#lostInfoInput').val());
    $('.date').text($('#lostDateInput').val());
    $('.place').text($('#lostPlaceInput').val());
    $('.reward').text($('#rewardInput').val());
    $('.content').text($('#contentInput').val())
    $('.phoneNumber').text($('#phoneNumberInput').val())
})

function readURL(input) {
    if (input.files && input.files[0]) {
        let reader = new FileReader();
        reader.onload = function(e) {
            $('.poster-image').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        $('.poster-image').attr('src', '');
    }
}

function selectReward() {
    if ($('.noReward').is(':checked')) {
        $('#rewardInput').val('');
        $('.reward').val('');
        $('#rewardInput').prop('disabled', true);
        $('.reward').val('이부분은 노출되지 않습니다.');
    } else if ($('.yesReward').is(':checked')) {
        $('#rewardInput').prop('disabled', false);
    }
}

</script>
</html>