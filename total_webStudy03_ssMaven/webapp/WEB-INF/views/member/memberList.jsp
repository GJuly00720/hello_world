<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="cPath" value="${pageContext.request.contextPath }" scope="application" /> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>member/memberList.jsp</title>
<script type="text/javascript" src="${cPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	var searchForm = $("#searchForm");
	$("#pagingArea").on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("[name='page']").val(pageNo);
		searchForm.submit();
		return false;
	});
});
</script>
<c:if test="${not empty message }">
	<script type="text/javascript">
				alert("${message}");
	</script>
	<c:remove var="message" scope="session" />
</c:if>
</head>
<body>
<h4>회원 목록</h4>

<input type="button" value="신규등록" onclick="location.href='${cPath}/member/memberInsert.do'"/>
<!-- request.getLocale() -->
<input type="image" src="<c:url value='/images/america.jpg'/>"	onclick="location.href='?lang=en'"/>
<input type="image" src="<c:url value='/images/korea.jpg'/>" onclick="location.href='?lang=ko'"/>

<c:choose>
	<c:when test="${not empty param.lang }">
		<fmt:setLocale value="${param.lang }" />
	</c:when>
	<c:when test="${not empty cookie.langCookie }">
		<fmt:setLocale value="${cookie.langCookie.value }" />
	</c:when>
	<c:otherwise>
		<fmt:setLocale value="${pageContext.request.locale }" />
	</c:otherwise>
</c:choose>


<fmt:bundle basename="kr.or.ddit.msg.message" prefix="member.">
<table>
	<thead>
		<tr>
			<th><fmt:message key="mem_id"/></th>
			<th><fmt:message key="mem_name"/></th>
			<th><fmt:message key="mem_add1"/></th>
			<th><fmt:message key="mem_hp"/></th>
			<th><fmt:message key="mem_mail"/></th>
			<th><fmt:message key="mem_mileage"/></th> 
		</tr>
	</thead>
	<tbody>
	<c:set var="memberList" value="${pagingVO.dataList }"/>
	<c:choose>
		<c:when test="${not empty memberList }">
			<c:forEach items="${memberList }" var="member">
				<tr>
					<td>${member.mem_id}</td>
					<td><a href="${pageContext.request.contextPath}/member/memberView.do?who=${member.mem_id}">${member.mem_name}</a></td>
					<td>${member.mem_add1}</td>
					<td>${member.mem_hp}</td>
					<td>${member.mem_mail}</td>
					<td>${member.mem_mileage}</td>
				</tr>
			</c:forEach>		
		</c:when>
		<c:otherwise>
			<tr><td colspan='6'>검색조건에 해당하는 회원이 없음 </td></tr>
		</c:otherwise>
	</c:choose>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="6">
				<div id="pagingArea">
					${pagingVO.pagingHTML }
				</div>
				<form id="searchForm">
					<input type="hidden" name="page" />
					<input type="hidden" name="searchType" 
						value="${pagingVO.searchType }"
					/>
					<input type="hidden" name="searchWord" 
						value="${param.searchWord }"
					/>
				</form>
				<form>
				<select name="searchType">
					<option value="all">전체</option>
					<option value="name">이름</option>
					<option value="add1">지역</option>
				</select>
				<input type="text" name="searchWord" 
				value="${pagingVO.searchWord }"/>
											<!-- 있으면 그검색어 input에 보여주고 없으면 화이트스페이스 -->
					<input type="submit" value="검색"/>
				</form>
				<script type="text/javascript">//↑애가 만들어지고 형성될것이라 스크립터 여기만듬.
					$("[name='searchType']").val("${empty pagingVO.searchType ? 'all':pagingVO.searchType}")
													//검색 타입이 있다면 그걸 검색 아니면 그냥 전체를 보여줌.
				</script>
			</td>
		</tr>
	</tfoot>
</table>	
</fmt:bundle>
</body>
</html>