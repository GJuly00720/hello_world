<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String[] fileList = (String[]) request.getAttribute("fileList");
//싱글 리스폰시블 프린시펄
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/semImageForm.jsp</title>
<SCRIPT type="text/javascript">
	function changeHandler(){
// 		var form = document.getElementById("myForm");
// 		var form = document.forms[0]; 같은 동작을하는 코드들이다. 방법만 다를뿐
		var form = document.myFormName;
		if(form.selImage.value){
			form.submit();
// 			var imageArea = document.getElementById("imageArea");
<%-- 			var pattern ='<img src="<%=request.getContextPath() %>/image/getImage.do?selImage=%P"/>'; --%>
// 			var imageName = form.selImage.value; 
// 			imageArea.innerHTML = pattern.replace("%P", imageName);
		}else{
			
		}
	}
</SCRIPT>
</head>
<body>
<!-- 1. d:\contents 폴더 아래의 이미지 목록을 사용자에게 제공. (동적작성) -->
<!-- (표현식과 스크립틀릿 기호 사용) -->
<!-- 2. 사용자가 이미지를 선택하면, 해당 이미지를 브라우저에 랜더링 (Servlet) -->
<form target="myFrame" id="myForm" name="myFormName" 
	action="<%=request.getContextPath() %>/image/getImage.do" method="post">
<select name="selImage" onchange="changeHandler();">
	<option value>이미지선택</option>
	<%
	for(String name : fileList){
  		%>
		<option><%=name %></option>
		<%
	}
	%>
</select>
</form>
<iframe name="myFrame"></iframe>
<div id="imageArea">

</div>
</body>
</html>