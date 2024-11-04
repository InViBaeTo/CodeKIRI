<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>File Test Page</title>
<link
	href="https://fonts.googleapis.com/css2?family=Koulen&family=Goldman&family=Notable&family=Oleo+Script&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/fileTest.css" />
</head>
<body>
	<div class="container">
		<header>
			<div class="header-left"><a href="${pageContext.request.contextPath}/">CODE KIRI</a></div>
			<div class="header-right">
				<a href="${pageContext.request.contextPath}/fileTest">FileTest</a> 
				<a href="${pageContext.request.contextPath}/detection">Detection</a> 
				<a href="${pageContext.request.contextPath}/doLogout">Logout</a> 
				<a href="${pageContext.request.contextPath}/myPage">Mypage</a>
			</div>
		</header>

		<div class="main-content">
			<h1>파일 업로드</h1>
			<div class="preview-screen">
				<img id="imagePreview" src="" alt="미리보기 이미지"
					style="display: none; max-width: 100%; max-height: 100%;" />
			</div>

			<div class="display-bar">
				<form id="uploadForm" onsubmit="return handleUpload(event);">
					<input type="file" name="file" id="fileInput" onchange="previewImage(event)" />
					<input type="submit" value="Upload" id="uploadButton" disabled />
				</form>
			</div>
			<div id="waitingMessage" class="waiting-message" style="display: none;">기다려 주세요...</div>
			<div id="resultBar" class="result-bar">파일을 넣어주세요</div>
		</div>
	</div>

	<script>
		let accuracyNum = 0; // 처음에는 랜덤 값을 0으로 고정
		let fileSelected = false;

		function previewImage(event) {
			const file = event.target.files[0];
			const reader = new FileReader();

			reader.onload = function(e) {
				const img = document.getElementById('imagePreview');
				img.src = e.target.result;
				img.style.display = 'block';
			};

			if (file) {
				fileSelected = true; // 파일이 선택되었음을 표시
				document.getElementById('uploadButton').disabled = false; // 업로드 버튼 활성화
				reader.readAsDataURL(file);
			}
		}

		function handleUpload(event) {
			event.preventDefault(); // 기본 폼 제출 방지
			document.getElementById('uploadButton').disabled = true; // 다시 업로드 버튼 비활성화
			document.getElementById('waitingMessage').style.display = 'block'; // 기다려 주세요 메시지 표시

			setTimeout(() => {
				// 3초 후 결과를 표시
				accuracyNum = Math.floor(Math.random() * 30); // 0~29 사이의 랜덤 값 생성
				const resultBar = document.getElementById('resultBar');

				if (accuracyNum == 0) {
					resultBar.innerHTML = "파일을 넣어주세요";
				} else if (accuracyNum < 10) {
					resultBar.innerHTML = "딥페이크의 확률이 낮습니다";
				} else {
					resultBar.innerHTML = "딥페이크의 확률이 높습니다";
				}

				fileSelected = false; // 파일 선택 상태 초기화
				document.getElementById('waitingMessage').style.display = 'none'; // 기다려 주세요 메시지 숨김
			}, 3000);
		}
	</script>
</body>
</html>
