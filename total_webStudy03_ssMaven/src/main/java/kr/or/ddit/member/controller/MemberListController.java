package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.CommonException;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.util.CookieUtil;
import kr.or.ddit.util.CookieUtil.textType;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

//@WebServlet("/member/memberList.do")

public class MemberListController implements ICommandHandler{
				//이이름의 소문자로 등록.
	//회원의 목록을 클라이언트가 조회하려는
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String lang = req.getParameter("lang");
		
		if(StringUtils.isNotBlank(lang)){
			Cookie langCookie = CookieUtil.createCookie("langCookie", lang, req.getContextPath(), textType.PATH, 60*60*24*2);
			resp.addCookie(langCookie);
		}
		
//		1. 요청분석(파라미터 분석->검증)
		String searchType = req.getParameter("searchType");
		String searchWord = req.getParameter("searchWord");
		String pagestr = req.getParameter("page");
		int currentPage = 1;
		if(StringUtils.isNumeric(pagestr)){
			currentPage = Integer.parseInt(pagestr);
		}
		
//		2. 의존관계(BLL) 형성
		IMemberService service = new MemberServiceImpl();
//		3. BL 선택
//		4. 로직이 돌려주는 데이터(information/content) 확보
		PagingVO<MemberVO> pagingVO = new PagingVO<MemberVO>(3,5);
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);

		int totalRecord = service.retrieveMemberCount(pagingVO);

		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<MemberVO> memberList = service.retrieveMemberList(pagingVO);
		pagingVO.setDataList(memberList);
//		5. 공유(view로의 전달)
		req.setAttribute("pagingVO", pagingVO);
		String goPage = "member/memberList"; //뷰선택 //논리적인 view네임이 return됨.
		return goPage;
	}
}
