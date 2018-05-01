<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.member.service.MemberServiceImpl"%>
<%@page import="kr.or.ddit.member.service.IMemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	IMemberService service = new MemberServiceImpl();
	List<MemberVO> memberList = service.retrieveMemberList(null);
%>  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>member/memberList.jsp</title>
<%
	String message =(String) session.getAttribute("message"); //맹점!!세션이 살아있기때문에 새로고침하면 다시 같은 메세지가 뜬다.
	if(StringUtils.isNotBlank(message)){
// 		플래시 속성 : 데이터를 사용 한 다음 바로 삭제하여 단 한번 사용하는 데이터
		%>
		<script type="text/javascript">
			alert("<%=message%>");
		</script>
		<%	
		session.removeAttribute("message"); //플래쉬어트리뷰드!!!
	}
%>
</head>
<body>
<h4>회원 목록</h4>
<input type="button" value="신규등록"
		onclick="location.href='<%=request.getContextPath() %>/member/memberForm.jsp'">
<table>
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>지역</th>
			<th>연락처</th>
			<th>이메일</th>
			<th>마일리지</th> 
		</tr>
	</thead>
	<tbody>
	<%
		if(memberList.size()>0){
// 			검색조건에 해당하는 리스트 존재
			for(MemberVO member : memberList){
				%>
				<tr>
					<td><%=member.getMem_id() %></td>
					<td><a href="<%=request.getContextPath()%>/member/memberView.jsp?who=<%=member.getMem_id()%>"><%=member.getMem_name() %></a></td>
					<td><%=member.getMem_add1() %></td>
					<td><%=member.getMem_hp() %></td>
					<td><%=member.getMem_mail() %></td>
					<td><%=member.getMem_mileage() %></td>
				</tr>
				<%
			}
		}else{
// 			존재하지 않음
			out.println("<tr><td colspan='6'>검색조건에 해당하는 회원이 없음 </td></tr>");
		}
	%>
	</tbody>
</table>	
</body>
</html>