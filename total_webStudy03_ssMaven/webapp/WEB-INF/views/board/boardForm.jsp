<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>board/boardForm.jsp</title>
<script type="text/javascript"
	src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/ckeditor/adapters/jquery.js'/>"></script>
<script type="text/javascript">
	$(function() {
		<c:if test="${not empty message }">
		alert("${message}");
		</c:if>
		$("#bo_content").ckeditor({
			uiColor : '#9AB8F3',
			filebrowserImageUploadUrl:"<c:url value='/board/imageUpload.do'/>"
		});
		var bo_content = $("#bo_content");
		var editForm = $('#editForm');
		$('#editForm').on("reset", function(event) {
			console.log(bo_content.text());
			ckeditor.val(bo_content.text());
		});
		
		var inputTag = "<input type='text' name='delAttNos' value='%V'/>";
			
		$(".fileDelBtn").on("click", function(){
			var delNo = $(this).data("attno");// 지워질 파일에 번호
			editForm.append(inputTag.replace("%V", delNo));
			$(this).parents("span:first").hide();
		});
	});
</script>
</head>
<body>
	<form method="post" id="editForm" enctype="multipart/form-data">
		<table>
			<tr>
				<th>글번호</th>
				<td><input type="hidden" name="bo_no" value="${board.bo_no}"
					required="required" /><span class="error">${errors["bo_no"] }</span></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="bo_title"
					value="${board.bo_title}" required="required" /><span
					class="error">${errors["bo_title"] }</span></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="bo_writer"
					value="${board.bo_writer}" required="required" /><span
					class="error">${errors["bo_writer"] }</span></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="bo_pass" value="${board.bo_pass}"
					required="required" /><span class="error">${errors["bo_pass"] }</span></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="bo_mail" value="${board.bo_mail}" /><span
					class="error">${errors["bo_mail"] }</span></td>
			</tr>
			<tr>
				<th>IP</th>
				<td><input type="text" name="bo_ip" readonly="readonly"
					value="${pageContext.request.remoteAddr}" required="required" /><span
					class="error">${errors["bo_ip"] }</span></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="bo_content" id="bo_content"></textarea>
					<span class="error">${errors["bo_content"] }</span></td>
			</tr>
			<tr>
				<th>기존파일</th>
					<td>
						<c:forEach items="${board.attatchList }" var="attVO" varStatus="vs">
						<span>
							${attVO.att_originalfilename }
							<span data-attno="${attVO.att_no }" class="fileDelBtn">[삭제]</span>
							<c:if test="${not vs.last }">&nbsp;&nbsp;|&nbsp;&nbsp;</c:if>
						</span>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="bo_files" /> <input type="file"
					name="bo_files" /> <input type="file" name="bo_files" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="저장" /> <input
					type="reset" value="취소" /> <input type="button" value="뒤로가기"
					onclick="history.back();" /> <input type="button" value="목록으로"
					onclick="location.href='<c:url value="/board/boardList.do"/>'" /></td>
			</tr>
		</table>
	</form>
</body>
</html>