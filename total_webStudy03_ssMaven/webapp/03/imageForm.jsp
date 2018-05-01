<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="javax.swing.text.AbstractDocument.Content"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/imageForm.jsp</title>
</head>
<body>
<!-- 1. d:\contents 폴더 아래의 이미지 목록을 사용자에게 제공. (동적작성) -->
<!-- (표현식과 스크립틀릿 기호 사용) -->
<!-- 2. 사용자가 이미지를 선택하면, 해당 이미지를 브라우저에 랜더링 (Servlet) -->
<form action="http://localhost/webStudy01/image/getImage.do" method="Post">
이미지를 선택하시오
<select name="chooseImage" >
	<option>Chrysanthemum.jpg</option>
	<option>Desert.jpg</option>
	<option>Hydrangeas.jpg</option>
	<option>Jellyfish.jpg</option>
	<option>Koala.jpg</option>
	<option>Lighthouse.jpg</option>
	<option>Penguins.jpg</option>
	<option>Tulips.jpg</option>
</select>
<input type="submit" value="사진"/>
</form>
</body>
</html>