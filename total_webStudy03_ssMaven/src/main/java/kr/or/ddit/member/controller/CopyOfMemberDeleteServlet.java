//package kr.or.ddit.member.controller;
//
//import java.io.IOException;
//import java.util.Map;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import kr.or.ddit.member.service.IMemberService;
//import kr.or.ddit.member.service.MemberServiceImpl;
//import kr.or.ddit.vo.MemberVO;
////@WebServlet("/member/memberDelete.do")
//public class CopyOfMemberDeleteServlet extends HttpServlet{
//	@Override
//	protected void doPost(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
////		//요청받는다.
//		request.setCharacterEncoding("UTF-8");
//		MemberVO member = new MemberVO();
//		
//		IMemberService service = new MemberServiceImpl();
//		service.removeMember(member);
////		if(){
//			
//		}
//		
//		
//		
////		2. 검증
////		3-1. 불통
////			badRequest 전송	
////		3-2. 통과
////			4. 로직객체(MemberServiceImpl)와의 의존관계 형성
////			5. serviceResult 로직(RemoveMember) 선택
////			<%
////				IMemberService service = new MemberServiceImpl();
////				ServiceResult result = service.removeMember(member);
////			%>
////				INVALIDPASSWORD
////					: 메세지 (rd 세션스코프에 담아서 플래시속성의 것으로 보낸다.)
////					: /member/memberView.jsp?who (redirect) : 파라미터 갖고간다
////				FAILED
////					: 메세지 (rd니까 세션스코프에 담아서 플래시속성의 것으로 보낸다.)
////					: /member/memberView.jsp?who (redirect) : 파라미터 갖고간다
////				OK
////		<!-- 			일반유저가 직접 탈퇴 -->
////		<!-- 			: 메세지 (플래시 ,탈퇴약관) -->
////		<!-- 			: / (redirect)	 -->
////					관리자
////					: 누가 탈퇴했다는 메세지 (플래시)
////					: /member/memberList.jsp (redirect
//		
//		
//		
//		
//		
////		//파라미터확보
////		//파라미터 검증
////		//		통	
////					의존관계형성
////					로직선택
////					로직이 주는 데이터 받기
////					==update 통OK
////							불통invalid
////							오류Failed
////							
////		//		불통
//	}
//
//		
//		String mem_id = request.getParameter("mem_id");
//		String mem_pass = request.getParameter("mem_pass");
//	
//		if(StringUtils.isBlank(mem_id)||
//			StringUtils.isBlank(mem_pass)){
//			response.sendError(400,"아디나 비번누락");
//			return;
//		}
//		 %>
//	1. 파라미터 확보.
//	<%-- <jsp:useBean id="member" class="kr.or.ddit.vo.MemberVO" scope="request"></jsp:useBean> --%>
//	<%-- <<jsp:setProperty property="*" name="member" /> --%>
//	<%
//	// 	Map<String,String> errors = new LinkedHashMap<>();
//	// 	request.setAttribute("errors", errors);
//	// 	boolean valid = validate(member,errors);
//	// 	if(valid){
//		IMemberService service = new MemberServiceImpl();
//		MemberVO member = new MemberVO();
//		member.setMem_id(mem_id);
//		member.setMem_pass(mem_pass);
//		ServiceResult result =  service.removeMember(member);
//		String goPage = null;
//		boolean redirect = false;
//		String message = null;
//		switch(result){
//			case INVALIDPASSWORD:
//				message = " 비번 오류 ";
//				redirect = true;
//				goPage = "/member/memberList.jsp?who="+member.getMem_id();
//				break;
//			case FAILED:
//				message = "좀이따 다시 시도";
//				redirect = true;
//				goPage = "/member/memberList.jsp?who="+member.getMem_id();
//				break;
//			default:
//				message = "탈퇴 성공적! 탈퇴약관(일주일간 동일 아이디 재갑 ㄴㄴ)";
//				redirect = true;
//				goPage = "/member/memberList.jsp";
//		}
//	// 	}
//		session.setAttribute("message", message);
//		if(redirect){
//			response.sendRedirect(request.getContextPath()+goPage);
//		} else {
//			RequestDispatcher rd = request.getRequestDispatcher(goPage);
//			rd.forward(request, response);
//		}
//}
