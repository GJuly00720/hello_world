<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>10/elCollectionAccess.jsp</title>
</head>
<body>
<h4> EL 에서 집합객체의 접근 방법 </h4>
<pre>
<%
	String [] array = {"ele1", "ele2", "ele3"};
	pageContext.setAttribute("array", array);
	
	List<String> sampleList = new ArrayList<>();
	sampleList.add("listEle1");
	sampleList.add("listEle2");
	sampleList.add("listEle3");
	request.setAttribute("sampleList", sampleList);
	
	Map<String, Object> sampleMap = new HashMap<>();
	sampleMap.put("key1", "value1");
	sampleMap.put("key2", "value2");
	sampleMap.put("key-3", "value3");
	sampleMap.put("key-4", array);
	pageContext.setAttribute("sampleMap", sampleMap);
	
	Set<String> sampleSet = new HashSet<>(); //순서x, 중복비허용
	sampleSet.add("selEle1");
	sampleSet.add("selEle2");
	sampleSet.add("selEle2");
	sampleSet.add("selEle3");
	pageContext.setAttribute("sampleSet", sampleSet);
	
%>
	1. 배열
		<%=((String[])pageContext.getAttribute("array"))[1] %>, ${array[1] }
		<%--=((String[])pageContext.getAttribute("array"))[4] --%>, ${array[4] } //출력전 연산,흐름제어가능 , 값을 출력만 가능. 대부분의 Exception은 공백으로 변환된다.
		<%--=((String[])pageContext.getAttribute("arrays"))[1] --%>, ${arrays[1] }
		
	2. 리스트
		<%=((List)request.getAttribute("sampleList")).get(1) %> 
		, ${sampleList.get(1) } // 자바객체의 메소드 호출.//2.5까지 불가.이후 가능. , ${sampleList[1] }
		<%--=((List)request.getAttribute("sampleList")).get(4) --%> 
		, \${sampleList.get(4) } , ${sampleList[4] } exception발생대신 공백으로 출력되기때문에 이형식이 더 많이 사용된다.
		
	3. 맵
		<%= ((Map)pageContext.getAttribute("sampleMap")).get("key2") %>
		, ${sampleMap.get("key2") }, ${sampleMap.key2 }
		<%= ((Map)pageContext.getAttribute("sampleMap")).get("key-3") %>
		, ${sampleMap.get("key-3") }, ${sampleMap.key-3 } , ${sampleMap["key-3"] } //←연산(연관)배열 구조 // 2.5이전에 사용됨. 
									// ↑산술연산자가 우선적으로 판단됨.// key라는 속성을 찾았으나 없으므로 0으로 치환후 연산.
		<%=((String[])((Map)pageContext.getAttribute("sampleMap")).get("key-4"))[1] %>
		, ${ sampleMap["key-4"][1] }
		
	4. 셋(Set)
		<%= pageContext.getAttribute("sampleSet") %>, ${sampleSet } --통으로 사용 하나씩 사용하려면. JSTL 필요  
</pre>
<script type="text/javascript"> 
	var sampleMap = {};
	sampleMap.key1 = "value1";
	sampleMap.key2 = "value2";
	sampleMap["key-3"] = "value3";
	alert(JSON.stringify(sampleMap)); // stringify 마샬링 가능.
</script>
</body>
</html>
















