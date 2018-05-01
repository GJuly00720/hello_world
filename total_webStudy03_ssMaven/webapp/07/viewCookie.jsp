<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="kr.or.ddit.util.CookieUtil"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>07/viewCookie.jsp</title>
</head>
<body>
	<h4>동일 경로에서 확인</h4>
	<pre>
<%
	String pattern = "쿠키명 : %s, 쿠키값 : %s";
// 	Cookie[] cookies = request.getCookies();// 요청으로부터 넘어오는 쿠키는 배열형이다.
// 	if (cookies != null) { //검증
// 		for (Cookie tmp : cookies) {
// 			out.println(String.format(pattern, tmp.getName(),
// 					URLDecoder.decode(tmp.getValue(), "UTF-8")));
// 		}
// 	}
	CookieUtil cookieUtil = new CookieUtil(request);
	Map<String, Cookie> cookieMap = cookieUtil.getCookieMap();
	for(Entry<String, Cookie> entry:cookieMap.entrySet()){
		String name = entry.getKey();
		String value = cookieUtil.getCookieValue(name);
		out.println(String.format(pattern,name,value));
	}

%>

</pre>
</body>
</html>