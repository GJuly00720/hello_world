<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!static enum SystemType {
		WINDOW("데스크탑(Window)"), ANDROID("모바일(Mobile)"), IPHONE("모바일(애플)"), MAC(
				"모바일(애플)"), IOS("모바일(애플)"), ANONYMOUS("anonymous context");
		private String systemInfo;

		SystemType(String text) {
			systemInfo = text;
		}

		public String getSystemInfo() {
			return this.systemInfo;
		}
	}

	static enum BrowserType {
		CHROME("크롬"), FIREFOX("파이어 폭스"), TRIDENT("익스플로러(10이후)"), MSIE(
				"익스플로러(10이전)"), NONAME("noname");
		private String browserName;
		BrowserType(String text){
			browserName=text;
		}
		public String getBrowserName(){
			return browserName;
		}
	}%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/semUserAgent</title>
</head>
<body>
<!-- 클라이언트가 모바일을 사용한다면, -->

<!-- 클라이언트가 크롬을 사용한다면, -->

<!-- 클라이언트가 파이어폭스를 사용한다면, -->

<!-- 클라이언트가 익스플로러를 사용한다면, -->

<!-- 최종 출력메세지 "당신의 접속 환경을 데스크탑이고, 사용 브라우저는 크롬 입니다."; -->
<!-- 최종 출력메세지 "당신의 접속 환경을 anonymous context이고, 사용 브라우저는 noname 입니다."; -->
	<%=request.getHeader("User-Agent")%>
	<%
		String userAgent = request.getHeader("User-agent").toUpperCase();
		SystemType[] systemTypes = SystemType.values();
		SystemType findedType = SystemType.ANONYMOUS;
		for (SystemType type : systemTypes) {
			if (userAgent.contains(type.toString())) {
				findedType = type;
				break;
			}
		}
		BrowserType[] browserTypes = BrowserType.values();
		BrowserType findedBrowser = BrowserType.NONAME;
		for(BrowserType type:browserTypes){
			if(userAgent.contains(type.toString())){
				findedBrowser = type;
				break;
			}
		}
	%>
	당신의 접속환경은 <%=findedType.getSystemInfo() %>이고
	사용 브라우저는 <%=findedBrowser.getBrowserName() %>이다....ㅇ&lt;-&lt;
</body>
</html>