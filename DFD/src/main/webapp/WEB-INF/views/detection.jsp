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

			<video id="liveScreenVideo" autoplay playsinline
				style="width: 80%; margin-top: 20px; border: 3px solid black;">
			</video>
			<button id="startButton">녹화 시작</button>
			<button id="stopButton" disabled>녹화 중지</button>
			<%
			// accuracy는 딥페이크 확률값을 불러오고 넣어둘 변수
			// 따로 확률을 보여주는 것 또한 생각중입니다
			int accuracy = 0;
			if (accuracy >= 80) {
			%>
			<div class="result-bar">딥페이크의 확률이 높습니다</div>
			<%
			} else if (accuracy < 80) {
			%>
			<div class="result-bar">딥페이크의 확률이 낮습니다</div>
			<%
			} else {
			%>
			<div class="result-bar">파일을 넣어주세요</div>
			<%
			}
			%>
		</div>
	</div>
	
	<%DFD_USER user = (DFD_USER)session.getAttribute("user"); %>
	<%String user_id = user.getUser_id(); %>
	
        
	<script>
	
	var name = "<%= user_id %>";
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

        mediaRecorder = new MediaRecorder(stream);

        mediaRecorder.ondataavailable = (event) => {
            if (event.data.size > 0) {
                recordedChunks.push(event.data);
            }
        };

        // 파일 이름 시간대로 지정
        mediaRecorder.onstop = async () => {
            const blob = new Blob(recordedChunks, { type: 'video/mp4' });
            let videoFile = new File([blob], 'recording.mp4', { type: 'video/mp4' });

            // 현재 시간을 가져와 타임스탬프 생성
            const date = new Date();
            const year = date.getFullYear();
            const month = date.getMonth() + 1; // 0부터 시작하므로 1을 더해줌
            const day = date.getDate();
            const hours = date.getHours();
            const minutes = date.getMinutes();
            const seconds = date.getSeconds();

            // 각 값을 padStart로 두 자리 수로 맞추고 문자열로 변환
            const paddedMonth = String(month).padStart(2, '0');
            const paddedDay = String(day).padStart(2, '0');
            const paddedHours = String(hours).padStart(2, '0');
            const paddedMinutes = String(minutes).padStart(2, '0');
            const paddedSeconds = String(seconds).padStart(2, '0');

            // 타임스탬프 생성
            const timestamp = year + paddedMonth + paddedDay + paddedHours + paddedMinutes + paddedSeconds;

            // 타임스탬프 로그 출력 (디버깅)
            console.log('생성된 타임스탬프:', timestamp);

            // 타임스탬프를 파일명에 추가
            const videoFileName = 'recording_' + timestamp + '.mp4';

            // 파일 이름 로그 출력 (디버깅)
            console.log('생성된 파일 이름:', videoFileName);
			
            videoFile = new File([blob], videoFileName, { type: 'video/mp4' });
            
            // 서버로 비디오 파일 전송
            const formData = new FormData();
            formData.append('video', videoFile);
            formData.append('user_name', 'smhrd15'); // 사용자 이름
            formData.append('user_folder',name)

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
        }, 10000); // 10초 후에 녹화 중지
    }

    document.getElementById('startButton').addEventListener('click', startRecording);

    document.getElementById('stopButton').addEventListener('click', () => {
        if (isRecording) {
            mediaRecorder.stop();
            
         	// 녹화 종료 시 테두리 색상 변경
            const liveVideoElement = document.getElementById('liveScreenVideo');
            liveVideoElement.classList.remove('red-border');
            
            isRecording = false;
            document.getElementById('startButton').disabled = false;
            document.getElementById('stopButton').disabled = true;
        }
    });

    
</script>


</body>
</html>