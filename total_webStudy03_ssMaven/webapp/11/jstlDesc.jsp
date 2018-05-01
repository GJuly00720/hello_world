<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!--     tagdir = 내가 만든 커스텀태그를 사용할 때. -->
<!--     uri = 라이브러리 형태의 태그사용. -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>11/jstlDesc.jsp</title>
<script>
	function validation( event){
		var inputTag=event.target;
		var url = inputTag.value;
		var pttern = /정규식패턴/igm; //이그노어,,글로벌..
		// 
		if(pattern.test()){
			return true;
		}else{
			콘솔출력
			return false;
		}
	}
</script>
</head>
<body>
<h4>JSTL (Jsp Standard Tag Library) </h4>
<form>
	import URL : <input type="text" name="importUrl" value="${param.importUrl }" />
	<label><input type="checkbox" name="viewSource" ${not empty param.viewSource?"ckecked":"" } value="true"/>소스로 보기</label>
	<input type="submit" value="import!"/>
</form>
<c:if test="${not empty param.importUrl }">
	<c:import url="${param.importUrl }" var="importData"/>
</c:if>
<pre>


</pre>
<div style="border: 1px solid coral;">
	<c:if test="${not empty importData }">
		<c:out value="${importData }" escapeXml="${ param.viewSource eq 'true'}" />
	</c:if>
</div>
<pre>
	: 커스텀 태그들 중에서 많이 사용되는 것들을 모아놓은 라이브러리.
	
	JSTL 사용단계
	1. 태그 라이브러리 파일을 빌드패스에 추가
	2. JSTL 을 사용할 JSP 페이지에서 사용할 태그를 로딩.
		- taglib 지시자 이용 - 커스텀 태그를 로딩.
	3. &lt;prefix:tagname 속성명="속성값" /&gt;
	
	JSTL 의 지원 태그 라이브러리
	1. 코어태그 (c 태그) 
		1) EL변수(속성) 지원용 : 플래쉬 어트리뷰트에서 사용 가능. 
		-	set :: 선언, 초기화, 스코프결정
		-	remove :: 삭제 
			&lt;c:set var="속성명" value="속성값" scope="영역" /&gt;
		** scope 는 생락가능 (기본 page scope 사용)
			<c:set var="testAttr" value="테스트값" scope="application"/>
			${applicationScope.testAttr } 
		
			&lt;c:remove var="지울 속성명" scope="속성을 지울 영역" /&gt;
		** scope 를 생략하면 모든 영역에서 같은 속성명을 가진 속성을 제거.
			<c:remove var="testAttr" /> <!-- 영역지정을 안했기 때문에 모든 스코프를뒤져 동일 명의 속성들을 전부 지운다. -->
			${ testAttr }
		
		2) 흐름제어 : if, choose~when~otherwise, forEach, forTokens
			iterate.jsp,condition.jsp

		3) URL 재처리 (URL rewriting) : url, redirect
			이동방식 : redirect, dispatch(forward/include)
			&lt;c:redirect url="서버사이드 경로표기방식의 url"/&gt;
			url 태그 : 
			1) 클라이언트 사이드 절대 경로 완성
			2) 쿼리 스트링
			3) url rewrite : 세션 파라미터 사용 주소 완성.			
				&lt;c:url value="서버사이드 경로 표기방식의 url"/&gt;
					&lt;c:param name="파라미터명" value="파라미터값"&gt;&lt;/c:param/&gt;
				&lt;/c:url/&gt;
			클라이언트 사이드 절대경로를 만들어줌 - > 컨텍스트 패스를 안해도됨.
			현재 세션을 유지할수 없다면 세션파라미터를 만들어서 유지가 가능하게 만들어줌.
			
		4) 기타 : import,out
<%-- 			<jsp:include page="/02/standard.jsp" /> -- 동일Context(같은 어플리케이션)내의 동적 내포만 가능. --%>
			&lt;c:import url="컨텍스트 제한 없는 url(절대경로)" var="속성명" scope="저장영역" /&gt;
			&lt;c:out value="출력할 값" escapeXml="태그의 escape 여부 결정"/&gt;
<%-- 			<c:import url="https://www.naver.com" var="naver" scope="session"></c:import> - 동적include - 컨텍스트의 제한 없음. --%>
<!-- 			외부의 사이트의 데이터를 긁어와서 		↑ 			사용가능 ↑  크로울링  -->
<%-- 			<c:out value="${naver }" escapeXml="false"></c:out> :  --%>
				
				
	2. 국제화태그 (fmt 태그)
		fmtDesc.jsp
	
	3. 함수 (fn 라이브러리) :: 스트링의 메서드를 대신하는 
		el 2.2, servlet 3.0 &lt;- 현재버전에선 el내부에서 메소드호출 가능해서 의미 없음. 그러나 필드에서 이하의 버전을 만났을 경우를 위해.
		${"aa".length() }, &lt; ${fn:length("aaaaa") } //object :: (내부에서 size로)
		<%
			String[] array = {"1", "2", "3"};
			pageContext.setAttribute("array", array);
			String origin = "abcdefg";
			pageContext.setAttribute("origin", origin);
		%>
		${fn:join(array, "|") }
		${fn:substringAfter(origin, "d") }
		${fn:substringBefore(origin, "d") }
		
	4.커스텀 라이브러리 작성 방법
		1) /WEB-INF/tlds 폴더 생성 // 태그라이브러리 데피니션폴더로 인식 (WAS에 의해 자동 인지되어 별도의 등록과정 필요없음.)
			tld : TagLibrary Definition
			
		2) custom.tld : 태그 라이브러리에 대한 정의를 설정.
			tlib-version : 라이브러리 버전
			short-name : taglib 지시자로 등록할 prefix
			uri : taglib 지시자에서 사용할 uri (식별자)
			function : 실제 함수에 대한 정의
				name : el 내에서 사용할 함수명
				function-class : 실행 코드를 가진 클래스의 qualified name.
				function-signature : 실행 코드를 가진 메소드의 시그니쳐 설정. 리턴타입 메소드명(아규먼트타입)
				
			
			
				
</pre>
</body>
</html>