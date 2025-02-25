<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
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
<head>
<%@ include file="../include/head.jsp"%>
	<!-- 우측 햄버거버튼에 관한 정보 -->
</head>
<body  id="page-top">
	<!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp"%>
	<!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp"%>
	<%@ include file="../include/parcelOutHeader.jsp"%>
<div class="container main">
	<input type="hidden" id="category" name="category" value="1" readonly>
	<div>
		<input type="hidden" id="id" name="id" value="${view[0].id}" readonly>
		<input type=hidden value="수정하기"></div>
		<input type=hidden value="${view[0].state}" id ="state"></div>
    <div>
        제목 사진 추가
        <input type="file" id="titlefileInput" name="titlefileInput" onchange="titleuploadImage(event)" />
        <p>
            <img id="titleImagePreview" src="${view[0].image}" alt="제목이미지첨부">
        </p>
        <table>
            <tr>
                <td>
                    종류:
                    <label for="f_type">강아지</label>
                    <input type="radio" name="type" value="강아지" ${view[0].type == '강아지' ? 'checked' : ''}>
                    <label for="f_type">고양이</label>
                    <input type="radio" name="type" value="고양이" ${view[0].type == '고양이' ? 'checked' : ''}>
                    <label for="f_type">그 외</label>
                    <input type="radio" name="type" value="그 외" ${view[0].type == '그 외' ? 'checked' : ''}>
                </td>
                <td>
                    성별:
                    <label for="f_gender">남</label>
                    <input type="radio" name="gender" value="남" ${view[0].gender == '남' ? 'checked' : ''}>
                    <label for="f_gender">여</label>
                    <input type="radio" name="gender" value="여" ${view[0].gender == '여' ? 'checked' : ''}>
                </td>
            </tr>
            <tr>
                <td>
                    예비이름: <input type="text" name="temporaryName" id="temporaryName" value="${view[0].temporary_name}">
                </td>
                <td>
                    나이: <input type="text" name="age" id="age" value="${view[0].age}">
                </td>
            </tr>
            <tr>
                <td>
                    몸 무 게: <input type="text" name="weight" id="weight" value="${view[0].weight}">
                </td>
                <td>
                    색상: <input type="text" name="color" id="color" value="${view[0].color}">
                </td>
            </tr>
            <tr>
                <td>
                    임시보호자 이름: <input type="text" name="shelterName" id="shelterName" value="${view[0].nickname}" readonly>
                </td>
                <td>
                    임시보호자의 번호: <input type="text" name="number" id="number" value="${view[0].mobile}" readonly>
                </td>
            </tr>
        </table>
        <p>
            <textarea id="content" rows="30" cols="100" style="width: 100%;" required name="content">${view[0].content}</textarea>
            <br>
            이미지 업로드 입력란 <input type="file" id="fileInput" onchange="uploadImage(event)" />
        </p>
        <p>
            ★ 사진의 크기(용량)이 너무 크면 등록이 불가하오니 <a href="https://www.iloveimg.com/ko/compress-image" target="_blank">[여기를 눌러주세요]</a>
        </p>
        <p>
            <button value="등록하기" id="resubmit">등록!</button>
        </p>
    </div>



	<div>
		<p>이미지 압축 후 등록해주시면 됩니다!★</p>
	</div>
	<button id="home">홈으로</button>
</div>
<footer>
	<%@ include file="../include/footer.jsp"%>
</footer>
</body>


<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
	let oEditors = []; // let를 let로 변경
	let updateFileNames1 = [];
	let imageFileNames1 = [];
	let imagePath;
	let imageName;

	$(document).ready(function() {
		Imglist();
	})

	.on('click', '#resubmit', function() {
		if (confirm("수정 하시겠습니까?") == true) {
			save();
		}
	})

	.on('click', '#home', function() {
		location.href = '/'
	})

	function Imglist() {
		let id = document.getElementById("id").value; // let를 let로 변경
		let title = document.getElementById("title").value; // let를 let로 변경
		let content = document.getElementById("content").value;
		console.log("img content:", content)

		let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;
		let match;
		while (match = regex.exec(content)) {
			let imageName = match[1];
			updateFileNames1.push(imageName);
			// content 변수 수정
			let pattern = new RegExp('(/image_parcelOut/complete/' + imageName
					+ ')', 'g');
			content = content.replace(pattern, '/image_parcelOut/ready/'
					+ imageName);
			//console.log("imgs content:", content)
		}
		let requestData = {
			updateFileNames1 : updateFileNames1
		};
		$.ajax({
			type : "POST",
			url : "/upimge",
			data : JSON.stringify(requestData),
			contentType : "application/json",
			success : function(response) {
				pasteHTML(updateFileNames1);
			},
			error : function(xhr, status, error) {
				alert("수정파일 오류: " + error);
			}
		});
	}

	function save() {
		console.log("save")
		// 에디터의 내용을 업데이트합니다.
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		// 제목과 내용을 가져옵니다.
		let id = document.getElementById("id").value;
		let catagory = document.getElementById("category").value;
		let state = document.getElementById("state").value; // let를 let로 변경
		
		let type = document.getElementById("type").value; // let를 let로 변경
		let temporary_name = document.getElementById("temporary_name").value; // let를 let로 변경
		let color = document.getElementById("color").value; // let를 let로 변경
		let age = document.getElementById("age").value; // let를 let로 변경
		let weight = document.getElementById("weight").value; // let를 let로 변경
		let gender = document.getElementById("gender").value; // let를 let로 변경
		let content = document.getElementById("content").value; // let를 let로 변경

		console.log("save content:", content)
		// 이미지 파일 이름 추출과 동시에 content 변수 수정
		let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;
		let match;
		while (match = regex.exec(content)) {
			let imageName = match[1];
			imageFileNames1.push(imageName);
			// content 변수 수정
			let pattern = new RegExp('(/image_parcelOut/ready/' + imageName
					+ ')', 'g');
			content = content.replace(pattern, '/image_parcelOut/complete/'
					+ imageName);
		}

		let requestData = {
			imageFileNames1 : imageFileNames1
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
				alert("수정파일 오류: " + error);
			}
		});

		let titleImagePath = document.getElementById('titleImagePreview').src;

		$.ajax({
			type : 'POST',
			url : '/doSalesRegistration', // 서버 URL을 여기에 입력하세요.
			data : {
				id : id,
				catagory : catagory,
				state : state,
				type : type,
				temporary_name : temporary_name,
				titleImagePath : titleImagePath,
				color : color,
				age : age,
				weight : weight,
				gender : gender,
				content : content
			},

			success : function(response) {
				location.href = '/parcelOutList'
				alert("등록완료");
			},
			error : function(xhr, status, error) {
				alert("등록실패!");
			}
		})

	}

	//제목 이미지 업로드 함수
	function titleuploadImage() {
		return new Promise(
				function(resolve, reject) {
					let formData = new FormData();
					let titlefileInput = document
							.getElementById("titlefileInput").files[0];
					formData.append('file', titlefileInput);
					// 새로운 이미지가 업로드되지 않았을 때는 기존의 title_img를 반환
					if (!titlefileInput) {
						resolve("${view[0].image}");
						return;
					}

					// 이미지를 서버에 업로드합니다.
					$
							.ajax({
								type : "POST",
								url : "/titleuploadImage",
								data : formData,
								processData : false,
								contentType : false,
								success : function(response) {
									if (response.success) {
										let imageFileName = response.imageFileName;
										let imagePath = '/image_parcelOut/title_img/'
												+ imageFileName; // 이미지 저장 경로에 파일 이름을 추가합니다.
										// 이미지 경로를 데이터베이스의 title_img 칼럼에 저장합니다.
										document
												.getElementById('titleImagePreview').src = imagePath;
										resolve(imagePath); // 이미지 경로를 반환합니다.
									} else {
										reject("이미지 업로드에 실패했습니다.");
									}
								},
								error : function(xhr, status, error) {
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

		// 이미지를 서버에 업로드합니다.
		$.ajax({
			type : "POST",
			url : "/uploadImage",
			data : formData,
			processData : false,
			contentType : false,
			success : function(response) {
				if (response.success) {
					let imageFileName = response.imageFileName;
					let imagePath = '/image_parcelOut/ready/' + imageFileName; // 이미지 저장 경로에 파일 이름을 추가합니다.
					pasteHTML(imagePath);
				} else {
					alert("이미지 업로드에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				alert("이미지 업로드 중 오류가 발생했습니다: " + error);
			}
		});
	}

	function pasteHTML(filepath) {
		let sHTML = '<img src="' + filepath + '">';
		oEditors.getById["content"].exec("PASTE_HTML", [ sHTML ]);
	}
</script>

<!-- 에디터 초기화 스크립트 -->
<script id="smartEditor" type="text/javascript">
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "content",
		sSkinURI : "/libs/smarteditor/SmartEditor2Skin.html",
		fCreator : "createSEditor2",
		htParams : {
			bUseToolbar : true,
			bUseVerticalResizer : false,
			bUseModeChanger : false
		}
	});
</script>
</html>