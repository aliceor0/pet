<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
<!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
	<%@ include file="../include/header.jsp"%>
	<!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp"%>
	<%@ include file="../include/parcelOutHeader.jsp"%>
	<div>
		<form method="post" action="/doSalesRegistration"
			enctype="multipart/form-data">

				<c:if test="${view[0].id != null}">
				<input type=hidden value="수정하기">
					<P>
						제목 : <input type="text" name="title" id="title" value="${view[0].title}">
					</P>
					<p>
						<input type="file" name='file' class="form-control" id="file"
							value="${view[0].image}" />
					</p>
					<p>
						<input type=hidden value="${view[0].id}" name="id">
					<P>
						종류: <input type="text" name="type" id="type" value="${view[0].type}">
					</P>
					<P>
						예비이름: <input type="text" name="temporaryName" id="temporaryName"
							placeholder="예쁘게 지어" value="${view[0].temporary_name}">
					</P>
					<P>
						성별: <input type="text" name="gender" id="gender"
							value="${view[0].gender}">
					</P>
					<P>
						색상: <input type="text" name="color" id="color"
							value="${view[0].color}">
					</P>
					<P>
						나이: <input type="text" name="age" id="age" value="${view[0].age}">
					</P>
					<P>
						몸무게: <input type="text" name="weight" id="weight"
							value="${view[0].weight}">
					</P>
					<P>
						임시보호자 이름: <input type="text" name="shelterName" id="shelterName"
							value="${view[0].nickname}" readonly>
					</P>
					<P>
						임시보호자의 번호: <input type="text" name="number" id="number"
							value="${view[0].mobile}" readonly>
					</P>

<!-- 				<textarea id="txtContent" rows="30" cols="100" style="width: 100%;" required></textarea>
				이미지 업로드 입력란
				<input type="file" id="fileInput" onchange="uploadI(event)" /> -->

					<p>
						<input type="submit" value="등록하기" id="resubmit">
					</p>
				</c:if>

			<!-- 새로등록 하기 -->
			<c:if test="${view[0].id == null}">
			<input type=hidden value="새글 작성">
				<P>
					제목 : <input type="text" name="title" id="title">
				</P>
				<p>
					<input type="file" name='file' class="form-control" id="file" />대표이미지
				</p>
				<P>
					종류: <input type="text" name="type" id="type">
				</P>
				<P>
					예비이름: <input type="text" name="temporaryName" id="temporaryName"
						placeholder="중복X">
				</P>
				<P>
					성별: <input type="text" name="gender" id="gender">
				</P>
				<P>
					색상: <input type="text" name="color" id="color">
				</P>
				<P>
					나이: <input type="text" name="age" id="age">
				</P>
				<P>
					몸무게: <input type="text" name="weight" id="weight">
				</P>
				<P>
					임시보호자 이름: <input type="text" name="shelterName" id="shelterName"	value="${info[0].nickname}" readonly>
				</P>
				<P>
					임시보호자의 번호: <input type="text" name="mobile" id="mobile" value="${info[0].mobile}" readonly>
				</P>
<!-- 				<textarea id="txtContent" rows="30" cols="100" style="width:100%;" required></textarea>
				이미지 업로드 입력란
				<input type="file" id="fileInput" onchange="uploadI(event)" /> -->
				<input type="submit" value="등록하기" id="resubmit">
				</c:if>
		</form>
	</div>
	<div>
		<p>
			★ 사진의 크기(용량)이 너무 크면 등록이 불가하오니 <a
				href="https://www.iloveimg.com/ko/compress-image" target="_blank">[여기를
				눌러주세요]</a>
		</p>
		<p>이미지 압축 후 등록해주시면 됩니다!★</p>
	</div>
	<button id="home">홈으로</button>

</body>
<footer>
	<%@ include file="../include/footer.jsp"%>
</footer>
<script>
let oEditors = [];
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
    
/* $(document)

	.on(
			'keypress',
			'#type,#temporaryName,#characteristic,#gender,#gender,#color,#age,#weight,#shelterName,#number,#file,#file2,#file3,#file4,#file5',
			function(e, u) {
				if (e.keyCode == 13)
					event.preventDefault();
			}) */

})
.on("click", "#home", function() {
	location.href = '/'
})
function pasteHTML(filepath) {
 let sHTML = '<img src="' + filepath + '">';
 oEditors.getById["txtContent"].exec("PASTE_HTML", [sHTML]);
} 
</script>
</html>