<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
</head>
<style>
    .main {
        max-width: 1200px;
        margin: 50px auto;
        padding: 20px;
        background-color: #f4f4f4;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .flex-container {
        display: flex;
        justify-content: space-between;
    }

    .flex-container > div {
        flex: 1;
        padding: 0 20px;
    }

    .flex-container > div img {
        max-width: 100%;
        height: auto;
        border-radius: 4px;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        height: 500px;
        overflow-y: auto;
    }

    table, th, td {
        border: 1px solid #ccc;
    }

    table th, table td {
        padding: 8px;
        text-align: left;
    }
	
	   .content-box {
        flex-basis: 100%;
        text-align: center;
        margin-top: 20px;
    }

    b {
        font-weight: bold;
    }

    p {
        margin-bottom: 10px;
    }
    .main div img {
        max-width: 500px;
        height: auto;
        border-radius: 4px;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    table, th, td {
        border: 1px solid #ccc;
    }

    table th, table td {
        padding: 8px;
        text-align: left;
    }

    b {
        font-weight: bold;
    }

    p {
        margin-bottom: 10px;
    }

    button {
        padding: 10px 20px;
        margin-right: 10px;
        background-color: #2a8890;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }

    button:hover {
        background-color: #0056b3;
    }
</style>
<body id="page-top">
	<input type=hidden value="1" class="category-id">
	<input type=hidden value="${view[0].id}" class="post-id">
	<!-- 상단 네비게이션바 정보 헤더에 포함 -->
	<%@ include file="../include/header.jsp"%>
	<!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp"%>
	<%@ include file="../include/parcelOutHeader.jsp"%>
<div class="container main">
<div class="flex-container">
    <div>
        <c:if test="${sessionScope.name == view[0].nickname}">
            <button id="delete">삭제</button>
            <button id="modify">수정</button>
            <select id="category">
                <option value="2">분양 중</option>
                <option value="3">예약 중</option>
                <option value="4">분양 종료</option>
            </select>
            <button id="change">상태바꾸기</button>
        </c:if>
        <input type=hidden value="${view[0].id}" id="id">
        <img src="${view[0].image}" alt="이미지">
    </div>

    <div>
        <table>
            <tr>
                <th>종류</th>
                <td>${view[0].type}</td>
            </tr>
            <tr>
                <th>색상</th>
                <td>${view[0].color}</td>
            </tr>
            <tr>
                <th>나이</th>
                <td>${view[0].age}</td>
            </tr>
            <tr>
                <th>몸무게</th>
                <td>${view[0].weight}</td>
            </tr>
            <tr>
                <th>성별</th>
                <td>${view[0].gender}</td>
            </tr>
            <tr>
                <th>예비이름</th>
                <td>${view[0].temporary_name}</td>
            </tr>
            <tr>
                <th>주인장 닉네임</th>
                <td>${view[0].nickname}</td>
            </tr>
            <tr>
                <th>주인장 번호</th>
                <td>${view[0].mobile}</td>
            </tr>
        </table>
    </div>
</div>
       
    <div class="content-box">
        <p>${view[0].content}</p>

    </div>
<button id="home">홈으로</button>
<button id="back">뒤로가기</button>
	<%@ include file="../include/comment.jsp"%>
</div>
	<footer>
	<%@ include file="../include/footer.jsp"%>
</footer>
</body>
<script>
$(document)
.ready(function() {
	/* showpage() */
})

.on("click", "#home", function() {
	location.href = '/'
})
.on("click", "#back", function() {
	location.href = '/parcelOutList'
})
.on("click", "#modify", function() {
	let id = $('#id').val();
	location.href = '/parcelUpdate?id='+id
})
.on("click", "#change", function() {
	let state = $('#state option:selected').val()
	let id = $('#id').val();
	if (confirm("변경할까요?") == true) {
		$.ajax({
			type : 'post',
			url : '/doState',
			data : {
				state : state,
				id : id
			},
			dataType : 'text',
			success : function(data) {
				if (data == '1') {
					alert('상태 변경 완료')
					location.href = '/parcelOutList'
				} else {
					alert('상태 변경 실패');
				}
			}
		})
	}
})

.on("click", '#delete', function() {
	if (confirm("삭제하시겠습니까?") == true) {
		$.ajax({
			type : 'post',
			url : '/doDelete',
			data : {
				id : $('#id').val()
			},
			dataType : 'text',
			success : function(data) {
				if (data == '1') {
					alert('삭제완료');
					location.href = '/parcelOutList'
				} else {
					alert('삭제실패');
				}
			}
		})
	}
})/* 
//댓글 처음 페이지
	.on("click", "#first", function() {
		$('#page').val("1")
		replyList()
		showpage()
	})

	//댓글 이전 페이지
	.on("click", "#before", function() {
		let num = $('#pagenum').text();
		let b = num.replace(/(\s*)/g, "")
		$('#page').val(b)
		replyList()
		showpage()
	})
	//댓글 다음 페이지
	.on("click", "#next", function() {
		let num = $('#pagenum').text();
		console.log(num)
		let b = num.replace(/(\s*)/g, "")
		$('#page').val(parseInt(b) + 1)
		replyList()
		showpage()
	})
	//댓글 마지막 페이지
	.on("click", "#last", function() {
		let num = $(this).text();
		$('#lastpage').val()
		replyList()
		showpage()
	})

	댓글 리스트 뽑아오기
	function replyList() {
		$
				.ajax({
					type : 'post',
					url : '/replyList',
					data : {
						id : $('#id').val(),
						page : $('#page').val()
					},
					dataType : 'json',
					success : function(data) {
						$('#reply_table').empty();
						let str = '<table>'
						for (i = 0; i < data.length; i++) {
							let bo = data[i];
							str += '<tr><td><input type=hidden id="reply_id" value="'+bo['id']+'">'
									+ bo['name'] + '</td><td>'
							if (bo['name'] == $('#reply_name').val()) {
								str += '<td><input type="text" value="'+bo['content']+'" id="reply_conntent"></td>'
										+ '<td>' + bo['time'] + '</td>'

							} else {
								str += '<td><input type="text" value="'+bo['content']+'" id="reply_conntent" readonly></td>'
										+ '<td>' + bo['time'] + '</td>'
							}
							if (bo['name'] == $('#reply_name').val()) {
								str += '<td><button id="reply_ch">댓글 수정</button><button id="reply_de">댓글 삭제</button></td>'
							}
						}
						str += '</tr></table>';
						$('#reply_table').append(str);
					}
				})
	}
	페이지번호 호출
	function showpage() {
		$
				.ajax({
					type : 'get',
					url : '/showpage',
					data : {
						id : $('#id').val(),
						page : $('#page').val()
					},
					dataType : 'text',
					success : function(data) {
						$('#showpage').empty()
						let b = data.slice(1, -1)
						b = b.replace(/(\s*)/g, "")
						let a = b.split(',')
						let str = '<tr><td><button id=first>맨처음</button><button id=before>이전</button>'
						for (let i = 0; i < a.length; i++) {
							str += '<button id=pagenum value='+a[i]+'>' + a[i]
									+ '</button>'
						}
						str += '<button id=next>다음</button><button id=last>마지막</button></td></tr>'
						$('#showpage').append(str)
						if ($('#page').val() == 1) {
							$('#before').hide()
						}
						if ($('#page').val() == $('#lastpage').val()) {
							$('#next').hide()
						}
					}
				})
	} */
</script>
</html>