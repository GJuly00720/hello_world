<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cPath" value="${pageContext.request.contextPath }" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">
<script src="${cPath }/js/jquery-3.3.1.min.js"></script> 
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
//alert //페이지 뜨기전에 먼저 뜸
$(function(){
	<c:if test="${not empty message }" >
		alert("${message}");
	</c:if>
	<c:remove var="message" scope="request" />
	$("[name='prod_insdate']").datepicker({
		dateFormat:"yy-mm-dd"
	});//들어가는 값을 객체 만들어서 함수에 넘겨서 적용!
// 	alert //페이지 완성되고 뜸
	var prod_lguTag = $("#prod_lgu");
	var prod_buyerTag = $("#prod_buyer");
	prod_lguTag.on("change",function(){
		var lgu = $(this).val(); //현재선택된 카테고리의 코드
		prod_buyerTag.find("option:gt(0)").hide();
		prod_buyerTag.find("option."+lgu).show();
	})
});
</script>
</head>
<body>
	<jsp:useBean id="prod" class="kr.or.ddit.vo.ProdVO" scope="request"></jsp:useBean>
	<jsp:useBean id="errors" class="java.util.LinkedHashMap"
		scope="request"></jsp:useBean>
	<form method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>상품명</th>
				<td><input type="text" name="prod_name"
					value="${prod.prod_name }" required="required" /><span
					class="error">${errors["prod_name"]}</span></td>
			</tr>
			<tr>
				<th>분류코드</th>
				<td><SELECT name="prod_lgu" id="prod_lgu">
						<option value="">분류선택</option>
						<c:forEach items="${lprodMap }" var="entry"> 
							<c:if test="${entry.key eq prod.prod_lgu }"> <!-- value.equals(prod.getProd_lgu()) -->
								<c:set var="selected" value="selected"></c:set>
							</c:if>
							<c:if test="${entry.key eq prod.prod_lgu }"> 
								<c:set var="selected" value=""/>
							</c:if>
							<option value="${entry.key }" ${selected  }>${entry.value }</option>
						</c:forEach>
				</SELECT>
<%-- 				<input type="text" name="prod_lgu" value="${prod.prod_lgu }" --%>
<!-- 					required="required" />  얘가 ↑변경.-->
				<span class="error">${errors["prod_lgu"]}</span>
				</td>
			</tr>
			<tr>
				<th>거래처코드</th>
				<td>
					<select name="prod_buyer" id="prod_buyer" required="required">
						<option value="">거래처선택</option>
						<c:forEach items="${buyerList}" var="buyer">
						<c:choose>
							<c:when test="${buyer.buyer_id eq prod.prod_buyer}">
								<c:set var="selected" value="selected"></c:set>
							</c:when>
							<c:otherwise>
								<c:set var="selected" value=""></c:set>
							</c:otherwise>
						</c:choose>
							<option value="${buyer.buyer_id }" class="${buyer.buyer_lgu}" ${selected }>
								${buyer.buyer_name}
							</option>
						</c:forEach>
					</select>				
<!-- 				<input type="text" name="prod_buyer" -->
<%-- 					value="${prod.prod_buyer }" required="required" /> --%>
					<span class="error">${errors["prod_buyer"]}</span>
				</td>
			</tr>
			<tr>
				<th>구매가</th>
				<td><input type="text" name="prod_cost"
					value="${prod.prod_cost }" required="required" /><span
					class="error">${errors["prod_cost"]}</span></td>
			</tr>
			<tr>
				<th>소비자가</th>
				<td><input type="text" name="prod_price"
					value="${prod.prod_price }" required="required" /><span
					class="error">${errors["prod_price"]}</span></td>
			</tr>
			<tr>
				<th>판매가</th>
				<td><input type="text" name="prod_sale"
					value="${prod.prod_sale }" required="required" /><span
					class="error">${errors["prod_sale"]}</span></td>
			</tr>
			<tr>
				<th>기본정보</th>
				<td><input type="text" name="prod_outline"
					value="${prod.prod_outline }" required="required" /><span
					class="error">${errors["prod_outline"]}</span></td>
			</tr>
			<tr>
				<th>상세정보</th>
				<td><input type="text" name="prod_detail"
					value="${prod.prod_detail }" /><span class="error">${errors["prod_detail"]}</span></td>
			</tr>
			<tr>
				<th>상품이미지</th>
				<td>
					<input type="file" name="prod_image"/> <!--  클라이언트로부터 오는 이름--> 
					<input type="hidden" name="prod_img" 
					value="${prod.prod_img }" required="required" /> <!--  server로부터 오는 이름-->
					<span class="error">${errors["prod_img"]}</span>
					</td>
			</tr>
			<tr>
				<th>재고량</th>
				<td><input type="text" name="prod_totalstock"
					value="${prod.prod_totalstock }" required="required" /><span
					class="error">${errors["prod_totalstock"]}</span></td>
			</tr>
			<tr>
				<th>입고일</th>
				<td><input type="text" name="prod_insdate"
					value="${prod.prod_insdate }" /><span class="error">${errors["prod_insdate"]}</span></td>
			</tr>
			<tr>
				<th>안전재고량</th>
				<td><input type="text" name="prod_properstock"
					value="${prod.prod_properstock }" required="required" /><span
					class="error">${errors["prod_properstock"]}</span></td>
			</tr>
			<tr>
				<th>사이즈</th>
				<td><input type="text" name="prod_size"
					value="${prod.prod_size }" /><span class="error">${errors["prod_size"]}</span></td>
			</tr>
			<tr>
				<th>색상</th>
				<td><input type="text" name="prod_color"
					value="${prod.prod_color }" /><span class="error">${errors["prod_color"]}</span></td>
			</tr>
			<tr>
				<th>배송방법</th>
				<td><input type="text" name="prod_delivery"
					value="${prod.prod_delivery }" /><span class="error">${errors["prod_delivery"]}</span></td>
			</tr>
			<tr>
				<th>단위</th>
				<td><input type="text" name="prod_unit"
					value="${prod.prod_unit }" /><span class="error">${errors["prod_unit"]}</span></td>
			</tr>
			<tr>
				<th>입고수량</th>
				<td><input type="text" name="prod_qtyin"
					value="${prod.prod_qtyin }" /><span class="error">${errors["prod_qtyin"]}</span></td>
			</tr>
			<tr>
				<th>판매수량</th>
				<td><input type="text" name="prod_qtysale"
					value="${prod.prod_qtysale }" /><span class="error">${errors["prod_qtysale"]}</span></td>
			</tr>
			<tr>
				<th>마일리지</th>
				<td><input type="text" name="prod_mileage"
					value="${prod.prod_mileage }" /><span class="error">${errors["prod_mileage"]}</span></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="저장" /> 
				<input	type="reset" value="취소" /> 
				<input type="button" value="뒤로가기" onclick="history.go(-1)" /> <!-- 					== history.back(-1)뒤로가기, 1 앞으로 window 브라우저 자체가 갖고있는 캐시데이터를 이용 -->
					<input type="button" value="목록으로"	onclick="location.href='<%=request.getContextPath()%>/prod/prodList.do'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>