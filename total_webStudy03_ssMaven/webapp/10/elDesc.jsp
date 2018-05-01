<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>10/elDesc.jsp</title>
</head>
<body>
<h4>EL(표현언어, Expression Language)</h4>
<pre>
	: 영역을 통해 공유되는 속성 값을 출력하기 위하 목적으로 사용하는 스크립트 언어
	\${[영역(pageScope|resquestScope|sessionScope|applicationScope).]속성명 } == \${EL변수명 }
	<%
		String test = "test";
		pageContext.setAttribute("tests", test);
		request.setAttribute("tests", "리쿼스트에 있는 tests");
		request.setAttribute("requestAttr", "리퀘스트 속성");
		session.setAttribute("sessionAttr", "세션 속성");
		application.setAttribute("applicationAttr", "어플리케이션 속성");
	%> 
	표현식 : <%=test %>, 표현언어 : ${tests }
	<%=pageContext.getAttribute("tests") %> ,${tests }
	<%=pageContext.getAttribute("test") %> ,${test }
	<%=request.getAttribute("requestAttr") %> , ${requestAttr }
	<%=request.getAttribute("tests") %> , ${requestScope.tests}
	<%=session.getAttribute("sessionAttr") %> , ${sessionAttr }
	<%=session.getAttribute("sessionAttr") %> , ${sessionScope.sessionAttr }
	<%=application.getAttribute("applicationAttr") %> , ${applicationAttr }
	<%=application.getAttribute("applicationAttr") %> , ${applicationScope.applicationAttr }
	
	EL이 제공하는 기능.
	1. 속성 데이터를 출력
	2. (속성 데이터에 대한 )연산자 제공
		1) 산술연산자 (+-*/%) //+문자열을 연결해주는 컨켓연산자로의 기능은 하지 않는다.
			${"3"+4 } //숫자로 parsing후 연산해벌임. ,\${"a"+5 } //산술연산만을 수행한다.
			<%
				int sampleNum = 7;
				request.setAttribute("sampleNum", sampleNum);
			%>
			,${sampleNum * 6 } // 스코프를 뒤졌지만 없는 속성명이였기때문에 sampleNum을 0으로 변경해버림.
			,${sampleNum - 0 } //
		2) 논리연산사 (and, or, not)
			and/or - short circuit(단축) 연산자 &lt;
			${ true and true } ${ true or false }  ${ not true }
			${ true and sampleOp } ${ true or sampleOp } \${ not sampleNum }
			//EL에선 피연산자의 타입보단 연산자의 타입이 우선된다.
		3) 비교연산자(&gt;,&lt;,==,&gt;=,&lt;=)
			${ 4 lt 3 } ,  ${ 4 gt 3 } , ${ 4 ge 3 } greatest than equel, ${ 4 le 3 } less than equel, 
			${ 4 eq 3 } equel, ${ 4 ne 3 } not equel,
			${ 4 lt testNum } // 해당 속성명이 없기때문에 앞의 피연산자의 타입에 맞춰 해당 변수의 타입을 만들어준다.
			${ 4 lt "3" }
		3) 단항연산자 !(not), empty( 있나 없나보고 있다면, 비어있는지(null) 여부 판단, type을 본후 , size or length를 봄. T/F)
			<%
				pageContext.setAttribute("nonattr", "   ");  
				List sampleList = new ArrayList();
				sampleList.add("testsss");
				pageContext.setAttribute("sampleList", sampleList);
			%>
			${ empty nonattr } 
			${ empty sampleList }
			empty 연산자의 동작 단계
			a) 속성의 존재여부 판단 : 존재하지 않는다면, true
			b) null 여부 판단 : null이면, true
			c) 타입을 체크, length/size 호출하여 결과 판단
			
		4) 삼항연산자 ( 조건? 참 문장 : 거짓 문장 )
			${ sampleNum gt 6 ? "참":"거짓" }
			${ not empty testNum ? "있다":"없다" }
			
	3. (속성으로 공유되는 )집합 객체에 대한 접근방법을 제공
	4. (속성으로 공유되는 )자바 객체의 메소드를 호출(since servlet spece 3.0) //자바빈규약을 기반을 사용.
	<jsp:useBean id="member" class="kr.or.ddit.vo.MemberVO" scope="request"></jsp:useBean>
	<%
		member.setMem_id("a001");
		member.setMem_name("김은대");
	%>
	<%=member.getMem_name() %>
	<jsp:getProperty property="mem_name" name="member"/>
	${ requestScope.member.getMem_name() }
	${ requestScope.member.mem_name } //2.5 이전. //getter호출 //자바빈규약을 역으로 이용.
	<%=member.getTestel() %>, ${member.testel } //getter를 호출하는 코드. //최초의 요청이 들어왔을 시 자바소스로 변하며 그때 getter를 호출하는 코드로 사용된다.
	
	5. EL 기본 객체 제공.
	pageScope, requestScope, sessionScope, applicationScope 를 비롯한 총 11한개의 객체
</pre>
</body>
</html>



















