<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<% response.setContentType("text/html; charset=UTF-8");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>네이버 메일 쓰기</title>
    <style>
       
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>네이버 메일 쓰기</h1>
        </div>
        <div class="content">
            <textarea id="smartTxt" name="smartTxt" placeholder="메일 내용을 입력해주세요"></textarea>
            <button class="btn">보내기</button>
        </div>
    </div>
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/ㅇㄹjquery.min.js"></script>
    <script type="text/javascript" src="/smarteditor/SmartEditor2Skin.html"></script>
    <script type="text/javascript">
        function smartEditor() {
            nhn.husky.EZCreator.createInIFrame({
                oAppRef: oEditors,
                elPlaceHolder: "smartTxt",
                sSkinURI: "/smarteditor/SmartEditor2Skin.html",
                fCreator: "createSEditor2"
            });
        }

        // 에디터 영역을 확인하고 초기화합니다.
        $(document).ready(function () {
            smartEditor();
        });
    </script>
</body>
</html>