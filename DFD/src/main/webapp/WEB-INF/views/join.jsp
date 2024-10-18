<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/join.css" />
</head>
<body>
    <div class="join-container">
        <div class="header">CODE KIRI</div>
        <form action="joinController" method="post">
            <label for="id">ID</label>
            <input type="text" id="id" name="id" class="input-field" />
            
            <label for="email">EMAIL</label>
            <input type="email" id="email" name="email" class="input-field" />

            <label for="pass">PASS</label>
            <input type="password" id="pass" name="pass" class="input-field" />

            <label for="passcheck">PASSCHECK</label>
            <input type="password" id="passcheck" name="passcheck" class="input-field" />
            
            <button type="submit" class="join-button">JOIN</button>
        </form>
    </div>
</body>
</html>
