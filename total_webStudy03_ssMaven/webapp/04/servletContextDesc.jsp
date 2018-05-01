<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/servletContextDesc.jsp</title>
</head>
<body>
<h4>application 기본객체(servletContext)</h4>
<pre>
	Context (상황/문맥/맥락) : 타겟과 관련된 모든 정보를 가진 객체 : 서블릿을 둘러싼 모든 어플리케이션에 대한 정보(서블릿이 돌아가는 서버에 관한정보 추출가능)
							ㄴ = servlet
			: servlet 이 운영되고 있는 환경에 대한 정보를 가진 객체(서버+어플리케이션)
			<%=application.hashCode() %>
		기능 
		1. 서버의 정보 확보
			<%=application.getServerInfo() %>  ::  &lt;- 서버의 정보 추출
			<%=application.getMajorVersion() %>.<%=application.getMinorVersion() %>  :: 서블릿 스펙 추출확인 가능
				서블릿 2.0과 3.0은 많이 다름. api가 해당 스펙에서 사용 가능한지 확인 필요.
			<%=application.getMimeType("test.jpg") %>  ::  argument로 파일의 명을 주면 Mime을 감지하여 그 Mime을 리턴값으로 준다.(그파일이 존재하는지 안하는지 )
		2. 웹어플리케이션을 대상으로 전달되는 컨텍스트 파라미터 확보(web.xml)
									(파라미터 : 특정 '타겟'을 향해 전달되는 값)
									컨텍스트 = 웹어플리케이션
									컨텍스트 파라미터는 특정 웹어플리케이션을 향해 넘어가는 값.
														ㄴ안에서라면 어디서든 가능 :: 동일한 값을 공유 :: 
									개발자가 web.xml을 통해 설정 후 
				<%=application.getInitParameter("param1") %>  :: web.xml 에 설정해놓은 초기화 parameter 
						
		3. 어플리케이션에서 로깅을 할 때 :: (로그를 기록하는 행위 : 로깅) : 
				syso=(휘발성)현재플로우를 타고도 출력하려는 값이 정상적으로 나오는가를 확인하기위해
				syso:과 
				<% application.log("출력되는가..."); %>  :: 분석 을 위한 것. 
		4(***). 웹 리소스를 확보	:: 변경가능성이 있는 정보들을 직접 입력하지 않고 파라미터로 입력될 수 있다.
				ㄴ 웹리소스:웹이라는 공간을 통해 주소로 접근 가능한 :url소지, 웹에서 접근 가능.
				/ 파일시스템리소스 : 웹 공간말고 파일시스템상의 주소를 통해 접근가능한.
				파일 시스템 경로 받아옴  getRealPath(url :서버사이드 경로 표기)
				입력스트림 개방해서 리턴 getResourceAsStream(url)
		<%= application.getRealPath("/images/Jellyfish.jpg") %> ::(url)을 주면 realpath경로를 준다.			
		<%
//		/images/Jellyfish.jpg 파일에 대한 입력 스트림. 				
		String fileSystemPath = application.getRealPath("/images/Jellyfish.jpg"); //서버사이드 절대경로
// 															서버사이드에선 컨텍스트명 미포함. 
		File srcFile = new File(fileSystemPath);
// 		/04 폴더에 대한 파일 객체
		File folder = new File(application.getRealPath("/04"));		
// 		복사할 때 사용할 이름.
// 		File targetFile = new File(folder.getName());
		File targetFile = new File(srcFile.getName());
// 		저장위치와 이름을 묶어서 생성한 파일 객체 -> 출력 스트림
		try(
// 		InputStream fis= application.getResourceAsStream("/images/Jellyfish.jpg"); /*url주시오..*/
		FileInputStream fis = new FileInputStream(srcFile); /*파일의 경로*/
// 													ㄴurl로 경로를 알아오는 것. 파일시스템의 경로르 상대적으로 알아온다..?				
		FileOutputStream fos = new FileOutputStream(targetFile);
		){
// 		스트림 카피
		byte[] buffer = new byte[1024];
		int pos = -1;
		while((pos = fis.read(buffer))!=-1){
			fos.write(buffer);
		}
		out.println("복사완료");
		}
		%>
	<%=pageContext.getAttribute("pageAttr")	%> 페이지 이동됨
	<%=request.getAttribute("requestAttr")	%> 요청이 새로 발생됨
	<%=session.getAttribute("sessionAttr")	%> 만료기간 안지났음
	<%=application.getAttribute("applicationAttr")	%> 서버 살아있음.
</pre>
<footer>
	저작권 : 205호
	담당자 : <%=application.getInitParameter("manager") %>   ::web.xml에 설정하여 4.웹  리소스확보 가능
</footer>
</body>
</html>