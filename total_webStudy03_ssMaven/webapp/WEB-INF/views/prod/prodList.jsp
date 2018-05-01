<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <c:set var="cPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>prod/prodList.jsp</title>
<script src="${cPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script>
$(function(){
	$("tbody").on("click","tr.dataTr", function(){ //비동기 처리시 사용. (동적으로 작성된 tr태그에 대해서도 바인딩할 수 있다.)
// 		var what = $(this).prod("id");
		var what = $(this).find("td:nth(1)").text();
		location.href="${cPath}/prod/prodView.do?what="+what;
	});
	$("#newBtn").on('click',function(){
		location.href="${cPath}/prod/prodInsert.do";
	});
	var searchForm = $('#searchForm'); //트레버싱예방을 위해 따로 변수로 선언하여 사용.
	var clientForm =$("#clientForm"); 
	var pagingArea = $("#pagingArea");// 페이징 이벤트가 발생했을 때
	pagingArea.on('click', 'a', function(event){//a태그에 대한 commandHandler//a태그의 이벤트가 들어왔을떄!!
		event.preventDefault;
		var pageNo = $(this).data("page");
		clientForm.find("[name='page']").val(pageNo);
		clientForm.submit();
		return false;
	})
	
	var optionPtrn = "<option value='%V' class='buyer'>%T</option>";
	
	var searchLguTag = clientForm.find("[name='prod_lgu']");
	searchLguTag.on("change", function(){
		var lgu = $(this).val();
		$.ajax({//비동기 요청
			url : "${cPath}/prod/getBuyerList.do",
			method : "get",
	 		data :{
	 			prod_lgu:lgu
	 		},
			dataType : "json", // text(text/plain), html(text/html), json(application/json) 
			success : function(resp) {// 응답데이터를사용하여
				var html = "";
				$.each(resp, function(index, buyer){
					
				
					html += optionPtrn.replace("%V", buyer.buyer_id)
										.replace("%T", buyer.buyer_name);
					
				});
				clientForm.find("[name='prod_buyer']").find("[class='buyer']").remove();
				clientForm.find("[name='prod_buyer']").append(html);
				clientForm.find("[name='prod_buyer']").val("${pagingVO.searchVO.prod_buyer }");
			},
			error : function(errorResp) {
				alert(errorResp.status);
			}
		});
	})
	
	var listBody = $('#listBody');
	
// 	searchForm.on("submit", function(){ //폼태그의 이동중단, 비동기로 변환
// 		event.preventDefault();
// 		var queryString = $(this).serialize(); //쿼리스트링으로 만들어줌.
		$("#searchForm, #clientForm").ajaxForm({
// 		searchForm.ajaxForm({ //searchForm의것 사용 // 비동기 <<<<
// 			url : "prodList.do", //상대경로 //주소를 안준다면 브라우저 주소창에 입력된 주소가 사용됨.
// 			method : "post",
// 			data : queryString,
			dataType : "json", // text(text/plain), html(text/html), json(application/json) 
			success : function(resp) { 
				var dataList = resp.dataList;
				var html = "";
				if(dataList){ //있으면
					$.each(dataList, function(index, prod){ // ↓ 클라이언트 사이드의 것을 사용
						html += "<tr class='dataTr' id='"+prod.Prod_id+"'>  ";
						html += "<td>"+prod.rnum+"</td>                     ";
						html += "<td class='prodId'>"+prod.prod_id+"</td>          ";
						html += "<td>"+prod.prod_name+"</td>                ";
						html += "<td>"+prod.lprod_nm+"</td>                 ";
						html += "<td>"+prod.prod_cost+"</td>                ";
						html += "<td>"+prod.prod_sale+"</td>                ";
						html += "<td>"+prod.buyer.buyer_name+"</td>    ";
						html += "<td>"+prod.buyer.buyer_add1+"</td>    ";
						html += "<td>"+prod.buyer.buyer_charger+"</td> ";
						html += "<td>"+prod.prod_mileage+"</td>             ";
						html += "</tr>                  ";
					});
				}else{
					html += "<tr><td colspan='10'>조건에 해당하는 상품이 없음.</td></tr>";
				}
				listBody.html(html);
				pagingArea.html(resp.pagingHTML);
				clientForm.find("[name='page']").val("");
			},
			error : function(errorResp) {
				alert(errorResp.status);
			}
		});
// 		return false;
// 	});
	
	$.ajax({
		url : "${cPath}/prod/getLprodList.do",
		method : "get",
		dataType : "json", // text(text/plain), html(text/html), json(application/json) 
		success : function(resp) { // resp = 언마샬링되어있는 자바스크립트 객체. 
// 			alert(JSON.stringify(resp)); //다시마샬링 문자열로바꿔서 확인하게...
			var html = "";
			$.each(resp, function(propName, propValue){
				html += optionPtrn.replace("%V", propName)
								.replace("%T", propValue);
			});
			searchLguTag.append(html);
			searchLguTag.val("${pagingVO.searchVO.prod_lgu }");
			searchLguTag.trigger("change");
		},
		error : function(errorResp) {
			alert(errorResp.status);
		}
	});
	
});
</script>
</head>
<body>
<h4> 상품 목록 조회 </h4>
<input type="button" value="신규상품등록" id="newBtn" />

<form id="searchForm"> <!-- 전송을 위한 폼 -->
	<input type="hidden" name="prod_lgu" value="${pagingVO.searchVO.prod_lgu }"/>
	<input type="hidden" name="prod_buyer" value="${pagingVO.searchVO.prod_buyer }"/>
	<input type="hidden" name="prod_name" value="${pagingVO.searchVO.prod_name }"/>
	<input type="hidden" name="page"/>
</form>

<form id="clientForm"> <!-- 입력을 위한 폼 -->
	<select name="prod_lgu">
		<option value="">분류선택</option>
	</select>
	<select name="prod_buyer">
		
		<option value="">거래처선택</option>
	</select>
	<input type="text" name="prod_name" value="${pagingVO.searchVO.prod_name }"/>
	<input type="hidden" name="page"/>
	<input type="submit" value="검색"/>
</form>
<table>
	<thead>
		<tr>
			<th>순번</th>
			<th>상품코드</th>
			<th>상품명</th>
			<th>분류명</th>
			<th>구매가</th>
			<th>판매가</th>
			<th>거래처명</th>
			<th>거래처 소재지</th>
			<th>거래처 담당자</th>
			<th>마일리지</th>
		</tr>
	</thead>
	<tbody id="listBody">
		<c:set var="prodList" value="${pagingVO.dataList }"></c:set>
		<c:if test="${not empty prodList}">
			<c:forEach items="${prodList }" var="prod">
			<tr class="dataTr" id="${prod.prod_id }">
				<td>${prod.rnum }</td> 
				<td id="id">${prod.prod_id }</td>
				<c:url value="/prod/prodView.do" var="viewURL">
					<c:param name="what" value="${prod.prod_id }"/>
				</c:url><!-- 클라이언트사이드경로 완성; -->
				<td><a href="${viewURL }">${prod.prod_name }</a></td>
				<td>${prod.lprod_nm }</td>
				<td>${prod.prod_cost }</td>
				<td>${prod.prod_sale }</td>
				<td>${prod.buyer.buyer_name }</td>
				<td>${prod.buyer.buyer_add1 }</td>
				<td>${prod.buyer.buyer.charger }</td>
				<td>${prod.prod_mileage }</td>
			</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty prodList}">
			<tr>
				<td colspan="10">조건에 해당하는 상품이 음슴. 메세지 출력.</td>
			</tr>
		</c:if>
	</tbody>
	<tfoot>
		<tr>
			<td id="pagingArea" colspan="10">
				${pagingVO.pagingHTML }
			</td>
		</tr>
	</tfoot>
</table>
</body>
</html>