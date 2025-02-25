<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/head.jsp"%>
</head>
<body>
	<%@ include file="../include/header.jsp"%>
	<!-- 우측 햄버거버튼에 관한 정보 -->
	<%@ include file="../include/sitemap.jsp"%>
	<%@ include file="../include/parcelOutHeader.jsp"%>
	<div>
		<div>
			<h1>입양 신청</h1>
			<p style="font-size: 18px;">
				책임질 준비가 되셨나요????<br>귀한 생명을 키운다는것은 엄청난 책임이 따라옵니다
			</p>
		</div>
	</div>

	<div>
		<div style="height: 30px;"></div>
	</div>

	<div>
		<div>
			<div>
				<input id="language" name="language" value="ko" type="hidden"
					value="" />
				<header>입양 신청서</header>

				<section></section>

				<h5>개인 정보 입력란</h5>
				<section>
					<div>
						<label>1. 성명</label>
						<div>
							<label><input id="p1" name="p1" type="text"
								value="<%=session.getAttribute("name")%>" readonly> </label>
						</div>
					</div>
				</section>
				<section>
					<div>
						<label>2. 연락처</label>
						<div>
							<label><input id="p2" name="p2" type="text" value="" /></label>
							<div>
								<i></i> “-” 제외한 숫자만 입력해주세요. 예) 01012345678
							</div>
						</div>
					</div>
				</section>
				<section>
					<div>
						<label>3. 대체 연락처</label>
						<div>
							<label><input id="p3" name="p3" type="text" value="" /></label>
							<div>
								<i></i> 본인외의 비상연락가능한 사람으로 적어주세욧<br> “-” 제외한 숫자만 입력해주세요. 예)
								01012345678
							</div>
						</div>
					</div>
				</section>
				<section>
					<div>
						<label>4. 이메일주소</label>
						<div>
							<label><input id="p4" name="p4" type="email" value="" /></label>
						</div>
					</div>
				</section>
				<section>
					<div>
						<label>5. 성별</label>
						<div>
							<div>
								<label><input name="p5" type="radio" value="남" /><i></i>남</label>
								<label><input name="p5" type="radio" value="여" /><i></i>여</label>
							</div>
							<div></div>
						</div>
					</div>
				</section>
				<section>
					<div>
						<label>6. 나이</label>
						<div>
							<label><input id="p6" name="p6" type="text" value="" /></label>
							<div>
								<i>숫자만 입력해주세요.</i>
							</div>
						</div>
					</div>
				</section>


				<section style="margin-bottom: 10px;">
					<div>
						<label>7. 집주소</label>
						<div>
							<div>
								<input type="text" id="p7" name="p7" placeholder="우편번호">
							</div>
						</div>
						<div>
							<input type="button" onclick="sample6_execDaumPostcode()"
								value="주소 찾기">
						</div>
					</div>
				</section>

				<section style="margin-bottom: 10px;">
					<div>
						<label></label>
						<div>
							<div>
								<input type="text" id="p8" name="p8" placeholder="주소">
							</div>
						</div>
					</div>
				</section>

				<section>
					<div>
						<label></label>
						<div>
							<div>
								<input type="text" id="p8a" name="p8a" placeholder="상세주소">
								<input type="hidden" id="sample6_extraAddress"
									placeholder="참고항목">
							</div>
							<div>
								<i></i> 상세주소까지 입력해 주세요. <br>예) 잔다리로 122 더불어숨센터 402호
							</div>
						</div>
					</div>
				</section>

				<section>
					<div>
						<label>8. 직업/직장명</label>
						<div>
							<label><input id="p9" name="p9" type="text" value=""
								placeholder="백수는 안돼요..." /></label>
						</div>
					</div>
				</section>
				<section>
					<div>
						<label>10. 데려갈 아이의 이름</label>
						<div>
							<label><input id="p10" name="p10" type="text"
								value="${name }" readonly /></label>
						</div>
					</div>
				</section>


			</div>
		</div>
	</div>
	<section>
		<div>
			<button id="home">홈으로</button>
			<button id="application">신청하기</button>
		</div>
	</section>
</body>
<footer>
	<%@ include file="../include/footer.jsp"%>
</footer>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
	let popupWindow = null;
	$(document).ready(function() {
		openPopup()
	})

	.on("click", "#home", function() {
		location.href = '/'
		$('#p1,#p2,#p3,#p4,#p5,#p6,#p7,#p8,#p8a,#p9').val('')
	})

	.on("click", "#application", function() {
		let gender = $("input[name='p5']:checked").val()
		$.ajax({
			type : "post",
			url : "/doApplication",
			data : {
				name : $('#p1').val(),
				mobile : $('#p2').val(),
				substityteMobile : $('#p3').val(),
				email : $('#p4').val(),
				gender : gender,
				age : $('#p6').val(),
				zipCode : $('#p7').val(),
				address : $('#p8').val(),
				detailedAddress : $('#p8a').val(),
				job : $('#p9').val(),
				takeCare : $('#p10').val()
			},
			dataType : "text",
			success : function(data) {
				if (data === "1") {
					alert("신청이 완료되었습니다.");
					location.href = '/'
					$('#p1,#p2,#p3,#p4,#p6,#p7,#p8,#p8a,#p9,#p10').val('')
				} else {
					alert("당신은 데려갈수없습니다.")
					location.href = '/takeCare'
				}
			}
		})
	})

	function openPopup() {
		// 팝업창을 띄우는데 사용할 URL
		let popupUrl = "/popup";

		// 팝업창의 사이즈 및 위치 설정
		let popupWidth = 850;
		let popupHeight = 700;
		let leftPosition = (screen.width - popupWidth) / 2;
		let topPosition = (screen.height - popupHeight) / 2;

		// 팝업창 열기
		popupWindow = window.open(popupUrl, "Popup", "width=" + popupWidth
				+ ",height=" + popupHeight + ",left=" + leftPosition + ",top="
				+ topPosition);
	}
</script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("p7").value = extraAddr;

				} else {
					document.getElementById("p7").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('p7').value = data.zonecode;
				document.getElementById('p8').value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("p8a").focus();
			}
		}).open();
	}

	function sample7_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("p7").value = extraAddr;

				} else {
					document.getElementById("p7").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('p8').value = data.zonecode;
				document.getElementById("p8").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("p8a").focus();
			}
		}).open();
	}
</script>
</html>