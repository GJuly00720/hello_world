<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content=charset=UTF-8"/>
<title>01/calculateForm.html</title>
</head>
<body>
	<!-- 사용자로부터 두개의 피연산자를 입력받아 더하기 연산을 수행  -->
	<form action="<%=request.getContextPath() %>/calculator" method="get">
		<pre>
		연산요청자 : <input type="text" name="client" />
		좌항피연산자 : <input type="number" name="op1" />
		<input type = "radio" name="operator" value="puls"/>+
		<input type = "radio" name="operator" value="minus"/>-
		<input type = "radio" name="operator" value="multiply"/>*
		<input type = "radio" name="operator" value="divide"/>/
		우항피연산자 : <input type="number" name="op2" /> 
		<button type="submit" >연산결과</button>
		</pre>
	</form>
	<div style="background-color:yellow">
		연산결과: <%= session.getAttribute("contents") %>
	</div>
</body>
</html>