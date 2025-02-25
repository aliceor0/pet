<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	AOS.init({
		duration: 1000,
		disable: function() {
			let maxWidth = 767;
			return window.innerWidth < maxWidth;
		}
	});
</script>
<header id="header">
<% String name = (String) session.getAttribute("name"); %>

	<div class="quick_bar" style="text-align: right;">
		<% if (name == null) { %>
			<a href="/login" class="menuBar">로그인&nbsp; </a>
			<a href="/signup" class="menuBar">회원가입</a>
		<% } else { %>
			<a><%=name%>님 반갑습니다.</a>
			<a href="/logout" class="menuBar" id=do_logout>로그아웃</a>
		<% } %></div>
	<div class="menu_box">
		<a href="/" class="logo"><img src="/image_main/logo.png" alt="logo" style="width:250px; height:80px"></a>
		<nav class="gnb">
			<ul class="main_menu">
				
				<li class="main_list n_1">
 					<a href="/adoption/process">유기동물 입양</a>
					<ul class="sub_menu">
						<li class="sub_list"><a href="/adoption/process">입양절차 안내</a></li>
						<li class="sub_list"><a href="/adoption/registration">동물등록제 안내</a></li>
						<li class="sub_list"><a href="/adoption/list">입양대상 동물</a></li>
						<li class="sub_list"><a href="/adoption/reviews">입양후기 목록</a></li>
					</ul>
				</li>
					
        <li class="main_list n_2">
        	<a href="/parcelOutList">회원간 분양</a>
        	<ul class="sub_menu">
						<li class="sub_list"><a href="/parcelOutList">분양리스트</a></li>
					</ul>
        </li>
				
				<li class="main_list n_3">
					<a href="/lost">실종강아지 찾기</a>
					<ul class="sub_menu">
						<li class="sub_list"><a href="/lost">실종강아지 제보</a></li>
						<li class="sub_list"><a href="/catch">실종강아지 목격</a></li>
					</ul>
				</li>
					
				<li class="main_list n_4">
					<a href="/fosterBlog">커뮤니티</a>
					<ul class="sub_menu">
						<li class="sub_list"><a href="/fosterBlog">임시보호 블로그</a></li>
						<li class="sub_list"><a href="/volunteer">자원봉사자 모집</a></li>
						<li class="sub_list"><a href="/volunteerReport">자원봉사 후기</a></li>
         	</ul>
         </li>
          
				<li class="main_list n_5">
					<a href="/information">훈련 및 정보</a>
					<ul class="sub_menu">
						<li class="sub_list"><a href="/information/animal">반려동물 정보</a></li>
						<li class="sub_list"><a href="/information/traning">기초훈련 방법</a></li>
 						<li class="sub_list"><a href="/information/hospital">동물병원 및 보호소</a></li>
					</ul>
				</li>
					
				<li class="main_list n_6">
					<a href="/petAll">쇼핑몰</a>
					<ul class="sub_menu">
						<li class="sub_list"><a href="/petFood">사료/간식</a></li>
						<li class="sub_list"><a href="/petSupplies">기타용품</a></li>
						<li class="sub_list"><a href="/partnerMain_4">제휴업체</a></li>
					</ul>
				</li>
<!-- 					
				<li class="main_list n_7">
					<a href="/">후원 및 기부</a>
					<ul class="sub_menu">
						<li class="sub_list"><a href="/">있으면</a></li>
						<li class="sub_list"><a href="/">하고요</a></li>
						<li class="sub_list"><a href="/">임시입니다.</a></li>
					</ul>
				</li> -->
			</ul>
		</nav>

		<div class="right">
			<div id="hamburger">
				<span></span>
				<span></span>
				<span></span>
				<span></span>
			</div>
		</div>
  </div>
	<div class="sub_bg"></div>
<script>
    $(document)
        .on('click', '#do_logout', function() {
            $.ajax({
                type: 'post',
                url: '/logout',
                data: {},
                dataType: 'text',
                success: function(data) {
                    if (data == '1') {
                        location.href = "/";
                    }
                }
            })
            return false;
        })
</script>
<script>
	$('#hamburger').click(function() {
		$("html").toggleClass("scroll_none");
		$(this).toggleClass('open');
		$('.sitemap-toggle').animate({
			right: "0"
		}, 400);
		$('.sitemap-toggle').addClass('boxShadow');
		$('.btn-close').css({
			 display: "block"
		});
	});

	if (innerWidth > 1400) {
		$("header#header").hover(function() {
			$(this).addClass("active");
			$(".sub_bg").addClass("active");
			$("header#header nav.gnb ul.sub_menu").addClass("active");
		}, function() {
			$(this).removeClass("active");
			$(".sub_bg").removeClass("active");
			$("header#header nav.gnb ul.sub_menu").removeClass("active");
		});
	}

$(function() {
	let lastScroll = 0;
	$(window).scroll(function(event) {

		let st = $(this).scrollTop();
		if (st > lastScroll) {
			$("header#header").addClass("scroll_active");
		} else {
		}
		
		lastScroll = st;
		if ($(this).scrollTop() == 0) {
			$("header#header").removeClass("scroll_active");
		}
	});
});
</script>

</header>
