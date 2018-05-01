package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.vo.MemberVO;

//@WebServlet("/member/memberView.do")
public class MemberViewController implements ICommandHandler{
	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
//		1.요청분석(파라미터 분석, 파라미터처리 - > 검증)
//	 
		String mem_id = req.getParameter("who");
			// 새로운 요청이 발생한 경우.
		if (StringUtils.isBlank(mem_id)) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST,"필수 파라미터 누락");
				//잘못된 방식으로 접근하여 누락될수 없는 데이터가 누락됬기때문에 에러메세지 송출
			return null; //goPage = null
		}
		IMemberService service = new MemberServiceImpl();
		MemberVO member  = service.retrieveMember(mem_id);
//		2. 의존관계(bbl) 형성
//		3. bl 선택
		req.setAttribute("member", member);
//		4. 로직이 돌려주는 데이터(infomation/content) 확보
		String goPage = "member/memberView"; //논리적인 view네임!!!!!!!!
		return goPage;
	}
}
