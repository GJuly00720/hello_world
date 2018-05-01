<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>member/memberForm.jsp</title>
<%
	String message =(String) request.getAttribute("message"); //맹점!!세션이 살아있기때문에 새로고침하면 다시 같은 메세지가 뜬다.
	if(StringUtils.isNotBlank(message)){
// 		플래시 속성 : 데이터를 사용 한 다음 바로 삭제하여 단 한번 사용하는 데이터
		request.removeAttribute("message");
		%>
		<script type="text/javascript">
			alert("<%=message%>");
		</script>
		<%	
	}
%>
</head>
<body>
	<form method="post"><!-- 두개의 주소가 필요 없음. 메소드롤 통해 같은 방향이라는것을 알고 알아서 행동함. --> 
	<!-- action 이없으면!!!!!!!!!!  -->
	
		<table>
			<tr>
				<th>회원아이디</th>
				<td><input type="text" name="mem_id"
					value="${member.mem_id}"  /><span
					class="error">${errors["mem_id"] }</span></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="mem_pass"
					value="${member.mem_pass}" /><span
					class="error">${errors["mem_pass"] }</span></td>
			</tr>
			<tr>
				<th>회원명</th>
				<td><input type="text" name="mem_name"
					value="${member.mem_name}"  /><span
					class="error">${errors["mem_name"] }</span></td>
			</tr>
			<tr>
				<th>주민번호1</th>
				<td><input type="text" name="mem_regno1"
					value="${member.mem_regno1}"  /><span
					class="error">${errors["mem_regno1"] }</span></td>
			</tr>
			<tr>
				<th>주민번호2</th>
				<td><input type="text" name="mem_regno2"
					value="${member.mem_regno2}"  /><span
					class="error">${errors["mem_regno2"] }</span></td>
			</tr>
			<tr>
				<th>생일</th>
				<td><input type="text" name="mem_bir"
					value="${member.mem_bir}" /><span class="error">${errors["mem_bir"] }</span></td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><input type="text" name="mem_zip"
					value="${member.mem_zip}"  /><span
					class="error">${errors["mem_zip"] }</span></td>
			</tr>
			<tr>
				<th>주소1</th>
				<td><input type="text" name="mem_add1"
					value="${member.mem_add1}"  /><span
					class="error">${errors["mem_add1"] }</span></td>
			</tr>
			<tr>
				<th>주소2</th>
				<td><input type="text" name="mem_add2"
					value="${member.mem_add2}"  /><span
					class="error">${errors["mem_add2"] }</span></td>
			</tr>
			<tr>
				<th>집전화</th>
				<td><input type="text" name="mem_hometel"
					value="${member.mem_hometel}"  /><span
					class="error">${errors["mem_hometel"] }</span></td>
			</tr>
			<tr>
				<th>회사전화</th>
				<td><input type="text" name="mem_comtel"
					value="${member.mem_comtel}"  /><span
					class="error">${errors["mem_comtel"] }</span></td>
			</tr>
			<tr>
				<th>휴대전화</th>
				<td><input type="text" name="mem_hp"
					value="${member.mem_hp}" /><span class="error">${errors["mem_hp"] }</span></td>
			</tr>
			<tr>
				<th>메일</th>
				<td><input type="text" name="mem_mail"
					value="${member.mem_mail}"  /><span
					class="error">${errors["mem_mail"] }</span></td>
			</tr>
			<tr>
				<th>직업</th>
				<td><input type="text" name="mem_job"
					value="${member.mem_job}" /><span class="error">${errors["mem_job"] }</span></td>
			</tr>
			<tr>
				<th>취미</th>
				<td><input type="text" name="mem_like"
					value="${member.mem_like}" /><span class="error">${errors["mem_job"] }</span></td>
			</tr>
			<tr>
				<th>기념일</th>
				<td><input type="text" name="mem_memorial"
					value="${member.mem_memorial}" /><span class="error">${errors["mem_memorial"] }</span></td>
			</tr>
			<tr>
				<th>기념일자</th>
				<td><input type="text" name="mem_memorialday"
					value="${member.mem_memorialday}" /><span class="error">${errors["mem_memorialday"] }</span></td>
			</tr>
			<tr>
				<th>마일리지</th>
				<td>1000</td>
			</tr>
		
			<tr>
				<td colspan="2"><input type="submit" value="저장" /> <input
					type="reset" value="취소" /></td>
			</tr>
		</table>
	</form>
</body>
</html>