package kr.or.ddit.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/inner.do")
//명령받는쪽
public class Model2TestServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		//처리...
		
		// /WEB-INF/inner.jsp <-로 우회적 접근
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/inner.jsp");
		rd.forward(req, resp);
	}
}
