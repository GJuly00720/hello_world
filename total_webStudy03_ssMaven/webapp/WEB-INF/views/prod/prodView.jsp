<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>prod/prodView.jsp</title>
</head>
<body>
	<table>
		<tr>
			<th>상품코드</th>
			<td>${prod.prod_id }</td>
		</tr>
		<tr>
			<th>상품명</th>
			<td>${prod.prod_name }</td>
		</tr>
		<tr>
			<th>분류명</th>
			<td>${prod.lprod_nm }</td>
		</tr>
		<tr>
			<th>거래처코드</th>
			<td>
				<table>
					<tr>
						<th>거래처코드</th>
						<th>거래처명</th>
						<th>거래처소재지</th>
						<th>거래처담당자</th>
						<th>연락처</th>
					</tr>
					<tr>
					<c:set var="buyerVO" value="prodVO.buyer"/>
						<td>${buyer.buyer_id}</td>
						<td>${buyer.buyer_name}</td>
						<td>${buyer.buyer_add1}</td>
						<td>${buyer.buyer_charger}</td>
						<td>${buyer.buyer_comtel}</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<th>공급업체코드</th>
			<td>${prod.prod_buyer }</td>
		</tr>
		<tr>
			<th>구매가</th>
			<td>${prod.prod_cost }</td>
		</tr>
		<tr>
			<th>소비자가</th>
			<td>${prod.prod_price }</td>
		</tr>
		<tr>
			<th>판매가</th>
			<td>${prod.prod_sale }</td>
		</tr>
		<tr>
			<th>기본정보</th>
			<td>${prod.prod_outline }</td>
		</tr>
		<tr>
			<th>상세정보</th>
			<td>${prod.prod_detail }</td>
		</tr>
		<tr>
			<th>상품이미지</th>
			<td>${prod.prod_img }</td>
		</tr>
		<tr>
			<th>재고량</th>
			<td>${prod.prod_totalstock }</td>
		</tr>
		<tr>
			<th>입고일</th>
			<td>${prod.prod_insdate }</td>
		</tr>
		<tr>
			<th>안전재고량</th>
			<td>${prod.prod_properstock }</td>
		</tr>
		<tr>
			<th>사이즈</th>
			<td>${prod.prod_size }</td>
		</tr>
		<tr>
			<th>색상</th>
			<td>${prod.prod_color }</td>
		</tr>
		<tr>
			<th>배송방법</th>
			<td>${prod.prod_delivery }</td>
		</tr>
		<tr>
			<th>단위</th>
			<td>${prod.prod_unit }</td>
		</tr>
		<tr>
			<th>입고수량</th>
			<td>${prod.prod_qtyin }</td>
		</tr>
		<tr>
			<th>판매수량</th>
			<td>${prod.prod_qtysale }</td>
		</tr>
		<tr>
			<th>마일리지</th>
			<td>${prod.prod_mileage }</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정하기" onclick="location.href='${cPath }/prod/prodUpdate.do?what=${prod.prod_id }'"/>
				<input type="button" value="목록으로"	onclick="location.href='${cPath}/prod/prodList.do'" />
			</td>
		</tr>
	</table>
</body>
</html>