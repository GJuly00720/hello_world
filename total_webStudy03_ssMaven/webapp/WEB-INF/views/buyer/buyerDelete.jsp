<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.BuyerVO"%>
<%@page import="kr.or.ddit.ServiceResult"%>
<%@page import="kr.or.ddit.buyer.service.BuyerServiceImpl"%>
<%@page import="kr.or.ddit.buyer.service.IBuyerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	%>
	<jsp:useBean id="buyer" class="kr.or.ddit.vo.BuyerVO" scope="request"></jsp:useBean>
	<jsp:setProperty property="*" name="buyer"/>
	<%
	String goPage = null;
	boolean redirect = false;
	String message = null;
	IBuyerService service = new BuyerServiceImpl();
	ServiceResult result = service.removeBuyer(buyer);
	switch(result){
		case OK:
			goPage = "/buyer/buyerList.jsp";
			redirect = true;
			message = "삭제 성공적! 일주일간 동일아이디 재가입불가";
			break;
		case FAILED:
			goPage = "/buyer/buyerView.jsp?who="+buyer.getBuyer_id();
			message = "잠시후 재시도 ㄱㄱ";
			break;
		default:
			goPage = "/buyer/buyerView.jsp?who="+buyer.getBuyer_id();
			message = "잘못된놈을 삭제하시는듯..";
	}

	session.setAttribute("message", message);
	
	if(redirect){
		response.sendRedirect(request.getContextPath()+goPage);		
	}else{
		RequestDispatcher rd = request.getRequestDispatcher(goPage);
		rd.forward(request, response);
	}
%>
