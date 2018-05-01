<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<ul>
	<li><a href="<c:url value='/member/memberList.do'/>">회원관리</a></li>
	<li><a href="<c:url value='/prod/prodList.do'/>">상품관리</a></li>
	<li><a href="<c:url value='/buyer/buyerList.do'/>">거래처관리</a></li>
	<li>방명록</li>
	<li><a href="<c:url value='/board/boardList.do'/>">자유게시판</a></li>
</ul>
