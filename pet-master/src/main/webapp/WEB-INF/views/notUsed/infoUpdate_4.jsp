<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../include/head.jsp" %>
    <meta charset="UTF-8">
    <title>update</title>
</head>

<body id="page-top">
    <%-- 상단 네비게이션바 정보 헤더에 포함 --%>
    <%@ include file="../include/header.jsp" %>
    <%-- 우측 햄버거버튼에 관한 정보 --%>
    <%@ include file="../include/sitemap.jsp" %>
    <%-- 중간 nav역할 --%>
    <%@ include file="../include/informationHeader.jsp" %>
<div class="container">
    <%-- 제목 입력란 --%>
    <input type="hidden" id="id" name="id" value="${information_board.id}" readonly>
    <textarea id="title"  rows="2" cols="100" placeholder="${information_board.title}">${information_board.title}</textarea><br>
    <select name=category id=category></select>
    <input type="file" id="titlefileInput" onchange="titleuploadImage(event)" accept="image/*"/>
    <%-- 제목 이미지 미리보기 --%>
    <div>
        <img id="titleImagePreview" src="${information_board.title_img}" alt="제목이미지첨부" style="max-width: 20%; height: auto;">
    </div>

    <%-- 내용 입력란 --%>
    <textarea id="txtContent" rows="30" cols="100" style="width: 100%;">${information_board.content}</textarea>
    <%-- 이미지 업로드 입력란 --%>
    <input type="file" id="fileInput" onchange="uploadImage(event)" accept="image/*" />

    <%-- 저장 버튼 --%>
    <div id="se2_sample" style="margin:10px 0;">
        <input type="button" onclick="save();" value="글등록하기">
    </div>
    <a href="/infoMain_4">정보 메인</a>
    <a href="/infoMain1_4">반려동물정보</a>
    <a href="/infoMain2_4">기초훈련방법</a>
</div>
    <%-- 외부 자바스크립트 파일 및 라이브러리 추가 --%>
    <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
    <script>
        // 텍스트 에디터 초기화 및 설정
        let oEditors = []; // 
        let updateFileNames1 = []; // 업데이트 삽입 (upimge)
        let imageFileNames1 = []; // 이미지 삽입 (eximge)
        let imagePath;
        let imageName;

        // 페이지 로드 시 실행되는 부분
        $(document).ready(function() {
            // 시작시 이미지 최종 경로에서 임시 경로로 이동 
            Imglist();

            $.ajax({
          	    type: "POST",
          	    url: "/category",
          	    data:{},
          	    dataType: 'json',
          	    success: function(response) {
          	    	response.forEach(function(category) {
                          // 카테고리 ID가 11, 12, 13인 경우에만 옵션으로 추가합니다.
                          if (category.id === 11 || category.id === 12 || category.id === 13) {
                              $('#category').append('<option value="' + category.id + '">' + category.state + '</option>');
                          }
          	        });
          	    },
          	    error: function(xhr, status, error) {
          	        alert("카테고리를 불러오는 중 오류가 발생했습니다: " + error);
          	    }
          	});
        });

        function Imglist() {
            // 이미지 임시경로로 이동을 위한 함수
            let content = document.getElementById("txtContent").value;
            let updateFileNames1 = [];
            console.log("img content:", content)
            let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;
            let match;
            while (match = regex.exec(content)) {
                let imageName = match[1];
                updateFileNames1.push(imageName);

                // 이미지 경로 이름 저장 
                let pattern = new RegExp('(/image_information/final_img/' + imageName + ')', 'g');
                content = content.replace(pattern, '/image_information/temp_img/' + imageName);
                console.log("imgs content:", content);
            }

            let requestData = {
                updateFileNames1: updateFileNames1,
                operationType: 'information'   // 저장공간 설정  /upimge 및 /moveImagesToSave 확인할것 
            };

            // 서버에 이미지 업데이트를 요청
            $.ajax({
                type: "POST",
                url: "/upimge",  // upimge 안에  /moveImagesToSave 정의되어있음
                data: JSON.stringify(requestData),
                contentType: "application/json",
                success: function(response) {
                    // 이미지 업데이트 성공 시 처리할 코드
                    pasteHTML(imageName);
                    console.log("Success: ", response);
                },
                error: function(xhr, status, error) {
                    alert("수정파일 오류: " + error);
                }
            });
        }

      //저장 버튼 클릭 시 실행되는 함수
        function save() {
            // 에디터의 내용을 업데이트합니다.
            oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);  
            // 제목과 내용을 가져옵니다.
            let id = document.getElementById("id").value; // let를 let로 변경
            let title = document.getElementById("title").value; // let를 let로 변경
            let category = document.getElementById("category").value;
            let content = document.getElementById("txtContent").value; // let를 let로 변경
            
            console.log("save content:", content)
            // 이미지 파일 이름 추출과 동시에 content 변수 수정
            let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;
            let match;
            while (match = regex.exec(content)) {
                let imageName = match[1];
                imageFileNames1.push(imageName);
                // content 변수 수정
                let pattern = new RegExp('(/image_information/temp_img/' + imageName + ')', 'g');
                content = content.replace(pattern, '/image_information/final_img/' + imageName); 
            }
            

            let requestData = {
            	    imageFileNames1: imageFileNames1,
            	    operationType: 'information_temp' // 또는 'other'
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
                let titleImagePath = document.getElementById('titleImagePreview').src;
                let titleimageName = titleImagePath.substring(titleImagePath.lastIndexOf('/') + 1);
                let finalImagePath = '/image_information/title_img/' + titleimageName; // 최종 이미지 경로
             // 이미지 업로드가 완료되면 서버에 데이터를 전송합니다.
                $.ajax({
                    type: "POST",
                    url: "/doinfo",
                    data: { id: id, category: category, title: title, title_img: finalImagePath, content: content }, // 이미지 경로를 추가
                    success: function(response) {
                        alert("내용이 성공적으로 저장되었습니다2!");
                    },
                    error: function(xhr, status, error) {
                        alert("내용 저장 중 오류가 발생했습니다3: " + error);
                    }
                });
            }
            
            
        function titleuploadImage(savePathType1) {
            return new Promise(function(resolve, reject) {
                let formData = new FormData();
                let titlefileInput = document.getElementById("titlefileInput").files[0];
                formData.append('file', titlefileInput);
                let savePathType1 ='information'; // 변수를 정의한 다음에 사용합니다.
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
                            let imagePath = '/image_information/title_img/'  + imageFileName;
                            document.getElementById('titleImagePreview').src = imagePath;
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
            let savePathType = "information"; // 또는 필요에 따라 다른 값으로 설정
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
                        let imagePath = '/image_information/temp_img/'  + imageFileName; // 이미지 저장 경로에 파일 이름을 추가합니다.  
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
	<%@ include file="../include/footer.jsp" %>
        </body>
        </html>