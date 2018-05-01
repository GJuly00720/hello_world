<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>06/includeDesc.jsp</title>
</head>
<body>
<h4> include(내포)의 종류 </h4>
<pre>
	내포 시점과 내포 대상에 따른 분류
	
	정적내포 : JSP 에 대한 서블릿 소스가 파싱될 때(실행되기 전)에 소스자체가 들어온다, 대상은 소스.
		:: 중복코드 제거, 변수 공유가능 
		변수 공유가능 but, 예외나 입셉션이 발생한다면 밑에 두가지를 볼 줄 알아야 한다.
		1) include 지시자 사용.
<%-- 	<%@ include file="/02/requestDesc.jsp" %>  --%>
		2) web.xml 에서 웹 어플리케이션 자체를 대상으로 한 내포.
		
		
	동적내포 : Runtime(실행시점(후)에서 내포), 실행 결과물
		ex) pageContext.include, jsp:include, ResquestDispatcher.include.
</pre>
<%-- <jsp:include page="/02/requestDesc.jsp" /> --%>
<%-- <%= today.toString() %>  --%>
<!-- 정적내포에서 include되고 있는 상태에서 today를 가져오면 소스 그자체를 가져오니까 공유 가능하다  
	<-긍정적인 방법 아님.:: 여러개를 include 되있다면  
동적내포에선    -->
</body>
</html>