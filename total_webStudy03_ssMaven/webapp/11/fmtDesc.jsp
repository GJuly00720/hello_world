<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.TimeZone"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="www.ddit.or.kr/myfn" prefix="myfn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>11/fmtDesc.jsp</title>
</head>
<body>
<h4> 국제화(fmt, format 태그) </h4>
<pre>
	: i18n(국제화, internationalization)과 l10n(지역화, localization) 을 지원하는 커스텀 태그 라이브러리.
	
	1. 국제화 서비스를 제공하기 위한 메세지 처리.
	   setLocale, message, bundle
	   
		1) 지원할 언어 선택 
		2) 메세지 번들 작성 (지원할 언어를 모두 넣어논 것.)// propertiesBundle //한,영
				kr/or/ddit/msg/message_ko.properties
				kr/or/ddit/msg/message_en.properties
				basename -> kr.or.ddit.msg.message // 현재시스템의 기본 로케일을 따라 선택됨. 
				ko_KR 언어에대한정보_지역에대한정보.
		3) 메세지 번들을 로딩. //resourceBundle..etc 사용.
		<fmt:setLocale value="ko_KR" /> 현재 locale의 정보를 직접 설정한다.
		<%
			ResourceBundle.getBundle("kr.or.ddit.msg.message", Locale.KOREA);
		%>
		<fmt:bundle basename="kr.or.ddit.msg.message">
		4) 메세지키(메세지코드)를 통해 메세지를 사용.
			<fmt:message key="hi"></fmt:message>
		</fmt:bundle>
		
	2. 지역화 서비스를 제공하기 위한 포맷팅과 파싱 태그를 지원.
		parseNumber , parseDate 
		formatNumber , formatDate	문자열로
		<fmt:formatNumber value="100000" type="currency" var="numText"/> 포맷작업을 할때 l10n의 기능이 세밀하게 작업해준다.
		${numText }
		<fmt:parseNumber value="${numText }" type="currency" var="number" parseLocale="ko_KR"/> 위의 것을 파싱해서 number로 잡음 parseLocale=(파싱과정에서)더 명확하게 잡아줌.
		${number * 3 }
		
		<fmt:setLocale value="en" />
						현재시간을 주기위함으로		시간과 날짜 둘다보겠다.
		<fmt:formatDate value="<%=new Date() %>" type="both" 
			dateStyle="long" timeStyle="long" var="dateText"/>
		${dateText } 
		
		<fmt:parseDate value="${dateText }" type="both"  
			dateStyle="long" timeStyle="long" var="dateObj" parseLocale="ko_KR"
		/> 
		${dateObj.time }  -getTime호출(밀리세컨드) 
		
			둘이 반대되는 일을 함.
		parse :: 문자열을 일정한 형식에 따라 특정 타입의 데이터로 변환하는 작업
		format :: 특정 타입의 데이터를 일정한 형식의 문자열로 변환하는 작업.
	
	3. 기타 : timeZone...
	
<%-- 	<fmt:timeZone value="<%=zone %>"> --%>
<%-- 		<fmt:setLocale value="ko" /> --%>
<%-- 		<%=zone.getDisplayName() %><fmt:formatDate value="<%=new Date() %>" type="both" /> --%>
<%-- 	</fmt:timeZone> --%>
	
</pre>
	timeZone : 시간을 설정
	locale : 시간을 보여주는 언어를 설정
<%
	String localeParam = request.getParameter("locale");
	String selZoneId = request.getParameter("timeZone");
	Locale currentLocale = request.getLocale();
	if(StringUtils.isNotBlank(localeParam)){
		currentLocale = Locale.forLanguageTag(localeParam);
	}
	
	TimeZone currentTimeZone = TimeZone.getDefault(); //현재타임존의 기본
	pageContext.setAttribute("currentLocale", currentLocale);
	if(StringUtils.isNotBlank(selZoneId)){
		currentTimeZone = TimeZone.getTimeZone(selZoneId); //현재시간대결정
	}
	Date today = new Date();
	Locale[] locales = Locale.getAvailableLocales(); //로케일에 대한정보 배열
// 	pageContext.setAttribute("locales", locales); // EL로 하려고..
	
	String[] zoneIds = TimeZone.getAvailableIDs();
// 	pageContext.setAttribute("zoneIds", zoneIds);
	TimeZone zone = TimeZone.getTimeZone(zoneIds[7]);
%>
<form>
	<select name="locale" onchange="document.forms[0].submit();">
		<c:forEach items="${myfn:getLocales() }" var="tmp" >
			<option value="${tmp.toLanguageTag() }"
				${tmp eq currentLocale ? "selected":"" }
			>${tmp.displayLanguage }</option>
		</c:forEach>
	</select>
	<select name="timeZone" onchange="document.forms[0].submit();">
		<c:forEach items="${myfn:getTimezoneIds() }" var="zoneId">
			<%
				String tmpTimeZone = (String)pageContext.getAttribute("zoneId");
			%>
			<option value="${zoneId }" 
				${zoneId eq param.timeZone ? "selected":"" }
			>${myfn:getTimeZone(zoneId).displayName }</option>
		</c:forEach>	
	</select>
</form>
<div>
	현재 선택한 언어: ${currentLocale.displayLanguage } <br/>
	현재 선택한 시간대: <%=currentTimeZone.getDisplayName() %>
	현재 시각:
	<fmt:setLocale value="${currentLocale }" />
	<fmt:formatDate value="<%=today %>" timeZone="<%=currentTimeZone %>"
		type="both" dateStyle="long" timeStyle="long"
	/>
</div>

</body>
</html>