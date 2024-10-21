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

    <h3>Flask API 호출 결과:</h3>
    <p>${apiResult != null ? apiResult : "아직 결과가 없습니다."}</p>
</body>
</html>
