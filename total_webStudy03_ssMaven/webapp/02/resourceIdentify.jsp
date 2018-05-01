<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/resourceIdentify.jsp</title>
</head>
<body>
<h4> 네트웤 상의 자원을 식별하는 방법 </h4>
<pre>
	네트워크 주소 체계 : IP v4 -> IP v6
	인간이 인지할수 있는 주소 체계 : DNS(Domain Name)
	ex) www.naver.co.kr	=> 4레벨 구조 == NTLD(National Top Level Domain) :범국가적
	  HostName/실질적 도메인,기업,회사/비영리인지 영리인지/국가
		->			->			->			-> 포함(하위레벨이 상위레벨에 소속)
		www.naver.com => 3레벨 구조 == GTLD(Global Top Level Domain) :전세계적 
	하위 레벨 도메인은 상위 레벨에 포함구조를 갖는다.	
		
	특정 서버내의 자원을 식별
	URI(Uniform Resource Identifier) : 네트워크에 흩어져있는 도메인들을 식별하는 방법(경로표시없이도 식별자를 통해 식별)
	: URL + URN(name) + URC(content)	ㄴ가상의 주소
	URL(Uniform Resource Locator) : 위치를 기반으로 분류(xml에 들어가있는 것(목록)을 기반으로 찾아낼수있다.(uri))
	ex) http://www.naver.com[= IP도 가능]:port_number/context1/depth1/filename
		ㄴ뎁스구조
	ex) http://localhost/webStudy01/02/gugudan.jsp  <- URL
	ex) http://localhost/webStudy01/gugudan  <-URI
	

	웹리소스/파일시스템리소스 = 경로를 찾는 방법이 달라지ㅐㅁ.
	
	자원을 식별하기 위한 방법
	1. full path 를 모두 기술한 절대경로 표기방식 //주소가 서버가 쓰는건지 클라이언트사이드에서 쓰는건지 꼭!!!구분해야함!!
	 	ex)http://localhost/webStudy01/images/Jellyfish.jpg (이런 fullpath는 많이 사용 안한다. : 하드코딩하면 나중에 바꿀때 어려우니까.)
	 	1) 클라이언트 사이드 절대경로 표기방식 
	 		**********context name 부터 나오고***(도큐먼트 도메인이 갖고있는건 localhost(도메인)밖에 없으니까!!) 
	 		이후의 모든 depth 구조를 표기하는 방식.
	 		ex)/webStudy01/images/Jellyfish.jpg
	 	2) 서버사이드 절대경로 표기방식 : context name 이 포함되지 않음. 이후의 구조만 표기. 
	 	(xml에 표기할때 위에방식처럼 컨텍스트 네임까지 표기한다면 서버는 이미 알고잇는데 한번 더 나오는거니까 오류가 뜬다.)
	 		ex)/images/Jellyfish.jpg
	2. 상대경로 표기방식 : 상대경로의 기준위치는 현재 브라우저의 주소입력창의 기준으로 경로를 판단.
	 	ex)http://localhost/webStudy01/02/resourceIdentify.jsp
	 		ㄴ의 기준위치 를 기준점. (브라우저의 location...?)
</pre>
<img src="http://localhost/webStudy01/images/Jellyfish.jpg"/> 
<!-- ㄴ절대경로 -->
<img src="<%=request.getContextPath() %>/images/Jellyfish.jpg"/>
<!-- 도큐먼트의 도메인이 갖고있는 주소  -->
<img src="../images/Jellyfish.jpg"/>
<!-- 상대경로  -->
</body>
</html>