<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="kr.or.ddit.buyer.service.BuyerServiceImpl"%>
<%@page import="kr.or.ddit.buyer.service.IBuyerService"%>
<%@page import="kr.or.ddit.vo.BuyerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<c:set var="cPath" value="${pageContext.request.contextPath }"/> 
<%
	request.setCharacterEncoding("UTF-8");
	BuyerVO buyer = (BuyerVO) request.getAttribute("buyer");
%>
<jsp:useBean id="errors" class="java.util.LinkedHashMap" scope="request"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>buyer/buyerView.jsp</title>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	<c:if test="${not empty message }">
	alert("${message }");
	<c:remove var="message"	 scope="session"/>
	</c:if>
	
	$(function() {
		var formBtn = $(".formBtn"); //미리 사용할 아이디와 태그들의 레퍼런스를 지정해놓는게 좋다.
		var cmdBtn = $(".cmdBtn"); //안전과 편리를 위해 // 그러나 동적 생성의 태그는 이방법을 사용하면 안됨
		var inputs = $("input"); //한번만 생성되는 녀석이니까.
		var editable = $("input.editable");
		var removeForm = $("[name='removeForm']");
		formBtn.hide();
		inputs.prop("readonly", true);
		//true or false로 나뉘고 불변할 속성들은 attr보다 prop을 쓰는것이 좋다. 
		$("#updateBtn").on("click", function() {
			// 			$("inputs.editable").prop("readonly",false);
			editable.prop("readonly", false);
			cmdBtn.toggle(); //toggle 현재 속성을 반전 시켜줌.(보여지는 버튼이라면 안보이게)
			formBtn.toggle();
		});
		$("#modifyForm").on("reset", function() {
			inputs.prop("readonly", true);
			cmdBtn.toggle();
			formBtn.toggle();
		});
		$("#removeBtn").click(function() {
			var remove = prompt("거래처 이름을 입력해주세요.");
			if (remove) {
				removeForm.find("[name='buyer_name']").val(remove);
				removeForm.submit();
			}
		});
	});
</script>
</head>
<body>
	<form name="removeForm"
		action="<%=request.getContextPath()%>/buyer/buyerDelete.do"
		method="post">
		<input type="hidden" name="buyer_id" value="<%=buyer.getBuyer_id()%>" />
	</form>

	<h4><%=buyer.getBuyer_name()%>
		님의 정보
	</h4>
	<form id="modifyForm" method="post" action="<%=request.getContextPath()%>/buyer/buyerUpdate.do">
		<table>
			<tr>
				<th>거래처 코드</th>
				<td><input type="text" name="buyer_id"
					value="${buyer.buyer_id}" /> <span class="error"><%=Objects.toString(errors.get("buyer_id"), "")%></span>
				</td>
			</tr>
			<tr>
				<th>거래처명</th>
				<td><input type="text" name="buyer_name"
					value="${buyer.buyer_name}" class="editable" /> <span
					class="error"><%=errors.get("buyer_name")%></span></td>
			</tr>
			<tr>
				<th>취급 상품 대분류</th>
				<td><input type="text" name="buyer_lgu"
					value="${buyer.buyer_lgu}" required="required" /><span
					class="error"><%=errors.get("buyer_lgu")%></span></td>
			</tr>
			<tr>
				<th>은행</th>
				<td><input type="text" name="buyer_bank"
					value="${buyer.buyer_bank}" class="editable" /><span
					class="error"><%=errors.get("buyer_bank")%></span></td>
			</tr>
			<tr>
				<th>계좌번호</th>
				<td><input type="text" name="buyer_bankno"
					value="${buyer.buyer_bankno}" class="editable" /><span
					class="error"><%=errors.get("buyer_bankno")%></span></td>
			</tr>
			<tr>
				<th>예금주</th>
				<td><input type="text" name="buyer_bankname"
					value="${buyer.buyer_bankname}" class="editable" /><span
					class="error"><%=errors.get("buyer_bankname")%></span></td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><input type="text" name="buyer_zip"
					value="${buyer.buyer_zip}" class="editable" /><span
					class="error"><%=errors.get("buyer_zip")%></span></td>
			</tr>
			<tr>
				<th>거래처 주소1</th>
				<td><input type="text" name="buyer_add1"
					value="${buyer.buyer_add1}" /><span class="error"><%=errors.get("buyer_add1")%></span></td>
			</tr>
			<tr>
				<th>거래처 주소2</th>
				<td><input type="text" name="buyer_add2"
					value="${buyer.buyer_add2}" class="editable" /><span
					class="error"><%=errors.get("buyer_add2")%></span></td>
			</tr>
			<tr>
				<th>거래처 전화번호</th>
				<td><input type="text" name="buyer_comtel"
					value="${buyer.buyer_comtel}" required="required"
					class="editable" /><span class="error"><%=errors.get("buyer_comtel")%></span></td>
			</tr>
			<tr>
				<th>Fax번호</th>
				<td><input type="text" name="buyer_fax"
					value="${buyer.buyer_fax}" required="required"
					class="editable" /><span class="error"><%=errors.get("buyer_fax")%></span></td>
			</tr>
			<tr>
				<th>거래처 메일</th>
				<td><input type="text" name="buyer_mail"
					value="${buyer.buyer_mail}" required="required"
					class="editable" /><span class="error"><%=errors.get("buyer_mail")%></span></td>
			</tr>
			<tr>
				<th>거래처 담당자</th>
				<td><input type="text" name="buyer_charger"
					value="${buyer.buyer_charger}" class="editable" /><span
					class="error"><%=errors.get("buyer_charger")%></span></td>
			</tr>
			<tr>
				<th>구내전화번호</th>
				<td><input type="text" name="buyer_telext"
					value="${buyer.buyer_telext}" class="editable" /><span
					class="error"><%=errors.get("buyer_telext")%></span></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="button" value="수정" id="updateBtn" class="cmdBtn" /> 
				<input type="button" value="탈퇴" id="removeBtn" class="cmdBtn" /> 
				<input type="button" value="목록보기" id="listBtn" 
				onclick="location.href='<%=request.getContextPath()%>/buyer/buyerList.do'" />
					<input type="submit" value="저장" class="formBtn" /> 
					<input type="reset" value="취소" class="formBtn"
					onclick="location.href='<%=request.getContextPath()%>/buyer/buyerList.do'" />
				</td>
			</tr>
			<tr>
			<th>거래목록</th>
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
						<%
							List<ProdVO> prodList = buyer.getProdList();
							if(prodList!=null && prodList.size()>0){
								for(ProdVO prod : prodList){
									%>
									<tr>
										<td><%=prod.getProd_id() %></td>
										<td><%=prod.getProd_name() %></td>
										<td><%=prod.getProd_cost() %></td>
										<td><%=prod.getProd_sale() %></td>
									</tr>
									<%
								}
							}else{
								%>
								<tr>
									<td colspan="2">거래이력없음</td>
								</tr>
								<%
							}
						%>
					</tbody>
				</table>
			</td>
		</tr>
		</table>
	</form>
</body>
</html>