<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/usercontView.jsp</title>
</head>
<body>
<h4>누적 접속자수 : <%= application.getAttribute("usercount") %></h4>
<a href="<%=request.getContextPath()%>/access">접속자수 늘리기</a>	
</body>
</html>