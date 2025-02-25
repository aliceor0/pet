<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../include/head.jsp" %>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<style>
.container.main {
    max-width: 1200px;
    font-family: 'Arial', sans-serif;
}

.main p {
    line-height: 1.6;
    text-align: left;
    margin-bottom: 5px;
}

#btnSearch:hover {
    background-color: #0056b3;
}

/* Table Styles */
.main table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

.main table td {
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

.main #btnSearch {
    width: 100%;
    background-color: #2a8890;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
}

.main #btnSearch:hover {
    background-color: #0056b3;
}

.row {
    display: flex;
    flex-wrap: wrap;
    justify-content: center; /* 전체 그리드를 가운데 정렬 */
   
}

.card {
    flex: 0 0 calc(23% - 20px);
    border: 1px solid #eee;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    background-color: #fff;
    transition: transform 0.3s ease;
}

.card:hover {
    transform: translateY(-5px);
}

.card-img {
    width: 100%;
    height: auto;
    border-radius: 10px 10px 0 0;
}

.card-body p {
    font-size: 16px;
    color: #333;
    font-weight: bold;
}
div .paging{
	margin : auto;
	text-align : center;
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
<div>
  <h1>
	동물보호관리시스템 유기동물 공고
  </h1>
  <br>
  <h4>유기동물 공고</h4>
  <p>
	[동물보호법] 제 17조 및 동법 시행규칙 제7조에 따라 유기,유실동물을 보호하고 있는 경우에는<br>
	소유자등이 보호조치 사실을 알 수 있도록 7일동안 공고하여야 합니다.<br>
	공고중인 동물 소유자는 해당 시군구 및 동물 보호센터에 문의하시어 동물을 찾아가시기 바랍니다.<br>
	다만, [동물보호법] 제19조 및 동법 시행규칙 제21조에 따라 소유자에게 보호비용이 청구될 수 있습니다.<br>
	또한 [동물보호법] 제17조에 따른 공고가 있는 날부터 10일이 경과하여도 <br>
	소유자등을 알 수 없는 경우에는 [유실물법] 제12조 및 [민법] 제253조의 규정에도 불구하고<br>
	해당 시,군수,구청장이 그 동물의 소유권을 취득하게 됩니다.<br><br>
	
	시/도지사,시장,구청장 (직인생략)<br><br>
  </p>
  </div>
<!-- 검색창 만들기 -->
<!-- 검색 : 지역그룹 html -->
<div>
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
		<td >
		  <select id="sigungu">
		    <option value="">전체</option>
		  </select>
		</td>
		<td>
		  <label class="">보호센터</label>
		</td>
		<td>
		  <select id="careNm">
		    <option value="">전체</option>
		  </select>
		</td>
		<td>
		    <label class="">상태</label>
		</td>
		<td>
		  <select id="state">
		    <option value="">전체</option>
		    <option value="notice">공고중</option>
		    <option value="protect">보호중</option>
		  </select>
		</td>
	</tr>
	<tr>
		<td>
		  <label class="">품종</label>
		</td>
		<td>
		  <select id="up_kind_cd">
		    <option value="">전체</option>
		    <option value="417000">개</option>
		    <option value="422400">고양이</option>
		    <option value="429900">기타</option>
		  </select>
		</td>
		<td>
		  <label class="">분류</label>
		</td>
		<td>
		  <select id="kindCd">
		    <option value="">전체</option>
		  </select>
		</td>
		<td>
		  <label class="">접수일</label>
		</td>
		<td>
			<input type="date" id="bgnde"> 
		</td>
		<td colspan="2">
			<input type="date" id="endde">
		</td>
	</tr>
</table>

<div><input type=button id=btnSearch value="조회"></div>
<br><br>
</div>
<!-- 데이터 호출 -->
<div class="adoptList"></div>
<br>
<div class="paging"></div>
</div>
<footer>
<%@ include file="../include/footer.jsp" %>
</footer>
</body>

<script>
$(document)
.ready(function(){
  showArea();       // 지역 및 보호소 리스트
  showUpKind();     // 축종 및 품종 리스트

  showList();       // 목록 출력
  enterPress();     // 엔터 => 조회 버튼
})
// 이벤트 : 클릭."조회"
$(document).on('click', '#btnSearch', function(e){
    // e.preventDefault();
    let sido = getUprCd();
    let sigungu = getOrgCd();
    let care_reg_no = getCareRegNo();
    let upkind = getUpkind();
    let kind = getKind();
    let state = getState();
    let startDate = showStartDate();
    let endDate = showEndDate();
    

    // console.log("state_click",state);
    showList(20,1,sido,sigungu,care_reg_no,upkind,kind,state,startDate,endDate);
});

// 함수 모음
// 검색 값 : Getter
function getUprCd(){        // getter 시도
    let sido= ''
    if($('#sido option:selected').val() != ""){
        sido = $('#sido option:selected').val();
    } else {
        sido = null;
    }
    // console.log("sido",sido);
    return sido;
}

function getOrgCd(){        // getter 시군구
    let sigungu= ''
    if($('#sigungu option:selected').val() != ""){
        sigungu = $('#sigungu option:selected').val();
    } else {
        sigungu = null;
    }
    // console.log("sigungu",sigungu);
    return sigungu;
}

function getCareRegNo(){    // getter 보호소
    let care_reg_no= '';
    if($('#careNm option:selected').val() != ""){
      care_reg_no = $('#careNm option:selected').val();
    } else {
      care_reg_no = null;
    }
    // console.log("care_reg_no",care_reg_no);
    return care_reg_no;
}

function getUpkind(){    // getter 축종코드
    let upkind= ''
    if($('#up_kind_cd option:selected').val() != ""){
      upkind = $('#up_kind_cd option:selected').val();
    } else {
      upkind = null;
    }
    // console.log("upkind",upkind);
    return upkind;
}

function getKind(){    // getter 품종코드
    let kind= ''
    if($('#kindCd option:selected').val() != ""){
      kind = $('#kindCd option:selected').val();
    } else {
      kind = null;
    }
    // console.log("kind",kind);
    return kind;
}

function showStartDate(){   // getter 검색시작일
  let startDate = $('#bgnde').val();
    
  if(startDate!=""){
    startDate = startDate = startDate.replace(/-/g, '');
  } else{
    startDate = null;
  }

  // console.log("startDate ",startDate);
  return startDate;
}

function showEndDate(){   // getter 검색 마지막 날
  let endDate = $('#endde').val();
    
  if(endDate!=""){
    endDate = endDate = endDate.replace(/-/g, '');
  } else{
    endDate = null;
  }

  // console.log("endDate ",endDate);
  return endDate;
}

function getState(){        // getter 상태
    let state= ''
    if($('#state option:selected').val() != ""){
      state = $('#state option:selected').val();
    } else {
      state = null;
    }
    // console.log("state",state);
    return state;
}

// 데이터 호출 및 페이지네이션
function showList(numOfRows=20,pageNo=1,sido=null,sigungu=null,care_reg_no=null,upkind=null,kind=null,state=null,startDate=null,endDate=null){
  const serviceKey = "%2FkAZSbMp8SbBevYUU1S0nB5AbzY0QzXQl9WbrCj9kt21%2BLK0o3Jr2C3Dvq%2FayTjgImhkbGxihCzBbfAsE3sTBA%3D%3D";
  let url = "https://apis.data.go.kr/1543061/abandonmentPublicSrvc/abandonmentPublic?serviceKey="+serviceKey+"&_type=json"

  // console.log(url)
  $.ajax({
    url: url,
    type: 'GET',
    data:{
      numOfRows:numOfRows,      // 페이지당 데이터 갯수
      pageNo:pageNo,            // 페이지번호
      
      upr_cd:sido,            // 시도 코드
      org_cd:sigungu,        // 시군구코드
      care_reg_no:care_reg_no,  // 보호소번호

      upkind:upkind,            // 축종코드 (개:417000, 고양이:422400, 기타:429900 )
      kind:kind,                // 품종코드 ex)골든리트리버
      state:state,             // 상태(전체:null,공고중:notice,보호중:protect)

      bgnde:startDate,              // 검색시작날짜 ex)20240301
      endde:endDate              // 검색종료날짜 ex)20240301
      
      // neuter_yn:neuter_yn      // 중성화여부
      
    },
    dataType: 'json',
    success: function(data) {
      // console.log(data);
      // 빈 값일때 alert
      let bodies = data.response.body.items
      // console.log(Object.keys(bodies).length === 0);
      if(Object.keys(bodies).length === 0) {
          alert("Nothing")
          $('#sido,#sigungu,#careNm,#up_kind_cd,#kindCd,#bgnde,#endde').val("");
          showList();
          
      } else {
        
      let items = data.response.body.items.item;
      // console.log(items.length);
      $('.adoptList').empty();
      
      let str ='';
      
      let i=0;
      for(let j=0; j<5; j++){
    	  str += '<div class="row">'; // 행 시작
        
        for(let k=0; k<4; k++){
          if(i<=items.length){
            let ob = items[i]

            if(ob){

           	  // 팝업 전달용 데이터
              if(ob.sexCd == "Q"){
                gender = "미상";
              } else if(ob.sexCd == "F") {
                gender = "암컷";
              } else {
                gender = "수컷";
              }

              if(ob.neuterYn == "U"){
                neuter = "미상";
              } else if(ob.neuterYn == "N"){
                neuter = "아니오";
              } else {
                neuter = "예";
              }

              let goPopupData = "'"+ob.popfile+"',"
                      +"'"+ob.happenDt+"',"
                      +"'"+ob.happenPlace+"',"
                      +"'"+ob.kindCd+"',"
                      +"'"+ob.colorCd+"',"
                      +"'"+ob.age+"',"
                      +"'"+ob.weight+"',"
                      +"'"+ob.noticeNo+"',"
                      +"'"+ob.noticeSdt+"',"
                      +"'"+ob.noticeEdt+"',"
                      +"'"+ob.processState+"',"
                      +"'"+gender+"',"
                      +"'"+neuter+"',"
                      +"'"+ob.specialMark+"',"
                      +"'"+ob.careNm+"',"
                      +"'"+ob.careTel+"',"
                      +"'"+ob.careAddr+"',"
                      +"'"+ob.orgNm+"',"
                      +"'"+ob.chargeNm+"',"
                      +"'"+ob.officetel+"'"


              // 데이터별 div
              str += '<div class="col-lg-3 col-md-6 mb-4">';
              str += '<div class="card h-100" style="border: 1px solid #ccc; margin-top: 15px;">';
              str += '<div class="card-body d-flex flex-column justify-content-center align-items-center" style="height: 250px;">';
              str += '<a href="#" onclick="openPopup(' + goPopupData + ')">';
              str += '<img style="object-fit: contain; height: auto; width: 100%; max-height: 100%;" src="' + ob.popfile + '" alt="유기동물"/>';
              str += '</div>'
              str += '<div class="card-content p-3 d-flex flex-column justify-content-center align-items-center" style="border-top: 1px solid #ccc; padding-left: 15px; padding-right: 15px;">';
              str += '<p>유형 : '+ob.kindCd+'</p>'
                  + '<p>지역 : '+ob.orgNm+'</p>'
/*                   + '<p>장소 : '+ob.happenPlace+'</p>' */
                  + '<p>날짜 : '+ob.noticeSdt+'</p>'
                  + '<p>특징 : '+ob.specialMark+'</p>';
              str += '</div>';
              str += '</div>';
              str += '</div>';

              i++;
            } else {
              str += '<div class="col"></div>'
            }
          }
        }
        str += '</div>';
      }  
        // console.log(str)
        $('.adoptList').append(str);

        // 페이지네이션
        let currentPage = data.response.body.pageNo;
        // console.log("currentPage",currentPage)
        let totalCount = data.response.body.totalCount;
        // console.log("totalCount",totalCount);

        // console.log("sigungu_first",sigungu)
        pagenation(currentPage,totalCount,numOfRows,sido,sigungu,care_reg_no,upkind,kind,state,startDate,endDate);
      }
    },
    error: function(error) {
      console.error('Error fetching data:', error);
    }
  });	
}

// 페이지네이션
function pagenation(currentPage,totalCount,numOfRows,sido,sigungu,care_reg_no,upkind,kind,state,startDate,endDate){
    // 품종 번호 0으로 시작해서 문자열화
    if(kind != null) {
      kind = '"'+kind+'"';
    } else {
      kind = null;
    }

    // 공고상태 문자열 적용
    if(state != null) {
      state = '"'+state+'"';
    } else {
      state = null;
    }

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
    let optional = sido+","+sigungu+","+care_reg_no+","+upkind+","+kind+","+state+","+startDate+","+endDate;

    if(startPage > 1 || currentPage > 1){
        pagestr += "<a href='#' onclick='showList("+numOfRows+",1,"+optional+")'>처음으로</a>&emsp;"+"<a href='#' onclick='showList("+numOfRows+","+prev+","+optional+")'>이전</a>&emsp;"
    }
    for(let i=startPage; i<=endPage; i++){
        pagestr += "<a href='#' onclick='showList("+numOfRows+","+i+","+optional+")'>"+i+"</a>&emsp;";
    }
    if(currentPage < realEndPage){  
        pagestr+="<a href='#' onclick='showList("+numOfRows+","+next+","+optional+")'>다음</a>&emsp;" + "<a href='#' onclick='showList("+numOfRows+","+realEndPage+","+optional+")'>마지막</a>";
    }
    // console.log(pagestr)
    $('.paging').append(pagestr);
}

// 검색창 : 지역 및 보호소
function showArea(){
  // 시군구 추출
  $('#sido').on('change', function(){
    // url 필수값
    let serviceKey = '?serviceKey=%2FkAZSbMp8SbBevYUU1S0nB5AbzY0QzXQl9WbrCj9kt21%2BLK0o3Jr2C3Dvq%2FayTjgImhkbGxihCzBbfAsE3sTBA%3D%3D'
    let protected = '&state=notice';
    let numOfRows = '&numOfRows=20'
    let _type = '&_type=json'

    // url 초기화
    let url = 'http://apis.data.go.kr/1543061/abandonmentPublicSrvc/';
    let upr_cd = '&upr_cd=';  // 시도코드
    let org_cd = '&org_cd=';  // 시군구코드

    let selectedSido = $(this).val();
    let category = 'sigungu';
    
    // console.log("serviceKey",serviceKey);

    // 옵션 초기화
    $('#sigungu').empty();
    $('#sigungu').append('<option value = "">전체</option>');
    $('#careNm').val("");

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
            let sigunguOption = '<option value='+items[i].orgCd+'>'+items[i].orgdownNm+'</option>';
            $('#sigungu').append(sigunguOption);
          }
        },
        error: function(){
          console.log('error');
        }
      })
    }
  });
  
  // 보호소 추출
  $('#sigungu').on('change', function(){
    // url 필수값
    let serviceKey = '?serviceKey=%2FkAZSbMp8SbBevYUU1S0nB5AbzY0QzXQl9WbrCj9kt21%2BLK0o3Jr2C3Dvq%2FayTjgImhkbGxihCzBbfAsE3sTBA%3D%3D'
    let protected = '&state=notice';
    let numOfRows = '&numOfRows=20'
    let _type = '&_type=json'

    // url 초기화
    let url = 'http://apis.data.go.kr/1543061/abandonmentPublicSrvc/';
    let upr_cd = '&upr_cd=';  // 시도코드
    let org_cd = '&org_cd=';  // 시군구코드

    // request 값
    upr_cd += $('#sido').val();

    let selectedSigungu = $(this).val();
    org_cd += selectedSigungu;

    category = 'shelter'

    // 옵션 초기화
    $('#careNm').empty();
    $('#careNm').append('<option value = "">전체</option>');

    if(selectedSigungu!=""){
      url += category+serviceKey+protected+numOfRows+_type;
      url += upr_cd+org_cd
      // console.log(url)

      $.ajax({
        url:url,
        type:'get',
        dataType:'json',
        success:function(data){
          // console.log(data);
          // item 배열 추출
          const items = data.response.body.items.item;
          // console.log(items);
          for (let i = 0; i < items.length; i++) {    
            let careNmOption = '<option value='+items[i].careRegNo+'>'+items[i].careNm+'</option>';
            // console.log(careNmOption);
            $('#careNm').append(careNmOption);
          }
        },
        error: function(){
          console.log('error');
        }
      })
    }
  })
}


// 검색창 : 축종 및 품종 호출
function showUpKind(){
  $('#up_kind_cd').on('change', function(){
    // url 필수값
    let serviceKey = '?serviceKey=%2FkAZSbMp8SbBevYUU1S0nB5AbzY0QzXQl9WbrCj9kt21%2BLK0o3Jr2C3Dvq%2FayTjgImhkbGxihCzBbfAsE3sTBA%3D%3D'
    let protected = '&state=notice';
    let numOfRows = '&numOfRows=20'
    let _type = '&_type=json'
    // url 초기화
    let url = 'http://apis.data.go.kr/1543061/abandonmentPublicSrvc/';
    let up_kind_cd = '&up_kind_cd=';  // 축종코드

    let selectedupkind = $(this).val();
    let category = 'kind';

    // 옵션 초기화
    $('#kindCd').empty();
    $('#kindCd').append('<option value = "">전체</option>');

    if(selectedupkind!=""){
      url += category+serviceKey+protected+numOfRows+_type;
      url += up_kind_cd+selectedupkind
      // console.log(url)

      $.ajax({
        url:url,
        type:'get',
        dataType:'json',
        success:function(data){
          // item 배열 호출
          const items = data.response.body.items.item;

          for (let i = 0; i < items.length; i++) {    
            let kindOption = '<option value='+items[i].kindCd+'>'+items[i].knm+'</option>';
            $('#kindCd').append(kindOption);
          }
        },
        error: function(){
          console.log('error');
        }
      })
    }
  })
};

// 엔터 => 검색
function enterPress(){
  $('#orgNm').keypress(function(e){
        if(e.keyCode == 13) {
            $('#btn').click();
        }
    });
}

function openPopup(popfile,happenDt,happenPlace,kindCd,colorCd,age,weight,noticeNo,noticeSdt,noticeEdt,processState,sexCd,neuterYn,specialMark,careNm,careTel,careAddr,orgNm,chargeNm,officetel){
	
	// 기본 동작 중지
    event.preventDefault();
	
    const queryParams = {
      popfile:popfile,
      happenDt:happenDt,
      happenPlace:happenPlace,
      kindCd:kindCd,
      colorCd:colorCd,
      age:age,
      weight:weight,
      noticeNo:noticeNo,
      noticeSdt:noticeSdt,
      noticeEdt:noticeEdt,
      processState:processState,
      sexCd:sexCd,
      neuterYn:neuterYn,
      specialMark:specialMark,
      careNm:careNm,
      careTel:careTel,
      careAddr:careAddr,
      orgNm:orgNm,
      chargeNm:chargeNm,
      officetel:officetel
    };
    const queryString = new URLSearchParams(queryParams).toString();
    // console.log(queryString);
    const win = window.open("/adoption/view?" + queryString, "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=100,left=100,width=1000,height=800");
}

</script>
</html>