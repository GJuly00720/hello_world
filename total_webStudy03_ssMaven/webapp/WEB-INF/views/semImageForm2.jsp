<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String[] fileList = (String[]) request.getAttribute("fileList");
	String[] imageNames = (String[])request.getAttribute("imageNames");
//SRP = 싱글 리스폰서블리티 퍼블리티? 책임분기
%>
    <%
//          response.setHeader("Pragma", "no-cache"); //1.0
//          response.setHeader("Cache-Control", "no-cache"); //1.1
//          response.addHeader("Cache-Control", "no-store"); //파폭 30번대 버전 이용자 -bug있어서..
//          response.setDateHeader("Expires", 0);//어떤경우에도 캐시를 남기지 않겠다.
      %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/semImageForm2.jsp</title>
<SCRIPT type="text/javascript">
	function changeHandler(){
// 		var form = document.getElementById("myForm"); form가져오는방법3가지
// 		var form = document.forms[0]; 같은 동작을하는 코드들이다. 방법만 다를뿐
		var form = document.myFormName;
		if(form.selImage.value){
			form.submit();
			var imageArea = document.getElementById("imageArea");
			imageArea.innerHTML="";
<%-- 			var pattern ='<img src="<%=request.getContextPath() %>/image/getImage.do?selImage=%P"/>'; --%>
// 			var imageName = form.selImage.value; 
// 			imageArea.innerHTML = pattern.replace("%P", imageName);
// 			if(imageName=="이미지 선택"){
// 				 imageArea.innerHTML="이미지를 선택하세요.";
// 			}
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
	action="<%=request.getContextPath() %>/image2/getImage.do" method="get">
<select name="selImage" onchange="changeHandler();" size="15" multiple = "multiple">
	<option>이미지선택</option>
	<%
	for(String name : fileList){
  		%>
		<option><%= imageNames!=null && Arrays.binarySearch(imageNames, name)>=0 ?"selected":"" %><%=name %></option>
		<%						
	}
// 	String iFrameSrc = null;
// 	if(imageNames!=null){
// 		iFrameSrc = request.getContextPath()+"/image2/getImage.do?selImage="+imageNames;
// 	}
	%>
</select>
</form>
<iframe name="myFrame" <%-- <%=iFrameSrc!=null?"src='"+iFrameSrc+"'":""%> --%>></iframe>
<div id="imageArea">
	<%
		if(imageNames!=null){
			String pattern = 
					"<img src='"+request.getContextPath()+"/image2/getImage.do?selImage=%s'/>";
					
				for(String imageName : imageNames){
					out.println(
						String.format(pattern,imageName)
						);
				}			
						
		}
	%>
</div>
</body>
</html>