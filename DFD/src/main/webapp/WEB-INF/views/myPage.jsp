<%@page import="com.DFD.entity.DFD_USER"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page</title>
<!-- Google Fonts 추가 -->
<link
	href="https://fonts.googleapis.com/css2?family=Koulen&family=Goldman&family=Notable&family=Oleo+Script&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Koulen&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/myPage.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="container">
		<header>
			<div class="header-left">
				<a href="${pageContext.request.contextPath}/">CODE KIRI</a>
			</div>
			<div class="header-right">
				<a href="${pageContext.request.contextPath}/fileTest">FileTest</a> <a
					href="${pageContext.request.contextPath}/detection">Detection</a> <a
					href="${pageContext.request.contextPath}/doLogout">Logout</a> <a
					href="${pageContext.request.contextPath}/myPage">Mypage</a>
			</div>
		</header>

		<div class="profile-section">
			<div class="profile-info">
				<div class="profile-image">
					<img src="${pageContext.request.contextPath}/img/아이콘.jpg"
						alt="Profile">
				</div>
				<div class="profile-details">
					<%
					DFD_USER user = (DFD_USER) session.getAttribute("user");
					String userId = user.getUser_id();
					%>
					<div class="email">
						이메일:
						<%=user.getUser_email()%></div>
					<div class="signup-date">
						가입일:
						<%=user.getJoined_at()%></div>
				</div>
			</div>
		</div>

		<div class="video-main">
			<h2>녹화된 파일 목록</h2>
			<div id="video-gallery" class="video-gallery"></div>
		</div>
	</div>

	<script>
    
        // Java에서 가져온 userId를 JavaScript 변수에 할당
        const userId = "<%=userId%>";

        // 페이지 로드 시 MP4 파일 목록 가져오기
        $(document).ready(function() {
            fetchMp4Files();
        });

        function fetchMp4Files() {
            $.ajax({
                url: 'http://192.168.219.115:5000/api/myPage?user_id='+userId,
                method: 'GET',
                success: function(response) {
                    if (response && Array.isArray(response)) {
                        renderVideoGallery(response);
                        console.log(response);
                    } else if (response.error) {
                        alert("오류: " + response.error);
                    }
                },
                error: function(xhr, status, error) {
                    console.log("Flask API 요청 실패: " + status + ", " + error);
                }
            });
        }

        function renderVideoGallery(mp4Files) {
            const videoGallery = $("#video-gallery");
            videoGallery.empty();

            if (mp4Files.length > 0) {
            	
            	mp4Files.forEach((value, index) => {
            	    console.log(index, value);  // 0 '딸기', 1 '귤', 2 '사과' 순서로 출력
            	    
            	    var videoItem = "";
            	    videoItem += '<div class="video-item">';
            	    videoItem += '<video width="150" height="150" controls>';
            	    videoItem += '<source src="http://192.168.219.115:5000/video/'+ userId +'/'+ value +'" type="video/mp4">';
            	    videoItem +='</video>';
            	    videoItem +='<div class="video-title">'+ value +'</div>';
            	    videoItem +='<button class="delete-button" onclick="sendVideoRequest(';
            	    videoItem +="'"+value+"'";
            	    videoItem +=')">X</button>';
            	    videoItem +='</div>';
            	    
            	    
            	videoGallery.append(videoItem);
            	});
            	
            } else {
                videoGallery.html("<p>업로드된 MP4 파일이 없습니다.</p>");
            }
        }

        function sendVideoRequest(filename) {
            $.ajax({
                url: "http://192.168.219.115:5000/deletevideo/" + userId + '/' + filename,
                method: 'GET',
                success: function(response) {
                    if (response.success) {
                        // 파일 삭제 후 MP4 파일 목록을 다시 가져오기
                        fetchMp4Files();
                        alert(response.message); // 성공 메시지 표시
                    } else {
                        alert("오류: " + response.error);
                    }
                },
                error: function(xhr, status, error) {
                    console.log("Flask API 요청 실패: " + status + ", " + error);
                }
            });
        }
      
        
        
    </script>
</body>
</html>
