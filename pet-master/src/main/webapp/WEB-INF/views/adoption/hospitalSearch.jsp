<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=6aa768f02fed854a1146c9f2dac841be"></script>
<title>Animal Hospital Data Processing</title>
</head>
<body>
    <h1>경기도 동물병원 정보</h1>

    <!-- 지도 -->
    <div style="display: flex;">
        <div  id="map" style="width:100%;height:400px;"></div>
        <div  id="hospitalList"></div>
    </div>

    <!-- 검색창 -->
        <div style="display: none;">
            <label class="">시도</label>
            <select id="sido">
                <option value="">전체</option>
                <option value = "6110000">서울특별시</option>
                <option value = "6260000">부산광역시</option>
                <option value = "6270000">대구광역시</option>
                <option value = "6280000">인천광역시</option>
                <option value = "6290000">광주광역시</option>
                <option value = "5690000">세종특별자치시</option>
                <option value = "6300000">대전광역시</option>
                <option value = "6310000">울산광역시</option>
                <option value = "6410000">경기도</option>
                <option value = "6530000">강원특별자치도</option>
                <option value = "6430000">충청북도</option>
                <option value = "6440000">충청남도</option>
                <option value = "6540000">전북특별자치도</option>
                <option value = "6460000">전라남도</option>
                <option value = "6470000">경상북도</option>
                <option value = "6480000">경상남도</option>
                <option value = "6500000">제주특별자치도</option>
        </select> 
        </div>
        <div>
        <label class="">시군구</label>
        <select id="sigungu">
            <option value="">전체</option>
        </select>
        </div>
        <div>
            <label class="">업체명</label>
            <input type="text" id="orgNm">
        </div>
    </div>
    <div>
        <input type="button" id="btn" value="조회">
    </div>
    <hr>
    <div class="result"></div>
    <div class="paging"></div>

    <div id="AllhospitalList"></div>

<script>
// 영업상태 "정상" 데이터만 추출
let filtered = [];

$(document).ready(function(){
    initMap();      // 지도 초기화
    showArea();     // 검색창 시군구 

    pageCount();    // "운영 중"인 업체 필터
    enterPress();   // 업체명+Enter => '조회'
      
})

$(document).on('click', '#btn', function(e){
    // e.preventDefault();
    filtered.splice(0, filtered.length);
    let sigungu = getSigun();
    let orgNm = getOrgNm();
    // console.log("orgNm",orgNm)
    pageCount(sigungu,orgNm);
});


// 함수 모음(영업상태 "정상" 필터링)
function pageCount(sigungu,orgNm){
    let url = 'https://openapi.gg.go.kr/Animalhosptl?KEY=d6725354882e4f1480e77fda61dfd226&type=json';
    // console.log("sigungu",sigungu);

    $.ajax({
        url: url,
        type: 'GET',
        data: {
            SIGUN_NM:sigungu
        },
        dataType: 'json',
        success: function(data) {
            if(data.Animalhosptl == null) {
                alert("Not Found");
                $('#orgNm').val('');
            } else {
                let totalCount = parseInt(data.Animalhosptl[0].head[0].list_total_count);
                fetchData(url,totalCount,sigungu,orgNm)
            }
        }
    })
}

function fetchData(url,totalCount,sigungu,orgNm) {
    let pSize = 1000;

    let totalPage= Math.ceil(totalCount/pSize)
    let fetchedPages = 0;

    // console.log("SIGUN_NM"+sigungu)

    for(let pIndex=1; pIndex<=totalPage; pIndex++){
        $.ajax({
            url: url,
            type: 'GET',
            data:{
                SIGUN_NM:sigungu,
                pSize:pSize,
                pIndex:pIndex
            },
            dataType: 'json',
            success: function(data) {
                // console.log(data)
                processData(data,orgNm);
                fetchedPages++;
                if (fetchedPages === totalPage) {
                    // console.log("numOf",filtered.length);
                    if(filtered.length == 0) {
                        // console.log("filtered",filtered)
                        alert("Not Found");
                        pageCount();
                        $('#sigungu, #orgNm').val();
                    }
                    parseData(filtered);
                    apiData(filtered);
                }
            }
        })
    }
}

function processData(data,orgNm) {
    // console.log("orgNm",orgNm)
    let items = data.Animalhosptl[1].row;

    if(orgNm != null){
        items = items.filter(obj => obj.BIZPLC_NM.includes(orgNm));
        // console.log("orgNm_filter:",items)
    }
    
    for (let i = 0; i < items.length; i++) {
        let bizState = items[i].BSN_STATE_NM;
        if (bizState === "정상") {
            filtered.push(items[i]);
        }
    }
}

// 카카오맵
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

function parseData(items) {
    // 지도 중심좌표 (이동)
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = { 
            center: new kakao.maps.LatLng(parseFloat(items[0].REFINE_WGS84_LAT), parseFloat(items[0].REFINE_WGS84_LOGT)), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };
        // console.log(mapOption.center)
    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마커 표시/클릭이벤트
    for (let i = 0; i < items.length; i++) {
        (function() {
            let bizState = items[i].BSN_STATE_NM; // 업체상태
            let sigunCode = items[i].SIGUN_CD; // 시군코드
            let sigunName = items[i].SIGUN_NM; // 시군명
            let bizplcName = items[i].BIZPLC_NM; // 업체명
            let licensgDate = items[i].LICENSG_DE; // 면허발급일
            let telNo = items[i].LOCPLC_FACLT_TELNO; // 전화번호
            let address = items[i].REFINE_LOTNO_ADDR; // 주소
            let latitude = parseFloat(items[i].REFINE_WGS84_LAT); // 위도 정보를 실수형으로 변환
            let longitude = parseFloat(items[i].REFINE_WGS84_LOGT); // 경도 정보를 실수형으로 변환

            // 동물병원 위치에 마커 표시
            var markerPosition = new kakao.maps.LatLng(latitude, longitude);
            var marker = new kakao.maps.Marker({
                position: markerPosition,
                map: map // map에 마커를 표시합니다.
            });

            // 마커를 클릭하면 인포윈도우에 동물병원 이름을 표시합니다.
            kakao.maps.event.addListener(marker, 'click', function() {
                // 해당 동물병원의 정보를 옆에 표시합니다.
                showHospitalInfo(bizplcName, sigunName, sigunCode, licensgDate, bizState, telNo, address, latitude, longitude);
                // 마커를 클릭하면 인포윈도우에 동물병원 이름을 표시합니다.
                var infowindowContent = '<div style="font-size:15px;">' + bizplcName + "</div>";
                infowindow.setContent(infowindowContent);
                infowindow.open(map, marker);
            });
        })();
    }
};

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

// 동물병원 목록 출력
function apiData(items) {

    $("#AllhospitalList").empty();

    for(let i=0; i<items.length; i++) {
        let bizState = items[i].BSN_STATE_NM                    // 업체상태
        let sigunCode = items[i].SIGUN_CD                       // 시군코드
        let sigunName = items[i].SIGUN_NM                       // 시군명
        let bizplcName = items[i].BIZPLC_NM                     // 업체명
        let licensgDate = items[i].LICENSG_DE                   // 면허발급일
        let telNo = items[i].LOCPLC_FACLT_TELNO                 // 전화번호
        let address = items[i].REFINE_LOTNO_ADDR                // 주소
        let latitude = parseFloat(items[i].REFINE_WGS84_LAT)    // 위도 정보를 실수형으로 변환
        let longitude = parseFloat(items[i].REFINE_WGS84_LOGT)  // 경도 정보를 실수형으로 변환    

        let AllhospitalHtml = "<div class='hospital'>" +
            "<h3>" + bizplcName + "</h3>" +
            "<p><strong>시군명:</strong> " + sigunName + "</p>" +
            "<p><strong>시군코드:</strong> " + sigunCode + "</p>" +
            "<p><strong>면허발급일:</strong> " + licensgDate + "</p>"+
            "<p><strong>업태상태:</strong> " + bizState + "</p>"+
            "<p><strong>전화번호:</strong> " + telNo + "</p>" +
            "<p><strong>주소:</strong> " + address + "</p>" +
            "<p><strong>위도:</strong> " + latitude + "</p>" +
            "<p><strong>경도:</strong> " + longitude + "</p>" +
            "</div>";

        $("#AllhospitalList").append(AllhospitalHtml);
    }
    nameClick();    // 목록 이름 클릭 
}

// 동적으로 추가된 요소에 이벤트 리스너를 할당합니다.
function nameClick(){
    $(".hospital h3").on("click", function() {
    // 클릭된 업체명의 부모 요소인 hospital을 찾습니다.
    let clickedName = $(this).parent().children().children().context.innerHTML;
    let clickedLatitude = parseFloat($(this).parent().children().children().prevObject[7].innerText.substring(4))
    let clickedLongitude = parseFloat($(this).parent().children().children().prevObject[8].innerText.substring(4))
    
    // 값이 올바르게 가져와졌는지 확인하기 위해 콘솔에 출력합니다.
    // console.log("CLickced Name:",clickedName);
    // console.log("Clicked Latitude:", clickedLatitude);
    // console.log("Clicked Longitude:", clickedLongitude);
    
    // 지도의 중심을 클릭된 위치로 변경합니다.
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = { 
        center: new kakao.maps.LatLng(clickedLatitude, clickedLongitude), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    
    // 마커가 표시될 위치입니다 
    var markerPosition  = new kakao.maps.LatLng(clickedLatitude, clickedLongitude); 

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);
    
    var iwContent = '<div style="padding:5px;">'+clickedName+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(37.47775414791, 126.859363664); //인포윈도우 표시 위치입니다

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        position : iwPosition, 
        content : iwContent 
    });
    
    // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
    infowindow.open(map, marker); 
    });
}

// 검색창 : 지역 옵션 호출
function showArea(){
// 시군구 추출
//   $('#sido').on('onload', function(){
    // url 필수값
    let serviceKey = '?serviceKey=%2FkAZSbMp8SbBevYUU1S0nB5AbzY0QzXQl9WbrCj9kt21%2BLK0o3Jr2C3Dvq%2FayTjgImhkbGxihCzBbfAsE3sTBA%3D%3D'
    let protected = '&state=notice';
    let numOfRows = '&numOfRows=50'
    let _type = '&_type=json'

    // url 초기화
    let url = 'http://apis.data.go.kr/1543061/abandonmentPublicSrvc/';
    let upr_cd = '&upr_cd=';  // 시도코드
    let org_cd = '&org_cd=';  // 시군구코드

    // let selectedSido = $(this).val();
    let selectedSido = 6410000
    let category = 'sigungu';

    // 옵션 초기화
    $('#sigungu').empty();
    $('#sigungu').append('<option value = "">전체</option>');

    if(selectedSido!=""){
      url += category+serviceKey+protected+numOfRows+_type;
      url += upr_cd+selectedSido
      // console.log(url)

      $.ajax({
        url:url,
        type:'get',
        dataType:'json',
        success:function(data){
          // console.log(data);
          // item 배열 추출
          const items = data.response.body.items.item;
          
          for (let i = 0; i < items.length; i++) {    
            let sigunguOption = '<option value='+items[i].orgdownNm+'>'+items[i].orgdownNm+'</option>';
            $('#sigungu').append(sigunguOption);
          }
        },
        error: function(){
          console.log('error');
        }
      })
    }
//   });
};

function getSigun(){
    let sigungu= ''
    if($('#sigungu').val() != ""){
        sigungu = $('#sigungu').val();
    } else {
        sigungu = null;
    }
    // console.log(sigungu)
    return sigungu;
}

// 검색 값 : 명칭
function getOrgNm(){
    let orgNm= ''
    if($('#orgNm').val() != ""){
        orgNm = $('#orgNm').val();
    } else {
        orgNm = null;
    }
    // console.log("orgNm",orgNm);
    return orgNm;
}

// 엔터 => 검색
function enterPress(){
  $('#orgNm').keypress(function(e){
        if(e.keyCode == 13) {
            $('#btn').click();
        }
    });
}
</script>
</body>
</html>