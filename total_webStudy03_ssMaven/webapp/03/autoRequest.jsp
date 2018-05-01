<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!-- <meta http-equiv="Refresh" content="1" /> -->
<title>03/autoRequest.jsp</title>
</head>
<body>
<h4>주기적인 자동 요청의 발생(Refresh 헤더)</h4>
<script type="text/javascript">
	var timer = null;
	var tmout = window.setTimeout(function(){
		console.log("timeout 으로 출력하는 텍스트");
		window.location.reload();
	} , 5000);
	var interval = window.setInterval(function(){
		var now = new Date();
		if(timer){
			timer.innerHtml = now;
		} 
		console.log("Interval 으로 출력하는 텍스트");
	}, 1000);
	function clickHandler(){
		clearTimeout(tmout);
		clearInterval(interval);
	}
</script>
<pre>
1. 서버 사이드 코드
	서버의 현재 시간 :<%=new Date() %>
	<%--
		response.setIntHeader("Refresh", 60);
	--%> 
2. 클라이언트 사이드 코드
	1)HTML : meta 태그의 http-equiv 속성을 통해 응답 헤더를 설정.
	<!-- <meta http-equiv="Refresh" content="1" /> -->
	
	2)javascript : scheduling 함수
		setTimeout : 일정시간동안 아무것도안하고 기다리다가 입력된 행위를 실행을 하고 끝낸다.
		setInterval : 일정기간마다 행위를 반복한다.
		<input type="button" value="작업종료" onclick="clickHandler()"/>
		클라이언트의 현재 시간 : <span id="timer"></span>

</pre>
<script>
	timer = document.getElementById("timer");
// 	var timer = document.getElementById("timer"); 
	//↑전역으로 선언되어있고 window가 갖고있는 timer. function밖에 있지만 사용가능 하긴한데 body에 엘리먼트가 많다면 실행 불가
</script>
</body>
</html>