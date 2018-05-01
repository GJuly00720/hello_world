<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/cache_control.jsp</title>
</head>
<body>
<h4> 캐시 제어용 헤더</h4>
<pre>
	Pragma(HTTP1.0)/Cache-Controll(HTTP1.1) : 캐시정책설정.(public, private, no-cache, no-store)
	Expires(HTTP) : 캐시 만료 시간 설정(ms 단위로 만료 일자를 설정)
	<%
		response.setHeader("Pragma", "no-cache"); // 1.0
		response.setHeader("Cache-Controll", "no-cache"); // 1.1
		response.addHeader("Cache-Controll", "no-store"); // bug 있는 firefox를
		//add해더를 사용하면 두가지 값을하나의 name에 셋팅할 수 있다.
		response.setDateHeader("Expires", 0);
		//밀리세컨드를 0으로 준다면 과거로 돌아가서 캐시를 남긴다는 소린데 말도 안되니까 어떤경우에도 캐시를 남기지 않겠다
		//그럼 언제나 응답상태코드는 200이다. 새로운 캐시를 사용한다는거니까.
	%>
</pre>

</body>
</html>