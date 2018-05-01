package kr.or.ddit.servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/getBloodType.do")
public class BloodTypeServlet extends HttpServlet {
	// bloodType/a.jsp 와 같은 컨텐츠들을 사용해서 응답을 전송.
	// 1. 현재 이 서블릿에서 모든 요청에 대한 처리가 완료되었다 라고 가정.
	// --> Redirect
	// 2. 클라이언트가 선택한 파라미터 데이터가 jsp에서 사용될 수 있도록...
	// 즉 현재 서블릿에서 일정 처리가 이뤄졌으나, 요청에 대한 완전한 처리는 아닌 경우
	// JSP 쪽에서 나머지 처리가 이뤄질수 잇도록 이동하는 방식.
	// --> Dispatch
	// 1.요청접수
	// 2.요청분석
	// 3.분석된 결과에 따라 동적인 처리
	// 4.응답을 전송하기 위한 이동코드

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String bt = req.getParameter("bloodType");

		if (bt != null) {
			RequestDispatcher rd = req.getRequestDispatcher
					("/WEB-INF/views/bloodTypes/" + bt + ".jsp");
			rd.forward(req, resp);
		} else {
			resp.sendError(400, "혈액형 정보가 누락됨");
		}
	}
}
