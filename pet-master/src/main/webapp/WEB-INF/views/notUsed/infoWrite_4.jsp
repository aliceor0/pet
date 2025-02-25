<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        width: 80%;  /* 수정된 부분 */
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 18px;
    }

    #category {
        width: 19%;  /* 수정된 부분 */
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 18px;
        height: 45px;
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

        #category {
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
    <%@ include file="../include/informationHeader.jsp" %>
    
    <div class="container">
    
	<input type="hidden" id="id" name="id" value="${information_board.id}" readonly>
	<select name="category" id="category"></select><textarea id="title" rows="2" cols="100" placeholder="제목을 입력하세요"></textarea>
	<input type="file" id="titlefileInput" onchange="titleuploadImage(event)" accept="image/*"/>
	 <div>
    <img id="titleImagePreview" style="max-width: 20%; height: auto;">
	</div> 
	
	<!-- 내용 입력란 -->
	<textarea id="txtContent" rows="30" cols="100" style="width: 100%;"></textarea>
	
	<!-- 이미지 업로드 입력란 -->
	<input type="file" id="fileInput" onchange="uploadImage(event)" accept="image/*" />
	
	
	
	<!-- 저장 버튼 -->
	<div id="se2_sample" style="margin:10px 0;">
	    <input type="button" onclick="save();" value="글등록하기">
	</div>

    
<a href="/infoMain_4">훈련 및 정보</a>
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
let boardName = 'information';

//페이지 로드 시 카테고리 옵션을 동적으로 추가합니다.
$(document)
	.ready(function() {
		$.ajax({
		    type: "POST",
		    url: "/category",
		    data:{},
		    dataType: 'json',
		    success: function(response) {
		    	response.forEach(function(category) {
	                // 카테고리 ID가 11, 12, 13인 경우에만 옵션으로 추가합니다.
	                if (category.id === 11 || category.id === 12) {
	                    $('#category').append('<option value="' + category.id + '">' + category.state + '</option>');
	                }
		        });
		    },
		    error: function(xhr, status, error) {
		        alert("카테고리를 불러오는 중 오류가 발생했습니다: " + error);
		    }
		});
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
});
</script>
</html>