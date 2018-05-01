<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/factorial.jsp</title>
</head>
<body>
<!-- 10! 연산결과를 출력하시오. -->
<!-- 재귀함수 -->
<%!
private int returnFuntion(int a){
	int result = 1;
	for(int i = 1; i<=10; i++){
		if(i <= 10){
			result *= i;
		} 
	} 
	return result;
}
%>
<%-- <%int result = returnFuntion(10); %> --%>
<%-- <%=returnFuntion(10)%> --%>

<%!
private long factorial(int num){
	if (num < 0){
		throw new IllegalArgumentException("음수연산 지원ㄴㄴ");
	}
	if(num == 0 || num == 1){
		return num;
	}else{
		return num * factorial(-- num);
	}
}
%>
<%
	String opStr = request.getParameter("op");
	long result = 1;
	if(opStr != null && opStr.matches("[0-9]{1,2}")){
		int op = Integer.parseInt(opStr);
		for(int i = 1; i <=op; i++){
			result *= i;
		}
	}else{
		result = -1;				
	}
%>

<!-- action, href 등과 같이 링크로 동작하는 속성의 값이 생략된 경우, -->
<!-- 기본값으로 현재 브라우저의 주소입력창의 주소값이 사용된다. -->
<form action =<%=request.getContextPath() %>/02/factorial.jsp">
	팩토리얼 피연산자 <input type="number" name="op" required="required"/>
	<input type="submit" value="연산결과!" />
</form>
<%
	if(result >= 0){
		%>
		<%=opStr %>! = <%= result %>, 
		factorial(10) = <%=factorial(10) %>
		<%
	}else{
		%>
		잘못된 파라미터로 연산 수행 실패.
		<%		
	}
%>

<%
int rslt = 1;
for(int a = 1; a<=10; a++){
%> 
<% rslt *= a; %> 
<%
}
%>
<%-- <%=result%> --%>

</body>
</html>