<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<%
// 	response.setContentType("text/plain");  //타입안정성을 보장하기 위하여(name을 잘못입력하게되는경우)↓방법이 정석이긴 하다.
	response.setHeader("Content-Type", "text/html;charset=UTF-8");
// 	response.setIntHeader("Content-Length", 10);
%>
<!DOCTYPE html>
<html>
<head>

<title>03/responseDesc</title>
</head>
<body>
<h4>response 기본객체(HttpServletResponse)</h4>
<pre>
	: 서버에서 클라이언트로 전송될 응답과 관련된 모든 정보를 캡슐화한 객체.
	
	** HTTP 프로토콜에 따라 응답데이터가 패키징되는 규칙
	1. response Line : 응답상태코드, protocol 
		* 응답상태코드(response status code) : 요청 처리결과를 나타내는 세자리 숫자.
		1) 100 : ING..., 주로 websocket에서 사용되며, 현재 연결이 유지 중임을 나타냄.
		2) 200 : 정상처리 상황 (OK/SUCCESS)
		3) 300 : 처리가 완료되기 위해서는 클라이언트 쪽의 추가적인 동작이 필요한 경우.
				304(Not Modified): 
				302/307(Moved resouce): 클라이언트가 모르는 상태에서 주소를 요구함, 
				근데 그 주소가 이동했고 와있는 다른 주소가 얘 어디로 갔어요~ 하는 코드(...);  
		4) 400 : 에러를 유발시킨 원인 : 클라이언트측 문제로 인해 처리 실패
				404(File Not Found/Resource Not Found): 요청을 해당 서버에서는 처리할 방법이 없음.
				(요청에 대한 응답자체가 존재하지 않음.)
					↓아래의 에러들↓
				서버에서 보호중인 소스에 대해 접근하려 할때 개발자가 해당 에러를 뜨게 만들어줘야한다. 
				400(Bad Request): 정상적인 요청이 아님
				401(Forbidden): 접근할 수 없는 응답에 대해 접근하려 할 때
				403(UnAuthorized):  
				405(Method not serpported): 요청 메서드가 서버의 응답 메서드와 달라 응답이 불가하다. 
		5) 500 : 에러를 유발시킨 원인 : 서버측 문제로 인해 처리 실패
				500(Internal Servar Error)
				db가 죽어있을 경우,개발자의 코드오류(nullPoint,예외처리,컴파일에러..etc)
		** 상태 코드 제어 : response.setStatus(status_code), response.sendError(status_code)
					response.sendRedirect()-서버의 상태코드에 의해 구분
	2. response Header : 응답데이터에 대한 부가정보(name:value).
				!!body를 어떻게 써먹겠다(제어하겠다)는 정보!!
		1) mime 설정에 사용 : Content-Type
			- response.setHeader(name, value)
			- response.setContentType(mime-text)
			- page지시자의 contentType 속성
		2) 캐시 데이터 제어 : Pragma, Cache-Controll, Expires
			cache_control.jsp 참고
			response.setHeader, setDateHeader(name, value(long)), setIntHeader
									ㄴint,date로 나눠진 이유는 타입에 한정성을 주기위해
			response.addHeader(name, value) : 하나의 헤더(name)에 여러값을 설정
		3) 자동 요청을 발생시킬때 : Refresh 헤더 사용
			autoRequest.jsp 참고
			
		4) 페이지 이동 : 
		<a href="<%=request.getContextPath() %>/03/flowControl.jsp?minDan=2&maxDan=7">페이지이동 테스트</a>
		
		
	2. response Body : 실제 응답데이터가 전송되는 파트
		응답 데이터를 기록하기 위한 스트림 확보.
		- response.getWriter()
		- response.getOutputStream() 

</pre>
</body>
</html>