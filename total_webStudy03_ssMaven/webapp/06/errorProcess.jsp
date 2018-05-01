<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %> 
    <!--  errorPage="/errors/eachError.jsp"-->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>06/errorProcess.jsp</title>
</head>
<body>
<h4> JSP 에서 에러 처리 </h4>
<pre>	
	(에러 페이지 처리 방식.)
	에러를 처리할 대상이 누구인가
	1. 지역적 처리 ; JSP 페이지 하나를 대상으로 한 에러 처리 
			하나의 어플리케이션을 대상으로 할때
		page 지시자의 errorPage 속성.   errorPage 나타내기 , isErrorPage 입셉션 발생해주기
	<%
		if(1==1){
			throw new ArithmeticException("강제 발생 예외");
		}
	%>
	2. 전역적 처리 ; 웹 어플리케이션 자체를 대상으로 한 에러 처리   web.xml 에서 설정
		1) 발생한 예외 타입별 처리(제어페이지)(exception-type)
		2) 발생한 에러 상태 코드별 처리(제어페이지)(error-code)
		
	*******☆★☆★☆★☆★☆★
	** 에러 처리 우선순위 (에러와 가장 가까운 에러 처리코드가 우선권을 갖는다.)
	1. 지역적 처리(JSP 페이지 하나를 대상) ↓
	2. 예외 타입별 처리 ↓
	3. 에러 상태 코드별 처리
	
	
</pre>
</body>
</html>