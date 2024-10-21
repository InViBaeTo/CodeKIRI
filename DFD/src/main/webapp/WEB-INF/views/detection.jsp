<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
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
            <a href="${pageContext.request.contextPath}/fileTest">FileTest</a> <a href="${pageContext.request.contextPath}/detection">Detection</a> <a href="${pageContext.request.contextPath}/">Logout</a>
            <a href="${pageContext.request.contextPath}/myPage">Mypage</a>
         </div>
      </header>

      <!-- 메인 콘텐츠 영역 -->
      <div class="main-content">
         <div class="user-screen">사용자 화면</div>
         <div class="display-bar">
            <label for="display">Display</label> <input type="text" id="display"
               name="display" class="display-input" disabled>
         </div>
         <div class="detection-bar">
            <div class="status-icon">
               <img src="${pageContext.request.contextPath}/img/icon-green.png"
                  alt="ON" class="status-img"> <span>ON</span>
            </div>
            <div id="detection-message" class="detection-message">딥페이크 사용
               의심이 됩니다</div>
         </div>
         <button onclick="toggleMessage()" class="toggle-button">문구
            변경</button>
         <!-- 문구 변경 버튼 -->
      </div>
   </div>
   <script>
      // 문구 변경을 위한 자바스크립트 함수
      function toggleMessage() {
         var messageBox = document.getElementById("detection-message");
         if (messageBox.innerHTML === "딥페이크 사용 의심이 됩니다") {
            messageBox.innerHTML = "안전한 콘텐츠입니다";
         } else {
            messageBox.innerHTML = "딥페이크 사용 의심이 됩니다";
         }
      }
   </script>
</body>
</html>
