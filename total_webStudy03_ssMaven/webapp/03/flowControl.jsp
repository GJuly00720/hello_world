<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/flowControl.jsp</title>
</head>
<body>
<h4> 웹 어플리케이션에서의 흐름 제어(페이지 이동) </h4>
<pre>
	** HTTP 
	stateless(비상태유지, 무상태특성) :
		요청에 대한 응답이 1:1 구조로 최종 전송된 이후에는 
		양쪽 pear에 대한 정보가 모두 사라진다.
	connectless(비연결형) : 요청 발생시 C/S 사이에 연결이 수립되고,
							해당 연결은 응답이 전송된 이후에 종료.
	A 페이지에서 B 페이지로의 이동
	1. Request Dispatch(요청 분기)
		A로 요청이 발생한 후, 서버내에서 B로 이동이 발생함.
		A로 발생한 원본 요청을 그대로 B에 전달할 수 있음.
		최종적인 응답은 B페이지에서 전송됨. 
		--> 클라이언트가 모르는 상황에서 이동하는 서버사이드 위임방식		
		<%
// 			1. 분기제어관리자 획득(원본요청으로서 획득할 수 있다)
// 			RequestDispatcher rd = request.getRequestDispatcher("/02/gugudan.jsp");
// 			rd.forward(request, response);
		%>		
	2. Redirect
		A로 요청이 발생한 후,
		A에서 Body가 없는 응답데이터가 전송(Line : 302, Header : location=B),
		B 방향으로 *새로운* 요청이 발생함.
		최종적으로 응답은 B에서 새로운 UI형태로 전송.
	<%
		response.sendRedirect(request.getContextPath()+"/02/gugudan.jsp?"+request.getQueryString());
// 	request.getQueryString()
// 이 코드로 원본에 붙어있던 쿼리를 새로운 요청뒤에 그대로 붙여 넣을수 있다.
	%>

</pre>
</body>
</html>