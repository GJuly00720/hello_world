<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.util.CookieUtil"%>
<%@page import="kr.or.ddit.util.CookieUtil.textType"%>
<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>10/elObject.jsp</title>
</head>
<body>
<h4> EL 기본 객체 </h4>
<pre>
	1. 영역과 관련된 객체
		영역(Scope)이란? 속성 데이터(속성명:속성값) 를 저장한 자료구조(Map).
		 
		(pageScope, requestScope, sessionScope, applicationScope)
		<%
			pageContext.setAttribute("sample-attr", "테스트속성");
			request.setAttribute("sample-array", Arrays.asList("ele1","ele2"));
			request.setAttribute("sample array", Arrays.asList("ele1","ele2"));
		%>
		${pageScope["sample-attr"] }
		${requestScope["sample-array"][0] }
		${requestScope["sample array"][0] }
		
	2. 파라미터 관련 객체 : 
		param(Map&lt;String,String&gt;) , paramValues(Map&lt;String, String[] &gt;) //el은 스코프의 객체를 clone함.
		//둘다 Map이지만 서로 entry타입이 다름.
				
		testParam 이라는 요청 파라미터의 값 출력
		<%= request.getParameter("testParam") %> , ${param.testParam } , ${param["testParam"] }
		<%= request.getParameter("param-2") %> , 
		${ not empty param["param-2"] ? param["param-2"] : "파라미터가 전달되지 않았음." }
		<%= request.getParameterValues("param-2") %>
		${paramValues["param-2"][1] } //객체복사하지 않고 가져오려면 정확하게 가져올 객체의 배열까지 선택해야 함.
		
	3. 요청 해더 관련 객체 : 
		header(Map&lt;String,String&gt;), headerValues(Map&lt;String,String[]&gt;) 
		<%=request.getHeader("accept") %> , ${header.accept }
		<%=request.getHeader("user-agent") %> , ${header["user-agent"] }
		<%=request.getHeaders("cookies") %> , ${headerValues["cookie"][0] }
		
	4. 쿠키 관련 객체 : cookie(Map&lt;String,Cookie&gt;)
		<%=request.getCookies() %>
		, ${cookie.JSESSIONID.getValue() }
		, ${cookie.JSESSIONID.value } //2.5방식
		, ${cookie.JSESSIONID.name } 
		<%--
// 			cookie.setPath(request.getContextPath());
			Cookie cookie = CookieUtil.createCookie("testCookie", "테스트쿠키", request.getContextPath()+"/10", textType.PATH);
			response.addCookie(cookie);
		--%>
		<%=request.getCookies()[0].getPath() %>
		, ${cookie.JSESSIONID.path } //path가 없으니까 표시x //기본값으로 설정되어있음.
		, ${cookie.JSESSIONID.maxAge } 

		//이름과 값만 서버쪽으로 보내진다. //나머진 웹에서 사용되는것이니까 필요가 없음?
		${cookie.testCookie.value }
		<%--=new CookieUtil(request).getCookie("testCookie").getPath() --%>
		${cookie.testCookie.getPath() }
		
	5. 컨텍스트 (초기화)파라미터 관련 객체_어플리케이션에게
		initParam(Map&lt;String,String&gt;)
		
		<%=application.getInitParameter("admin") %>
		,${initParam.admin }, ${initParam["admin"] }
		
	6. pageContext :: jsp의 나머지 기본객체를 사용가능.
		<%=request.getContextPath() %>
		${pageContext.getRequest().getContextPath() } 
		${pageContext.request.contextPath }
<%-- 		${pageContext.request } //예전버전으로 사용하면 코드어시스트되지만 왠만하면 코드어시스트는 사용하지 않을것. --%>

</pre>
</body>
</html>



























