package kr.or.ddit.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 사용자로부터 op1과 op2라는 이름의 피연산자를 받아서
 * 최종적으로 op1 + op2 = 결과 와 같은 형태의 응답데이터를 
 * html형식으로 제공
 * 
 */
//@WebServlet("/calculate")
public class CalculatorServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String queryString = req.getQueryString();
		System.out.println(queryString);
		req.setCharacterEncoding("UTF-8");  //인코딩은 파라미터를 뽑기전에 해야한당.
		
		resp.setContentType("text/html;charset=utf-8");
		String client = req.getParameter("client");
		String opParam1 = req.getParameter("op1");
		String opParam2 = req.getParameter("op2");

		if (opParam1 != null && opParam1.matches("-?[0-9]+")
				&& opParam2 != null && opParam2.matches("\\d+")
				) {
			String pattern = "<html><body><h4>%d+%d=%d</h4><h4>%s</h4></body></html>";

			int op1 = Integer.parseInt(opParam1);
			Integer op2 = new Integer(opParam2);
			try (
					PrintWriter out = resp.getWriter();
			) {
				out.println(String.format(pattern, op1, op2, op1 + op2 , client));
			}
		} else {
			resp.sendError(400);// 에러 응답데이터 400 = Bad Request
		}

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		resp.setContentType("text/html;charset=utf-8");
		req.setCharacterEncoding("UTF-8"); // 인코딩하는 방식
					//ㄴ바디가 있을때 사용가능 ==doPost()
				
		String client = req.getParameter("client");
		String opr = req.getParameter("opr");
		String opParam1 = req.getParameter("op1");
		String opParam2 = req.getParameter("op2");
		String pattern = null;
		if (opParam1 != null && opParam1.matches("-?[0-9]+")
				&& opParam2 != null && opParam2.matches("\\d+")
				) {
			if (opr.matches("+")) {
				pattern = "<html><body><h4>%d+%d=%d</h4><h4>%s</h4></body></html>";
			} else if (opr.matches("-")){
				pattern = "<html><body><h4>%d-%d=%d</h4><h4>%s</h4></body></html>";
			} else if (opr.matches("*")) {
				pattern = "<html><body><h4>%d*%d=%d</h4><h4>%s</h4></body></html>";
			} else if (opr.matches("/")) {
				pattern = "<html><body><h4>%d/%d=%d</h4><h4>%s</h4></body></html>";
			}
			
			int op1 = Integer.parseInt(opParam1);
			Integer op2 = new Integer(opParam2);
			String.format(pattern, op1, op2, op1 + op2 + client);
			try (
					PrintWriter out = resp.getWriter();
			) {
				out.println(String.format(pattern, op1, op2, op1 + op2 , client));
			}
		} else {
			resp.sendError(400);// 에러 응답데이터 400 = Bad Request
		}

	}

}
