<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.util.CookieUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
   	Cookie[] logCookie = request.getCookies();
   %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>07/sessionTimer.jsp</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
<%
	String authId = (String)session.getAttribute("authId"); //
	if(authId!=null){//로그인한 회원
		%>
<script type="text/javascript">
	$(function(){
		var timerArea= $('#timerArea');
		var msgArea = $('#msgArea');
		var timeout = <%= session.getMaxInactiveInterval()%>-2; 
			//서버의 시간과 클라이언트의 시간에 차이가 있을 수 있기때문에 optional↑시간을 주는것이 안전
		var timer = timeout;
		msgArea.hide();
		var timerJob = setInterval(function(){
			timer--; //120 -> 2:00 //자바_스크는 기본적으로 double로 계산해준다.
			var min = Math.trunc(timer / 60);
			var sec = timer % 60;
			$('#timerArea')
			timerArea.html(min +":"+sec); 
			//$('#timerArea')이렇게 선택자 지정하면 1초에 한번씩 트레벌싱(탐색)해서 곤련선택자를 찾기때문에 긴로딩과 렉의 원인이 됨
			if(timer==0){ //0초가 되면
				clearInterval(timerJob) //인터벌메소드를 멈춰준다.
// 				location.reload();  //세션을 갱신
			//현재페이지는 유지한채로 리로딩되게 해야함 == 비동기유지...jquery ajax를 수업한 후 다시코딩
			}
		}, 1000)
		setTimeout(function(){
			msgArea.show();
		}, (timeout-60)*1000);
		$(".cmdBtn").on("click",function(){
			var btnId = $(this).attr('id') //prop는 id안의 속성을 꺼낼때
			if(btnId =="yesBtn"){//예버튼
				timer = timeout;
				msgArea.hide();
				location.reload();//새로고침 (=새로우 요청=세션연장.)
			}else if(btnId =="noBtn"){ //아니오버튼
				msgArea.hide();
			}
		});
	});
</script>
<%
	}
		%>
</head>
<body>
<h4>세션 타이머</h4>
<%
	if(authId!=null){
%>
<!-- 다음 타이머 기능은 로그인 한 경우에만 실행 되도록.. -->
현재 세션의 남은 시간<div id="timerArea"></div>
<div id="msgArea" >
	남은 시간이 1분입니다. 연장ㄱㄱ? <br/>
	<input type="button" value="예" class="cmdBtn" id="yesBtn"/>
<!-- 	서버에서도 세션연장 (페이지 리프레쉬) -->
	<input type="button" value="아니오" class="cmdBtn" id="noBtn"/>
<!-- 	시간은 계속 흐름 -->
</div>
<%
	}else{
		out.println("<a href='"+request.getContextPath()+"/login/loginForm.jsp'>로그인</a>");
	}
%>
</body>
</html>