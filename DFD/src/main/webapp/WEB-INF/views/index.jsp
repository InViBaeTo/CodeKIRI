<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Flask API 테스트 페이지</title>
</head>
<body>
    <h2>Flask API를 호출하는 버튼</h2>
    <form action="run-python" method="GET">
        <button type="submit">Python 코드 실행</button>
    </form>
    <c:if test="${not empty apiResponse}">
        <h3>Flask API 응답 결과:</h3>
        <p>${apiResponse}</p>
    </c:if>
</body>
</html>
