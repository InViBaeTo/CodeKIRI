<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css" />
</head>
<body>
    <div class="login-container">
        <div class="header" onclick="location.href='${pageContext.request.contextPath}/'" style="cursor: pointer;">CODE KIRI</div>
        <form action="doLogin" method="post">
            <label for="id">ID</label>
            <input type="text" id="id" name="id" class="input-field" />
            
            <label for="pass">PASS</label>
            <input type="password" id="pass" name="pass" class="input-field" />
            
            <button type="submit" class="login-button">LOGIN</button>
            <button type="button" class="naver-button">NAVER</button>
            <button type="button" class="google-button">GOOGLE</button>
            <a href="flaskController">
            <button type="button" class="kakao-button">KAKAO</button>
            </a>
        </form>
    </div>
</body>
</html>
