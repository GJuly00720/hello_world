package kr.or.ddit.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet{
	ServletContext application;
	
	@Override
	public void init() throws ServletException {
		super.init();
		getServletContext();
		application = getServletContext();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8");
		StringBuffer html = new StringBuffer("<html>");
		html.append("<body>");
		html.append(String.format("<h4>안녕하세요, 접속시간이 : %tc</h4>", Calendar.getInstance()));
		html.append(" ServletContext : " + application.hashCode() );
		html.append("<br/> 초기화 파라미터 : "+ application.getInitParameter("param1"));
		html.append("</body>");
		html.append("</html>");
		try(
				PrintWriter out = resp.getWriter();
				){
			out.println(html);
		}
		
		
	}
}
