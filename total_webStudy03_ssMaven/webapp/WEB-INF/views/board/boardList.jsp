<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>board/boardList.jsp</title>
<link rel="stylesheet" href="<c:url value='/js/bootstrap/css/bootstrap.min.css'/>">
<script type="text/javascript" src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/bootstrap/js/bootstrap.min.js'/>"></script>
<script type="text/javascript">
$(function(){
	var searchForm = $("#searchForm");
	$('#pagingArea').on('click','a',function(event){ //a에 대한 이벤트를 처리
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("[name='page']").val(pageNo);
		searchForm.submit();
		return false;
	});
});
</script>
<style>
table .thead-dark th { color:#fff; background:#212529; text-align: center;}
table td{
	text-align: center !important;
}
</style>
</head>
<body>
<input class="btn-info" type="button" value="새글쓰기"
	onclick="location.href='<c:url value='boardInsert.do'/>'"
	/>
<table class="table table-striped table-bordered table-hover">
	<thead class="thead-dark">
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="boardList" value="${pagingVO.dataList }"/>
		<c:choose>
		<c:when test="${not empty boardList }">
			<c:forEach var="board" items="${boardList}"  >
				<c:url value="/board/boardView.do" var="viewUrl">
					<c:param name="what" value="${board.bo_no}"/>
				</c:url>
				<tr>
					<td>${board.rnum}</td>
					<td><a href="${viewUrl }" >${board.bo_title }</a></td>
					<td>${board.bo_writer }</td>
					<td>${board.bo_date }</td>
					<td>${board.bo_hit }</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="5">
				작성된 글이 없습니다.
				paging처리
				검색 작성자 제목 내용
				부트스트랩
				</td>
			</tr>	
		</c:otherwise>
		</c:choose>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="6">
				<div id="pagingArea"> 
					<ul class="pagination">
						<li>
							${pagingVO.pagingHTML }
						</li>
					</ul>
				</div>
				<form id="searchForm"> <!-- 전송용 폼 --> 
					<input type="hidden" name="page"/>
					<input type="hidden" name="searchType"
					value="${pagingVO.searchType }"
					/>
					<input type="hidden" name="searchWord"
					value="${param.searchWord }"
					/>
				</form>
				<form> <!-- 검색폼 ↑ 위의 전송용 폼에 묶여 함게간다. 검색 후 paging도 되야하니까. -->
				<select name="searchType">
					<option value="all">전체</option>
					<option value="writer">작성자</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="searchWord" 
				value="${pagingVO.searchWord }"/>
					<input type="submit" value="검색" class="btn btn-warning"/>
				</form>
				<script type="text/javascript">//↑애가 만들어지고 형성될것이라 스크립터 여기만듬.
					$("[name='searchType']").val("${empty pagingVO.searchType ? 'all':pagingVO.searchType}")
				</script>
			</td>
		</tr>
	</tfoot>
</table>

</body>
</html>