<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.or.ddit.db.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>08/100con100job.jsp</title>
</head>
<body>

<%
	long startTime = System.currentTimeMillis();
	Connection conn = ConnectionFactory.getConnection();
	for(int i = 0; i <=99; i++){
		Statement stmt = conn.createStatement();
		ResultSet rs= stmt.executeQuery("SELECT MEM_NAME FROM MEMBER WHERE MEM_ID ='a001'");
		if(rs.next()){
			out.println(rs.getString("MEM_NAME"));
		}
		rs.close();
		stmt.close();
	}
	conn.close();
	long endTime = System.currentTimeMillis();
%>
<br/>
<%=endTime-startTime %>ms
</body>
</html>