<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Objects"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <c:set var="cPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<c:if test="${not empty messgae }">
	alert("${message }")
	<c:remove var="message" scope="session" />
</c:if>
</head>
<body>
<form enctype="multipart/form-data" method="post">
	<table>
			<tr>
				<th>거래처명</th>
				<td><input type="text" name="buyer_name"
					value="${buyer.buyer_name}" required="required" /><span
					class="error">${errors["buyer_name"]}</span></td>
			</tr>
			<tr>
				<th>취급상품대분류</th>
				<td>
					<select id="buyer_lgu" name="buyer_lgu"  >
						<option value="">분류선택</option>
						<c:forEach items="${lprodMap }" var="entry">
							<c:if test="${entry.key eq buyer.buyer_lgu }">
								<c:set var="selected" value="selected" />
							</c:if>
							<c:if test="${entry.key ne buyer.buyer_lgu }">
								<c:set var="selected" value="" />
							</c:if>
							<option value="${entry.key }" ${selected }>${entry.value }</option>
						</c:forEach>
					</select>
					<span class="error">${errors["buyer_lgu"]}</span></td>
			</tr>
			<tr>
				<th>거래처이미지</th>
				<td>
					<input type="file" name="buyer_image" />
				</td>
			</tr>
			
			<tr>
				<th>거래은행</th>
				<td><input type="text" name="buyer_bank"
					value="${buyer.buyer_bank}" /><span class="error">${errors["buyer_bank"]}</span></td>
			</tr>
			<tr>
				<th>계좌번호</th>
				<td><input type="text" name="buyer_bankno"
					value="${buyer.buyer_bankno}" /><span class="error">${errors["buyer_bankno"]}</span></td>
			</tr>
			<tr>
				<th>예금주</th>
				<td><input type="text" name="buyer_bankname"
					value="${buyer.buyer_bankname}" /><span class="error">${errors["buyer_bankname"]}</span></td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><input type="text" name="buyer_zip"
					value="${buyer.buyer_zip}" /><span class="error">${errors["buyer_zip"]}</span></td>
			</tr>
			<tr>
				<th>주소1</th>
				<td><input type="text" name="buyer_add1"
					value="${buyer.buyer_add1}" /><span class="error">${errors["buyer_add1"]}</span></td>
			</tr>
			<tr>
				<th>주소2</th>
				<td><input type="text" name="buyer_add2"
					value="${buyer.buyer_add2}" /><span class="error">${errors["buyer_add2"]}</span></td>
			</tr>
			<tr>
				<th>회사전화</th>
				<td><input type="text" name="buyer_comtel"
					value="${buyer.buyer_comtel}" required="required" /><span
					class="error">${errors["buyer_comtel"]}</span></td>
			</tr>
			<tr>
				<th>팩스</th>
				<td><input type="text" name="buyer_fax"
					value="${buyer.buyer_fax}" required="required" /><span
					class="error">${errors["buyer_fax"]}</span></td>
			</tr>
			<tr>
				<th>메일</th>
				<td><input type="text" name="buyer_mail"
					value="${buyer.buyer_mail}" required="required" /><span
					class="error">${errors["buyer_mail"]}</span></td>
			</tr>
			<tr>
				<th>담당자</th>
				<td><input type="text" name="buyer_charger"
					value="${buyer.buyer_charger}" /><span class="error">${errors["buyer_charger"]}</span></td>
			</tr>
			<tr>
				<th>내선번호</th>
				<td><input type="text" name="buyer_telext"
					value="${buyer.buyer_telext}" /><span class="error">${errors["buyer_telext"]}</span></td>
			</tr>
			
			<tr>
				<td colspan="2">
				<input type="submit" value="저장" /> 
				<input type="reset" value="취소" />
				</td>
			</tr>
	</table>
</form>
</body>
</html>