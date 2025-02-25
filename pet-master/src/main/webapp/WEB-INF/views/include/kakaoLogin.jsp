<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<a href="javascript:void(0)"><img style="width:40px" src="/img/kakaologin.png"  onclick="kakaoLogin();" /></a>
<!-- <a href="javascript:void(0)" onclick="kakaoLogout();">
<span>카카오 로그아웃</span>
</a> -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
    // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해야 합니다.
    Kakao.init('808816a49a68605dacac51bbf908a384');

    // SDK 초기화 여부를 판단합니다.
/*     console.log(Kakao.isInitialized()); */

    function kakaoLogin() {
        Kakao.Auth.login({
            success: function(response) {
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function(response) {
                        /* console.log(response)
                        console.log(response.id)
                        console.log(response.properties.nickname) */
                        kakaoLogout();
                        $.ajax({
                        	type: 'Post',
                        	url: '/APIidcheck',
                        	data: {user_id: response.id},
                        	dataType: 'text',
                        	success: function(data) {
                                if (data == 1) {
                                    location.href = "/";
                                } else {
                                	location.href = "/signup";
                                }
                        	}
                        })
                    }, 
                    fail: function(error) {
                        console.log(error)
                    },
                });
            },
            fail: function(error) {
                console.log(error)
            },
        });
    }

    //카카오로그아웃  
    function kakaoLogout() {
        if (Kakao.Auth.getAccessToken()) {
            Kakao.API.request({
                url: '/v1/user/unlink',
                success: function(response) {
                    console.log(response)
                },
                fail: function(error) {
                    console.log(error)
                },
            })
            Kakao.Auth.setAccessToken(undefined)
        }
    }
</script>