package kr.or.ddit.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/access") //클라이언트가 이요청을 날릴 때마다 누적됨.
public class UserCountServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Integer cnt = (Integer)getServletContext().getAttribute("usercount");
		if(cnt==null){//속성이 존재하지 않는 상황
			cnt = 0;
		}
		cnt++;
		getServletContext().setAttribute("usercount", cnt);
		
		resp.sendRedirect(req.getContextPath()+"/04/usercontView.jsp");
	}
}
