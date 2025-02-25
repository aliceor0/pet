<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<%@ include file="../include/head.jsp" %>
		<style>
		        .main {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
		
		
		
        #title {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 18px;
        }

        #titlefileInput,
        #fileInput {
            margin-bottom: 20px;
        }

        #titleImagePreview {
            max-width: 100%;
            height: auto;
            margin-top: 10px;
        }

        #imageContainer {
            margin-bottom: 20px;
        }

        #txtContent {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            resize: vertical;
        }

        #se2_sample input[type="button"] {
            padding: 10px 20px;
            background-color: #2a8890;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }

        #se2_sample input[type="button"]:hover {
            background-color: #0056b3;
        }

        @media (max-width: 768px) {
            #title {
                font-size: 16px;
            }

            #txtContent {
                font-size: 14px;
            }

            #se2_sample input[type="button"] {
                font-size: 16px;
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
    <%@ include file="../include/adoptionHeader.jsp" %>
    <div class="container">
      <h2>입양후기 작성</h2>
  <!-- 검색버튼은 돋보기 이미지로 교체할 것 -->
<!--   <input type="text"><button>검색</button> -->
  <hr>
	<input type="hidden" id="id" name="id" value="" readonly>
	
	
	<!-- value 꼭! 1로 바꿀것 -->
	<input type="hidden" id="category" name="category" value="30" readonly>
	
	
	<textarea id="title" rows="2" cols="100" placeholder="제목을 입력하세요"></textarea><br>
	<input type="file" id="titlefileInput" onchange="titleuploadImage(event)" accept="image/*"/>
	 <div>
    <img id="titleImagePreview"style="max-width: 20%; height: auto;">
	</div> 
	

	<div id="imageContainer"></div>
	
	<!-- 내용 입력란 -->
	<textarea id="txtContent" rows="30" cols="100" style="width: 100%;"></textarea>
	
	<!-- 이미지 업로드 입력란 -->
	<input type="file" id="fileInput" onchange="uploadImage(event)" accept="image/*" />
	
	
	
	<!-- 저장 버튼 -->
	<div id="se2_sample" style="margin:10px 0;">
	    <input type="button" onclick="save();" value="글등록하기">
	</div>

</div>
	<%@ include file="../include/footer.jsp" %>
</body>
<!-- 외부 자바스크립트 파일 및 라이브러리 추가 -->
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script>
//텍스트 에디터 초기화 및 설정
let oEditors = []; //
let imageFileNames1 = [];
let imagePath;

//페이지 로드 시 카테고리 옵션을 동적으로 추가합니다.
$(document)
	.ready(function() {

});

//저장 버튼 클릭 시 실행되는 함수
function save() {
    // 에디터의 내용을 업데이트합니다.
    oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);
    
    // 제목과 내용을 가져옵니다.
    let id = $("#id").val();
    let title = $("#title").val();
    let category = $("#category").val();
    let content = $("#txtContent").val();

    console.log("save content:", content);

    let imageFileNames1 = [];  // imageFileNames1 배열 초기화

    // 이미지 파일 이름 추출과 동시에 content 변수 수정
    let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;
    let match;
    let imageName;
    
    while (match = regex.exec(content)) {
        imageName = match[1];
        
        imageFileNames1.push(imageName);
        // content 변수 수정
        let pattern = new RegExp('(/image_adopt/temp_img/' + imageName + ')', 'g');
        content = content.replace(pattern, '/image_adopt/final_img/' + imageName); 
    }

    console.log(imageName);
    
    let requestData = {
        imageFileNames1: imageFileNames1,
        operationType: 'adopt' // 또는 'other'
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
    let finalImagePath = '/image_adopt/title_img/' + titleimageName; // 최종 이미지 경로

    // 이미지 업로드가 완료되면 서버에 데이터를 전송합니다.
    $.ajax({
        type: "POST",
        url: "/addAdoptReview",
        data: { id: id, category: category, title: title, title_img: finalImagePath, content: content }, // 이미지 경로를 추가
        success: function(response) {
            alert("내용이 성공적으로 저장되었습니다2!");
            location.href = '/adoptionReviews'
        },
        error: function(xhr, status, error) {
            alert("내용 저장 중 오류가 발생했습니다3: " + error);
        }
    });
}
    
    
function titleuploadImage(savePathType1) {
    return new Promise(function(resolve, reject) {
        let formData = new FormData();
        let titlefileInput = $("#titlefileInput")[0].files[0];
        formData.append('file', titlefileInput);
        
        let savePathType1 = 'adopt'; // 변수를 정의한 다음에 사용합니다.
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
                    let imagePath = '/image_adopt/title_img/'  + imageFileName;
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
    let savePathType = "adopt"; // 또는 필요에 따라 다른 값으로 설정
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
                let imagePath = '/image_adopt/temp_img/'  + imageFileName; // 이미지 저장 경로에 파일 이름을 추가합니다.  
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


<!-- 에디터 초기화 스크립트 -->
<script id="smartEditor" type="text/javascript"> 
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
</script>

</html>