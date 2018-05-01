<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>01/first.jsp</title>
</head>
<body>
	<h4>최초의 JSP</h4>
	<h4>요청시간 : <%=Calendar.getInstance() %></h4>
	<div style="background-color: pink;">
		<%=request.getRequestURL() %>
	</div>
</body>
</html>