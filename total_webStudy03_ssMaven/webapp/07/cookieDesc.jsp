<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.util.CookieUtil.textType"%>
<%@page import="kr.or.ddit.util.CookieUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>07/cookieDesc.jsp</title>
</head>
<body>
	<h4>웹 어플리케션에서 상태 유지</h4>
	<pre>
	: HTTP 프로토콜의 stateless(비상태유지/무상태) 특성의 단점을 
	보완하기 위한 개념으로 쿠키와 세션으로 정의할 수 있음.
	
	1. Cookie 
	<%
// 		server쪽
// 		1) 쿠키 생성 
// 		Cookie sampleCookie = new Cookie("sampleCookie",
// 				"sampleCookieValue");
		Cookie sampleCookie = CookieUtil.createCookie("sampleCookie", "sampleCookieValue");
		// 	  2) 쿠키를 클라이언트 쪽으로 전송 (응답(데이터의 일부분으로 전송))
		response.addCookie(sampleCookie);
// 		Cookie koreanCookie = new Cookie("koreanCookie",URLEncoder.encode("한국쿠키", "UTF-8"));
		Cookie koreanCookie = CookieUtil.createCookie("koreanCookie","한글 쿠키");
		//한글 쿠키는 결국 넘어가는 값은 특문으로 인식되는 한글이기 때문에 인코딩상의 오류가 발생한다.
		//따로 인코딩이 필요하다.
		response.addCookie(koreanCookie);
		
// 		쿠키의 속성들
// 		1) 경로(path) : 브라우저에 저장되있던 쿠키가 
// 			다음 번 요청이 어느경로로 발생할 때 서버로 전송될 지 결정.
// 			명시적으로 설정하지 않으면, 기본값으로 쿠키를 생성할때의 경로가 설정
// 		Cookie allPathCookie = new Cookie("allPath","All~~Path");	//현재 패스는 기본값 07까지
		Cookie allPathCookie = CookieUtil.createCookie("allPath", "All~~Path", request.getContextPath()+"/06", textType.PATH);	//현재 패스는 기본값 07까지
// 		allPathCookie.setPath(request.getContextPath()+"/06"); //클라이언트사이드의 절대경로로 path 변경//06까지로 명시적설정.
		response.addCookie(allPathCookie);
// 		2) 호스트설정 (domain) : 브라우저에 저장됐던 쿠키가 *어느 사이트로* 재전송될지 여부를 결정.
// 					기본값으로 쿠키를 생성한 도메인이 설정. 
// 			해당 경로의 호스트로만 쿠키가 전송된다.
// 			호스트를 바꿀 필요가 없을거같지만 도메인의 레벨구조일수 있기때문에... (gtld, ntld) 
// 							→  resourceIdentify.jsp에 도메인레벨구조 설명 참조
// 		www.naver.co.kr
// 		mail.naver.com
// 		blog.naver.com
// 		news.naver.com
// 		cafe.naver.com
// 		www.naver.com		
// 		.naver.com  //이렇게 설정하여 해당 사이트의 모든 단말기에 접속 가능하도록 설정
// 		--	쿠키를 생성할 때의 도메인이 domain 속성으로 설정된 도메인 레벨에	포함되어있어야만 
// 			정상적으로 domain 속성이 설정됨
// #	127.0.0.1       	localhost
// #	::1            	localhost
// 	127.0.0.1       	localhost
// 	::1             	localhost
// 	127.0.0.1       	www.lgj.com
// 	127.0.0.1       	mail.lgj.com
// 	127.0.0.1		blog.lgj.com
// 		Cookie allHostCookie = new Cookie("allHost","All~~Host~~");
		Cookie allHostCookie = CookieUtil.createCookie("allHost","All~~Host~~","localhost",textType.HOST);
// 		allHostCookie.setDomain(".lgj.com"); //도메인레벨구조에 따른 선언
		//생성한 곳은 localhost이지만 호스트는 ↑로 되어있다. 
// 		현재 내가 소속되어있는 도메인 네임을 기준으로 설정한다.// 설정하는걸 연습하려면 가상의 도메인생성, 해당 호스트에서 생성.
		response.addCookie(allHostCookie);
		
// 		3) 만료시간 : 초단위 쿠키의 생존 시간.
// 			0 : 기존 쿠키를 삭제 :: 단 maxAge 를 제외한 나머지 설정이 동일한 경우
// 								(모든 (4가지)attribute가 동일한 경우에만 삭제 가능.)
// 			-1 : 브라우저 종료(세션종료)와 동시에 삭제될 쿠키 ::: **기본값**
// 			 ㄴ명시적으로 주는 경우가 있다 :: 브라우저의 종류에 따라(브라우저가 종료되도 세션이 삭제되지 않는 브라우저같은거)
// 		Cookie longLiveCookie = new Cookie("longLive","Long~~Live~~");
		Cookie longLiveCookie = CookieUtil.createCookie("longLive", "Long~~Live~~", "/", textType.PATH, -1);
		longLiveCookie.setMaxAge(-1); // 만료시간을 설정가능 : int :초단위
		longLiveCookie.setPath("/"); // /는 context제한없이 모두 전송 가능. 쿠키
		response.addCookie(longLiveCookie);
	%>
	
	  
	  ↓여기서부턴 client
	  3) 브라우저가 쿠키를 자기 저장소에 저장.
	  4) 다음번 요청이 발생할 때 다시 서버쪽으로 쿠키 전송. : request header : cookie
	  
	  <a href="viewCookie.jsp">동일경로에서 쿠키 확인하기</a>
	  <a href="<%=request.getContextPath() %>/06/viewCookie.jsp">다른경로에서 쿠키 확인하기_06</a>
	  <a href="<%=request.getContextPath() %>/05/viewCookie.jsp">다른경로에서 쿠키 확인하기_05</a>
	  
	  복원된 쿠키정보:
	  ↓server
	  <%--
		// 	  5) 요청을 통해 전송된 쿠키를 서버상에서 확보한 이후 상태를 복원. : request
		Cookie[] cookies = request.getCookies();
		if (cookies != null) { //검증
			for (Cookie tmp : cookies) {
				if ("koreanCookie".equals(tmp.getName())
						|| "sampleCookie".equals(tmp.getName())) { //equals할때 (비교대상이 앞에오게)이렇게 짜는 습관 들이기 nullpoint 예방가능

					out.println(URLDecoder.decode(tmp.getValue(),"UTF-8"));
				}
			}
		}
	--%>
</pre>
</body>
</html>