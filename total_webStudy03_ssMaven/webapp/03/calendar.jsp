<?xml version="1.0" encoding="UTF-8"?>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");


    String y=request.getParameter("year");
    String m=request.getParameter("month");

  
    Calendar cal = Calendar.getInstance();
    int year = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH)+1; 

    if(y!=null)
    year = Integer.parseInt(y);
    if(m!=null)
    month = Integer.parseInt(m);

    cal.set(year, month-1, 1);
    year = cal.get(Calendar.YEAR);
    month = cal.get(Calendar.MONTH)+1;

    
    int startDay = cal.get(Calendar.DAY_OF_WEEK);
    int endDay = cal.getActualMaximum(Calendar.DATE);
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


    <table border="1">
        <caption >
        <a href="calendar.jsp?year=<%=year%>&month=<%=month-1%>">이전달</a>
        <%=year%>년 <%=month%>월
        <a href="calendar.jsp?year=<%=year%>&month=<%=month+1%>">다음달</a>
        </caption>
        <tr>
            <td>일</td>
            <td>월</td>
            <td>화</td>
            <td>수</td>
            <td>목</td>
            <td>금</td>
            <td>토</td>
        </tr>
		<%=startDay %>
        <%
            int line = 0;
            
            out.print("<tr>");
            for(int i=1; i<startDay; i++) {
                out.print("<td> </td>");
                line+=1;
            }

            
            String fc;
            for(int i=1; i<=endDay; i++) {
                fc = line == 0 ? "red" : (line == 6 ? "blue" : "black");
                out.print("<td>");
                out.print(i);
                out.print("</td>");
                line+=1;
                if(line==7 && i!=endDay) {
                    out.print("</tr><tr>" );
                    line = 0;
                }
            }

           
            while(line>0 && line<7) {
                out.print("<td> </td>");
                line++;
            }
            out.print("</tr>");
      %>
    </table>

</body>
</html>