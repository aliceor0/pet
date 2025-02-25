<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신청 하기전 읽어야 할 주의 사항</title>
</head>
<style>
.cube div span {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(#ed58c0, #ce0000);
    transform: rotateY(calc(90deg * var(--i))) translateZ(75px);
}

.top {
    position: absolute;
    top: 0;
    left: 0;
    width: 100px;
    height: 100px;
    background: #ed58c0;
    transform: rotateX(90deg) translateZ(73px);
}

.top::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100px;
    height: 100px;
    background: rgb(246, 14, 219);
    transform: translateZ(-150px);
    filter: blur(100px);
    box-shadow: 0 0 60px rgba(232, 224, 66, 0.2)
                0 0 70px rgba(232, 224, 66, 0.4),
                0 0 80px rgba(232, 224, 66, 0.6),
                0 0 90px rgba(232, 224, 66, 0.8),
                0 0 100px rgba(232, 224, 66, 0.1);
}

.cube {
    margin: auto;
    position: relative;
    width: 150px;
    height: 150px;
    transform-style: preserve-3d;
    transform: rotateX(-30deg);
    animation: animate 5s linear infinite;
}

@keyframes animate {
    0% {
        transform: rotateX(-30deg) rotateY(0deg);
    }
    100% {
        transform: rotateX(-30deg) rotateY(360deg);
    }
}

.cube div {
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    transform-style: preserve-3d;
}

</style>
<body>
<br>
    <div class="cube">
		<div class="top"></div>
		<div>
			<span style="--i: 0"></span> 
			<span style="--i: 1"></span> 
			<span style="--i: 2"></span> 
			<span style="--i: 3"></span>
		</div>
	</div>
	<br><br>
	<div>
	<h3>꼭 꼭 반드시 읽어주세요</h3>
	</div>
	<div>
		<p>아래사항의 경우 입양이 어려울수있습니다.</p>
		<p>1. 가정으로 입양이 아닌 경우</p>
		<p>(ex:공장, 회사, 군부대, 농장, 식당 등)</p>
		<p>2. 5마리 이상의 동물을 한꺼번에 키우고 있는 경우.</p>
		<p>(상담후 입양이 가능 할 수 있습니다.)</p>
		<p>3. 미취학 아동의 자녀가 3명 이상이거나 5세 이하의 아이가 2명 이상인 경우.</p>
		<p>4. 가족 구성원 전체의 동의를 얻지 않은 경우나 미성년자의 입양신청</p>
		<p>5. 외국으로 입양을 원하거나 한국에 거주하는 외국인</p>
		<p>(상담후 입양이 가능 할 수 있습니다.)</p>
		<p>6. 가족구성원 중 동물에 대한 알레르기나 우울증 등의 질환으로 치료를 받고있는 경우.</p>
		<p>(상담후 입양이 가능 할 수 있습니다.)</p>
		<p>7. 70세 이상 혼자 거주하고 있는 경우</p>
		<p><b>중요! 빈칸이 하나라도 있을 경우 신청 자체가 불가능하니 참고 해주세요.</b></p>
	</div>
</body>
</html>