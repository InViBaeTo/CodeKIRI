package com.DFD.mainController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DFD.dao.userDAO;
import com.DFD.entity.DFD_USER;

/**
 * Servlet implementation class doLoginController
 */
@WebServlet("/doLogin")
public class doLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		

		DFD_USER member = new DFD_USER();
		member.setUser_id(id);
		member.setUser_pw(pass);
		
		// 2. 기능 실행
		userDAO dao = new userDAO();
		
		DFD_USER result = dao.login(member);
		
		if(result!=null) {
			// 로그인 성공
			System.out.println("login success");
			HttpSession session = request.getSession();
			session.setAttribute("user", result);
		}else {
			System.out.println("login fail");
		}
		
		// 3. view 선택
		String url = "main";
		response.sendRedirect(url);
		
		
	}

}
