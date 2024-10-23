package com.DFD.mainController;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DFD.dao.uploadDAO;
import com.DFD.entity.DFD_UPLOAD;
import com.DFD.entity.DFD_USER;

@WebServlet("/myPage")
public class myPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		DFD_USER user = (DFD_USER)session.getAttribute("user");
		uploadDAO dao = new uploadDAO();
		
		String id = user.getUser_id();
		
		List<DFD_UPLOAD> list = dao.getUpload(id);
		
		System.out.println("getImage success");
		session.setAttribute("Image", list);
		
		
		String url = "WEB-INF/views/myPage.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}

}
