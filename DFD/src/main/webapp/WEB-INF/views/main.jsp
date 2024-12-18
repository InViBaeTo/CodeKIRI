<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ page import="com.DFD.entity.DFD_USER"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Main Page</title>
<!-- Google Fonts 추가 -->
<link
	href="https://fonts.googleapis.com/css2?family=Koulen&family=Goldman&family=Notable&family=Oleo+Script&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/mainPage1.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/mainPage2.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/mainPage3.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/mainPage4.css" />


</head>
<body>
	<div class="container">
		<!-- 첫 번째 섹션 -->
		<section class="section">
			<div class="main-content">
				<img src="${pageContext.request.contextPath}/img/face1.jpg"
					alt="Deepfake Detector" class="main-image">
				<div class="text-overlay">
					<h1>DEEPFAKE DETECTION</h1>
				</div>
				<div class="question">
					<p>Is he real?</p>
					<p>Is she real?</p>
				</div>
			</div>
			<div class="scroll-indicator">scroll</div>
		</section>

		<!-- 두 번째 섹션 -->
		<section class="section second-section">

			<div class="main-content">
				<img src="${pageContext.request.contextPath}/img/face2.jpg"
					alt="Deepfake Detector" class="main-image">
				<div class="text-overlay">
					<h1>DEEPFAKE</h1>
					<p1> <span class="highlight">당신이 마주하는</span>화면너머의 진실</p1>
					<br>
					<p2>딥페이크 디텍터는 <span class="highlight">여러분의 신변</span> 안전을 위하여<br>
					언제나 <span class="highlight">진실</span>을 찾기 위해 노력합니다.</p2>
				</div>
			</div>
			<div class="scroll-indicator">scroll</div>
		</section>

		<!-- 세 번째 섹션 -->
		<section class="section third-section">
			<header>
				<div class="header-left">
					<a href="${pageContext.request.contextPath}/">CODE KIRI</a>
				</div>
				<div class="header-right">
					<%
					DFD_USER user = (DFD_USER) session.getAttribute("user");
					if (user != null) { // 로그인 상태일 때
					%>

					<a href="${pageContext.request.contextPath}/fileTest">FileTest</a>
					<a href="${pageContext.request.contextPath}/detection">Detection</a>
					<a href="${pageContext.request.contextPath}/doLogout">Logout</a> <a
						href="${pageContext.request.contextPath}/myPage">Mypage</a>
					<%
					} else { //비로그인 상태일때
					%>
					<a href="${pageContext.request.contextPath}/login">FileTest</a> <a
						href="${pageContext.request.contextPath}/login">Detection</a> <a
						href="${pageContext.request.contextPath}/login">Login</a> <a
						href="${pageContext.request.contextPath}/join">Join</a>

					<%
					}
					%>
				</div>
			</header>
			<div class="main-content">
				<!-- 이미지 갤러리 -->
				<div class="image-gallery">
					<img src="${pageContext.request.contextPath}/img/face6.jpg"
						alt="Face 1"> <img
						src="${pageContext.request.contextPath}/img/face4.jpg"
						alt="Face 2"> <img
						src="${pageContext.request.contextPath}/img/face5.png"
						alt="Face 3"> <img
						src="${pageContext.request.contextPath}/img/face3.jpg"
						alt="Face 4">
				</div>
				<!-- 설명 박스 -->
				<div class="description-box">
					<h1>DETECTOR</h1>
					<p class="text1">
						CODE KIRI는 AI 시대에 맞춰<br>딥페이크 탐지 서비스를 개발하는 팀입니다.
					</p>
					<p class="text2">
						AI가 발전하여 화면너머의 사람마저<br>감출 수 있는 상황에 맞추어<br>딥페이크를 검출하고
						이용자에게 진실을 알려주기 위해<br>이 프로그램이 개발 되었습니다.
					</p>
				</div>
			</div>
			<div class="scroll-indicator">END</div>
		</section>

	</div>

	<script>
		// 스크롤 이벤트 방지
		window.addEventListener('wheel', function(event) {
			event.preventDefault(); // 기본 스크롤 동작 방지
		}, {
			passive : false
		});

		// 스크롤 스냅을 위한 스크립트
		let sections = document.querySelectorAll('.section');
		let currentSection = 0;

		function scrollToSection(index) {
			sections[index].scrollIntoView({
				behavior : 'smooth'
			});
		}

		window.addEventListener('wheel', function(event) {
			if (event.deltaY > 0) { // 아래로 스크롤
				currentSection = Math.min(currentSection + 1,
						sections.length - 1);
			} else { // 위로 스크롤
				currentSection = Math.max(currentSection - 1, 0);
			}
			scrollToSection(currentSection);
			event.preventDefault(); // 기본 스크롤 동작 방지
		}, {
			passive : false
		});
	</script>
</body>
</html>
