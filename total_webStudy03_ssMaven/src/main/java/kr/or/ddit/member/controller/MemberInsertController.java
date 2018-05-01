package kr.or.ddit.member.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;

import kr.or.ddit.InsertGroup;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.validate.MemberInsertValidate;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.validate.CommonValidator;
import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.MemberVO;

/**
 * 네스트풀uri... = 한가지 주소로 여러 가지를 처리. 회원 신규등록을 처리하는 과정 (/member/memberInsert.do) 1.
 * 신규등록 양식제공 (GET) 2. 양식을 통해 입력된데이터들의 처리(POST) PUT/DELETE같은 다른 메소드들을 사용해서 좀더 많은
 * 처리 가능.
 */
// @WebServlet("/member/memberInsert.do")
// 하나의 주소만으로 여러 일을 처리함.
public class MemberInsertController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String method =  request.getMethod();
		// memberForm쪽으로 연결만해줌.
		if ("get".equalsIgnoreCase(method)) {
			return doGet(request, response);
//			goPage = "member/memberForm";
		} else  if ("post".equalsIgnoreCase(method)){
			return doPost(request, response);
		}else{
			response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED , method + "는 지원하지 않스니다");
		}
		return method;
	}
	public String doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String goPage= null;
		goPage = "member/memberForm";
		return goPage;

	}

	public String doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// memberInsert에서 일어나는 일들을 해줌.
		MemberVO member = new MemberVO();
		request.setAttribute("member", member);
		try {
			BeanUtils.populate(member, request.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}

		Map<String, String> errors = new LinkedHashMap<>();
		request.setAttribute("errors", errors);
		
		CustomValidator<MemberVO> validator = new CommonValidator<MemberVO>();
		
		boolean valid = validator.validate(member, errors, InsertGroup.class);
		String goPage = null;
		String message = null;
		if (/* valid */errors.size() == 0) {// 통과
			IMemberService service = new MemberServiceImpl(); // 로직객체와의
																// 의존관계형성
			ServiceResult result = service.createMember(member);
			HttpSession session = request.getSession();
			switch (result) {
			case PKDUPLICATED:
				message = "아이디 중복, 다시입력";
				goPage = "member/memberForm";
				break;
			case FAILED:
				message = "미안;서버오류임; 다시 입력 ㄱㄱ";
				goPage = "member/memberForm";
				break;
			case OK:
				goPage = "redirect:/member/memberList.do";
				session.setAttribute("message", member.getMem_id()
						+ "님! 신규 등록 완료쓰~");
			}
		} else { // 불통
			goPage = "member/memberForm";
		}

		return goPage;
	}

	

}
