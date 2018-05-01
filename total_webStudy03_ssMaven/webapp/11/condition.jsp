<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>11/condition.jsp</title>
</head>
<body>
<h4> JSTL 조건문 </h4>
<form>
	당신의 나이는 ? <input type="number" name="age"/>
	<input type="submit" value="연령에 맞는 메세지 출력"/>
</form>
<!-- 입력나이가  -->
<!-- 10대면, 애긔애긔하다. -->
<!-- 20대면, 칭구먹쟈~ -->
<!-- 30대면, 행님아 칭구왔데이~ -->
<!-- 40대면, 건강 조심하세요~ -->
<!-- 그 이상이면, 아버지! 정답을 알려줘!  -->
<c:set var="age" value="${param.age }"/>
<%-- <c:if test="${not empty param.age }"> --%>
<%-- 	<c:if test="${ param.age ge 10 and param.age lt 20 }"> --%>
		
<%-- 	</c:if> --%>
<%-- </c:if> --%>
<c:if test="not empty age">
	<c:if test="${age ge 10 and age lt 20}">
		<c:set var="message" value="10대면, 애긔애긔하다."/>
	</c:if>
	<c:if test="${age ge 20 and age lt 30}">
		<c:set var="message" value="20대면, 칭구먹쟈~"/>
	</c:if>
	<c:if test="${age ge 30 and age lt 40}">
		<c:set var="message" value="30대면, 행님아 칭구왔데이~"/>
	</c:if>
	<c:if test="${age ge 40 and age lt 50}">
		<c:set var="message" value="40대면, 건강 조심하세요~."/>
	</c:if>
	<c:if test="${age ge 50}">
		<c:set var="message" value="아부지"/>
	</c:if>
	<c:if test="${age lt 10}">
		<c:set var="message" value="유아기"/>
	</c:if>
</c:if>
<c:choose>
	<c:when test="${age ge 10 and age lt 20}">
		10대면, 애긔애긔하다.
	</c:when>
	<c:when test="${age ge 20 and age lt 30}">
		20대면, 칭구먹쟈~
	</c:when>
	<c:when test="${age ge 30 and age lt 40}">
		30대면, 행님아 칭구왔데이~
	</c:when>
	<c:otherwise>
		10대 미만이거나 40대 이상.
	</c:otherwise>
</c:choose>
<div>
	${ message }
</div>

<%-- 	<c:set var="age"/> --%>
<%-- 	<c:if test=""> --%>
		
<%-- 	</c:if> --%>

<pre>
	1. 단일 조건문(if/else)
		if(조건식){조건을 만족하는 경우 실행되는 구문}
		&lt;c:if test="조건식" &gt; 조건을 만족하는 경우 실행되는 구문 &lt;/c:if&gt;
		<c:set var="testAttr" value="30"/>
		<c:if test="${ testAttr lt 4 }"> 조건식에는 test라는 속성에 EL문이 넣어져 사용된다.
			참 실행 구문
		</c:if>
		<c:if test="${ testAttr ge 4 }">
			거짓 실행 구문
		</c:if>
		<c:choose>
			<c:when test="${ testAttr lt 4 }">
				참 실행 구문
			</c:when>
			<c:otherwise>
				거짓 실행 구문
			</c:otherwise>
		</c:choose>
<!-- 		param1 이라는 파라미터가 있으면 그 파라미터에 * 30 을 하고, -->
<!-- 		 없으면, "해당 파라미터가 존재하지 않는다."를 출력. -->
		<c:if test="${empty param.param1 }">
			해당 파라미터가 존재하지 않는다.
		</c:if>
		<c:if test="${not empty param.param1 }">
			${param["param1"]*30 }
		</c:if>
		
		<c:choose>
			<c:when test="${empty param.param1 }">
				해당 파라미터가 존재하지 않는다.
			</c:when>
			<c:otherwise>
				${param["param1"]*30 }
			</c:otherwise>
		</c:choose>
		
		
	2. 다중 조건문(switch(조건(정수))/case/default)
		choose/when/otherwise
		&lt;c:choose>
			&lt;c:when test="조건식1">이안에 조건이 들어감. &lt;/c:when>
			&lt;c:when test="조건식2"> &lt;/c:when>
			&lt;c:otherwise> default와 동일기능. &lt;/c:otherwise>
		&lt;/c:choose>

</pre>
</body>
</html>














