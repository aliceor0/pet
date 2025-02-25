<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/head.jsp" %>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<style>
    .write {
        margin: 20px auto;
        width: 90%;
        padding: 20px;
    }

    .write-table {
        width: 100%;
        border-collapse: collapse;
    }

    .write-table td {
        padding: 10px;
        border: 1px solid #ddd;
    }

    .title,
    .agent,
    .adress,
    .name,
    .phone-number1,
    .phone-number2,
    .phone-number3,
    .recruit-start-date,
    .recruit-end-date,
    .volunteer-start-date,
    .volunteer-end-date,
    .home-page {
        width: 100%;
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ccc;
    }

    .poster-image {
        max-width: 100px;
        height: auto;
    }

    .save-button input {
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .save-button input:hover {
        background-color: #0056b3;
    }

    @media (max-width: 768px) {
        .write {
            width: 95%;
        }

        .poster-image {
            max-width: 80px;
        }

        .save-button input {
            padding: 8px 16px;
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
    <%@ include file="../include/communityHeader.jsp" %>
<div class="write">
    <table border=1>
        <tr>
            <td>제목</td>
            <td>
                <input type="text" class="title" maxlength='64' required>
            </td>
            <td>사진 파일첨부</td>
            <td>
            	<img id="titleImagePreview">
                <input type="file" id="titlefileInput" required onchange="titleuploadImage(event)" />
            </td>
        </tr>
        <tr>
            <td>모집기관</td>
            <td>
                <input type="text" class="agent" maxlength='20' required>
            </td>
            <td>주소</td>
            <td>
                <input type="text" class="adress" onclick="ADRshow()" readonly required>
            </td>
        </tr>
        <tr>
            <td>담당자 이름</td>
            <td>
                <input type="text" class="name" maxlength='10' required>
            </td>
            <td>담당자 연락처</td>
            <td>
                <input type="text" class="phone-number1" maxlength='3' style="width: 25%;" required >
                -<input type="text" class="phone-number2" maxlength='4' style="width: 25%;" required>
                -<input type="text" class="phone-number3" maxlength='4' style="width: 25%;" required>
            </td>
        </tr>
        <tr>
            <td>모집기간</td>
            <td>
                <input type="radio" name="recruitPeriod" value="everyDay" checked>상시모집
                <input type="radio" name="recruitPeriod" value="someTime">직접입력<br>
                <input type="date" class="recruit-start-date" style="width: 40%;" disabled> ~ <input type="date" class="recruit-end-date" style="width: 40%;"disabled>
            </td>
            <td>봉사기간</td>
            <td>
                <input type="radio" name="period" value="everyDay" checked>상시가능
                <input type="radio" name="period" value="someTime">직접입력<br>
                <input type="date" class="volunteer-start-date" style="width: 40%;" disabled> ~ <input type="date" class="volunteer-end-date" style="width: 40%;"disabled>
            </td>
        </tr>
        <tr>
            <td>활동가능일</td>
            <td>
                <input type="radio" name="date" value="매일" checked>매일
                <input type="radio" name="date" value="평일">평일
                <input type="radio" name="date" value="주말">주말
            </td>
            <td>활동가능시간</td>
            <td>
             	<input type="radio" name="time" value="종일" checked>종일
                <input type="radio" name="time" value="오전">오전
                <input type="radio" name="time" value="오후">오후
                <input type="radio" name="time" value="유선문의">유선문의
            </td>
        </tr>
        <tr>
            <td>홍보페이지</td>
            <td colspan="3"><input type="text" class="home-page" maxlength='64' required></td>
        </tr>
        <tr>
            <td colspan="4">※ 자원봉사 모집 글은 봉사 단체당 한개의 글만 올리실 수 있습니다.<br>
※ 자원봉사 모집 글은 목적의 변질 및 광고성 게시물 등으로의 수정을 방지하기 위하여<br>
     등록 후 수정, 삭제가 되지 않습니다.<br>
※ 코너 성격과 맞지 않은 글을 등록할 경우, 글 삭제 및 아이디가 정지되실 수도 있습니다.</td>
        </tr>
        <tr>
            <td colspan="4">
				<!-- 내용 입력란 -->
				<textarea id="txtContent" rows="30" cols="100" style="width: 100%;" required></textarea>
				<!-- 이미지 업로드 입력란 -->
				<input type="file" id="fileInput" onchange="uploadImage(event)" accept="image/*" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
                안내사항을 확인하셨다면 체크부탁드립니다.
                <input type="checkbox" required>
            </td>
        </tr>
        <tr>
            <td colspan="4">	
				<!-- 저장 버튼 -->
				<div id="se2_sample" style="margin:10px 0;">
					<input type="button" onclick="save();" value="글등록하기">
				</div>
			</td>
        </tr>
    </table>
</div>
	<%@ include file="../include/footer.jsp" %>
</body>
<script>
let oEditors = []; //
let imageFileNames1 = [];
let imagePath;
let recruitPeriod = '상시';
let volunteerPeriod = '상시';

$(document)
.ready(function(){
	//스마트에디터 초기화 
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "txtContent",
        sSkinURI: "/libs/smarteditor/SmartEditor2Skin.html",
        fCreator: "createSEditor2",
        htParams: { 
            bUseToolbar: true, 
            bUseVerticalResizer: false, 
            bUseModeChanger: false 
        }
    });
    
	// 모집기간의 값을 설정해주는 곳
    $('input[name="recruitPeriod"]').change(function(){ //라디오버튼을 눌렀을 때
        if($(this).val() === 'everyDay'){ // 상시모집이라면 날짜선택을 못하게하고 value를 초기화
            $('.recruit-start-date, .recruit-end-date').prop('disabled', true).val('');
			recruitPeriod = '상시'; // 상시모집일경우 모집기간을 상시로 고정
        } else if($(this).val() === 'someTime'){ // 직접입력이라면 날짜선택창 활성화.
            $('.recruit-start-date, .recruit-end-date').prop('disabled', false);
        }
    });
    
    $('.recruit-start-date, .recruit-end-date').change(function(){ //날짜를 선택하면 모집기간 변수에 저장
    	recruitPeriod = $('.recruit-start-date').val() + ' ~ ' + $('.recruit-end-date').val();
    });
    
    
    // 봉사기간의 값을 설정해주는 곳 -> 모집기간의 값설정과 동일한 로직
    $('input[name="period"]').change(function(){
        if($(this).val() === 'everyDay'){
            $('.volunteer-start-date, .volunteer-end-date').prop('disabled', true).val('');
			volunteerPeriod = 'everyDay';
        } else if($(this).val() === 'someTime'){
            $('.volunteer-start-date, .volunteer-end-date').prop('disabled', false);
        }
    });
    
    $('.volunteer-start-date, .volunteer-end-date').change(function(){
    	volunteerPeriod = $('.volunteer-start-date').val() + ' ~ ' + $('.volunteer-end-date').val();
    });
})

function save() {
	
	oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);

    let id = $("#id").val();
    let title = $("#title").val();
    let category = $("#category").val();
    let content = $("#txtContent").val();

    console.log("save content:", content);

    let imageFileNames1 = [];  // imageFileNames1 배열 초기화

    // 이미지 파일 이름 추출과 동시에 content 변수 수정
    let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;
    let match;
    while (match = regex.exec(content)) {
        let imageName = match[1];
        imageFileNames1.push(imageName);
        // content 변수 수정
        let pattern = new RegExp('(/image_community/temp_img/' + imageName + ')', 'g');
        content = content.replace(pattern, '/image_community/final_img/' + imageName); 
    }

    let requestData = {
        imageFileNames1: imageFileNames1,
        operationType: 'community' // 또는 'other'
    };

    $.ajax({
        type: "POST",
        url: "/eximge",
        data: JSON.stringify(requestData),
        contentType: "application/json",
        success: function(response) {
            // location.href="/infoWrite_4";
            pasteHTML(imageName);
        },
        error: function(xhr, status, error) {
            alert("내용 저장 중 오류가 발생했습니다1: " + error);
        }
    });

    // 제목이미지 업로드 경로(절대경로-> 이름만 추출)
    let titleImagePath = $("#titleImagePreview").attr("src");
    let titleimageName = titleImagePath.substring(titleImagePath.lastIndexOf('/') + 1);
    let finalImagePath = '/image_community/title_img/' + titleimageName; // 최종 이미지 경로

    
 // 에디터의 내용을 업데이트합니다.
    let phoneNumber = $('.phone-number1').val() + '-' + $('.phone-number2').val() + '-' + $('.phone-number3').val();
    
    titleuploadImage().then(function(uploadedImagePath) {
        $.ajax({
            type: "POST",
            url: "/addVolunteer",
            data: {
                title: $('.title').val(),
                agent: $('.agent').val(),
                adress: $('.adress').val(),
                name: $('.name').val(),
                phoneNumber: phoneNumber,
                recruitPeriod: recruitPeriod,
                volunteerPeriod: volunteerPeriod,
                date: $('input[name="date"]:checked').val(),
                time: $('input[name="time"]:checked').val(),
                homePage: $('.home-page').val(),
                img: uploadedImagePath,
                content: document.getElementById("txtContent").value,
                imageFileNames1: imageFileNames1,  // 이미지 파일명 배열 추가
                operationType: 'community'
            },
            success: function(response) {
                alert("내용이 성공적으로 저장되었습니다!");
                
                location.href="/volunteer";
            },
            error: function(xhr, status, error) {
                alert("내용 저장 중 오류가 발생했습니다: " + error);
            }
        });
    }).catch(function(error) {
        alert("이미지 업로드 중 오류가 발생했습니다: " + error);
    });
}


//제목 이미지 업로드 함수
function titleuploadImage(savePathType1) {
    return new Promise(function(resolve, reject) {
        let formData = new FormData();
        let titlefileInput = $("#titlefileInput")[0].files[0];
        formData.append('file', titlefileInput);
        
        let savePathType1 = 'community'; // 변수를 정의한 다음에 사용합니다.
        formData.append('savePathType1', savePathType1);
        
        // 이미지를 서버에 업로드합니다.
        $.ajax({
            type: "POST",
            url: "/titleuploadImage",
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if (response.success) {
                    let imageFileName = response.imageFileName;
                    let imagePath = '/image_community/title_img/'  + imageFileName;
                    $('#titleImagePreview').attr('src', imagePath);
                    resolve(imagePath); // 이미지 경로를 반환합니다.
                } else {
                    reject("이미지 업로드에 실패했습니다.");
                }
            },
            error: function(xhr, status, error) {
                reject("이미지 업로드 중 오류가 발생했습니다: " + error);
            }
        }); 
    });
}

//이미지 업로드 함수
function uploadImage(event) {
    let formData = new FormData();
    let fileInput = event.target.files[0];
    formData.append('file', fileInput);
    let savePathType = "community"; // 또는 필요에 따라 다른 값으로 설정
    formData.append('savePathType', savePathType);
    // 이미지를 서버에 업로드합니다.
    $.ajax({
        type: "POST",
        url: "/uploadImage",
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response.success) {
                let imageFileName = response.imageFileName;
                let imagePath = '/image_community/temp_img/'  + imageFileName; // 이미지 저장 경로에 파일 이름을 추가합니다.  
                pasteHTML(imagePath);
            } else {
                alert("이미지 업로드에 실패했습니다.");
            }
        },
        error: function(xhr, status, error) {
            alert("이미지 업로드 중 오류가 발생했습니다: " + error);
        }
    }); 
}

///에디터에 이미지를 삽입하는 함수
function pasteHTML(filepath) {
    let sHTML = '<img src="' + filepath + '">';
    oEditors.getById["txtContent"].exec("PASTE_HTML", [sHTML]);
} 

function ADRshow(){
    new daum.Postcode({
        oncomplete: function(data) {
            console.log(data);
            let roadAddr = data.roadAddress; // 도로명 주소 변수
            let jibunAddr = data.jibunAddress; // 지번 주소 변수
            if(roadAddr!==''){              
               $('.adress').val(roadAddr) 
            }else if(jibunAddr!==''){
                $('.adress').val(jibunAddr)  //도로명이 없을경우 지번을 넣는다
            }
        }
    }).open();
}


/* //에디터에 이미지를 삽입하는 함수
function pasteHTML(filepath) {
 let sHTML = '<img src="' + filepath + '">';
 oEditors.getById["txtContent"].exec("PASTE_HTML", [sHTML]);
} */

</script>
</html>