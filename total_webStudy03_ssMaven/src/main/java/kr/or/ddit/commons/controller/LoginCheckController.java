package kr.or.ddit.commons.controller;

import java.io.IOException;
import java.nio.channels.SeekableByteChannel;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.commons.service.AuthenticateServiceImpl;
import kr.or.ddit.commons.service.IAuthenticateService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.util.CookieUtil;
import kr.or.ddit.util.CookieUtil.textType;
import kr.or.ddit.vo.MemberVO;

public class LoginCheckController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if(session==null){ // 세션이 없다. 불순한 의도 || 세션만료시간동안 요청없다가 만료후 요청 
			resp.sendError(400,"최초의 요청일 수 없음"); 
			return null;
		}
		Cookie[] cookies = req.getCookies();
		if(cookies==null){ // 사용자가 브라우저의 쿠키설정을 안해놨을 경우. //web.xml에서 tracking-mode를 쿠키로 잡아놓음.
			session.setAttribute("message", "브라우저 설정 오류");
			return "redirect:/login/loginForm.jsp";
		}
		String mem_id = req.getParameter("mem_id");
		String mem_pass = req.getParameter("mem_pass");
		String idSaveCheckBox = req.getParameter("idSave"); 
		
		String goPage = null; 
		String message = null;
		if(StringUtils.isBlank(mem_id) || StringUtils.isBlank(mem_pass)){ // 데이터 누락.
			goPage = "redirect:/login/loginForm.jsp";
			message = "id,비번 누락";
		}else{
			IAuthenticateService service = new AuthenticateServiceImpl();
			Object result = service.authenticate(new MemberVO(mem_id, mem_pass));
			if(result instanceof MemberVO){ // 인증 성공
				// 체크한 상태에서 인증에 성공했다면, 해당 아이디를 일주일간 기억.
				// 체크하지 않은 상태에서 인증 성공했다면, 저장되어있던 아이디까지 삭제.
				int maxAge = 0 ;
				if("idSave".equals(idSaveCheckBox)){
					maxAge = 60*60*24*7;
				}
				Cookie idCookie = CookieUtil.createCookie("idCookie", mem_id, req.getContextPath(), textType.PATH, maxAge);
				
				resp.addCookie(idCookie);
				session.setAttribute("authMember", result);
				goPage = "redirect:/";
				
			}else{ // 인증 실패
				if(ServiceResult.NOTEXIST.equals(result)){
					message = "인증실패. 존재하지 않는 아이디입니다.";
				}else{
					message = "인증실패. 비밀번호를 다시확인하십시오..";
				}
				goPage = "redirect:/login/loginForm.jsp";
			}
		}
		session.setAttribute("message", message);
		return goPage;
	}

}
