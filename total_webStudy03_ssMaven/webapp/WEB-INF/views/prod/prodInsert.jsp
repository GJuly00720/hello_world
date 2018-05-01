<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.or.ddit.prod.service.ProdServiceImpl"%>
<%@page import="kr.or.ddit.prod.service.IProdService"%>
<%@page import="kr.or.ddit.vo.ProdVO"%>
<%@page import="kr.or.ddit.ServiceResult"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%

// 	if (redirect) {
// 		response.sendRedirect(request.getContextPath() + goPage);
// 	} else {
// 		RequestDispatcher rd = request.getRequestDispatcher(goPage);
// 		rd.forward(request, response);
// 	}
%>
전달된 파라미터 확보 prodId~ prodvo세팅. prodVO에 파라미터넣기 검증 =db의 스키마와 제약조건 nullable
datatype data형식 (YYYY-MM-DD) :: 날짜데이터로 파싱가능한 행태로 넘어오는지. to_data
mandatory 부분 :: buyerId, lprod_nm 통 의존관계형성 로직선택 로직이 주는 값받기 OK what 파람들고
= (prod_id) forbyReference(한객체를 보고있는 형식) (selectkey로 만들어진 pk.) prod_view
:: 조회가능하도록 커넥션종료 - redirect Failed 사과메세지 기존입력데잍터 prod_form dispatch
requset 불통 prod_form :기존입력데이터, 에러메세지,request, dispatch
