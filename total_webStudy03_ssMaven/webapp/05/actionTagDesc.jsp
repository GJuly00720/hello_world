<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>05/actionTagDesc.jsp</title>
</head>
<body>
<h4>JSP 액션 태그(Action Tag)</h4>
<pre>
	: 일종의 커스텀 태그로 JSP 스펙에 따라 WAS에 의해 기본제공되는 커스텀 태그.
	커스텀 태그의 형태 : 
	&lt;prefix:tagname attribute_name="attribute_value" ...... &gt;
	
	JSP 액션태그의 형태 : 가독성, 서버사이드 코드를 몰라도 사용이 쉽다.
	&lt;jsp:tagname attribute.... /&gt;
	
	종류
	1. forward : RequestDispatcher 의 forward 와 동일한 방식의 흐름 제어
	2. include : RequestDispatcher 의 include 와 동일한 방식의 흐름 제어
	-EJB규약..
	<%--
// 		pageContext.forward("/02/gugudan.jsp");
	--%>
	스크립틀릿 기호보다 액션태그가 가독성이 더 좋다.
	↓
<%-- 	<jsp:forward page="/02/gugudan.jsp" > --%>
<%-- 		<jsp:param value="2" name="minDan"/> --%>
<%-- 		<jsp:param value="7" name="maxDan"/> --%>
<%-- 	</jsp:forward> --%>
	
<%-- 		<jsp:include page="/02/gugudan.jsp" > --%>
<%-- 			<jsp:param value="2" name="minDan"/>  --%>
<%-- 			<jsp:param value="7" name="maxDan"/> --%>
<%-- 		</jsp:include> --%>
	3. useBean, setProperty, getProperty...
	&lt;jsp:useBean class="객체타입" id="변수명 && 속성명" scope="객체를 공유할 영역" &lt; 
				: JavaBean 객체를 스크립틀릿 기호를 사용하지 않고, 생성 할 수 있도록 지원하는 태그
				* JavaBean 객체 : JavaBean 규약에 따라 선언되고, 재활용 가능 객체.
	&lt;jsp:setProperty name="javaBean 객체가 공유될 때의 속성명" property ="객체의 프로퍼티 명||*" &lt; 
				: JavaBean 객체의 setter를 호출하기 위한 태그
				:" * ": property값으로 사용하는 경우,
						property명과 parameater명이 동일한 경우 자동 바인드. 
	&lt;jsp:getProperty &lt; :
				: JavaBean 객체의 특성을 이용한 getter를 호출하고 출력하는 태그 
	
	<jsp:useBean id="member" class="kr.or.ddit.vo.MemberVO" scope="request" ></jsp:useBean>
	<jsp:setProperty property="*" name="member" param="mem_id"  />
	<jsp:getProperty property="mem_id" name="member"/>
	<%--
		MemberVO member = (MemberVO)request.getAttribute("member"); 
		if(member==null){
			member= new MemberVO();
			request.setAttribute("member", member);
			member.setMem_id("a001");
		}
			member.serMem_id(request.getParameter("mem_id")); <- param
			out.println(member.getMem_id()); //꺼내고 바로 출력
	--%>
	//자바빈 규약 이해!!!!!!!!!!!!!!!!!!!!!!!
	//자바빈 :: 객체 지향적을 작성되어있어 언제든 사용가능한 객체 (모든 객체들 상징) 
	//스크립틀릿 기호 없이도 자바코드를 사용할 수있는 것. 클래스만들어주고 변수도 선언해줌.
	// 스코프. 빈이 생성, 스코프를 통해 공유, 속성명은 id로 공유됨. 생성된 객체를 특정 스코프로 관리되게 해줌.
	// 해당 스코프안에 빈으로 만든 변수명의 객체가 있다면 원래 있는 것으로 갖고와서 해줌. 없으면 만들어주고! 개쩌는군;;;
<%-- 	<jsp:useBean id="변수명" class="해당 객체만들어짐"></jsp:useBean> --%>
<%-- 	<jsp:setProperty property="mem_id 이름의 새터생성" name="member" value="a001라는 값을 넣어줌" param="mem_id"/>  setter를 만들어줌.--%>
																param으로 설정해주면 req에 있는 파람 저이름을 뽑아줌 오 ㄹ 개쩌네;;
							property="*" member에 전부를 뒤져 param을 찾아봄. 없으면 memberVO에 자동 생성. 
<%-- 	<jsp:getProperty property="mem_id" name="member"/>  getter --%>
</pre>
</body>
</html>