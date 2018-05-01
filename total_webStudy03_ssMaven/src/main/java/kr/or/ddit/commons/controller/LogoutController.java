package kr.or.ddit.commons.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.mvc.ICommandHandler;

public class LogoutController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		//로그아웃 (먼저 로그인상태여야함.)
		HttpSession session = req.getSession(false); 
		if(session == null || session.isNew()){ // 새로 만들어진 세션인지 확인해줌.
			resp.sendError(400,"로그아웃전 로그인이 필요합니다");
			return null;
		}
		
		session.invalidate();
		return "redirect:/";
	}
	

}
