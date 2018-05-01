<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.DataBasePropVO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Objects"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>08/dbProps.jsp</title>
</head>
<body>
<%
	//	검색기능
	request.setCharacterEncoding("UTF-8");	//지금 get방식이라 사용불가한 메서드지만 
											//우리는 서버에 설정(usebodyEncordingTo = true)을 추가해놨기 떄문에 사용가능.
	String keyword = request.getParameter("keyword");
	List<DataBasePropVO> list =null;
	String[] headers = null;
	//언제든 바뀔가능성 있는 정보와 불변할 정보가 한소스 안에 있다. //책임분리의 원칙 안지킴
// 		String url = "jdbc:oracle:thin:@localhost:1521:XE";
// 		String user = "PC13";
// 		String password = "java";
		
// 		Class.forName("oracle.jdbc.driver.OracleDriver"); // 한번만 로딩하면 되는데 스크립틀릿기호 안에있어서 지역변수화 되어있어서 여러번 로딩하게 되어있음.(메모리스캔하는 시간적 낭비) //그래서 바보같은 코드임. 
		//오라클 드라이버를 로딩을 위해 해당 주소의 해당 드라이버를 받아옴.콸러파이드 네임으로.
		//그래서 init()에 넣는다. 서버가 켜질때 한번만 실행되게 
		
		Map<String,Object> pMap = new HashMap<String,Object>();
		pMap.put("keyword",keyword);
// 		DataBasePropsDAOImpl dbDao = new DataBasePropsDAOImpl(); 출력을 위해  db를 사용하는 객체 말고 서비스 객체를 사용하는 녀석으로 변경
// 		DataBasePropsServiceImpl service = new DataBasePropsServiceImpl();
		IDataBasePropsService service = new DataBasePropsServiceImpl();
// 		list = dbDao.selectDataBaseProps(pMap);
		list = service.retrieveDBProps(pMap);
		headers = (String[])pMap.get("header"); 
		
%>
<form>
	<input type="text" name="keyword" value="<%=Objects.toString(keyword, "") %>"/>		
<!-- 												1.8부터 나온 값을 받아서 nullDefault : 널일겨우 보여줄것을 입력해줌.. -->
	<input type="submit" value="검색"/>
</form>
<TABLE>
<thead>
	<tr>
		<th>프로퍼티 명</th>
		<th>프로퍼티 값</th>
		<th>설명</th>
		<%-- 
			for(String header : headers){ // 출력 값의 확실성을 줬기 때문에 이렇게 줄 필요가 없다.
				out.println(
					String.format("<th>%s</th>",header)
					);
			}
		--%>
	</tr>
</thead>
<tbody>
<%
	if(list.size()>0){
		for(DataBasePropVO vo : list){
			out.println("<tr>");
// 			for(Entry<String,Object> entry: map.entrySet()){
				out.println( 	//순서대로 출력하겠다는 확실성을 줬다.
					String.format(("<td>%s</td>"),vo.getProperty_name())
				);
				out.println(
					String.format(("<td>%s</td>"),vo.getProperty_value())
				);
				out.println(
					String.format(("<td>%s</td>"),vo.getDescription())
				);
// 			}
			out.println("</tr>");
		}
	}else{
		out.println("<tr><td colspan='3'>검색조건에 해당 ㄴㄴ</td></tr>");
	}
%>

</tbody>
</TABLE>
</body>
</html>