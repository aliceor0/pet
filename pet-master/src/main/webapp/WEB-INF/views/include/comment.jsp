<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="comment-list">
    <c:forEach items="${commentList}" var="list">
        <div class="comment" data-id="${list.id}" style="border-bottom: 1px solid #ccc; padding: 5px;">
            <div class="comment-header" style="display: flex; align-items: center; justify-content: space-between;">
                <div style="display: flex; align-items: center;">
                    <span class="comment-name" style="font-weight: bold; padding-right: 10px;">${list.nickname}</span>
                    <div class="comment-date" style="font-size: 0.8em; color: #777;">${list.created}</div>
                </div>
                <div class="comment-actions" style="text-align: right;">
                    <c:if test="${sessionScope.name == list.nickname}">
                        <span class="btn-modify" onclick="modifyComment((this), ${list.id})" style="margin-right: 5px; cursor: pointer; font-size: 0.9em;">수정</span>
                        <span class="btn-delete" onclick="deleteComment(${list.id}, (this))" style="margin-right: 5px; cursor: pointer; font-size: 0.9em;">삭제</span>
                    </c:if>
                </div>
            </div>
            <div class="comment-content" style="padding: 10px; word-break: break-all;">${list.content}</div>
        </div>
    </c:forEach>
</div>
	<input type=hidden value="${page}" id="page">
	<input type=hidden value="${last}" id="lastpage">
	<div id="showpage">
	</div>
<div class="comment-section" style="margin-top: 15px;">
    <% if (name != null && !name.isEmpty()) { %>
    <div class="comment-header" style="margin-bottom: 10px;">
        <%= name %>
    </div>
    <% } %>

    <div class="comment-content" style="margin-bottom: 10px; display: flex;">
        <textarea class="content-input" onfocus="loginCheck()" style="width: 90%; height: 80px; padding: 10px; box-sizing: border-box; resize: none; margin-right: 2%;" <% if (name == null || name.isEmpty()) { %> placeholder="로그인 후 작성할 수 있습니다" <% } %>></textarea>
        <button class="btn-comment" onclick="addComment()" style="width: 8%; height: 80px; background-color: #2a8890; color: #ffffff; border: none; border-radius: 5px; cursor: pointer;">등록</button>
    </div>
</div>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
let isEditing = false;
let nickname = "${sessionScope.name}";

$(document)
.ready(function() {
// 	showpage()
})

//로그인이 되어있는지 체크하는 함수.
function loginCheck() {
    if (!nickname) {
    	$('.content-input').blur();
		if (confirm("로그인 후 작성 가능합니다. 로그인창으로 이동하시겠습니까?")) {
            location.href = 'login';
            return false;  // 함수 종료
        } else {
        	return false; // 함수 종료
        }
    }
    return true;
}


// 등록 버튼을 눌렀을 때 실행되는 함수
function addComment() {
	//로그인 여부 체크
	if (!loginCheck()) {
        return false; // 함수 종료
    }
    
    let content = $('.content-input').val();
    // 내용이 비어 있거나 공백, 스페이스만 있는 경우
    if (!content.trim()) {
        alert('내용을 입력하세요.');
        $('.content-input').focus();
        return false; // 함수 종료
    }
	console.log($('.post-id').val());
    $.ajax({
        type: 'post',
        url: '/addComment',
        data: {
            categoryId: $('.category-id').val(),
            postId: $('.post-id').val(),
            content: content
        },
        dataType: 'text',
        success: function(data) {
            getComment();
            $('.content-input').val('');
        }
    });
}

// //페이지번호 호출
// function showpage() {
// 		$.ajax({
// 			type : 'get',
// 			url : '/showpage',
// 			data : {
// 				id : $('#id').val(),
// 				page : $('#page').val()
// 			},
// 			dataType : 'text',
// 			success : function(data) {
// 				$('#showpage').empty()
// 				let b = data.slice(1, -1)
// 				b = b.replace(/(\s*)/g, "")
// 				let a = b.split(',')
// 				let str = '<tr><td><button id=first>맨처음</button><button id=before>이전</button>'
// 				for (let i = 0; i < a.length; i++) {
// 					str += '<button id=pagenum value='+a[i]+'>' + a[i]
// 							+ '</button>'
// 				}
// 				str += '<button id=next>다음</button><button id=last>마지막</button></td></tr>'
// 				$('#showpage').append(str)
// 				if ($('#page').val() == 1) {
// 					$('#before').hide()
// 				}
// 				if ($('#page').val() == $('#lastpage').val()) {
// 					$('#next').hide()
// 				}
// 			}
// 		})
// 	}

// 수정버튼 눌렀을 때 및 수정완료, 취소버튼 함수
function modifyComment(button, id) {
    if (isEditing) {
        alert("이미 수정중인 댓글이 있습니다.");
        return false;
    }
    isEditing = true;

    let commentId = id;
    let $comment = $(button).closest('.comment');
    let $content = $comment.find('.comment-content');
    let $commentHeader = $comment.find('.comment-header');
    
    // 댓글 수정 폼으로 변경
$content.html('<div style="float: left; padding: 10px; box-sizing: border-box; resize: none; margin-right: 2%; width: 90%;"><textarea class="edit-textarea" style="padding: 10px; width: 100%; height: 60px; resize: none;">' + $content.text().trim() + '</textarea></div>'
                   + '<div style="width: 8%; float: right; margin-top: 10px; display: inline-block; height: 25px;">'
                   + '<button class="btn-save" style=" width: 100%; height: 100%; background-color: #2a8890; color: #fff; border: none; border-radius: 5px; cursor: pointer;">수정완료</button>'
                   + '</div>'
                   + '<div style="width: 8%; float: right; margin-top: 5px; display: inline-block; height: 25px;">'
                   + '<button class="btn-cancel" style="width: 100%; height: 100%; background-color: #ccc; color: #fff; border: none; border-radius: 5px; cursor: pointer;">취소</button>'
                   + '</div>'
                   + '<div style="clear: both;"></div>');
    $commentHeader.find('.comment-actions').hide();


    $('.btn-save').on('click', function() {
        $.ajax({
            type: 'post',
            url: '/addComment',
            data: {
                commentId: commentId,
                postId: $('.post-id').val(),
                content: $('.edit-textarea').val()
            },
            dataType: 'text',
            success: function(data) {
                alert("수정성공");
                getComment();
            },
            error: function(error) {
                alert("수정 실패");
            }
        });
        isEditing = false;
    });

    $('.btn-cancel').on('click', function() {
        getComment();
        isEditing = false;
    });
}

// 댓글을 삭제하는 함수
function deleteComment(id, button){
	$.ajax({
		type:'post', url:'/deleteComment', 
		data:{id : id}, 
		dataType:'text',
		success:function(data){
			$(button).closest('.comment').remove();
			alert("삭제성공")
		}
	}); 
}

//댓글을 가져오는 함수
function getComment() {
    $.ajax({
        type:'post', 
        url:'/getComment',
        data:{ id: $('.post-id').val(), categoryId: $('.category-id').val() },
        dataType:'json',
        success: function(data) {
        	$('.comment-list').empty();
        	let str = "";
        	if (data.length > 0) {
        	    for (let i = 0; i < data.length; i++) {
        	        let dateText = data[i].created;
        	        if (data[i].created !== data[i].updated) {
        	            dateText = data[i].updated + ' (수정됨)';
        	        }

        	        str += '<div class="comment" data-id="' + data[i].id + '" style="border-bottom: 1px solid #ccc; padding: 5px;">'
        	            + '    <div class="comment-header" style="display: flex; align-items: center; justify-content: space-between;">'
        	            + '        <div style="display: flex; align-items: center;">'
        	            + '					   <span class="comment-name" style="font-weight: bold; padding-right: 10px;">' + data[i].nickname + '</span>'
        	            + '						 <div class="comment-date" style="font-size: 0.8em; color: #777;">' + data[i].created + '</div>'
        	            + '				 </div>'
            	        if (nickname === data[i].nickname) {
            	        		str += '<div class="comment-actions" style="text-align: right;">'
            	        				+ '		 <span class="btn-modify" onclick="modifyComment((this), ' + data[i].id + ')" style="margin-right: 5px; cursor: pointer; font-size: 0.9em;">수정</span>'
            	        				+ '		 <span class="btn-delete" onclick="deleteComment(' + data[i].id + ', (this))" style="margin-right: 5px; cursor: pointer; font-size: 0.9em;">삭제</span>'
            	        				+ '	</div>'
            	        }
            	    str += '		</div>'
        	            + '    <div class="comment-content" style="padding: 10px; word-break: break-all;">' + data[i].content + '</div>'
        	        	  + '    </div>'
        	            + '</div>';
        	    }
        	    $('.comment-list').append(str);
        	} else {
        	    str += '<div><p>등록된 댓글이 없습니다.</p></div>';
        	    $('.comment-list').append(str);
        	}
        }
    });
}

</script>