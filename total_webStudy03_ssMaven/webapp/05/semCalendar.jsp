<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@page import="static java.util.Calendar.*"%>
<!-- static Import구문 ↑얘가 갖고있는걸 아예 먼저갖고온다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/semCalendar.jsp</title>
</head>
<body>
<%
String yearStr = request.getParameter("year");
String monthStr = request.getParameter("month");
String localeStr = request.getParameter("lang");

Calendar cal = getInstance(); //Calendar는 생성자묶여있어서 외부에서 못부름 그래서 겟인스턴스해서 부름. //현재 달력
if(StringUtils.isNumeric(yearStr)
		&&StringUtils.isNumeric(monthStr)){ //isNumeric 숫자가 있는지 확인해줌
	cal.set(YEAR, Integer.parseInt(yearStr));
	cal.set(MONTH, Integer.parseInt(monthStr));
}


//현재시간
int year = cal.get(YEAR); //현재달력의 년도
int month = cal.get(MONTH); //현재 월
int currDay =cal.get(DAY_OF_MONTH);

// 전달 구하기
cal.add(MONTH, -1); //이니까 amount로 -1을 줌 
int beforeYear = cal.get(YEAR); 
int beforeMonth = cal.get(MONTH); 

// 다음달 구하기
cal.add(MONTH, 2); //0상태가 지금 달이니까  위에서 -1되었으니까 1로 만들려면 2가 맞다.
int nextYear = cal.get(YEAR);
int nextMonth = cal.get(MONTH);

cal.add(MONTH, -1); //현재로 되돌림

String titlePtrn = "%d년 %d월";
cal.set(DAY_OF_MONTH, 1);
int firstDate = cal.get(DAY_OF_WEEK);
int offset = firstDate-1;
//	↑첫 날앞의 공백들  ↑첫날의 시작이 몇번째인지 출력해줌

int lastDay = cal.getActualMaximum(DAY_OF_MONTH);

//lang파라미터에 대해 얘가 변한다.
Locale locale = request.getLocale(); //요청헤더안에 있는 현재 클라이언트의 로케일(현재 접속한 클라이언트의 위치 정보) 받아옴
if(StringUtils.isNoneBlank(localeStr)){
	locale = Locale.forLanguageTag(localeStr);
}
DateFormatSymbols dfs = new DateFormatSymbols(locale); //받아온 locale을 넘겨서 format을 맞춰줌..?
String[] weekDays = dfs.getShortWeekdays();
//0번방은 공백. 일요일부터 1로 시작한다는것을  weekDays.length <- 이걸 출력해서 알 수 있음
String pattern = "<td>%s</td>";

%>
<script type="text/javascript">
	function handler(year, month) {
		var form = document.forms[0];
		form.year.value = year;
		form.month.value = month;
		form.submit();
	}//전달 클릭시 폼이 전송되게 할것 
</script>

<!-- 								가져가는 파라미터 -->
<a href="javascript:handler(<%=beforeYear%>,<%=beforeMonth%>);">전달&lt;&lt;</a>
<!-- href에 "?" = #같은 동작을 하게되는데 다른점은 뒤에 QueryString을 붙일 수 있게끔 셋팅하는것-->
<h4><%=String.format(titlePtrn, year, month+1)  %></h4>
<a href="javascript:handler(<%=nextYear%>,<%=nextMonth%>);">&gt;&gt;다음달</a> 
<%-- "<%= request.getContextPath()%>/05/semCalendar.jsp?year=<%=nextYear%>&month=<%=nextMonth%>" --%>



<!-- 요일, 요일별 열 6, 행 7 -->

<form>
	<input type="hidden" name="dummy" value="calendar"/>
	<INPUT type="number" name="year" value="<%=year %>" />년
	<SELECT name="month" onchange="document.forms[0].submit();">
	<%
		String[] months = dfs.getShortMonths();
		String optPtrn ="<option value='%s'%s>%s</option>";
		for(int i =0; i <months.length-1; i++){
			String selected = "";
			if(i==month){
				selected = "selected";
			}
			out.println(
				String.format(optPtrn, i, selected, months[i])
			);
		}
	%>
	</SELECT>
	<select name="lang" onchange="document.forms[0].submit();">
	<%
		Locale[] locales = Locale.getAvailableLocales();
		for(Locale tmp : locales){
			String selected = "";
			if(tmp.equals(locale)){
				selected = "selected";
			}
			out.println(
					String.format(optPtrn, tmp.toLanguageTag(), selected, tmp.getDisplayLanguage()) 
											//"나라-언어" 나라					//언어를 풀네임으로 보여주는 메소드  
			);
		}
	%>		
	</select>
</form>

<table>
<thead>
	<tr>
		<%
		for(int i =1 ; i <= weekDays.length-1; i++){
			out.println(String.format(pattern, weekDays[i]));
		}
		%>
	</tr>
</thead>
<TBODY>
<%
	//이번달 1일로 세팅
	int cnt = 1;
	for(int row = 1; row<=6; row++){
		out.println("<tr>");
		for(int col = 1; col<=7; col++){
			String dateStr = "&nbsp";//공백문자
			int temp = cnt ++ -offset;
			if(temp > 0 && temp <= lastDay){
				dateStr = temp+"";
			}
			out.println(String.format(pattern, dateStr));
		}
		out.println("</tr>");
	}
%>
</TBODY>
</table>
</body>
</html>