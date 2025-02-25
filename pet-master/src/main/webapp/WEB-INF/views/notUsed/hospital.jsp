<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../include/head.jsp" %>
<style>
   
  .hospital {
    border: 1px solid #ccc;
    padding: 10px;
    margin-bottom: 10px;
  }
  .hospital h3 {
    margin-top: 0;
  }
  .closed {
    color: red;
  }
</style>
</head>
<body id="page-top">
	<!-- 상단 네비게이션바 정보 헤더에 포함 -->
		<%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
		<%@ include file="../include/sitemap.jsp" %>
		<!-- 중간 nav역할 -->
    <%@ include file="../include/informationHeader.jsp" %>
    <div class="container">
<h1>경기도 동물병원 정보</h1>
<div style="display: flex;">
<div  id="map" style="width:100%;height:400px;"></div>
<div  id="hospitalList"></div>
</div>
<div id="AllhospitalList"></div>
</div>
<%@ include file="../include/footer.jsp" %>
</body>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6aa768f02fed854a1146c9f2dac841be"></script>
<script>

$(document).ready(function() {
    initMap(); // 지도 초기화
    fetchData(); // 데이터 불러오기

});

var infowindow = new kakao.maps.InfoWindow({zIndex:1});
var map; // map 변수를 전역으로 선언하여 다른 함수에서도 접근할 수 있도록 합니다.

function initMap() {
    var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng(37.6525840286,126.8910463832), // 초기 지도 중심 위치를 설정합니다.
        level: 3 // 초기 지도 확대/축소 레벨을 설정합니다.
    };

    map = new kakao.maps.Map(container, options); // 전역 변수 map을 초기화합니다.
}

function fetchData() {
    let url = 'https://openapi.gg.go.kr/Animalhosptl?KEY=d6725354882e4f1480e77fda61dfd226';

	$.ajax({
        url: url,
        type: 'GET',
        dataType: 'xml',
        success: function(data) {
            parseData(data);
            apiData(data);
        },
        error: function(xhr, status, error) {
            console.error("API 호출 실패:", error);
        }
    });
}



 function parseData(data) {
    $(data).find('row').each(function() {
        let row = $(this);
        let bizplcName = row.find('BIZPLC_NM').text();
        let sigunName = row.find('SIGUN_NM').text();      
        let licensgDate = row.find('LICENSG_DE').text();
        let bizState = row.find('BSN_STATE_NM').text();
        let telNo = row.find('LOCPLC_FACLT_TELNO').text();
        let address = row.find('REFINE_LOTNO_ADDR').text();
        let latitude = parseFloat(row.find('REFINE_WGS84_LAT').text()); // 위도 정보를 실수형으로 변환
        let longitude = parseFloat(row.find('REFINE_WGS84_LOGT').text()); // 경도 정보를 실수형으로 변환
    
     // 폐업이나 말소인 경우 데이터 처리를 건너뜁니다.
        if (bizState === '폐업' || bizState === '말소') {
            return; // 해당 반복문을 중단하고 다음 반복문으로 넘어갑니다.
        } 

        // 동물병원 위치에 마커 표시
        var markerPosition = new kakao.maps.LatLng(latitude, longitude);
        var marker = new kakao.maps.Marker({
            position: markerPosition,
            map: map // map에 마커를 표시합니다.
        });

        // 마커를 클릭하면 인포윈도우에 동물병원 이름을 표시합니다.
        kakao.maps.event.addListener(marker, 'click', function() {
            // 해당 동물병원의 정보를 옆에 표시합니다.
            showHospitalInfo(bizplcName, sigunName, licensgDate, bizState, telNo, address);
            // 마커를 클릭하면 인포윈도우에 동물병원 이름을 표시합니다.
            infowindow.setContent('<div style="font-size:15px;">' + bizplcName +"</div>");
            	/* 	"<p><strong>" + bizplcName + "</strong></p>" +
                      "<p><strong>전화번호:</strong> " + telNo + "</p>" +
                      "<p><strong>주소:</strong> " + address + "</p>" +
        			"</div>"); */
            infowindow.open(map, marker);
        });
   
        
    });
}
 
//해당 동물병원의 정보를 표시하는 함수
 function showHospitalInfo(bizplcName, sigunName, licensgDate, bizState, telNo, address) {
     // 동물병원 정보를 나타내는 div에 해당 동물병원의 모든 정보를 추가합니다.
     var hospitalHtml = "<div class='hospital'>" +
         "<h3>" + bizplcName + "</h3>" +
         "<p><strong>시군명:</strong> " + sigunName + "</p>" +
       /*   "<p><strong>시군코드:</strong> " + sigunCode + "</p>" + */
         "<p><strong>면허발급일:</strong> " + licensgDate + "</p>"+
         "<p><strong>업태상태:</strong> " + bizState + "</p>"+
         "<p><strong>전화번호:</strong> " + telNo + "</p>" +
         "<p><strong>주소:</strong> " + address + "</p>" +
         "</div>";

     $('#hospitalList').html(hospitalHtml);
    
 }
 
 function apiData(data) {
	    $(data).find('row').each(function() {
	        let row = $(this);
	        let sigunName = row.find('SIGUN_NM').text(); //시군명
	        let sigunCode = row.find('SIGUN_CD').text(); // 시군코드
	        let bizplcName = row.find('BIZPLC_NM').text(); //업체명
	        let licensgDate = row.find('LICENSG_DE').text(); // 면허발급일
	        let bizState = row.find('BSN_STATE_NM').text(); // 업체상태
	        let telNo = row.find('LOCPLC_FACLT_TELNO').text(); // 전화번호
	        let address = row.find('REFINE_LOTNO_ADDR').text();//주소
	        let latitude = row.find('REFINE_WGS84_LAT').text(); //위도
	        let longitude = row.find('REFINE_WGS84_LOGT').text(); //경도

	        let AllhospitalHtml = "<div class='hospital'>" +
	            "<h3>" + bizplcName + "</h3>" +
	            "<p><strong>시군명:</strong> " + sigunName + "</p>" +
	            "<p><strong>시군코드:</strong> " + sigunCode + "</p>" +
	            "<p><strong>면허발급일:</strong> " + licensgDate + "</p>";

	        // 업태상태가 '말소'인 경우에는 다른 스타일로 표시
	        if (bizState === '말소' || bizState === '폐업') {
	        	AllhospitalHtml += "<p class='closed'><strong>업태상태:</strong> " + bizState + "</p>";
	        } else {
	        	AllhospitalHtml += "<p><strong>업태상태:</strong> " + bizState + "</p>";
	        }

	        AllhospitalHtml += "<p><strong>전화번호:</strong> " + telNo + "</p>" +
	            "<p><strong>주소:</strong> " + address + "</p>" +
	            "<p><strong>위도:</strong> " + latitude + "</p>" +
	            "<p><strong>경도:</strong> " + longitude + "</p>" +
	            "</div>";

	        $("#AllhospitalList").append(AllhospitalHtml);
	    });
	} 







</script> 
</html>
