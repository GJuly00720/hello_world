<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/implicitObject</title>
</head>
<body>
<h4> JSP 기본 객체 (내장객체) </h4>
<pre>
	: JSP 템플릿에 의해 서블릿 소스가 파싱될 때 자동으로 선언되고, 생성되는 지역 객체들 (변수들...)
		request(HttpServletRequest) : 요청과 관련된 정보를 가진 객체
		response(HttpServletResponse) : 응답과 관련된 정보를 가진 객채
		out(JSPWriter) : 웹 어플리케이션의 출력스트림 객체
		session(HttpSession) : 웹에서 형성되는 session의 모든 상태 정보를 가진 객체.
		application(ServletContext) : 서블릿을 운영중인 웹어플리케이션과 서버에 관한 정보를 가진 객체
		<%=application.getInitParameter("param1") %>, <%=application.hashCode() %>
		config(ServletConfig) : 서블릿의 설정 정보를 가진 객체
		page(Object) : this, 현재 JSP 페이지의 인스턴스
		pageContext(pageContext) : JSP 페이지와 관련된 모든정보를 가진객체
				(제일 먼저 생성되면서 나머지 모든 기본객체의 getter를 가짐)
		exception(Throwable) : 발생한 예외에 대한 정보를 가진 객체 (에러를 처리할 페이지에서 사용됨)
		

</pre>
	<div style="background-color: yellow">
		<%=pageContext.getAttribute("pageAttr")	%>
		<%=request.getAttribute("requestAttr")	%> 
		<%=session.getAttribute("sessionAttr")	%>
		<%=application.getAttribute("applicationAttr")	%>
	</div>
</body>
</html>