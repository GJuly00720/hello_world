package kr.or.ddit.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 사용자로부터 op1과 op2라는 이름의 피연산자를 받아서 최종적으로 op1 + op2 = 결과 와 같은 형태의 응답데이터를 html형식으로
 * 제공
 * 
 */
@WebServlet("/calculate")
public class SemCalculatorServlet extends HttpServlet {

	public static enum Operator {// 퍼브릭 이너클래스 // 확장성에 관한문제 해결.
		PLUS("+"), MINUS("-"), MULTIPLY("*"), DIVIDE("/");// 생성자
		private String sign;
		Operator(String sign) {
			this.sign = sign;
		}
		public String getSign() {
			return sign;
		}
		public void setSign(String sign) {
			this.sign = sign;
		}
		public int operate(int op1, int op2) {
			int result = -1;
			switch (sign) {
			case "+":
				result = op1 + op2;
				break;
			case "-":
				result = op1 - op2;
				break;
			case "*":
				result = op1 * op2;
				break;
			case "/":
				result = op1 / op2;
				break;
			default:
				// 처리할 수 없는 연산자가 선택됐으므로 에러
				break;
			}
			return result;
		}
	}// 모든이넘은 자신과 똑같은 텍스트를 밸류값으로 갖고있다

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		resp.setContentType("text/html;charset=utf-8");
		req.setCharacterEncoding("UTF-8"); // 인코딩하는 방식
		// ㄴ바디가 있을때 사용가능 ==doPost()

		String client = req.getParameter("client");
		String operatorStr = req.getParameter("Operator");

		String opr = req.getParameter("opr");
		String opParam1 = req.getParameter("op1");
		String opParam2 = req.getParameter("op2");

		if (opParam1 != null && opParam1.matches("-?[0-9]+")
				&& opParam2 != null && opParam2.matches("\\d+")
				&& operatorStr != null) {
			String pattern = "<html><body><h4>%d %s %d=%d</h4><h4>%s</h4></body></html>";
			int op1 = Integer.parseInt(opParam1);
			Integer op2 = new Integer(opParam2);

			int result = 0;
			String sign = null;
			try {
				Operator operator = Operator.valueOf(operatorStr.toUpperCase());
				result = operator.operate(op1, op2);
				sign = operator.getSign();
			} catch (IllegalArgumentException e) {
				// 사칙연산 이외의 연산자가 파라미터로 넘어온 경우.
			}// 체크드입셉션-예외를 처리하지 않았을때, 언쳌입셥션/// 런타임입셉션

			String contents = String.format(pattern, op1, sign, op2, result, client);
			
			HttpSession session = req.getSession();
			session.setAttribute("contents",contents);
//			req.setAttribute("contents", contents);
//			RequestDispatcher rd = req.getRequestDispatcher("/01/calculateForm.jsp"); 
//				rd.forward(req, resp);
			resp.sendRedirect(req.getContextPath()+"/01/calculateForm.jsp");
				
//			try (PrintWriter out = resp.getWriter();) {
//				out.println(String.format(pattern, op1, sign, op2, op1 + op2,
//						client));
//			}
		} else {
			resp.sendError(400);// 에러 응답데이터 400 = Bad Request
		}

	}

}
