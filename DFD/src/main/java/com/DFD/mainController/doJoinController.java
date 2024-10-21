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

@WebServlet("/doJoin")
public class doJoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String email = request.getParameter("email");		
		String pass = request.getParameter("pass");
		String passCheck = request.getParameter("passcheck");
		

		DFD_USER member = new DFD_USER();
		member.setUser_id(id);
		member.setUser_pw(pass);
		member.setUser_email(email);
		
		if(!pass.equals(passCheck)) {
			response.sendRedirect("join");
		}
		
		// 2. 기능 실행
		userDAO dao = new userDAO();
		
		int result = dao.join(member);
		
		String url = "";
		
		if(result>0) {
			// join 성공
			DFD_USER LogMem =  dao.login(member);
			System.out.println("join success");
			HttpSession session = request.getSession();
			session.setAttribute("user", LogMem);
			url = "main";
		}else {
			System.out.println("join fail");
			url = "join";
		}
		
		// 3. view 선택
		
		response.sendRedirect(url);
		
	}

}
