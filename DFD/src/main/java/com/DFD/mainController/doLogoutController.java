package com.DFD.mainController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/doLogout")
public class doLogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 세션 가져오기
		HttpSession session = request.getSession(false); //세션 없으면 null 반환
		if(session != null) {
			session.invalidate();
			System.out.println("로그아웃 성공");
		}
		// 로그아웃 후 갈 URL
		response.sendRedirect("main"); // main 페이지로 리다이렉트
	}

}
