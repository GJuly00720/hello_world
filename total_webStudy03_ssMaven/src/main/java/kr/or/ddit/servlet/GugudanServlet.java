package kr.or.ddit.servlet;

import javax.servlet.http.*;
import javax.servlet.*;

import java.io.*;
import java.util.*;

import javax.servlet.annotation.*;

import java.text.*;

@WebServlet("/gugudan")
// since servlet spec 3.0
public class GugudanServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/html;charset=utf-8");

		String result = generateData(2, 9);

		try (PrintWriter out = resp.getWriter();) {
			out.println(result);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// 1. 클라이언트의 요청 분석
		// 2. 파라미터 확보(파라미터명: name속성)
		String param1 = req.getParameter("minDan");
		String param2 = req.getParameter("maxDan");
		// 3. 클라이언트 데이터 검증.
		String  result = null;
		if (param1 != null && param1.matches("[2-9]") 
			&& param2 != null && param2.matches("[2-9]")
			){
				int minDan = Integer.parseInt(param1);
				int maxDan = Integer.parseInt(param2);
				result = generateData(minDan, maxDan);
		}else {
			result = "<html><body><h4>정상적인 구구단 서비스 불가!</h4></body></html>";
		}

		resp.setContentType("text/html;charset=utf-8");


		try (PrintWriter out = resp.getWriter();) {
			out.println(result);
		}
	}

	private String generateData(int min, int max) throws IOException {
		// 1. 템플릿 읽기
		String path = GugudanServlet.class.getResource("../sample.tmpl")
				.getFile();
		System.out.println(path);// cmd에서 확인할수있다. 왜냐면 여긴 server side module
		// 현재 클래스파일을 기준으로 상대경로로 해서 가져올 파일의 경로를 알아낸다.
		File file = new File(path);
		StringBuffer html = new StringBuffer();
		// 일반적인 스트림: 바로 연결가능
		// 연결형 스트림: 바로연결 불가. 일반스트림이 열리고 연결형 스트림을 연결가능.buffer
		try (FileInputStream fis = new FileInputStream(file);
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(fis, "UTF-8")// 1byte를 2byte로
															// 변환했기때문에 한글데이터를
															// 원형그대로 가져올수있다.
				);) {
			String buffer = null;// closable객체가아님
			while ((buffer = reader.readLine()) != null) {// 더이상 리턴되는값이 없을때
															// =null 일떄 eof
				html.append(buffer);
			}
		}

		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat(
				" yyyy년 MM월 dd일 HH시 mm분 ");
		// formatting : 특정 타입의 데이터를 일정한 형식의 문자열로 변환.
		// parsing : 일정한 형식의 문자열을 특정 타입의 데이터로 변한.

		String result = html.toString().replace("%date", formatter.format(now));
		// ㄴ정규표현식 메타문자로 해석하는데 일반문자로 바꾸기위해 \\.
		String pattern = "<td>%d*%d=%d</td>";

		StringBuffer gugudan = new StringBuffer();
		for (int dan = min; dan <= max; dan++) {
			gugudan.append("<tr>");
			for (int mul = 1; mul <= 9; mul++) {
				gugudan.append(String.format(pattern, dan, mul, (dan * mul)));
			}
			gugudan.append("</tr>");
		}

		// try with resource 구문 형태
		// try{(Closable 개체의 할당 구문, close 메소드 호출 대상){
		// 예외 발생 가능구문
		// }catch(예외 종류){//예외 처리 구문
		// }
		result = result.replace("%gugudan", gugudan.toString());
		return result;
	}
}