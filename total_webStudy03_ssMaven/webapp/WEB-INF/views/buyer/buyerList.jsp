<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cPath" value="${pageContext.request.contextPath }" scope="application"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>buyer/buyerList.jsp</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="http://malsup.github.io/min/jquery.form.min.js"></script>
<c:if test="${not empty message }">
	<script type="text/javascript">
		alert("${message}");
	</script>
	<c:remove var="message" scope="session" />
</c:if>
<script type="text/javascript">
	$(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	var clientForm = $("#clientForm");
	pagingArea.on("click","a",function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		clientForm.find("[name='page']").val(pageNo);
		clientForm.submit();
		return false;
	});
	
	var optionPtrn = "<option value='%V'>%T</option>";

	$.ajax({
		url : "<%=request.getContextPath()%>/prod/getLprodList.do",
		method : "get",
		dataType : "json", //text(text/plain), html(text/html), json(application/json), request header(accept), response header(Content-Type)
		success : function(resp) {
//				alert(JSON.stringify(resp));
			var html = "";
			$.each(resp,function(propName, propValue){
				html += optionPtrn.replace("%V", propName)
									.replace("%T", propValue);
			});
			clientForm.find("[name='buyer_lgu']").append(html);
			clientForm.find("[name='buyer_lgu']").val("${pagingVO.searchVO.buyer_lgu}");
		},
		error : function(errorResp) {
			alert(errorResp.status);
		}
	});
	
	var listBody = $("#listBody");
	
	$("#searchForm, #clientForm").ajaxForm({
		dataType : "json", //text(text/plain), html(text/html), json(application/json), request header(accept), response header(Content-Type)
		success : function(resp) {
			var dataList = resp.dataList;
			var html="";
			if(dataList){
				$.each(dataList,function(index, buyer){
					html+="<tr>                                                                                                                             ";
					html+="<td>"+buyer.buyer_id +"</td>                                                                                                ";
					html+="<td><a href='${cPath}/buyer/buyerView.do?who="+buyer.buyer_id+"'>"+buyer.buyer_name+"</a></td>";
					html+="<td>"+buyer.lprod_nm+"</td>                                                                                              ";
					html+="<td>"+buyer.buyer_comtel +"</td>                                                                                                ";
					html+="<td>"+buyer.buyer_fax +"</td>                                                                                              ";
					html+="<td>"+buyer.buyer_mail +"</td>                                                                                           ";
					html+="</tr>                                               ";
				});
			}else{
				html = "<tr><td colspan='6'>조건에 해당하는 상품이 없음.</td></tr>";
			}
			listBody.html(html);
			pagingArea.html(resp.pagingHTML);
			clientForm.find("[name='page']").val("");
			},
			error : function(errorResp) {
			alert(errorResp.status);
			}
		});
	});
</script>
</head>
<body>
	<h4>회원 목록</h4>
	<input type="button" value="신규등록"
		onclick="location.href='${cPath}/buyer/buyerInsert.do'" />
	<table>
		<thead>
			<tr>
				<th>아이디</th>
				<th>거래처명</th>
				<th>지역</th>
				<th>전화번호</th>
				<th>팩스번호</th>
				<th>이메일</th>
			</tr>
		</thead>
		<tbody id="listBody">
			<c:set var="buyerList" value="${pagingVO.dataList }" />
			<c:if test="${not empty buyerList }">
				<c:forEach items="${buyerList }" var="buyer">
					<tr class="dataTr" id="${buyer.buyer_id }">
						<td>${buyer.buyer_id }</td>
						<c:url value="/buyer/buyerView.do" var="viewURL">
							<c:param name="who" value="${buyer.buyer_id }"></c:param>
						</c:url>
						<td><a href="${viewURL }">${buyer.buyer_name }</a></td>
						<td>${buyer.buyer_add1 }</td>
						<td>${buyer.buyer_comtel }</td>
						<td>${buyer.buyer_fax }</td>
						<td>${buyer.buyer_mail }</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty buyerList }">
				<tr>
					<td colspan='6'>검색조건에 해당하는 회원이 없음.</td>
				</tr>
			</c:if>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="6">
					<div id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
					<form id="searchForm">
						<input type="hidden" name="page" /> <input type="hidden"
							name="searchType" value="${pagingVO.searchType }" /> <input
							type="hidden" name="searchWord" value="${pagingVO.searchWord }" />
					</form>
					<form id="adminForm">
						<select name="searchType">
							<option value="all">전체</option>
							<option value="name">이름</option>
							<option value="add1">지역</option>
						</select> <input type="hidden" name="page" /> <input type="text"
							name="searchWord" value="${pagingVO.searchWord }" /> <input
							type="submit" value="검색" />
					</form>
				</td>
			</tr>
		</tfoot>
	</table>
</body>
</html>