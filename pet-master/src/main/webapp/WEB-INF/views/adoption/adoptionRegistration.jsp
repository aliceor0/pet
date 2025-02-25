<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<%@ include file="../include/head.jsp" %>
		
		<style>
	.main {
    display: flex;
    flex-direction: column;
    margin-bottom: 50px;
}

.main h2 {
    text-align: left; /* h2만 left로 변경 */
    margin-bottom: 30px;
}

.main p, .main ol, .main ul {
    text-align: left;
    width: 80%;
    max-width: 800px;
    margin-bottom: 30px;
    line-height: 1.5; /* 줄간격 추가 */
}

.main ul, .main ol {
    margin-left: 20px; /* 목록 내용 들여쓰기 */
}

.main ul li, .main ol li {
    list-style-type: disc; /* 목록 스타일 변경 */
    margin-bottom: 10px;
}

.main p b, .main ul li b, .main ol li b {
    font-weight: bold; /* 볼드체 추가 */
}

.main img {
    max-width: 100%;
    height: auto;
    margin-bottom: 30px;
}

/* 등록절차 목록 스타일링 */
.main ol {
    counter-reset: item;
}

.main ol li {
    counter-increment: item;
    margin-bottom: 15px;
}

.main li {
    margin-left: 10px;
}

.main ol li::before {
    content: counter(item) ".";
    margin-right: 10px;
    font-weight: bold;
}

/* 반려동물등록대행업체 정보 */
.main p a {
    color: #0077cc; /* 링크 색상 변경 */
    text-decoration: underline;
}
#btn:hover {
    background-color: #0056b3;
}

/* Table Styles */
.main table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

.main table td,th {
    padding: 8px;
    text-align: center; /* Center align the text in table cells */
}

.main table select, .main table input[type="date"], .main input[type="button"]{
    width: 100%;
    border-radius: 5px;
    border: 1px solid #ccc;
    box-sizing: border-box;
    color: black; /* Set the text color of the select elements to black */
    background-color: white; /* Set the background color of the select elements to white */
}

.main #btn {
    width: 100%;
    background-color: #2a8890;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
}

.main #btn:hover {
    background-color: #0056b3;
}

div.paging{
	margin:auto;
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
    <div class="container main">
  <h2>| 동물등록제란?</h2>
    <p>
      &emsp;<b>태어난 지 2개월 이상의 반려견으르 국가에 의무적으로 등록하는 제도입니다.</b><br>
      &emsp;강아지를 잃어버렸을 때 미리 등록된 정보를 바탕으로 빠르게 찾을 수 있고, 유기 또는 불법 판매를 방지할 수 있습니다.<br>
      &emsp;등록하면 지자체에서 운영하는 놀이터에 입장하거나 광견병 무료 예방 접종 등의 혜택이 주어집니다.
    </p>
    <br>
    <br>
  <h2>| 등록방법</h2>
    <p>&emsp;① 내장형 무선식별장치 개체 삽입 / ② 외장형 무선식별장치 부착</p>
    <br>
    <br>
  <h2>| 동물등록절차안내</h2>
    <!-- 파워포인트 화살표단계처럼 변환하기 -->
    <ol>
      <li>무선식별장치장착확인 <samll>*식별장치 비용 및 시술비(내장형) 발생</samll></li>
      <li>동물등록신청서 등
        작성 및 제출/
        수수료 납부
        (내장 만원, 외장 3천원)</li>
      <li>검토 및
        등록사항 기록 등</li>
      <li>시·군·구청
        등록 승인 후/
        등록증 수령</li>
    </ol>
    <ul>
      <li>최초 등록시에는 동물등록에게 무선식별장치를 장착하기 위해 반드시 <b>1.등록대상동물과 동반하여 2.방문신청</b> 하셔야 합니다.</li>
      <li>지자체조례에 따라 대행업체를 통해서만 등록이 가능한 지역이 있으니 시·군·구청 등록을 원하실때에는 가능여부를 사전에 확인하시기 바랍니다.</li>
      <li>등록신청인이 직접 방문하지 않고 대리인이 신청할때는 위임장, 신분증 사본 등이 필요하오니 등록기관에 사전연락하시어 필요서류를 확인, 준비하시기 바랍니다.</li>
    </ul>
    <br>
    <br>
    <h2>| 반려동물등록대행업체</h2>
    <!-- 반려동물등록대행업체 정보조회 서비스API https://www.data.go.kr/data/15098916/openapi.do -->
    
	<table>
		<tr>
			<td>
	        	<label class="">시도</label>
	        </td>
	        <td>
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
		   	</td> 
	     
	        <td>
		        <label class="">시군구</label>
		    </td>
		    <td>
		        <select id="sigungu">
		            <option value="">전체</option>
		        </select>
	        </td>
	        <td>
	            <label class="">업체명</label>
	        </td>
	        <td>
	            <input type="text" id="orgNm">
	        </td>
		</tr>	        
    </table>
    <div>
        <input type="button" id="btn" value="조회">
    </div>
    <hr>
    <table class="result"></table>
    <div class="paging"></div>
</div>
<footer>
<%@ include file="../include/footer.jsp" %>
</footer>
	
</body>
<script>
$(document)
.ready(function(){
    // 시작 함수 모음
    showArea();     // 검색 폼
    showList();     // 대행업체 리스트 불러오기
    enterPress();   // enter => 검색
})

// 이벤트 : 클릭."조회"
$(document).on('click', '#btn', function(e){
	e.preventDefault();
	
    let addr = getAddr();
    let orgNm = getOrgNm();
    // console.log(addr)
    showList(1,addr,orgNm);
});


// 함수 모음

// 똑같은 코드라도 60%는 error + 로딩 너무 느림..
// url+인증키 밖으로 빼서 문자열로 합치니 갑자기 빨라짐...
function showList(pageNo=1,addr=null,orgNm=null) {
    if(addr==null){
        addr = null;
    } else {
        addr = addr
    }

    if(orgNm==null){
        orgNm = null;
    } else {
        orgNm = orgNm
    }
        
    const serviceKey = "%2FkAZSbMp8SbBevYUU1S0nB5AbzY0QzXQl9WbrCj9kt21%2BLK0o3Jr2C3Dvq%2FayTjgImhkbGxihCzBbfAsE3sTBA%3D%3D";
    let url = 'http://apis.data.go.kr/1543061/recordAgencySrvc/recordAgency?serviceKey='+serviceKey+"&_type=json";

    $.ajax({
        type:'GET',
        url:url,
        data:{
            addr:addr,
            pageNo:pageNo,
            orgNm:orgNm
        },
        dataType:'json',
        success:function(data){
            // console.log(data)
            // 빈 값일때 alert
            let bodies = data.response.body.items
            // console.log(Object.keys(bodies).length === 0);
            if(Object.keys(bodies).length === 0) {
                alert("Nothing")
                $('#sido,#sigungu,#orgNm').val("");
                showList(1);
                
            } else {
            let items = data.response.body.items.item;
            // console.log(items);
            $('.result').empty();

            let str ='';
            str += '<thead><tr><th>상호</th><th>주소</th><th>전화번호</th></tr></thead>'
                str += '<tbody>'
                
            for(let i=0; i<items.length; i++){
            let ob = items[i]

	            if(ob.orgAddrDtl = ""){
	                      ob.orgAddrDtl=""
	            }
				
	            str += '<tr><td>'+ ob.orgNm +'</td>'
	                +'<td>'+ ob.orgAddr + ob.orgAddrDtl+'</td>'
	                +'<td>'+ob.tel+'</td></tr>'
	            }
                str += '<tbody>'
            $('.result').append(str);

            // 페이지네이션
            let currentPage = data.response.body.pageNo;
            // console.log("currentPage",currentPage)
            let totalCount = data.response.body.totalCount;
            // console.log("totalCount",totalCount);
            // console.log("orgNm",orgNm)

            pagenation(currentPage,totalCount,addr,orgNm);
            }
        }
    })
}


// 페이지네이션
function pagenation(currentPage,totalCount,addr,orgNm){
    if(addr != null) {
        addr = '"'+addr+'"';
    } else {
        addr = null;
    }
    
    // console.log("addr2",addr)

    if(orgNm != null) {
        orgNm = '"'+orgNm+'"';
    } else {
        orgNm = null;
    }
    
    // console.log("orgNm2",orgNm)

    let numOfRows = 10;
    
    let endPage = Math.ceil(currentPage/10)*10;
    let startPage = endPage - 9; 
   
    // 최종페이지
    let realEndPage = Math.ceil(Math.ceil(totalCount/numOfRows))
    // console.log("realEndPage",realEndPage)
    if(realEndPage < endPage){
        endPage = realEndPage;
    }
    // console.log("endPage",endPage)
    // 이전페이지
    let prev = currentPage-1;
    // 다음페이지
    let next = currentPage+1;
    
    $('.paging').empty();

    let pagestr = "";

    if(startPage > 1 || currentPage > 1){  
        pagestr += "<a href='#' onclick='showList(1,"+addr+","+orgNm+")'>처음으로</a>&emsp;"+"<a href='#' onclick='showList("+prev+","+addr+","+orgNm+")'>이전</a>&emsp;"
    }
    for(let i=startPage; i<=endPage; i++){
        pagestr += "<a href='#' onclick='showList("+i+","+addr+","+orgNm+")'>"+i+"</a>&emsp;";
    }
    if(currentPage < realEndPage){  
        pagestr+="<a href='#' onclick='showList("+next+","+addr+","+orgNm+")'>다음</a>&emsp;" + "<a href='#' onclick='showList("+realEndPage+","+addr+","+orgNm+")'>마지막</a>";
    }
    // console.log(pagestr)
    $('.paging').append(pagestr);
    
    // 페이지네이션 링크에 대한 기본 동작 막기
    $('.paging a').on('click', function(event) {
        event.preventDefault();
    });
}


// 검색창 : 지역 옵션 호출
function showArea(){
  // 시군구 추출
  $('#sido').on('change', function(){
    // url 필수값
    let serviceKey = '?serviceKey=%2FkAZSbMp8SbBevYUU1S0nB5AbzY0QzXQl9WbrCj9kt21%2BLK0o3Jr2C3Dvq%2FayTjgImhkbGxihCzBbfAsE3sTBA%3D%3D'
    let protected = '&state=notice';
    let numOfRows = '&numOfRows=50'
    let _type = '&_type=json'

    // url 초기화
    let url = 'http://apis.data.go.kr/1543061/abandonmentPublicSrvc/';
    let upr_cd = '&upr_cd=';  // 시도코드
    let org_cd = '&org_cd=';  // 시군구코드

    let selectedSido = $(this).val();
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
  });
};


// 검색 값 : 주소
function getAddr(){
    let sido = '';
    if($('#sido option:selected').text() != "전체"){
        sido = $('#sido option:selected').text();
    } else {
        sido = null;
    }
    // console.log($('#sido option:selected').text())
    
    let sigungu= ''
    if($('#sigungu').val() != ""){
        sigungu = $('#sigungu').val();
    } else {
        sigungu = null;
    }

    if(sido != null){
        if(sigungu != null){
            addr = sido + ' ' + sigungu ;
        } else {
            addr = sido;
        }
    } else {
        addr = null
    }

    return addr;
}

// 검색 값 : 명칭
function getOrgNm(){
    let orgNm= ''
    if($('#orgNm').val() != ""){
        orgNm = $('#orgNm').val();
    } else {
        orgNm = null;
    }

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
</html>