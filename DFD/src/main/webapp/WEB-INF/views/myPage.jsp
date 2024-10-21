<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page</title>
<!-- Google Fonts 추가 -->
<link
	href="https://fonts.googleapis.com/css2?family=Koulen&family=Goldman&family=Notable&family=Oleo+Script&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/myPage.css" />
</head>
<body>
	<div class="container">
		<!-- 헤더 -->
		<header>
			<div class="header-left">CODE KIRI</div>
			<div class="header-right">
				<a href="${pageContext.request.contextPath}/fileTest">FileTest</a> <a
					href="${pageContext.request.contextPath}/detection">Detection</a> <a
					href="${pageContext.request.contextPath}/">Logout</a> <a
					href="${pageContext.request.contextPath}/myPage">Mypage</a>
			</div>
		</header>

		<!-- 메인 콘텐츠 -->
		<div class="profile-section">
			<div class="profile-info">
				<div class="profile-image">
					<img src="${pageContext.request.contextPath}/img/profile.png"
						alt="Profile">
				</div>
				<div class="profile-details">
					<div class="email">이메일: smhrd@naver.com</div>
					<div class="signup-date">가입일: 2023/10/01</div>
				</div>
			</div>
		</div>

		<!-- 이미지 목록 -->
		<div class="image-gallery">
			<div class="image-item">
				<img src="${pageContext.request.contextPath}/img/placeholder.png"
					alt="Image 1">
				<div class="image-date">2023/10/01</div>
				<button class="delete-button">🗑</button>
			</div>
			<div class="image-item">
				<img src="${pageContext.request.contextPath}/img/placeholder.png"
					alt="Image 2">
				<div class="image-date">2023/10/02</div>
				<button class="delete-button">🗑</button>
			</div>
			<div class="image-item">
				<img src="${pageContext.request.contextPath}/img/placeholder.png"
					alt="Image 3">
				<div class="image-date">2023/10/03</div>
				<button class="delete-button">🗑</button>
			</div>
			<div class="image-item">
				<img src="${pageContext.request.contextPath}/img/placeholder.png"
					alt="Image 4">
				<div class="image-date">2023/10/04</div>
				<button class="delete-button">🗑</button>
			</div>
			<div class="image-item">
				<img src="${pageContext.request.contextPath}/img/placeholder.png"
					alt="Image 5">
				<div class="image-date">2023/10/05</div>
				<button class="delete-button">🗑</button>
			</div>
			<div class="image-item">
				<img src="${pageContext.request.contextPath}/img/placeholder.png"
					alt="Image 6">
				<div class="image-date">2023/10/06</div>
				<button class="delete-button">🗑</button>
			</div>
		</div>

		<!-- 페이지네이션 -->
		<div class="pagination">
			<a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">»</a>
		</div>
	</div>
</body>
</html>
