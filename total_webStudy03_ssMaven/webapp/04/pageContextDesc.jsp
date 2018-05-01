<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/pageContextDesc.jsp</title>
</head>
<body>
<h4> PageContext 객체의 활용</h4>
<pre>
	: JSP 페이지 하나와 1:1 구조로 생성되는 객체로, 해당 페이지의 모든 정보를 가짐.
	
	기능
	1. 나머지 기본 객체의 참조를 확보
	<%= pageContext.getRequest() == request %>
	<%= pageContext.getResponse() == response %>
	<%= pageContext.getOut() == out %>
	<%= pageContext.getSession() == session %>
	<%= pageContext.getServletContext() ==  application%>
	<%= pageContext.getServletConfig() == config %>
	<%= pageContext.getPage() == page %>
	<%= pageContext.getException() == exception %>
	<!-- 에러가 발생하지 않았므로 null 이 페이지를 isErrorPage를(이페이지에서 에러를 처리하겠다) true로 바꿔주면 에러에 대해 처리가능하다 -->
	2. 흐름 제어(페이지 이동) : RequestDipaspatcher를 사용한 흐름 제어방식과 동일.
						: 주로 서버사이드 페이지 모듈화에서 사용됨.
						 :버퍼의 활용 방법 : 예제 :: bufferDesc.jsp
	<%
		pageContext.include("/01/first.jsp");
// 		RequestDispatcher rd = request.getRequestDispatcher("/01/first.jsp");  
// 		rd.include(request, response); //buffer사용. 
	%>
	
	3. 속성 제어(Scope 에서 다시 얘기함.) :: 페이지 스코프를 제어할 수 있지만 페이지 스코프를 통해 나머지 스코프도 제어 가능.
		pageContents는 나머지 기본객체에 대한 참조를 갖고있기 때문에,
	
		<%
			application.setAttribute("attr1", "공유데이터");
			
// 			request.setAttribute("attr1", "공유데이터");
			pageContext.setAttribute("attr1", "공유데이터", pageContext.APPLICATION_SCOPE);
		%>
	4. 에러 데이터 확보(에러 처리에서 다시 얘기함.)
		
		
</pre>
</body>
</html>