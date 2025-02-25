<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/head.jsp" %>
	<style>
	    table {
	        width: 100%;
	        border-collapse: collapse;
	        border-spacing: 0;
	    }
	
	    table td {
	        padding: 10px;
	        height: 60px;
	    }
	
	    #title {
	        width: 100%;
	        border: 1px solid #ccc;
	        border-radius: 4px;
	        font-size: 18px;
	        height: 45px;
	        padding: 10px;
	    }
	
	    #category {
	        width: 25%;
	        border: 1px solid #ccc;
	        border-radius: 4px;
	        font-size: 18px;
	        height: 45px;
	    }
	
	    #fileInput {
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
	    
	    #se2_sample .btn-back {
	        padding: 10px 20px;
	        background-color: #e0e0e0;
	        color: black;
	        border: none;
	        border-radius: 4px;
	        cursor: pointer;
	        font-size: 18px;
	        transition: background-color 0.3s ease;
	    }
	
	    #se2_sample input[type="button"]:hover {
	        background-color: #0056b3;
	    }
	
	    .file-input-container {
	        display: block;
	        width: 170px;
	        height: 170px;
	        text-align: center;
	        cursor: pointer;
	        position: relative;
	        overflow: hidden;
	    }
	
	    .file-input-container input[type="file"] {
	        position: absolute;
	        width: 100%;
	        height: 100%;
	        opacity: 0;
	        cursor: pointer;
	        z-index: 2;
	    }
	
	    #titlefileInput {
	        position: absolute;
	        width: 100%;
	        height: 100%;
	        opacity: 0;
	        cursor: pointer;
	    }
	
	    #titleImagePreview {
	        max-width: 100%;
	        max-height: 100%;
	        width: 100%;
	        height: 100%;
	        object-fit: cover;
	        z-index: 1;
	    }
	</style>
</head>
<body id="page-top">
	<!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp" %>
    <!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp" %>
	<!-- 중간 nav역할 -->
    <jsp:include page="/WEB-INF/views/include/${board}Header.jsp" />
    
    <div class="container">
	    <input type="hidden" id="id" name="id" value="" readonly>
	    <table>
	    	<tr>
				<td rowspan="3" style="width: 180px; text-align: center; padding-bottom: 0;">
				    <label for="titlefileInput" class="file-input-container" style="display: inline-block; position: relative; bottom: 0; width: 100%;">
				        <input type="file" id="titlefileInput" onchange="titleuploadImage()" accept="image/*" style="display: none;"/>
				        <img id="titleImagePreview" style="width: 100%; height: auto; z-index: 0; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"/>
				        <span class="input-message" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1;">썸네일 첨부</span>
				    </label>
				</td>
	    		<td>
	    			<p>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td style="vertical-align: bottom; padding-bottom: 0;">
					<select name="category" id="category">
					    <c:forEach items="${categoryList}" var="category">
					        <c:if test="${(board == 'adoption' and category.id == 1) 
					        			or (board == 'information' and (category.id == 13 or category.id == 14))
					        			or (board == 'community' and (category.id == 9 or category.id == 12))}">
					            <option value="${category.id}" data-board="${board}">${category.state}</option>
					        </c:if>
					    </c:forEach>
					</select>
	    		</td>
	    	</tr>
	    	<tr>
		    	<td>
		    		<input type="text" id="title" placeholder="제목을 입력하세요">
		    	</td>
	    	</tr>
	    </table>
		<!-- 내용 입력란 -->
		<textarea id="txtContent" rows="30" cols="100" style="width: 100%;"></textarea>
	
		<!-- 이미지 업로드 입력란 -->
		<input type="file" id="fileInput" onchange="uploadImage(event)" accept="image/*" />
	
	
	
		<!-- 저장 버튼 -->
		<div id="se2_sample" style="margin:10px 0; text-align:center;">
	    	<input type="button" onclick="save();" value="글등록하기">
	    	<button class="btn-back" onclick="history.back()">돌아가기</button>
		</div>
	</div>
	<footer>
		<%@ include file="../include/footer.jsp" %>
	</footer>
</body>

<script>
let boardName = $('#category').find("option:selected").data('board');

$(document)
.ready(function() {

});
</script>
<!-- 스마트에디터 로드 -->
<script type="text/javascript" src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/js/editor.js"></script>
</html>