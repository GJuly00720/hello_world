<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer="1kb" autoFlush="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/bufferDesc.jsp</title>
</head>
<body>
<h4>웹어플리케이션에서 버퍼의 활용</h4>
<pre>
	buffer : 속도 차이를 보완하기 위해 사용하는 임시 메모리 공간
	JSP 에서 버퍼의 사이즈 : 기본값 8kb -> page 지시자의  buffer 속성으로 변경가능.
	buffer 제어 : out 객체 사용, 응답데이터의 크기와 예와 발생 가능성을 고려해서 제어
	** 버퍼가 잘못 설정된 경우, forward 이동이나 에러처리가 불가능.
	(직접적으로 사용할땐 스트림객체(out)를 사용하여 제어한다. response를 쓰는건...?)
	<%= out.getBufferSize() %>
	<%= out.getRemaining() %>
	<%= out.isAutoFlush() %> <!-- true가 기본값. 자동방출을 지원. 제어는 page지시자 내에서 가능. -->
	<%
		for(int i = 1; i<=9900; i++){
			out.println(i+"번째 출력");
			if(i==9000){ // 버퍼 방출 이후
// 				throw new RuntimeException("강제 예외 발생");
				RequestDispatcher rd = request.getRequestDispatcher("/03/responseDesc.jsp");
				rd.forward(request, response);
			}
		}
	%>
</pre>
</body>
</html>