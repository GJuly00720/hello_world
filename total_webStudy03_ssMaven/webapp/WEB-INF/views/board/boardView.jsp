<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="www.ddit.or.kr/myfn" prefix="myfn"  %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"  %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>

<script type="text/javascript" src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/notify.min.js'/>"></script>
<%-- <c:set var="likeCookie" value="${myfn:decoder(cookie.likeCookie.value, 'UTF-8') }"></c:set> --%>
<script>
$(function(){
	<c:if test="${not empty message }">
// 		$.notify("${message}", {position:"t 1", className:"warn"});
	<c:remove var="message" scope="session" /> 
	</c:if>	
// 	<c:if test="${not fn:contains(likeCookie, board.bo_no) }">
	$(".lhBtn").on("click", function(){
		var id = $(this).prop("id");
		var spanTag = $(this);
		if(document.cookie.indexOf("${board.bo_no}") == -1){
			$.ajax({
				url : "<c:url value='/board/boardLike.do'/>",
				method : "get",
				data : {
					what:"${board.bo_no}",
					likeFlag:id
				},
				dataType : "text", // text(text/plain), html(text/html), json(application/json)  
				success : function(resp) {
					if(resp=="success"){
						var numberStr = spanTag.attr("title");
						spanTag.attr("title",parseInt(numberStr)+1);
					}
				},
				error : function(errorResp) {
					alert(errorResp.status);
				},
				async:fales//비동기를 동기로 변경.
			});
		}
	});
// 	</c:if>
	var hiddenForm = $("#hiddenForm");
	$(".cmdBtn").on('click',function(){
		var btnId = $(this).prop("id");
		hiddenForm.attr("method","get");
		if(btnId == "updateBtn"){
			hiddenForm.attr("action","<c:url value='/board/boardUpdate.do'/>"); 
		}else if(btnId =="deleteBtn"){
			var bo_pass = prompt("비밀번호 입력");
			if(!bo_pass)return;
			hiddenForm.find("[name='password']").val(bo_pass);
			hiddenForm.attr("action","<c:url value='/board/boardDelete.do'/>");
			hiddenForm.attr("method","post");
		}else{
			hiddenForm.attr("action","<c:url value='/board/boardList.do'/>");
		}
		hiddenForm.submit();
	});
});
</script>
<style>
.lhBtn{
	cursor: pointer;
}
</style>
</head>
<body>
	<form id="hiddenForm">
		<input type="hidden" name="what" value="${board.bo_no}"/>
		<input type="hidden" name="password" />
	</form>
	<table>
		<tr>
			<th>글번호</th>
			<td>${board.bo_no}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${board.bo_title}
				<span class="lhBtn" id="likeBtn" title="${ board.bo_like}">좋아요</span>
				<span class="lhBtn" id="hateBtn" title="${ board.bo_hate}">싫어요</span>
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${board.bo_writer}</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>${board.bo_pass}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${board.bo_mail}</td>
		</tr>
		<tr>
			<th>IP</th>
			<td>${board.bo_ip}</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<c:forEach items="${board.attatchList }" var="attVO" varStatus="vs">
					<c:url value="/board/download.do" var="downloadUrl">
						<c:param name="what" value="${attVO.att_no }"/>
					</c:url>
					 <a href="${downloadUrl }" title="다운로드:${attVO.att_downcount }, 크기:${attVO.att_fancysize}">
					${attVO.att_originalfilename }</a> 
					<c:if test="${not vs.last }">&nbsp;&nbsp;|&nbsp;&nbsp;</c:if>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${board.bo_content}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${board.bo_date}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${board.bo_hit}</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" class="cmdBtn" id="updateBtn" value="수정" />
				<input type="button" class="cmdBtn" id="deleteBtn" value="삭제" />
				<input type="button" class="cmdBtn" id="listBtn" value="목록가기" />
			</td>
		</tr>
	</table>
</body>
</html>