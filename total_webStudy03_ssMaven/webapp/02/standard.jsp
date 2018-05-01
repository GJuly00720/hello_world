<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/standard.jsp</title>
</head>
<body>
<h4>JSP(Java(JSP) Server Page)</h4>
<pre>
	JSP? 자바를 기반으로 확장 CGI 방식의 서버사이드 모듈을 구성하기 위한 스크립트 언어.
		: 서블릿 스펙을 베이스로 동작하는 템플릿 구조를 가짐.
	
	JSP 소스의 표준 구성 요소
	1. 정적 텍스트 : 형태가 변형되지 않는 하드코딩 산출물 // 클라이언트 사이드 코드
				: 일반 텍스트, HTML, Javascript, CSS...
	-------------------------------------서버사이드 코드↓-----------
	2. 스크립틀릿(scriptlet) <% %> <% // **** 자바 코드 가 들어간다!!! ****
	//스크립틀릿 기호 안에 변수 선언하면 모두 지역변수가 된다. 스크립틀릿 기호 안에 선언과 작성을 하면 지역코드가 된다.
		int a = 4;
		System.out.println(a);
		if(true){}
		for(int i = 4; i < 6; i++){
			%>
			<%=i %>
			<%
		}
		Date today = new Date();
		System.out.println(global);
	%>
	3. 지시자(derective) <%--@ --%>
	<%--@ 지시자명 속성명="속성값"  --%> : JSP 페이지 자체에 대한 설정 정보.
		1) page(필수) : JSP 페이지 자체에 대한 설정 정보 (전처리 설정). //(package, import 같은 실행코드가 작성되기 전에 나오는 코드에 대한 부가적인 정보들)
					: 지시자의 속성을 설정하여 전처리를 함.
						- contentType : 응답데이터 MIME 설정
						- import : import 구문 완성
						- trimDirectiveWhitespace : 공백 제거
		2) include : 정적 내포
		3) taglib : 커스텀 태그 로딩.
		session 시간/통로
		buffer : 임시 저장공간 (응답데이터 전송속도 ↑. 8kb(변경가능))
	4. 표현식 <%--= --%>
		<%=32 %> <%="테스트" %> <%=today %> <%=new Date() %> 
		<%=getGlobal() %>
		: 응답 데이터로 값을 출력하기 위한 (자바)코드 (syso과 같고 syso은 콜솔에, 표현식은 응답데이터로)
	
	5. 선언부 <%! %>
	
	<%!//전역변수나 전역 메소드를 선언할 때 사용. //선언할때의 위치는 상관없다. 무조건 전역으로 빠짐. //요청을 하기전까진 인식못함.
	// 선언부로 선언한 전역변수는 객체 상태 공유가 제한적임
	// 따라서, 웹어플리케이션에서 상태공유를 위한 별도의 메모리공간(Scope)이 사용됨
		String global = "test";
		public String getGlobal(){
			return global;
		}
	%>
		: 스크립틀릿이나 표현식을 사용하는 경우에는 지역변수나 지역코드만을 작성. 지역으로 제한되지 않는 전역으로 필요할 경우에 선언부를 사용.
	6. 주석<%-- --%> 주석을 사용할때도 클라이언트인지 서버인지 주의가 필요.
		1) client side 주석 : 1. 보안에 취약, 응답데이터로 주석이 출력됨. 
							2. 주석때문에 데이터의 사이즈가 커짐.  
<!-- 			HTML주석 : -->
			<style type="text/css">
/* 					CSS주석 */
			</style>
			<script type="text/javascript">
// 			Javascript주석
			</script>
			
			
		2) server side 주석
<%--			JSP주석 --%>
			<%
			// java주석(싱글라인) /* */(멀티라인) /** */(javadoc 주석)
			 %>
	7. 기본객체 : 차후에 jsp에대해서 만들어 지는 jsp 소스 안에 있는 지역변수들.
		
	8. action 태그
	
	9. EL
	10. JSTL	
		
</pre>

</body>
</html>