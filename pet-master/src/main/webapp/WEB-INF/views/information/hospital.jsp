<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../include/head.jsp" %>
    <style>
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

    <h1>동물병원 및 보호소 정보</h1>
    
    <input type="text" id="searchInput" placeholder="장소 검색">
	<button id="searchButton">검색</button>
    <div style="display: flex;">
        <div id="map" style="width:100%;height:400px;"></div>
        <div id="hospitalList"></div>
        <div id="shelterList"></div>
    </div>
    <div id="searchResults"></div>
    <div id="AllhospitalList"></div>
    <div id="AllShelterList"></div>
    </div>


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
            let hospitalUrl = 'https://openapi.gg.go.kr/Animalhosptl?KEY=b37ef1d1d8be43e0b78587b9cab38ffe&pIndex=';
            let shelterUrl = 'http://apis.data.go.kr/1543061/animalShelterSrvc/shelterInfo?serviceKey=nRyADypS2Q72SjKzOjQ0a3EsieIfk1zNGTps%2BYx%2B2Be%2Bn8MJAcqulmbI4A%2BoViy%2BUP%2F1kBW97QTk%2Fua4Y2WMdA%3D%3D&pageNo=';
            let totalRequests = 100;

            // Fetch hospital data
            for (let i = 1; i <= totalRequests; i++) {
                let hurl = hospitalUrl + i;

                $.ajax({
                    url: hurl,
                    type: 'GET',
                    dataType: 'xml',
                    success: function(data) {
                        HospitalData(data);
                        parseHData(data);
                    },
                    error: function(xhr, status, error) {
                        console.error("Hospital API 호출 실패:", error);
                    }
                });
            }

            // Fetch shelter data
            for (let i = 1; i <= totalRequests; i++) {
                let surl = shelterUrl + i;

                $.ajax({
                    url: surl,
                    type: 'GET',
                    dataType: 'xml',
                    success: function(data) {
                        ShelterData(data);
                        parseSData(data);
                    },
                    error: function(xhr, status, error) {
                        console.error("Shelter API 호출 실패:", error);
                    }
                });
            }
        }

        function parseHData(data) {
            $(data).find('row').each(function() {
	               // 파싱 로직 추가
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
	               	$('#shelterList').hide();
	               	$('#hospitalList').show();
	              	  	
	
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

        function parseSData(data) {
            $(data).find('item').each(function() {
	                // 파싱 로직 추가
	            	let item = $(this); // 'item' 변수 정의
	                let careNm = item.find('careNm').text();
	                let orgNm = item.find('orgNm').text();
	                let divisionNm = item.find('divisionNm').text();
	                let careTel = item.find('careTel').text();
	                let saveTrgtAnimal = item.find('saveTrgtAnimal').text();
	                let careAddr = item.find('careAddr').text();
	                let jibunAddr = item.find('jibunAddr').text();
	                let latitude = parseFloat(item.find('lat').text());
	                let longitude = parseFloat(item.find('lng').text()); 
	          
	                   
	                // 보호센터 위치에 마커 표시
	                var markerPosition = new kakao.maps.LatLng(latitude, longitude);
	                var marker = new kakao.maps.Marker({
	                    position: markerPosition,
	                    map: map // map에 마커를 표시합니다.
	                });
	               
	
	                
	                kakao.maps.event.addListener(marker, 'click', function() {
	                	  $('#hospitalList').hide();
	                	  $('#shelterList').show();
	                	showShelterInfo(careNm,divisionNm,saveTrgtAnimal,careAddr,careTel);
	                	infowindow.setContent('<div style="font-size:15px;">' + careNm +"</div>");
	                	infowindow.open(map, marker);
	               /*  // 새로운 보호센터 정보를 생성하여 #shelterList에 추가
	                let shelterInfo = "<div class='shelter-info'>" +
	                      "<h3>" + careNm + "</h3>"+
	                      "<p><strong>관할구역:</strong>" + orgNm +"</p>"+
	                      "<p><strong>구분:</strong>" + divisionNm + "</p>"+
	                      "<p><strong>보호 동물:</strong>" + saveTrgtAnimal + "</p>"+
	                      "<p><strong>주소:</strong> " + careAddr + "</p>"+
	                      "<p><strong>지번 주소:</strong>" + jibunAddr + "</p>"+
	                      "</div>"; */
	                // $('#shelterList').append(shelterInfo);
	            });
            });
        }

        function showHospitalInfo(bizplcName, sigunName, licensgDate, bizState, telNo, address) {
            // 동물병원 정보를 나타내는 div에 해당 동물병원의 모든 정보를 추가합니다.
            // 표시 로직 추가
        	 let hospitalHtml = "<div class='hospital'>" +
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

        function showShelterInfo(careNm, divisionNm, saveTrgtAnimal, careAddr, careTel) {
            // 보호센터 정보를 나타내는 div에 해당 보호센터의 모든 정보를 추가합니다.
            // 표시 로직 추가
        	let shelterInfo = "<div class='shelter-info'>" +
            "<h3>" + careNm + "</h3>"+
            //"<p><strong>관할구역:</strong>" + orgNm +"</p>"+
            "<p><strong>구분:</strong>" + divisionNm + "</p>"+
            "<p><strong>보호 동물:</strong>" + saveTrgtAnimal + "</p>"+
            "<p><strong>연락처:</strong>" + careTel + "</p>"+
            "<p><strong>주소:</strong> " + careAddr + "</p>"+
            //"<p><strong>지번 주소:</strong>" + jibunAddr + "</p>"+
            "</div>";
        	 $('#shelterList').html(shelterInfo);
        }

        function ShelterData(data) {
            // 보호센터 데이터 파싱 및 표시 로직 추가
            $(data).find('item').each(function() {
                let item = $(this); // Define 'item' variable
                let careNm = item.find('careNm').text();
                let orgNm = item.find('orgNm').text();
                let divisionNm = item.find('divisionNm').text();
                let saveTrgtAnimal = item.find('saveTrgtAnimal').text();
                let careTel = item.find('careTel').text();
                let careAddr = item.find('careAddr').text();
                let jibunAddr = item.find('jibunAddr').text();
                
        /*         // Check if it's a hospital or shelter
                if (divisionNm === '동물병원') {
                    // Skip if it's a hospital
                    return;
                } */
                
                // Create new shelter info and append to #AllShelterList
                let AllshelterInfo = "<div class='shelter-info'>" +
                      "<h3>" + careNm + "</h3>"+
                      "<p><strong>기관 이름:</strong>" + orgNm +"</p>";

                if (divisionNm === '동물병원') {
                    AllshelterInfo += "<p class='closed'><strong>구분:</strong> " + divisionNm + "</p>";
                } else {
                    AllshelterInfo += "<p><strong>구분:</strong> " + divisionNm + "</p>";
                }
                      
                AllshelterInfo +=  "<p><strong>보호 동물:</strong>" + saveTrgtAnimal + "</p>"+
                      "<p><strong>연락처:</strong>" + careTel + "</p>"+
                      "<p><strong>주소:</strong> " + careAddr + "</p>"+
                      "<p><strong>지번 주소:</strong>" + jibunAddr + "</p>"+
                      "</div>";
                
                $('#AllShelterList').append(AllshelterInfo);
            });
        }

        function HospitalData(data) {
            // 동물병원 데이터 파싱 및 표시 로직 추가
        	$(data).find('row').each(function() {
                let row = $(this);
                let sigunName = row.find('SIGUN_NM').text(); //시군명
                let sigunCode = row.find('SIGUN_CD').text(); // 시군코드
                let bizplcName = row.find('BIZPLC_NM').text(); //업체명
                let licensgDate = row.find('LICENSG_DE').text(); // 면허발급일
                let bizState = row.find('BSN_STATE_NM').text(); // 업체상태
                let telNo = row.find('LOCPLC_FACLT_TELNO').text(); // 전화번호
                let address = row.find('REFINE_LOTNO_ADDR').text();//주소
                //let latitude = row.find('REFINE_WGS84_LAT').text(); //위도
                //let longitude = row.find('REFINE_WGS84_LOGT').text(); //경도

                let AllhospitalHtml = "<div class='hospital'>" +
                    "<h3>" + bizplcName + "</h3>" +
                    "<p><strong>시군명:</strong> " + sigunName + "</p>" +
                    "<p><strong>시군코드:</strong> " + sigunCode + "</p>" +
                    "<p><strong>면허발급일:</strong> " + licensgDate + "</p>";

                // 업태상태가 '말소'인 경우에는 다른 스타일로 표시
                if (bizState === '말소' || bizState === '폐업') {
                	return;
                	//AllhospitalHtml += "<p class='closed'><strong>업태상태:</strong> " + bizState + "</p>";
                } else {
                	//AllhospitalHtml += "<p><strong>업태상태:</strong> " + bizState + "</p>";
                }

                AllhospitalHtml += "<p><strong>전화번호:</strong> " + telNo + "</p>" +
                    "<p><strong>주소:</strong> " + address + "</p>" +
                   // "<p><strong>위도:</strong> " + latitude + "</p>" +
                    //"<p><strong>경도:</strong> " + longitude + "</p>" +
                    "</div>";

                $("#AllhospitalList").append(AllhospitalHtml);
            });
        }
        
     // 검색 버튼 클릭 시 실행되는 함수
        document.getElementById('searchButton').addEventListener('click', function() {
            var keyword = document.getElementById('searchInput').value;
            
            // 장소 검색 객체를 생성합니다.
            var places = new kakao.maps.services.Places();

            // 키워드로 장소를 검색합니다.
            places.keywordSearch(keyword, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    // 검색 결과를 표시할 HTML 문자열 초기화
                    var html = "";

                    // 검색된 각 위치에 대해 처리
                    result.forEach(function(place) {
                        // 검색 결과를 표시할 HTML 문자열을 추가합니다.
                        html += "<p>" + place.place_name + "</p>"; // 예시: 검색된 장소의 이름을 추가
                    });

                    // 검색 결과를 화면에 표시합니다.
                    document.getElementById('searchResults').innerHTML = html;

                    // 첫 번째 검색 결과를 선택하여 지도에 표시합니다.
                    var firstPlace = result[0];
                    var latlng = new kakao.maps.LatLng(firstPlace.y, firstPlace.x);
                    map.setCenter(latlng); // 지도 중심을 첫 번째 검색 결과 위치로 이동합니다.
                } else {
                    alert('검색 결과가 없거나 검색에 실패했습니다.');
                }
            });
        });


    </script>
        <%@ include file="../include/footer.jsp" %>
</body>
</html>
