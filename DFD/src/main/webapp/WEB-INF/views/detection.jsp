<%@page import="com.DFD.entity.DFD_USER"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>


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
			<div class="header-left">
				<a href="${pageContext.request.contextPath}/">CODE KIRI</a>
			</div>
			<div class="header-right">
				<a href="${pageContext.request.contextPath}/fileTest">FileTest</a> <a
					href="${pageContext.request.contextPath}/detection">Detection</a> <a
					href="${pageContext.request.contextPath}/">Logout</a> <a
					href="${pageContext.request.contextPath}/myPage">Mypage</a>
			</div>
		</header>

		<!-- 메인 콘텐츠 영역 -->
		<div class="main-content">
			<div class="main-bar">
				<h1>실시간 화면 캡처</h1>
			</div>
			<div class="video-container">
				<video id="liveScreenVideo" class="video" autoplay playsinline>
				</video>
			</div>
			<div class="button-container">
				<button id="startButton">녹화 시작</button>
				<button id="stopButton" disabled>녹화 중지</button>
			</div>
			<div class="result-bar">
				<p id="predictionResult">예측 결과 기다리는중...</p>
			</div>

		</div>
	</div>

	<%
	DFD_USER user = (DFD_USER) session.getAttribute("user");
	%>
	<%
	String user_id = user.getUser_id();
	%>


	<script>
	

	var name = "<%=user_id%>";
	console.log("유저 아이디:", name);

	
    let mediaRecorder;
    let recordedChunks = [];
    let isRecording = false;
    let stream; // 화면 공유 스트림을 저장할 변수
    //mediaRecorder = new MediaRecorder(stream, { mimeType: 'video/webm; codecs=vp9' });
	//영상 타입 지정, mp4 파일을 바로 생성하지 못하고 변환이 필요함
    
    
    async function startRecording() {
        // 화면 공유를 한 번만 요청하고 스트림을 저장
        if (!stream) {
            stream = await navigator.mediaDevices.getDisplayMedia({ video: true });
        }

        const liveVideoElement = document.getElementById('liveScreenVideo');
        liveVideoElement.srcObject = stream;
        liveVideoElement.play(); // 비디오 재생
        
     	// 녹화 시작 시 테두리 색상 변경
        liveVideoElement.classList.add('red-border');

        
        
        mediaRecorder = new MediaRecorder(stream, { mimeType: 'video/webm; codecs=vp9',});

        mediaRecorder.ondataavailable = (event) => {
            if (event.data.size > 0) {
                recordedChunks.push(event.data);
            }
        };

        // 파일 이름 시간대로 지정
        mediaRecorder.onstop = async () => {
            const blob = new Blob(recordedChunks, { type: 'video/webm', });

         // 현재 시간을 이용해 타임스탬프 생성
            const date = new Date();
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            const seconds = String(date.getSeconds()).padStart(2, '0');

            // 타임스탬프 생성
            const timestamp = year + month + day + hours + minutes + seconds;

            // 타임스탬프 로그 출력 (디버깅)
            console.log('생성된 타임스탬프:', timestamp);

            // 타임스탬프를 파일명에 추가
            const videoFileName = 'recording_' + timestamp + '.webm';

            // 파일 이름 로그 출력 (디버깅)
            console.log('생성된 파일 이름:', videoFileName);
			
        
            
            // 서버로 비디오 파일 전송
            const formData = new FormData();
            formData.append('video', blob, videoFileName);
            formData.append('user_name', 'smhrd15'); // 사용자 이름
            formData.append('user_folder', name);

            try {
                const response = await fetch('http://192.168.219.115:5000/saveVideo', {
                    method: 'POST',
                    body: formData
                });
                const result = await response.json();
                if (response.ok) {
                    console.log('비디오 업로드 성공:', result);
                } else {
                    console.error('에러 발생:', result.error);
                }
            } catch (error) {
                console.error('전송 중 오류 발생:', error);
            }

            recordedChunks = []; // 다음 녹화를 위해 초기화
        };

        // 녹화 시작 시 버튼 비활성화
        mediaRecorder.start();
        isRecording = true;
        document.getElementById('startButton').disabled = true;
        document.getElementById('stopButton').disabled = false;

        // 자동 녹화 시작
        setTimeout(() => {
            if (isRecording) {
                mediaRecorder.stop(); // 현재 녹화 중지
                setTimeout(() => startRecording(), 100); // 0.1초 후에 새로운 녹화 시작
            }
        }, 20000); // 20초 후에 녹화 중지
    }

    document.getElementById('startButton').addEventListener('click', startRecording);

    document.getElementById('stopButton').addEventListener('click', () => {
    	document.getElementById('stopButton').addEventListener('click', () => {
    	    if (isRecording) {
    	        mediaRecorder.stop();

    	        // 녹화 종료 시 테두리 색상 변경
    	        const liveVideoElement = document.getElementById('liveScreenVideo');
    	        liveVideoElement.classList.remove('red-border');

    	        // 화면 공유 스트림 중지
    	        if (stream) {
    	            stream.getTracks().forEach(track => track.stop());
    	        }

    	        isRecording = false;
    	        document.getElementById('startButton').disabled = false;
    	        document.getElementById('stopButton').disabled = true;
    	    }
    	});

    });
    async function fetchPrediction() {
        try {
        	
            const response = await fetch('http://192.168.219.115:5000/get_prediction');
            if (response.ok) {
                const data = await response.json();
                console.log(data);
                document.getElementById('predictionResult').innerText = "예측 결과: " + data.prediction +"딥페이크 확률: "+ data.probability+"%";
            } else {
                document.getElementById('predictionResult').innerText = "예측 결과 기다리는중...";
            }
        } catch (error) {
            console.error("Error fetching prediction:", error);
        }
    }

    // 일정 시간마다 fetchPrediction 함수를 호출
    setInterval(fetchPrediction, 10000); // 10초마다 예측 결과 조회
    
    
    // 페이지 접속시 예측값 초기화
    window.addEventListener('load', function() {
        fetch('http://192.168.219.115:5000/reset_prediction_result', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                console.log(data.message);
            }
        })
        .catch(error => console.error('Error:', error));
    });
    
</script>


</body>
</html>