<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>09/iBatisDesc.jsp</title>
</head>
<body>
<h4> iBatis </h4>
<pre>
	iBatis ? SQLMapper : 쿼리를 실행하기 위한 기반 객체를 생성.(IoC패턴 = DI패턴)_의존해야하는 객체가 iBatis내부에서 생성.
															//패턴적용여부에 따라 lib인가 framework인가 
															제어권이 프레임웤쪽에 있다(개발의 순서를 지켜야 한다.) IoC패턴.
			DataMapper : Relation &lt;-&gt; Java Object mapping
			ORM Framework : Object Relation Mapping (개발자가 쿼리안짬.)
			Persistence Framework : Persistence Layer 를 지원하는 프레임웤.
			
	사용 단계
	1. jar 파일을 build path에 추가
	2. 설정 파일
		1) 환경 설정 : SqlMapConfig.xml...
			properties : resource(classpath 기준경로)
			settings
			typeAlias : 여기에하면 한번만 등록하면 된다.
			transactionManager(dataSource :- Simple/DBCP/JNDI)
			sqlMap : resource(classpath 기준경로)
		2) 매퍼 설정 :  member, xml... 
	3. SqlMapClient 객체 생성(싱글턴): SqlMapClientBuilder 사용(시글턴 아닌 멀티인젝션으로 만들면 트랜젝션 관리가 안됨.)
	4. Persistence Layer 에서 3번 객체 사용.
			sqlMapClient.쿼리실행메소드("쿼리아이디",parameterClass 타입의 객체)
			** insert 쿼리 실행
			1) Object insert : selectKey 엘리먼트 사용되는 경우, 
								PK를 직접 생성해줘야하는 경우,
								selectKey 내부에서 생성된 PK가 반환됨.
			2) int update/delete : update or delete 된 수를 rowCnt로 리턴.
			
	** iBatis를 이용한 멀티테이블 조인
	1) 메인데이터를 가진 테이블을 기준으로 각테이블의 관계 파악
		ex) 한명의 회원의 기본정보와 그 사람이 그동안 구매한 상품의 목록을 조회.
		Member(메인데이터 테이블)/Prod : 1:N구조 (회원은 한명(반드시있음)/구매목록은 여럿(있을수도 없을수도)) :부모는 하나 자식은 여럿.
		한곳에 거래처에 대한 기본 정보와 그 거래처와의 거래물품 목록을 조회.
		Buyer(메인데이터 테이블)/Prod : 1:N구조 
		상품의 기본정보를 조회할때 그 상품의 거래처 정보까지 함께 조회
		Prod(메인데이터 테이블)/Buyer : 1:1구조
	2) 테이블의 관계를 DomainLayer(VO)들 사이에 관계로 반영
		1:N -> has Many 관계
			MemberVO has Many ProdVO (prodList)
			Buyer has Many prodVO
		1:1 -> has A 관계
			ProdVO has A BuyerVO
	3) resultMap 사용
		1. nested Map(중첩맵) 방식 : 개발자가 테이블을 직접 조인하는 경우.
		2. nested Select(중첩셀렉트) 방식 : 각 테이블의 조회쿼리를 별도 작성하고, 
										iBatis의 내부적인 설정으로 조인하는 방식
</pre>
</body>
</html>