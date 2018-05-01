<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.util.CookieUtil"%>
<%@page import="java.util.Date"%>
<%@page import="java.nio.channels.SeekableByteChannel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>07/sessionDesc.jsp</title>
</head>
<body>
<h4> 세션 (session)</h4>
<pre>
	: HTTP의 stateless 단점을 보완하기 위한 상태정보를 서버상에 저장하는 개념.(==Session Scope의 속성 형태)
	웹에서 세션의 정의 : 어플리케이션을 사용하는 동안.
	
	세션 생명주기
	생성 : 한 유저가 한 브라우저를 이용해 최초의 요청을 발생시킨 경우 , 생성!!
		==> 클라이언트에서 서버쪽으로 세션 id가 전송되지 않는 경우.
	유지 : 세션이 생성될 때 부여된 식별자(세션id)가 쿠키(JSESSIONID)형태로 
		클라이언트쪽에 저장되었다가 다음 요청이 발생할때 서버로 전송  =의 반복이 세션유지
		세션아이디 : <%=session.getId() %>
		JSESSIONID쿠키 : <%=new CookieUtil(request).getCookieValue("JSESSIONID") %>
		세션 생성 시간 : <%= new Date(session.getCreationTime()) %>
			
		세션의 tracking-mode : cookie, url(공격에 취약:하이잭킹), ssl/tls
		<a href="sessionDesc.jsp;jsessionid=<%=session.getId()%>">세션유지하기_세션파라미터로</a>
<!-- 				세션파라미터or메트릭트패스 라고불림 -->
		
	소멸(만료) : (j)세션아이디가 더이상 전송안됨
			세션을 만료시킬 수 있는 세가지 이벤트가 발생하면
			JSESSIONID라는 쿠키가 만료됨. (더이상 전송되지 않음으로 만료됨)
		현제 세션의 만료시간 : <%=session.getMaxInactiveInterval() %>
</pre> 
</body>
</html>