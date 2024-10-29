package com.DFD.mainController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/myPage")
public class myPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        String url = "WEB-INF/views/myPage.jsp"; // index.jsp의 경로
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response); // 결과를 index.jsp로 전달
    
	}
}
