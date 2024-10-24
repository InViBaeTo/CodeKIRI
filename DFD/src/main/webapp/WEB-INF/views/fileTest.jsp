<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>File Test Page</title>
<!-- Google Fonts 추가 -->
<link
	href="https://fonts.googleapis.com/css2?family=Koulen&family=Goldman&family=Notable&family=Oleo+Script&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/fileTest.css" />

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
		<div class="main-content">
			<div class="preview-screen">
				<img id="imagePreview" src="" alt="미리보기 이미지"
					style="display: none; max-width: 100%; max-height: 100%;" />
			</div>
			<div class="display-bar">
				<label for="fileInput">IMG File</label> <input type="file"
					id="fileInput" name="fileInput" accept="image/*"
					onchange="previewImage(event)" required />
				<button class="test-button">TEST</button>
			</div>
			<% // accuracy는 딥페이크 확률값을 불러오고 넣어둘 변숨
			// 따로 확률을 보여주는 것 또한 생각중입니다
			int accuracy = 0;
			if(accuracy >= 80){ %>
			<div class="result-bar">딥페이크의 확률이 높습니다</div>
			<%} else if(accuracy < 80) {%>
			<div class="result-bar">딥페이크의 확률이 낮습니다</div>
			<%} else {%>
			<div class="result-bar"> 사진을 넣어주세요</div>
			<%} %>
		</div>
	</div>
	    <h1>파일 업로드</h1>
		    <form action="http://192.168.219.115:5000/upload" method="post" enctype="multipart/form-data">
		        <input type="file" name="file"/>
		        <input type="submit" value="Upload"/>
		    </form>
	
	<script>
		function previewImage(event) {
			const file = event.target.files[0]; // 사용자가 선택한 필드 0번째 파일 가져오기
			const reader = new FileReader(); // 비동기 파일 읽기

			reader.onload = function(e) {
				const img = document.getElementById('imagePreview');
				img.src = e.target.result; // 업로드한 파일의 URL을 미리보기 이미지로 설정
				img.style.display = 'block'; // 이미지 표시
			};

			if (file) {
				reader.readAsDataURL(file); // 파일을 읽어 Data URL 형식으로 변환
			}
		}
	</script>
</body>
</html>