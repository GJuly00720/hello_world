<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	static enum SystemType{
		WINDOW("데스크탑(Window)"), ANDROID("모바일(Mobile)"),IPHONE("모바일(애플)"),MAC("모바일(애플)"), IOS("모바일(애플)");
		private String systemInfo;
		SystemType(String text){
			systemInfo=text;
		}
		public String getSystemInfo(){
			return this.systemInfo;
		}
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<pre>
클라이언트의 브라우저와 시스템을 확인해서, //접속시 키워드 확인.
클라이언트가 데스크탑을 사용한다면,
<%
Enumeration<String> e = request.getHeaderNames();
while(e.hasMoreElements()){
	String headerName = e.nextElement();
	String headerValue = request.getHeader(headerName);
	if(headerValue.contains("Windows")){
		out.println("당신의 접속환경은 데탑이고, ");
	}else if(headerValue.contains("Mobile")){
		out.println("당신의 접속환경은 모바일이고, ");
	}else{
		out.print("당신의 접속 환경을 anonymous context이고, ");
	}
	if(headerValue.contains("Safari")){
		out.println("사용브라우저는 사파리 입니다.");
	}else if (headerValue.contains("Chrome")){
		out.println("사용브라우저는 크롬 입니다.");
	}else if (headerValue.contains("FireFox")){
		out.println("사용브라우저는 파폭 입니다.");		
	}else if (headerValue.contains("Trident")){
		out.println("사용브라우저는 익스 입니다.");		
	}else{
		out.print("사용 브라우저는 noname 입니다.");
	}
}

%>
클라이언트가 모바일을 사용한다면,

클라이언트가 크롬을 사용한다면,

클라이언트가 파이어폭스를 사용한다면,

클라이언트가 익스플로러를 사용한다면,

최종 출력메세지 "당신의 접속 환경을 데스크탑이고, 사용 브라우저는 크롬 입니다.";
최종 출력메세지 "당신의 접속 환경을 anonymous context이고, 사용 브라우저는 noname 입니다.";
		<%=request.getRemoteAddr() %>
		<%=request.getRemoteHost() %>
		<%=request.getRemotePort() %>
		<%=request.getMethod() %> 
		
		<%=request.getRequestURI() %>
		<%=request.getRequestURL() %>
		<%=request.getProtocol() %>
		
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
</pre>
</body>
</html>