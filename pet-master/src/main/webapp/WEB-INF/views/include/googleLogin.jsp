<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src='http://code.jquery.com/jquery-latest.js'></script>    
<p  style=" display:inline-block;" class="g_id_signin" data-type="icon" data-shape="circle" id="g_id_onload" data-client_id="548290331946-46hfido1hbmrl2kssghk5bql9c2t3vfu.apps.googleusercontent.com" data-callback="handleCredentialResponse"></p>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script>
    function handleCredentialResponse(response) {
        const responsePayload = parseJwt(response.credential);
        $.ajax({
        	type: 'Post',
        	url: '/APIidcheck',
        	data: {user_id: responsePayload.sub,mail: responsePayload.email},
        	dataType: 'text',
        	success: function(data) {
                if (data == 1) {
                    location.href = "/";
                } else {
                	location.href = "/signup";
                }
        	}
        })
    };

    function parseJwt(token) {
        const base64Url = token.split('.')[1];
        const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));

        return JSON.parse(jsonPayload);
    };
</script>