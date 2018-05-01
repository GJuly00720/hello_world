<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<h4></h4>
	<pre>
	(단계를  정확하게 이해하자.)
	1. 벤더로부터 제공받은 드라이버를 빌드 패스에 추가()
	2. Class.forName을 이용해서 드라이버를 로딩(드라이버클래스를 로딩)
	3. DriverManager 를 이용해서 로딩된 드라이버를 통해 Connection 생성.
	** DataSource를 활용하는 경우, 2,3번이 통합됨.//드라이버 로더 사용할 피료엉ㅄ다. &lt;-드라이버 로더방식을 하면 로딩이 됬는지 확인이 어려움.
	//한번만 로딩되면 되니까 db드라이버로더로 옮김.
	4. Connection을 통해 Query객체를 생성 
		↓(명확한 구분 필요 ****)
		1) Statement : 동적 쿼리 실행. (이 쿼리에 대해생성된 쿼리가 실시간으로 변경, 적용 가능.//미리 쿼리문의 준비가 x)
		2) preparedStatement : 선컴파일된 쿼리 객체, 정적 쿼리실행(런타임시 쿼리문 변경불가./미리 준비된 쿼리가 있음.)
								쿼리 파라미터를 사용한 데이터 변경은 가능.
		3) CallableStatement : Function/Prodedure (데이터베이스 내부에서 돌아갈수 있는 절차적 로직 실행가능.)을 호출 할 때 사용.
	5. 쿼리 실행
		1) ResultSet executeQuery : select쿼리
		2) int executeUpdate : insert/update/delete 등의 갱신쿼리 
		(갱신된 쿼리의 갯수를 말함 _ 으로 갯수를 확인함으로 db갱신이 바르게 됬는지 확인 가능.)
	6. ResultSet(결과집합) 사용
	7. close(closable 객체)
		** SQLException 발생가능.	 
		
	</pre>

</body>
</html>