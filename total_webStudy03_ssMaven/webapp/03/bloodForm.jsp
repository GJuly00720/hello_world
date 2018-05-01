<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<form action="<%=request.getContextPath() %>/getBloodType.do">
<select name="bloodType" onchange="document.forms[0].submit();">
	<option value>혈액형</option>
	<option value="a">A형</option>
	<option value="b">B형</option>
	<option value="ab">AB형</option>
	<option value="o">O형</option>
</select>
</form>
</body>
</html>