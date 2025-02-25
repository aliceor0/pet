<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="sitemap-toggle">
	<div class="wrap">
		<span class="btn-close"></span>
			<ul class="onedepth-list">
				<li><span class="menu-title">유기견 입양</span>
					<ul class="sub-menu">
						<li><a href="/adoption/process">입양절차 안내</a></li>
						<li><a href="/adoption/registration">동물등록제 안내</a></li>
						<li><a href="/adoption/list">입양대상 동물</a></li>
						<li><a href="/adoption/reviews">입양후기 목록</a></li>
					</ul>
				</li>
				
				<li><span class="menu-title">회원간 분양</span>
					<ul class="sub-menu">
						<li><a href="/parcelOutList">분양리스트</a></li>
					</ul>
				</li>
				
				<li><span class="menu-title">실종강아지 찾기</span>
					<ul class="sub-menu">
						<li><a href="/lost">실종강아지 제보</a></li>
						<li><a href="/catch">실종강아지 목격</a></li>
					</ul>
				</li>
				
				<li><span class="menu-title">커뮤니티</span>
					<ul class="sub-menu">
						<li><a href="/fosterBlog">임시보호 블로그</a></li>
						<li><a href="/volunteer">자원봉사자 모집</a></li>
						<li><a href="/volunteerReport">자원봉사 후기</a></li>
					</ul>
				</li>
				
				<li><span class="menu-title">훈련 및 정보</span>
					<ul class="sub-menu">
						<li><a href="/information/animal">반려동물 정보</a></li>
						<li><a href="/information/traning">기초훈련 방법</a></li>
						<li><a href="/information/hospital">동물병원 및 보호소</a></li>
					</ul>
				</li>
				
				<li><span class="menu-title">쇼핑몰</span>
					<ul class="sub-menu">
						<li><a href="/petFood">사료/간식</a></li>
						<li><a href="/petSupplies">기타용품</a></li>
						<li><a href="/partnerMain_4">제휴업체</a></li>
					</ul>
				</li>
<!-- 				
				<li><span class="menu-title">후원 및 기부</span>
					<ul class="sub-menu">
						<li><a href="/">있으면</a></li>
						<li><a href="/">하고요</a></li>
						<li><a href="/">임시입니다.</a></li>
					</ul>
				</li> -->
			</ul>
	</div>
</div>
<script>
	$('.btn-close').click(function() {
		$("html").toggleClass("scroll_none");
		$("#hamburger").toggleClass('open');
		$('.sitemap-toggle').animate({
			right: "-400px"
		}, 400);
		$('.sitemap-toggle').removeClass('boxShadow');
		$(this).css({
			display: "none"
		});
	});
</script>