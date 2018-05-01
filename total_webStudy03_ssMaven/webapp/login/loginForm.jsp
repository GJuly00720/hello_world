<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>login/loginForm.jsp</title>

<c:set var="message" value="${empty message ? param.message : message }"></c:set> <!-- 파람과 scope 뒤짐 --> 
<c:if test="${param.error eq 'true' }">
	<c:set var="message" value="브라우저에 설정오류로 요청처리가 불가합니다." ></c:set>
</c:if>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
<c:if test="${not empty message }">
	alert("${message }");
	<c:remove var="message" scope="session"/>
</c:if>


<%-- 	응답데이터가 나간후 해석되어야(<%=서버사이드에서 어플리케이션 실행될때%>) <- 쿼테이션이 필요한 이유... 뭔데...? --%>
</script>
</head>
<body>
<h4> 로그인 폼 </h4>

<!-- 아이디 기억하기 버튼을 체크 했다면 로그인에 성공했을 때 성공한 아이디를 3일동안 아이디를 기억시켜서 복원 ,(쿠키에 저장해놓고) -->
<!-- 체크하지 않은경우 , 저장되어있는 아이디가 있더라도 삭제. --> 
<!-- 단 체크박스 버튼에 대해서는 체크했다는 상태정보까지 복원. -->
<form action="${pageContext.request.contextPath }/login/loginCheck.do" method="post" >
	아이디 : <INPUT type="text" name="mem_id" value="${cookie.idCookie.value }" /> 
	<input type="checkbox" name="idSave" value="idSave" 
		${not empty cookie.idCookie ? "checked":"" }
	/>아이디 기억하기
	비밀번호 : <INPUT type="text" name="mem_pass"/> 
	<INPUT id='bnt' type="submit" value="로그인"/>
</form>
</body>
</html>