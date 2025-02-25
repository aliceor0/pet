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
        border-radius: 8px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 8px;
        margin-top: 5px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
    }
    input[type="text"] {
    width: 70%;
    }

    input[type="button"] {
        padding: 10px 20px;
        background-color: #2a8890;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }

    input[type="button"]:hover {
        background-color: #0056b3;
    }

    #titleImagePreview {
        max-width: 20%;
        height: auto;
        border-radius: 4px;
        border: 1px solid #ccc;
    }

    textarea {
        resize: vertical;
    }

    a {
        color: blue;
        text-decoration: underline;
    }
</style>
</head>
<body  id="page-top">
	<!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp"%>
	<!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp"%>
	<%@ include file="../include/parcelOutHeader.jsp"%>
	<!-- 새로등록 하기 -->
	<input type="hidden" id="category" name="category" value="2" readonly>
<div class="container main">
	<div>
			제목 사진 추가<input type="file" id="titlefileInput" name="titlefileInput"
				onchange="titleuploadImage(event)" />
		<p>
			<img id="titleImagePreview"	style="max-width: 20%; height: auto;">
		</p>
		<table>
			<tr>
				<td>
					종류:
					<label for="f_type">강아지</label>
			    	<input type="radio" name="type" value="강아지" checked>
			    	<label for="f_type">고양이</label>
			    	<input type="radio" name="type" value="고양이">
			    	<label for="f_type">그 외</label>
			    	<input type="radio" name="type" value="그 외">
				</td>
				<td>
					성별:
					<label for="f_gender">남</label>
			    	<input type="radio" name="gender" value="남" checked>
			    	<label for="f_gender">여</label>
			    	<input type="radio" name="gender" value="여">
				</td>
			</tr>
			<tr>
				<td>
					예비이름: <input type="text" name="temporaryName" id="temporaryName">
				</td>
				<td>
					나이: <input type="text" name="age" id="age">
				</td>
			</tr>
			<tr>
				<td>
				몸 무 게: <input type="text" name="weight" id="weight">
				</td>
				<td>
				색상: <input type="text" name="color" id="color">
				</td>
			</tr>
			<tr>
				<td>
					임시보호자 이름: <input type="text" name="shelterName" id="shelterName" value="${info[0].nickname}" readonly>
				</td>
				<td>
					임시보호자의 번호: <input type="text" name="mobile" id="mobile" value="${info[0].mobile}" readonly>
				</td>
			</tr>
		</table>
		<p>
			<textarea id="txtContent" rows="30" cols="100" style="width: 100%;"></textarea>
			이미지 업로드 입력란 <input type="file" id="fileInput"
				onchange="uploadImage(event)" />
		</p>
		<p>
			★ 사진의 크기(용량)이 너무 크면 등록이 불가하오니 <a
				href="https://www.iloveimg.com/ko/compress-image" target="_blank"
				style="color: blue">[여기를 눌러주세요]</a>
		</p>
		<input type="button" onclick="save();" value="글등록하기">
	</div>
	</div>
<footer>
	<%@ include file="../include/footer.jsp"%>
</footer>
</body>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
let oEditors = []; //
let imageFileNames1 = [];
let imagePath;

$(document)
.ready(function() {
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
})

.on('click', '#home', function() {
	location.href = '/'
})

	function save() {
		// 에디터의 내용을 업데이트합니다.
		oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);
		// 제목과 내용을 가져옵니다.
	    let category = $("#category").val();
	    let type = $('input[name="type"]:checked').val();;
	    let temporary_name = $("#temporary_name").val();
	    let color = $("#color").val();
	    let age = $("#age").val();
	    let weight = $("#weight").val();
	    let gender = $('input[name="gender"]:checked').val();;
	    let content = $("#txtContent").val();
		
		console.log("save content:", content)
		// 이미지 파일 이름 추출과 동시에 content 변수 수정
		let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;
		let match;
		while (match = regex.exec(content)) {
			let imageName = match[1];
			imageFileNames1.push(imageName);
			// content 변수 수정
			let pattern = new RegExp('(/image_parcelOut/temp_img/' + imageName
					+ ')', 'g');
			content = content.replace(pattern, '/image_parcelOut/final_img/'
					+ imageName);
		}
		console.log("이미지이름" + imageFileNames1);

		let requestData = {
			imageFileNames1 : imageFileNames1,
			operationType: 'parcelOut'
		};

		// 이미지 업로드를 수행합니다.
		// 이미지 업로드가 완료되면 서버에 데이터를 전송합니다.

		$.ajax({
			type : "POST",
			url : "/eximge",
			data : JSON.stringify(requestData),
			contentType : "application/json",
			success : function(response) {
				pasteHTML(imageName);
			},
			error : function(xhr, status, error) {
				alert("내용 저장 중 오류가 발생했습니다: " + error);
			}
		});

	    // 제목이미지 업로드 경로(절대경로-> 이름만 추출)
	    let titleImagePath = $("#titleImagePreview").attr("src");
	    let titleimageName = titleImagePath.substring(titleImagePath.lastIndexOf('/') + 1);
	    let finalImagePath = '/image_parcelOut/title_img/' + titleimageName; // 최종 이미지 경로

		$.ajax({
			type : 'POST',
			url : '/doSalesRegistration', // 서버 URL을 여기에 입력하세요.
			data : {
				category : category,
				type : type,
				temporary_name : temporary_name,
				title_img: finalImagePath,
				color : color,
				age : age,
				weight : weight,
				gender : gender,
				content : content,
			},

			success : function(response) {
				alert("등록완료");
				location.href = '/parcelOutList'
			},
			error : function(xhr, status, error) {
				alert("등록실패!");
			}
		})

	}

	//제목 이미지 업로드 함수
function titleuploadImage(savePathType1) {
    return new Promise(function(resolve, reject) {
        let formData = new FormData();
        let titlefileInput = $("#titlefileInput")[0].files[0];
        formData.append('file', titlefileInput);
        
        let savePathType1 = 'parcelOut'; // 변수를 정의한 다음에 사용합니다.
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
                    let imagePath = '/image_parcelOut/title_img/'  + imageFileName;
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
    let savePathType = "parcelOut"; // 또는 필요에 따라 다른 값으로 설정
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
                let imagePath = '/image_parcelOut/temp_img/'  + imageFileName; // 이미지 저장 경로에 파일 이름을 추가합니다.  
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

//에디터에 이미지를 삽입하는 함수
function pasteHTML(filepath) {
    let sHTML = '<img src="' + filepath + '">';
    oEditors.getById["txtContent"].exec("PASTE_HTML", [sHTML]);
}  
</script>
</html>