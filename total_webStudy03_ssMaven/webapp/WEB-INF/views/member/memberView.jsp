<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>member/memberView.jsp</title>
<script type="text/javascript"
 	src="${cPath }/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
 	<c:if test="${not empty message }">
 		alert("${message }");
 		<c:remove var="message" scope="session" />
 	</c:if>
 	
	$(function(){
		var formBtn= $(".formBtn"); //미리 사용할 아이디와 태그들의 레퍼런스를 지정해놓는게 좋다.
		var cmdBtn= $(".cmdBtn");	//안전과 편리를 위해 // 그러나 동적 생성의 태그는 이방법을 사용하면 안됨
		var inputs = $("input"); //한번만 생성되는 녀석이니까.
		var editable =$("input.editable");
		var removeForm = $("[name='removeForm']");
		formBtn.hide();
		inputs.prop("readonly",true);
		//true or false로 나뉘고 불변할 속성들은 attr보다 prop을 쓰는것이 좋다. 
		$("#updateBtn").on("click", function(){
// 			$("inputs.editable").prop("readonly",false);
			editable.prop("readonly", false);
			cmdBtn.toggle(); //toggle 현재 속성을 반전 시켜줌.(보여지는 버튼이라면 안보이게)
			formBtn.toggle();
		});
		$("#modifyForm").on("reset",function(){
			inputs.prop("readonly",true);
			cmdBtn.toggle();
			formBtn.toggle();
		});
		$("#removeBtn").click(function(){
			var pass = prompt("비밀번호 입력 ㄱㄱ");
			if(pass){
				removeForm.find("[name='mem_pass']").val(pass);
				removeForm.submit();
			}
		});
	});
</script>
</head>
<body>
	<form name="removeForm" action="${cPath }/member/memberDelete.do" method="post">
		<input type="hidden" name="mem_id" value="${member.mem_id }"/>
		<input type="hidden" name="mem_pass" />
	</form>
	<h4>${member.mem_name}
		님의 정보
	</h4>
	<form id="modifyForm" method="post" action="${cPath }/member/memberUpdate.do"> 
	<table>
		<tr>
			<th>회원아이디</th>
			<td><input type="text" name="mem_id"
				value="${member.mem_id}" />
				<span class="error">${errors["mem_id"] }</span>	
			</td>
		</tr>
		<tr>
			<th>비밀번호(${member.mem_pass})</th>
			<td>
				<input type="text" name="mem_pass" value="" class="editable" />
				<span class="error">${errors["mem_pass"] }</span>
			</td>
		</tr>
		<tr>
			<th>회원명</th>
			<td>
				<input type="text" name="mem_name" 
				value="${member.mem_name}" class="editable" />
				<span class="error">${errors["mem_name"] }</span>	
			</td>
		</tr>
		<tr>
			<th>주민번호1</th>
			<td><input type="text" name="mem_regno1"
				value="${member.mem_regno1}" /></td>
		</tr>
		<tr>
			<th>주민번호2</th>
			<td><input type="text" name="mem_regno2"
				value="${member.mem_regno2}" /></td>
		</tr>
		<tr>
			<th>생일</th>
			<td><input type="text" name="mem_bir"
				value="${member.mem_bir}" /></td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td>
				<input type="text" name="mem_zip"
				value="${member.mem_zip}" class="editable" />
				<span class="error">${errors["mem_zip"] }</span></td>
		</tr>
		<tr>
			<th>주소1</th>
			<td><input type="text" name="mem_add1"
				value="${member.mem_add1}" class="editable" />
				<span class="error">${errors["mem_add1"] }</span></td>
		</tr>
		<tr>
			<th>주소2</th>
			<td><input type="text" name="mem_add2"
				value="${member.mem_add2}" class="editable" />
				<span class="error">${errors["mem_add2"] }</span></td>
		</tr>
		<tr>
			<th>집전화</th>
			<td><input type="text" name="mem_hometel"
				value="${member.mem_hometel}" class="editable" />
				<span class="error">${errors["mem_hometel"] }</span></td>
		</tr>
		<tr>
			<th>회사전화</th>
			<td><input type="text" name="mem_comtel"
				value="${member.mem_comtel}" class="editable" />
				<span class="error">${errors["mem_comtel"] }</span></td>
		</tr>
		<tr>
			<th>휴대전화</th>
			<td><input type="text" name="mem_hp"
				value="${member.mem_hp}" class="editable" />
				<span class="error">${errors["mem_hp"] }</span></td>
		</tr>
		<tr>
			<th>메일</th>
			<td><input type="text" name="mem_mail"
				value="${member.mem_mail}" class="editable" />
				<span class="error">${errors["mem_mail"] }</span></td>
		</tr>
		<tr>
			<th>직업</th>
			<td><input type="text" name="mem_job"
				value="${member.mem_job}" class="editable" />
				<span class="error">${errors["mem_job"] }</span></td>
		</tr>
		<tr>
			<th>취미</th>
			<td><input type="text" name="mem_like"
				value="${member.mem_like}" class="editable" />
				<span class="error">${errors["mem_like"] }</span></td>
		</tr>
		<tr>
			<th>기념일</th>
			<td><input type="text" name="mem_memorial"
				value="${member.mem_memorial}" class="editable" />
				<span class="error">${errors["mem_memorial"] }</span></td>
		</tr>
		<tr>
			<th>기념일</th>
			<td><input type="text" name="mem_memorialday"
				value="${member.mem_memorialday}" class="editable" />
				<span class="error">${errors["mem_memorialday"] }</span></td>
		</tr>
		<tr>
			<th>마일리지</th>
			<td>${member.mem_mileage}</td>
		</tr>
		<tr>
			<th>탈퇴여부</th>
			<td>${member.mem_delete}</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="수정" id="updateBtn" class="cmdBtn" />
				<input type="button" value="탈퇴" id="removeBtn" class="cmdBtn" />
				<input type="submit" value="저장" class="formBtn"/>
				<input type="reset" value="취소" class="formBtn"/>
				<input type="button" value="목록으로" onclick="location.href='memberList.do'" />
			</td>
		</tr>
		<tr>
			<th>구매목록</th>
			<td>
				<table>
					<thead>
						<tr>
							<th>상품코드</th>
							<th>상품이름</th>
							<th>상품구매가</th>
							<th>상품판매가</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="prodList" value="${member.prodList }"/>
							<c:choose>
								<c:when test="${not empty prodList }">
									<c:forEach items="${prodList }" var="prod">
										<tr>
											<td>${prod.prod_id }</td>
											<td>${prod.prod_name }</td>
											<td>${prod.prod_cost }</td>
											<td>${prod.prod_sale }</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="2">구매이력없음</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>