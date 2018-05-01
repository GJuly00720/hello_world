<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>11/iterate.jsp</title>
<style>
	.yellow{
		background-color: yellow;
	}
	.green{
		background-color: green;
	}
	.blue{
		background-color: blue;
	}
</style>
</head>
<body>
<h4> JSTL 반복문 </h4>
<pre>
	1. 일반 반복문 ( for(초기화절; 조건절; 증감절 ){ 반복될 구문 } )
		&lt;c:forEach var="속성명" begin="초기값" 
					end="종료값(여기까지.)" step="증가치" varStatus="LoofTagStatus 객체에 대한 참조 속성명"&gt;
			반복될 구문
		&lt;/c:forEach&gt;
		** LoopTagStatus 객체 : 현재 반복에 대한 모든 상태 정보를 가진 객체.
			: index(반복문내에서 사용되는 인덱스값(step에 따라 변화)) , begin, end, step, count(반복횟수) - 숫자 
			  first, last - boolean
		
		<c:forEach var="num" begin="1" end="10" step="2" varStatus="vs">
			first : ${vs.first }, last : ${vs.last }, index : ${vs.index },	count : ${vs.count }, num : ${num }		
		</c:forEach>
		
	2. 향상된 반복문 ( for( 요소에 접근할 임시 블럭 변수 : 반복대상집합객체(컬렉션) ){ 반복될 구문 )
		<%
			List<String> sampleList = Arrays.asList("listValue1","listValue2","listValue3");
			pageContext.setAttribute("sampleList", sampleList);
		%>
		&lt;c:forEach items="반복대상객체(컬렉션)" var="임시블럭속성" varStatus="LoopTagStatus" &gt;
			반복구문
		&lt;/c:forEach&gt;
		
		<c:forEach items="${sampleList }" var="element" varStatus="listVs">
			${element }${listVs.last?"":"," }
			<!-- <c:if test="${not listVs.last }">,</c:if> -->
			
		</c:forEach>
		
	3. 토큰의 집합에 대해 일정한 반복을 수행하는 경우
		token : 문장의 구성요소중 의미를 지니는 최소 단위.
		
		<c:forTokens items="아버지가|방에|들어가신다." delims="|" var="token">
			${token }
		</c:forTokens>	StringTokenizer... split.... 동작구조 같음. 반복될 아이템을 구분자로 나눔. var =  해당 반복에 접근
		<c:forTokens items="2000,3000,1000,45000" delims="," var="number">
			${number * 2 }
		</c:forTokens> 

</pre>

<!-- 2단부터 9단까지의 구구단, 승수를 1~9까지. -->
<!-- table태그를 사용하여 출력. 각 단을 한 행에 출력 -->
<!-- 세번째 행tr의 배경색을 노란색 -->
<!-- 맨마지막 행tr의 배경색 초록 -->
<!-- 다섯번째 열td의 배경색 파란색 -->
<%-- 	<c:set var="x" value="*"/> --%>
<table border ="1">
	<c:forEach var="dan" begin="2" end="9" step="2" varStatus="danVs">
		<c:choose>
			<c:when test="${danVs.count eq 3}">
				<c:set var="trClass" value="yellow"/>		
			</c:when>
			<c:when test="${danVs.last }">
				<c:set var="trClass" value="green"/>
			</c:when>
			<c:otherwise>
				<c:set var="trClass" value="normal"/>
			</c:otherwise>
		</c:choose>
		<tr class="${trClass }">
			<c:forEach var="mul" begin="1" end="9" step="1" varStatus="mulVs">
				<c:if test="${mulVs.count eq 5 }">
					<c:set var="tdClass" value="blue"></c:set>
				</c:if>
				<c:if test="${mulVs.count ne 5 }">
					<c:set var="tdClass" value="normal"></c:set>
				</c:if>
				<td class="${tdClass}">
				${ dan }*${ mul }=${ dan*mul }</td>
			</c:forEach>
		</tr>
	</c:forEach>
</table>
</body>
</html>