<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	static enum ServiceType{
		STANDARD("/02/standard.jsp"), GUGUDANFORM("/01/gugudanForm.html"), 
		GUGUDAN("/02/gugudan.jsp"),
		CALCULATEFORM("/01/calculateForm.jsp"), CALENDAR("/05/semCalendar.jsp");	
		
		ServiceType(String url){
			jspPage = url;
		}
		private String jspPage;
		public String getJspPage(){
			return jspPage;
		}
	}
%>    
    
<%
	String content = request.getParameter("content");
	String goPage = null;
	if(StringUtils.isNotBlank(content)){
		try{
			ServiceType serviceType = ServiceType.valueOf(content.toUpperCase());
			goPage = serviceType.getJspPage();
		}catch(IllegalArgumentException e){
			//제공할 수 없는 content
			response.sendError(404, content+"에 해당하는 서비스는 제공하지 않습니다.");
			return;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<style type="text/css">
	#topMenu{
		width: 100%;
		height: 100px;
		background-color: pink;
	}
	#topMenu>ul{/* 직계자식 */
		float: left;
	}
	#topMenu li{/* 후손 */
		float: left;
		list-style : none;
		padding: 20px;
	}
	#leftMenu{
		float: left;
		width: 20%;
		height: 500px;
		background-color: #ffedf4;
	}
	#content{
		float: right;
		width: 79%;
		height: 500px;
	}
	#footer{
		float: left;
		width: 100%;
		height: 50px;
		background-color: violet;
	}
</style>
</head>
<body>
<div id="topMenu">
<%-- 	<iframe src="<%=request.getContextPath() %>/includee/topMenu.jsp"></iframe> --%>
	<%-- 
// 		pageContext.include("/includee/topMenu.jsp");
	--%>
	<jsp:include page="/includee/topMenu.jsp" />
</div>
<div id="leftMenu">
<%-- 	<iframe src="<%=request.getContextPath() %>/includee/leftMenu.jsp"></iframe> --%>
	<%--
		pageContext.include("/includee/leftMenu.jsp");
	--%>
	<jsp:include page="/includee/leftMenu.jsp" />
</div>
<div id="content">
	<%
		if(goPage==null){
 			%>
 			<h4> 웰컴 페이지 (web.xml 에 등록되어 있음)</h4>
			<pre>
			로그인이 되어있다면 해당 상태정보를 보여줄 수 있어야 함.(공유)
			로그인 하지 않은 상태에서 접근했다면, 로그인 페이지로 이동할 링크 제공.
			로그인 상태에서 접근했다면 로그인한 사람의 아이디를 출력.
			<%
			MemberVO authMember =(MemberVO) session.getAttribute("authMember");
			if(authMember == null){ //donot login
				%>
				<a href="<%=request.getContextPath() %>/login/loginForm.jsp">로그인</a>
				<%
			}else{ 
				%>
				<%=authMember.getMem_id() %>님 <a href="<%=request.getContextPath() %>/login/logout.do">로그아웃</a>
				<%
			}
			%>
			</pre>
 		
 		<%
		}else{
			pageContext.include(goPage);
		}
	%>
</div>
<div id="footer">
	<%-- 
// 		pageContext.include("/includee/footer.jsp");
	--%>
	 <jsp:include page="/includee/footer.jsp" />
</div>
</body>
</html>