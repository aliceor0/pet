<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="include/head.jsp" %>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body id="page-top">
	 <!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="include/sitemap.jsp" %>
		<!-- 중간 nav역할 -->
    <%@ include file="include/communityHeader.jsp" %>
    
	<textarea id="txtContent" rows="30" cols="100" style="width: 100%;" required></textarea>
	<!-- 이미지 업로드 입력란 -->
	<input type="file" id="fileInput" onchange="uploadI(event)" />
	<input type="button" onclick="save();" value="글등록하기">
	<input type="button" onclick="che();" value="체크">
</body>
<script>
let oEditors = [];
let imageFileNames1 = [];
let imagePath;
let imageName;

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
})


function che() {
	console.log("진입")
	imageFileNames1 = []
    // 에디터의 내용을 업데이트합니다.
    oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);

    // 스마트에디터 내부의 content을 가져옵니다.
 	let content = document.getElementById("txtContent").value;
 	console.log(content)
 	let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;

 	let match;
 	while (match = regex.exec(content)) {
 	    let imageName = match[1];
 	    imageFileNames1.push(imageName);
 	}

 	console.log("배열 맞나요? " + imageFileNames1);
 	
    oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);  
    content = document.getElementById("txtContent").value;
	
    imageFileNames1.forEach(function(fileName) {
        let pattern = new RegExp('(/testimg/' + fileName + ')', 'g');
        content = content.replace(pattern, '/mainimg/' + fileName);
    });
    
    console.log("str = " + content);
}


function save() {
	
    // 에디터의 내용을 업데이트합니다.
    oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);

    // 스마트에디터 내부의 content을 가져옵니다.
 	let content = document.getElementById("txtContent").value;
 	let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;

 	let match;
 	while (match = regex.exec(content)) {
 	    let imageName = match[1];
 	    imageFileNames1.push(imageName);
 	}

    content = document.getElementById("txtContent").value;
	
    imageFileNames1.forEach(function(fileName) {
        let pattern = new RegExp('(/testimg/' + fileName + ')', 'g');
    	content = content.replace(pattern, '/mainimg/' + fileName);
    });

    let requestData = {
        content: content,
        imageFileNames1: imageFileNames1
    };

    $.ajax({
        type: "POST",
        url: "/tempimage1",
        data: JSON.stringify(requestData),
        contentType: "application/json",
        success: function(response) {
            alert("내용이 성공적으로 저장되었습니다!");
            location.href="/tempimage";
        },
        error: function(xhr, status, error) {
            alert("내용 저장 중 오류가 발생했습니다: " + error);
        }
    });
}


//이미지 업로드 함수
function uploadI(event) {
 let formData = new FormData();
 let fileInput = event.target.files[0];
 formData.append('file', fileInput);
 // 이미지를 서버에 업로드합니다.
 $.ajax({
     type: "POST",
     url: "/uploadI",
     data: formData,
     processData: false,
     contentType: false,
     success: function(response) {
         if (response.success) {
             let imageFileName = response.imageFileName;
             let imagePath = '/testimg/' + imageFileName; // 이미지 저장 경로에 파일 이름을 추가합니다.
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
</script>
</html>