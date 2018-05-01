<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>05/viewCookie.jsp</title>
</head>
<body>
	<h4>다른 경로에서 확인</h4>
	<pre>
<%
	String pattern = "쿠키명 : %s, 쿠키값 : %s";
	Cookie[] cookies = request.getCookies();
	if (cookies != null) { //검증
		for (Cookie tmp : cookies) {
			out.println(String.format(pattern, tmp.getName(),
					URLDecoder.decode(tmp.getValue(), "UTF-8")));
		}
	}
%>

</pre>
</body>
</html>