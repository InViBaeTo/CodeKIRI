<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Test Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/fileTest.css" />
</head>
<body>
    <div class="container">
        <!-- 헤더 -->
        <header>
            <div class="header-left">CODE KIRI</div>
            <div class="header-right">
                <a href="#">FileTest</a>
                <a href="#">Detection</a>
                <a href="#">Logout</a>
                <a href="#">Mypage</a>
            </div>
        </header>

        <!-- 메인 콘텐츠 -->
        <div class="main-content">
            <div class="preview-screen">
                미리보기 화면
            </div>
            <div class="display-bar">
                <label for="fileInput">IMG File</label>
                <input type="text" id="fileInput" name="fileInput" class="display-input" disabled>
                <button class="test-button">TEST</button>
            </div>
            <div class="result-bar">
                딥페이크의 확률이 낮습니다
            </div>
        </div>
    </div>
</body>
</html>
