
<%@page import="com.DFD.entity.DFD_USER"%>
<%@page import="com.DFD.dao.userDAO"%>
<%@page import="org.apache.catalina.User"%>
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
		<%
		DFD_USER user = (DFD_USER) session.getAttribute("user");
		%>
		<!-- 메인 콘텐츠 -->
		<div class="profile-section">
			<div class="profile-info">
				<div class="profile-image">
					<img src="${pageContext.request.contextPath}/img/아이콘.jpg"
						alt="Profile">
				</div>
				<div class="profile-details">
					<div class="email">
						이메일:<%=user.getUser_email()%></div>
					<div class="signup-date">
						가입일:<%=user.getJoined_at()%></div>
				</div>
			</div>
		</div>

		<!-- 이미지 목록 -->
		<div class="image-main">
			<div class="image-gallery">
				<div class="image-item">
					<img src="${pageContext.request.contextPath}/img/placeholder.png"
						alt="Image 1">
					<div class="image-date">2023/10/01</div>
					<button class="delete-button">X</button>
				</div>
			</div>
		</div>

	</div>

</body>
</html>
