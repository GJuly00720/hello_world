<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/requestDesc.jsp</title>
</head>
<body>
<h4> request 기본객체 (HttpServletRequest)</h4>
<pre>
	<%
		Date today = new Date();
	%>
		이때 가장 먼저 request와 responce를 봐야한다.
	톰캣같은 아이들의 다른이름 :	서블릿컨테이너 웹컨테이너 was 미들웨어
	: 클라이언트와 클라이언트의 요청 정보를 캡슐화한 객체
	: request Line + request Header + request Body 의 정보를 가진 객체
	
	1. 파라미터 확보에 사용: RFC2396 규약에 따라 인코딩된 특수문자에 대한 처리 선행.
		(ServletDescription 파일 참고)
		Map&lt;String,String[]&lt; getParameterMap,***** 
		Enumeration&lt;String&lt; getParameterNames, 
		String[] getParameterValues(name),
		String getParameter(name)
		
	2. line 이나 header 영역을 통해 전달되는 메타 데이터 확보에 사용
		
		---->리퀘스트에 사용되는 기본설정중에는 post때만 사용되게 하는 것
		<%=request.getCharacterEncoding() %> 
		---->post용(body필요)
		<%=request.getContentType() %>
		---->여기서 content는 body를 말함. 그래서 바디가 없으면 -1을 출력. 
			웬만한 content라는 말들은 body를 말함
		<%=request.getContentLength() %>
		
		
			---->하드코딩하지않고 절대 경로 완성에 사용(클라이언트)
		<%=request.getContextPath() %>
		
			---->현재의 로컬. server의 주소,이름,port를 가져온다.
		<%=request.getLocalAddr() %>
		<%=request.getLocalName() %>
		<%=request.getLocalPort() %>
		
			---->클라이언트의 주소,이름,port를 가져온다.
		<%=request.getRemoteAddr() %>
		<%=request.getRemoteHost() %>
		<%=request.getRemotePort() %>

			---->request Line의 정보
		<%=request.getMethod() %> 
		<%=request.getRequestURI() %>
		<%=request.getRequestURL() %>
		<%=request.getProtocol() %>
		
			---->request Header(metadata정보(부가데이터))의 정보
				:header는 이름과 값의 쌍으로 있다.
		Enemeration&lt;String&lt; request.getHeaderNames()
		String getHeader(name)
		long getDateHeader(name) (↓String을 자동으로 파싱한다.)
		int getIntHeader(name)
		(모든 날짜 date는 밀리세컨드로 환산된다 = long/ 타입이 int로 되어있다면 초단위)
		
		<%= new Date(new Date().getTime()) %>
		<%= new Date(0) %>	밀리세컨드의 기준점이 되는 녀석
</pre>
<table>
<%
	final String PTRN = "<th>%s</th><td>%s</td>";
%>
<%
	Enumeration<String> en = request.getHeaderNames();

	while(en.hasMoreElements()){
		out.print("<tr>");
		String headerName = en.nextElement();
		String headerValue = request.getHeader(headerName);
		out.println(String.format(PTRN, headerName, headerValue));
		out.print("</tr>");
	}
	
%>
</table>
</body>
</html>