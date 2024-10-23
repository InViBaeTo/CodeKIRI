<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Detection Page</title>
<!-- Google Fonts 추가 -->
<link
	href="https://fonts.googleapis.com/css2?family=Koulen&family=Goldman&family=Notable&family=Oleo+Script&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/detection.css" />

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

		<!-- 메인 콘텐츠 영역 -->
		<div class="main-content">
			<h1>실시간 화면 캡처</h1>

			<video id="screenVideo" autoplay playsinline
				style="width: 80%; margin-top: 20px; border: 3px solid black;"></video>
			<button id="startCapture">공유 화면 설정</button>

			<div class="detection-bar">
				<div id="detection-message" class="detection-message">딥페이크 사용
					의심이 됩니다</div>
			</div>
		</div>

		<script>
      // 화면 공유 기능
      const startCaptureButton = document.getElementById('startCapture');
      const videoElement = document.getElementById('screenVideo');

      let captureInterval;

      startCaptureButton.addEventListener('click', async () => {
    	    try {
    	        // 화면 공유 시작
    	        const stream = await navigator.mediaDevices.getDisplayMedia({ video: true });
    	        videoElement.srcObject = stream;

    	        // 비디오가 로드된 후에만 실행
    	        videoElement.addEventListener('loadedmetadata', () => {
    	            console.log("비디오 크기: ", videoElement.videoWidth, videoElement.videoHeight);

    	            // 캔버스를 생성해 비디오에서 이미지 데이터를 가져옴
    	            const canvas = document.createElement('canvas');
    	            const context = canvas.getContext('2d');
    	            
    	            // 10초마다 스크린샷을 찍음
    	            captureInterval = setInterval(() => {
    	                // 비디오의 너비와 높이를 캔버스에 맞춤
    	                canvas.width = videoElement.videoWidth;
    	                canvas.height = videoElement.videoHeight;
    	                context.drawImage(videoElement, 0, 0, canvas.width, canvas.height);
    	                
    	                // 스크린샷을 base64 이미지로 변환
    	                const screenshot = canvas.toDataURL('image/png');
    	                console.log("스크린샷이 생성되었습니다.");

    	                // 서버로 이미지 전송
    	                sendScreenshotToServer(screenshot);
    	            }, 10000);
    	        });

    	    } catch (err) {
    	        console.error("Error: " + err);
    	    }
    	});

      
      
        // 스크린샷을 서버로 전송하는 함수
		function sendScreenshotToServer(screenshot, userFolderPath) {
		    console.log("서버로 스크린샷 전송 중...");
		    
		    fetch('http://192.168.219.115:5000/saveScreenshot', {  
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/json'
		        },
		        body: JSON.stringify({ 
		            image: screenshot,
		            userFolder: userFolderPath // 사용자 폴더 경로 추가
		        })
		    })
		    .then(response => {
		        if (!response.ok) {
		            throw new Error('서버 응답에 문제가 있습니다: ' + response.status);
		        }
		        return response.json(); 
		    })
		    .then(data => {
		        console.log('스크린샷이 저장되었습니다:', data);
		    })
		    .catch(error => {
		        console.error('스크린샷 저장 오류:', error);
		    });
		}
      
   </script>
</body>
</html>