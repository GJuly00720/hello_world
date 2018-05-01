package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.vo.MemberVO;

//@WebServlet("/member/memberDelete.do")
public class MemberDeleteController implements ICommandHandler{
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String mem_id = request.getParameter("mem_id");
		String mem_pass = request.getParameter("mem_pass");
	
		if(StringUtils.isBlank(mem_id)||
			StringUtils.isBlank(mem_pass)){
			response.sendError(400,"아디나 비번누락");
			return null;
		}
		IMemberService service = new MemberServiceImpl();
		MemberVO member = new MemberVO();
		member.setMem_id(mem_id);
		member.setMem_pass(mem_pass);
		ServiceResult result =  service.removeMember(member);
		String goPage = null;
		String message = null;
		switch(result){
			case INVALIDPASSWORD:
				message = " 비번 오류 ";
				goPage = "redirect:/member/memberList.jsp?who="+member.getMem_id();
				break;
			case FAILED:
				message = "좀이따 다시 시도";
				goPage = "redirect:/member/memberList.jsp?who="+member.getMem_id();
				break;
			default:
				message = "탈퇴 성공적! 탈퇴약관(일주일간 동일 아이디 재갑 ㄴㄴ)";
				goPage = "redirect:/member/memberList.jsp";
		}
		HttpSession session = request.getSession();
		session.setAttribute("message", message);
		
		return goPage;

	}

}
