<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="subBody" style="top:120px; margin-bottom:40px;">
	<div class="sub-visual-box bgImage04" data-aos="fade" data-aos-duration="1000">
		<div class="container">
			<div class="page-head-title research-head">
				<h2 class="sub-title" data-aos="fade-up" data-aos-delay="200" data-aos-duration="1000">
				커뮤니티</h2>
				<p class="page-explain" data-aos="fade-up" data-aos-delay="400" data-aos-duration="1000"></p>
			</div>
		</div>
	</div>
	<div class="submenu-box txt_c">
		<div class="submenu-wrap">
			<ul class="fs18 submenu-list">
				<li class="inline-list-item "><a href="/fosterBlog">임시보호 블로그</a></li>
				<li class="inline-list-item "><a href="/volunteer">자원봉사자 모집</a></li>
				<li class="inline-list-item "><a href="/volunteerReport">자원봉사 후기</a></li>
			</ul>
		</div>
	</div>
</div>
<script>
		$(window).scroll(function() {
				let wh2 = $(window).scrollTop();
				if (wh2 > 50) {
						$(".page-head-title").stop().animate({
						opacity: ".3"
						}, 100);
				} else {
						$(".page-head-title").stop().animate({
						opacity: "1"
				}, 100);}
		});
</script>