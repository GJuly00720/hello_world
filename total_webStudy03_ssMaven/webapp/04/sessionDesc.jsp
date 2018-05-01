<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/sessionDesc.jsp</title>
</head>
<body>
<h4>session (HttpSession)</h4>
<pre>
	한 세션 : 사용자가 어플리케이션을 사용하기 시작하는 순간부터 사용 종료할때까지의 기간(의 정보).
	(= 한 session = session들에 대한 정보를 갖고 있는 객체가 HttpSession)
	
	세션의 생명주기(태어나서 죽을때까지를 "한 세션")
	세션의 대상 : 한 사람의 사용자와 하나의 브라우져를 대상으로 해서 생성
		ex) 네이버를 크롬으로 로그인한 상태에서 익스로 또 네이버에 들어가면 로그인을 다시 해야함(세션이 두개!) 
		
	세션 시작 : 사용자로부터 최초의 요청이 발생하면. 
		ex) 네이버에 로그인 할때가 아니라 네이버의 인덱스페이지를 달라는 요청을 보냈을때부터 세션 시작
		
	세션의 유지 원리 (id, time) : 
		각각의 유저와 브라우저에 (새로운 요청에도 변하지 않는)**식별자**를 부여 
	<%=session.getId() %>	
	<%=new Date(session.getCreationTime()) %>
	<%=session.getMaxInactiveInterval() %> <!-- 마지막요청을 기준으로 정해진 만료시간 (차가 1800초 이내라면 세션 유지)-->
	<%=new Date(session.getLastAccessedTime()) %> <!-- 마지막 요청시간 -->
	** 만료시간 : 일정시간(session timeout) 내에 새로운 요청이 발생하지 않으면,
				세션을 종료시키는 구조. 
		
	세션 종료(가정_직접적으론 알수 없음) : 
		세션의 만료 시간 이내에 새로운 요청이 발생하지 않았다면.
		사용자가 브라우져를 닫았을 때(종료하였을때./닫았다는건 만료시간내에 아무런 요청이 발생할 수 없다.)
			ㄴ반드시 세션이 끊긴다고 장담할 수 없다.
		사용자가 명시적으로 로그아웃을 했을때.(로그아웃이라는 커멘드가 발생할 수 있는 ui를 만들어 줬을때 해당.)  
</pre>
</body>
</html>