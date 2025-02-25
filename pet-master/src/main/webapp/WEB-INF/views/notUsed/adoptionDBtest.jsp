<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB연동테스트</title>
</head>
<body>
<table>
  <tr>
	<td colspan="2"><input type="hidden"></td>
  </tr>
  <tr>
    <td>사진</td>
    <td><input type="text"></td>
  </tr>
  <tr>
    <td>동물종류</td>
    <td><input type="text"></td>
  </tr>
  <tr>
    <td>제목</td>
    <td><input type="text"></td>
  </tr>
  <tr>
    <td><input type="button" id="btnAdd" value="등록"></td>
  </tr>
</table>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on('click','#btnAdd',function(){
  $.ajax({
	type:'GET',
    url:'/',
    data:{sent_id:$('#vid').val()},
    dataType:'json',//'text' 
    success:function(data){
    	console.log(data)
    }
    
	 
  })
})
</script>
</html>