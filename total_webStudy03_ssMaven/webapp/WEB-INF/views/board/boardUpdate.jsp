<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>글번호</th>
			<td><input type="text" name="bo_no"
				value="${board.bo_no }" required="required" /><span
				class="error">${board.bo_no}</span></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="bo_title"
				value="${board.bo_title }" required="required" /><span
				class="error">${board.bo_title}</span></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="bo_writer"
				value="${board.bo_writer}" required="required" /><span
				class="error">${board.bo_writer}</span></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="text" name="bo_pass"
				value="${board.bo_pass}" required="required" /><span
				class="error">${board.bo_pass}</span></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="bo_mail"
				value="${board.bo_mail}" /><span class="error">${board.bo_mail}</span></td>
		</tr>
		<tr>
			<th>IP</th>
			<td><input type="text" name="bo_ip"
				value="${board.bo_ip}" required="required" /><span
				class="error">${board.bo_ip}</span></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><input type="text" name="bo_content"
				value="${board.bo_content}" /><span class="error">${board.bo_content}</span></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><input type="text" name="bo_date"
				value="${board.bo_date}" required="required" /><span
				class="error">${board.bo_date}</span></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><input type="text" name="bo_hit"
				value="${board.bo_hit}" /><span class="error">${board.bo_hit}</span></td>
		</tr>
		
	</table>
</body>
</html>