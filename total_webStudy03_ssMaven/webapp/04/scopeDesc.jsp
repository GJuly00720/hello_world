<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/scopeDesc.jsp</title>
</head>
<body>
<h4> Scope(영역) </h4>
<pre>
	: webApplication에서 상태를 공유하기 위한 메모리 영역.
	Attribute(속성) : Scope 를 통해 공유하고 있는 상태 정보 (이름:값);
	기본객체(속성)가 메모리영역을 사용하기 위해 갖고있는 맵이다.
			:전역으로 상태공유가 어렵기 때문에 각각 의 시간을 나눠 상태를 공유하는것.
	
	** scope를 가진 객체와 그 객체의 생존 범위에 따른 분류
	1. page scope(pageContext) : 하나의 JSP 페이지 내에서만 유효한 영역.
	2. request scope(HttpServletRequest) : 요청에 대한 응답이 전송되기 전까지 유효한 영역 
	3. session scope(HttpSession) : 하나의 세션이 만료되기 전까지 유효한 영역이고,
									각 세션마다 자기 scope를 별도로 운영. 
	4. application scope(SevletContext) : 어플리케이션 종료 전까지 유효한 영역.
	
	<%
	// 속성이 공유할수있는 메모리 정보에 제한이 없다.)
		pageContext.setAttribute("pageAttr", "페이지 속성"); 
		request.setAttribute("requestAttr", "리퀘스트 속성");
		session.setAttribute("sessionAttr", "세션 속성");
		application.setAttribute("applicationAttr", "어플리케이션 속성");
	%>
	<%=pageContext.getAttribute("pageAttr")	%>
	<%=request.getAttribute("requestAttr")	%>
	<%=session.getAttribute("sessionAttr")	%>  쿠키와도 연관이 있다.(캐시삭제하면 이전에 이력이 없어지고 그건 세션 새로고침같은건가...?뭐냐..?)
	<%=application.getAttribute("applicationAttr")	%>
		
		이동하는 방식의 따라 request의 생존범위가 달라짐.
	<%
// 		RequestDispatcher rd = request.getRequestDispatcher("/04/implicitObject.jsp");
// 		rd.include(request, response);
		response.sendRedirect(request.getContextPath()+"/04/implicitObject.jsp");
	%>
	개발자가 공유하고싶은 범위를 조절 가능.
	 -> 가능하면 최소한의 스코프로. (왜냐면 웹의 메모리점유, 공유범위 오류생길)
	 
	 메모리로(휘발성) 저장할지 db에(유지됨) 저장할지
</pre>
</body>
</html>