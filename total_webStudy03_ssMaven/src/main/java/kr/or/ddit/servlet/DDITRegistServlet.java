package kr.or.ddit.servlet;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.util.CommonUtil;
import kr.or.ddit.vo.StudentVO;

/**
 * Servlet implementation class DDITRegistServlet
 */
@WebServlet("/regist.do")
public class DDITRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 1. 제일먼저 인코딩!!!
		request.setCharacterEncoding("UTF-8");

		// 2. 파라미터(데이터) 받아오기.
		// name, age, mail,hp,addr, gen, lic, hoddy, grade
		String name = request.getParameter("name");
		String ageStr = request.getParameter("age");
		String mail = request.getParameter("mail");
		String hp = request.getParameter("hp");
		String addr = request.getParameter("addr");
		String gen = request.getParameter("gen");
		// request의 겟파라미터는 제너릭의 키와 벨류값으로 관리되고있다.
		// 그 중 밸류는 배열로 관리된다.(엔트리는 배열로 관리)
		// 동일한 이름(키값)으로 전달되는 다양한 밸류값을 확보가능.
		String[] lic = request.getParameterValues("lic");
		String[] hobby = request.getParameterValues("hobby");
		String grade = request.getParameter("grade");

		
		
		// 3.들어온 데이터에대한 검증
		// 클라이언트사이드에선 필수데이터 검증, 데이터 타입, 데이터길이, 데이터 형식.....--> 객체검증 (용 프레임웤이
		// 만들어져있다)
		// 서버사이드에선 객체검증이 끝난 데이터가 제대로 들어왔는지를 확인
		// whitespace = null은 아니되 size가 0
		StudentVO stVO = new StudentVO(); //<-- 검증의 대상.(VO)
		stVO.setName(name);
		stVO.setAge(Integer.parseInt(ageStr));
		stVO.setAddr(addr);
		stVO.setGen(gen);
		stVO.setGrade(grade);
		stVO.setHobby(hobby);
		stVO.setHp(hp);
		stVO.setLic(lic);
		stVO.setMail(mail);
		
		
		
		Map<String, String[]> paramMap = request.getParameterMap();
		String pattern = "파라미터명: %s, 파라미터값 : %s\n";
		for(java.util.Map.Entry<String, String[]> entry : paramMap.entrySet() ){/*순서가 있는거처럼 접근가능*/
			//List,set 안에 들어있는건 엘리먼트  = 값하나로 구성
			//엘리먼트 = 키와 밸류로 구성
			String pName = entry.getKey();
//			request.getParameterValues(pName);
			String[] pValue = entry.getValue();
			System.out.printf(pattern, pName, Arrays.toString(pValue));
		}
		
		Enumeration<String> en= request.getParameterNames();
		while(en.hasMoreElements()){
			String pName = (String) en.nextElement();
			String[] pValue = request.getParameterValues(pName);
			System.out.printf(pattern, pName, Arrays.toString(pValue));
		}
		
		// 객체검증
		// 필수데이터 여부, 데이터 타입, 데이터길이, 데이터 형식.....--> 객체검증 (용 프레임웤이
				// 만들어져있다)
		boolean valid = true;//<- 플래그변수 : if문에 한번이라도 걸린다면 검증통과 불가
		Map<String, String> errors = new LinkedHashMap<String, String>();
		if (CommonUtil.isBlank(stVO.getName())) {
			valid = false;
			errors.put("name", "이름누락");
		}
		if (StringUtils.isBlank(stVO.getMail())) {
			valid = false;
			errors.put("mail", "이메일 입력ㄱㄱ");
		}
		if (stVO.getHp() == null || stVO.getHp().trim().length() == 0
				|| !hp.matches("\\d{3}-\\d{3,4}-\\d{4}")) {
			valid = false;
			errors.put("hp", "폰번이 누락이거나 형식틀림");
		}
		
		if (valid) {// 검증을 통과한 경우 
			// DB저장 VO(ValueObject)로 담아서
			// -> 저장을 위한 DAO호출
			System.out.println(stVO);
			
		}else{// 에러메세지는 최대한 자제.
			
			// errors 맵을 어떻게 전달하지??????
			// Dispatch이동방식
			// 페이지 이동
			RequestDispatcher rd = request.getRequestDispatcher("/01/variousInput.jsp");
			rd.forward(request, response);
//			response.sendRedirect(request.getContextPath()+"/01/variousInput.jsp");
		}
	}
}
