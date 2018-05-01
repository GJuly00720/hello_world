<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<style type='text/css'>
table {
	border-collapse: collapse;
	background-color: green;
}

td, th {
	border: 1px solid black;
}
</style>
<body>
	<%!public String generateData(int minDan, int maxDan) {
		String pattern = "<td>%d*%d=%d</td>";
		StringBuffer gugudan = new StringBuffer();
		for (int dan = minDan; dan <= maxDan; dan++) {
			gugudan.append("<tr>");
			for (int mul = 1; mul <= 9; mul++) {
				gugudan.append(String.format(pattern, dan, mul, (dan * mul)));
			}
			gugudan.append("</tr>");
		}
		return gugudan.toString();
	}%>
	<!-- GugudanSevlet과 동일한 응답데이터를 생성하는 JSP -->
	<!-- 클라이언트의 요청 발생 시간 -->
	<!-- 2~9단까지의 구구단 -->
	<!-- 요청이 완료된 서비스 완료시간 -->
	<%
		//기본객체 request,response
		String param1 = request.getParameter("minDan");
		String param2 = request.getParameter("maxDan");
		// 3. 클라이언트 데이터 검증.
		String result = null;
		if (param1 != null && param1.matches("[2-9]") && param2 != null
				&& param2.matches("[2-9]")) {
			int minDan = Integer.parseInt(param1);
			int maxDan = Integer.parseInt(param2);
			result = generateData(minDan, maxDan);

			Date now = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat(
					" yyyy년 MM월 dd일 HH시 mm분 ");
	%>
	<h4>
		요청시간 :
		<%=formatter.format(now)%></h4>
	<table>
		<%=result%>
	</table>
	<table>
		<%
			String ptrn = "%d * %d = %d";
				for (int dan = 2; dan <= 9; dan++) {
		%>
		<tr>
			<%
				for (int mul = 1; mul <= 9; mul++) {
			%>
			<td><%=String.format(ptrn, dan, mul, (dan * mul))%></td>
			<%
				}
			%>
		</tr>
		<%
			}
		%>
	</table>
	<%
		} else {
			result = "<h4>정상적인 구구단 서비스 불가!</h4>";
	%>
	<%=result%>
	<%
		}
	%>

	서비스 완료 시간 :
	<span id='timeArea'></span>
	<script type='text/javascript'>
		var today = new Date();
		document.getElementById('timeArea').innerHTML = today;
	</script>
</body>
</html>