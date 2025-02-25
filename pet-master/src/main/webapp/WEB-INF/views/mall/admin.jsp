<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/admin.css" rel="stylesheet" type="text/css">
</head>
<style>
</style>
<body>

  <nav id="nav" >
      <span id="serchArea" style="padding-left: 150px;width: 20%; ">
        <button id="doSerch" onclick="location.href='/'" style="width: 70%;">어쩌구</button>
    </span>
    <span id="categoryBar" style="width:80%">
        <a href="/admin" class="categoryMenu">상품관리</a>
        <a href="/adminorder" class="categoryMenu">주문관리</a>
        <a href="memberList" class="categoryMenu">고객관리</a>
        <button id="doSerch" onclick="location.href='/'">메인페이지</button>
    </span>
</nav>
<div style="height: 140px;">
<table style="height: 100%; width: 100%; ">
    <tr >
        <td style="width: 15%; text-align: center;">상품관리</td>
        <td>여기는 비워주는곳</td>
        <td style="width: 15%; vertical-align: bottom;text-align: right;"><button onclick="location.href='/addGoods' ">상품추가</button></td>
    </tr>
</table>
<div>
<div style="text-align: right">
</div>
<div style="">
	    <table class="goodsL" style="margin: 30px 40px 0px 50px; width: 92%;">
	    </table>
</div>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)
.ready(function(){
	getGoodsList()//시작하면 상품테이블생성
})
.on('click','.siuu',function(){ //수정버튼
	let a=$(this).parent().parent().find('td:eq(0)').text();
	$.ajax({
		type:'post',
		url:'/siuuGoods',
		data:{goodsid:$(this).parent().parent().find('td:eq(0)').text()},
		dataType:'text',
		success:function(data){
			window.location.href = '/addGoods';
		}
	})
})
.on('click','.sack',function(){ //삭제버튼
	if(confirm("정말로 삭제하시겠습니까?")){
		$.ajax({
			type:'get',url:'/delete',data:{id:$(this).parent().parent().find('td:eq(0)').text()},
			dataType:'text',
			success:function(data){
				$('.goodsL').empty();
				getGoodsList();
			}
		})
		alert("정상적으로 삭제했습니다")
	}else{
		alert()
	}
})
function getGoodsList(){ //테이블가져오는 함수
	$.ajax({
		type:'post',
		url:'/goodslist',
		data:{},
		dataType:'json',
		success:function(data){
			let Headtable = '<tr><td>제품ID(id)</td><td>카테고리(category)</td>'+
	            '<td>제품사진(img1)</td><td>계시명(title)</td><td>상품가격(price)</td>'+
				'<td>할인률(discnt)</td><td>할인가격(price*discnt)</td>'+
	            '<td>재고량(stock)</td><td>배송방법</td><td>수정/삭제</td></tr>';
	        $('.goodsL').append(Headtable);
			for(let i = 0;i<data.length;i++){
				let ob = data[i];
				let price =ob['price']
				let discnt = ob['discnt']
				let disprice = price*(1 - discnt / 100)
				let to10 = Math.round(disprice / 10) * 10;
				let str = '<tr><td>'+ob['id']+'</td><td>'+ob['category']+'</td><td>'+
				'<img style="width:120px" src="/image_mall/title_img/'+ob['img1']+'">'+
				'</td><td>'+ob['title']+'</td><td>'+ob['price']+'</td><td>'+ob['discnt']+'%'+'</td><td>'+
				to10+'</td><td>'+ob['stock']+'</td><td>'+ob['delpay']+'</td><td>'+'<button class="siuu" value="'+ob['id']+'">수정</button>/'+
				'<button class="sack" value="'+ob['id']+'">삭제</button>'+'</td></tr>'
				$('.goodsL').append(str);
			}
		}
	})
}
</script>
</html>