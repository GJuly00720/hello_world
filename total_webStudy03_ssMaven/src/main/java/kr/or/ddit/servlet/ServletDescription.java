package kr.or.ddit.servlet;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 서블릿(Servlet)
 * :자바기반의 스펙이면서, 확장 CGI 방식의 서버사이드 모듈을 개발하기 위한 스펙
 * 	동시에 서블릿 스펙에 따라서 개발된 운영 객체(즉 개발이 되고서 실제 서버에서 운영되고 있는 객체)/중의적의미갖는다.
 * 서블릿을 개발하고 운영하기 위한 환경
 *  : JRE(JVM)/자바기반 + WAS(Web Application Server/(Tomcat, Jeus, WebSphere, WebLogic, Resin)) + JDK
 *
 * 서블릿 운영 환경에서 WAS의 역활 : 
 * 	1. 클라이언트의 요청 리스닝(요청을 대기해주는 역활)
 *  2. 서블릿의 라이프사이클을 관리(서블릿의 객체 생성~ (요청에따른 행위?) ~소멸)
 *  	** 콜백(CallBack) 선언은 개발자가 호출은 시스템(WAS)이
 *  		: 특정한 이벤트가 발생하면 시스템(WAS)에 의해서 자동으로 호출되는 구조 (onclickAction, doGet )
 *  	1) 초기화 : init(ServletConfig)
 *  			: 특별한 설정(load-on-startup/서블릿 객체설정에 순서를 줄수있다.)이 없는 한 
 *  				서블릿에 대해 최초의 요청이 들어오면 순서대로 객체 생성.(후에 init메서드 생성)
 *  			: 서블릿의 객체관리 특성 : WAS는 기본적으로 서블릿을 싱글턴으로 관리함(처음 한번만 실행후 이후엔 )
 *  			ServletConfig : web.xml을 통해서 서블릿을 등록하고 매핑설정한 정보들을 캡슐화한 객체
 *  						:서블릿의 초기화 파라미터를 확보할 때 사용.
 *  	2) 요청 : service(), doXXX
 *  			a) sevice : 현재 프로토콜의 http method를 판단하고, 관련된 콜백(메소드)을 호출하는 역활.
 *  			b) doXXX : service가 http method 에 따라 호출하는 콜백 메소드(필요한 요청에 대해서만 수행하는 메서드)
 *  					(구분을 하지 않으려면 service를 오버라이드하면된다.(그럼 알아서 필요한걸 부르겠지..))
 *  											ㄴ하면 모든 메서드와 무관한 행위를 하기위함.
 *  											ex) usebody캐릭터셋같은 중복코드에 대한 예방.
 *  												
 *  			** Http method의 종류 : Get, POST, PUT, DELETE, OPTION, HEAD, TRACE
 *  			** HTTP(Hyper Text Transfer Protocol)
 *  			: 웹상에서 요청과 응답데이터를 패키징하는 규칙성에 대한 정의
 *  			Request 패키징
 *  			1) Request Line : Method URL Protocol/versionInfo
 *  				Method : 클라이언트가 요청을 발생시킨 목적, 요청의 포장 방식
 *  			Get : 조회, 웹에서 대부분의 요청은 기본적으로 GET메소드 사용.
 *  					Request Body 영역이 생성되지 않음.
 *  			Post : 등록, 클라이언트에서 서버로 일정정보가 전달되기 때문에 Request Body영역 생성.
 *  			Put : 갱신
 *  			DELETE : 삭제
 *  			2) Request Header : 클라이언트와 요청에 대한 구체적인 부가 정보(메타데이터)들이 들어감
 *  				((body에 들어가는 데이터에 대한)MIME, 컨텐드의길이, ip, 클라이언트에 대한 정보) 
 *  			3) Request Body : 클라이언트가 서버로 전달하는 컨텐츠(데이터) 영역
 *  	3) 소멸 : destroy
 * 
 * 	서블릿 개발 단계
 * 1. HttpServlet 을 상속한 서블릿을 정의
 * 2. 컴파일 : 바이트코드는 /WEB-INF/classes에 정의 (classPath에 등록)
 * 3. WAS에 등록(web.xml, @WebServlet/이때 설정정해줌)
 * 4. URL과 매핑 : *주의!! 경로매핑과 확장자매핑을 동시사용불가!!*
 * 					ex) /dapth01/*.jsp (X!!!안됨!!)
 * 		1) 경로 매핑	ex) /dapth01/* <-wild카드를 사용한방식
 * 		2) 확장자 매핑	ex) *.jsp
 * 
 * 
 * 
 * ***********
 * 클라이언트의 파라미터를 처리하는 방법론
 * 		클라이언트의 요청 파라미터가 전달되는 방법
 * 		1. POST : body 영역이 형성되고, 특별한 설정이 없는 한, 해당 영역내의 문자열의 형태로 전달
 * 		2. GET : Line영역의 주소를 통해 QueryString의 형태로 전달
 * 				쿼리스트링  ==> segment1&segment2....
 * 						segment ==> param_name = param_value
 * 					ex) URL?op1=4&op2=7
 * 		클라이언트의 요청 파라미터를 확보하는 방법 : 전달되는 형태와 무관하게 뽑으면 된다.
 * 		1.String HttpServletRequest.getParameter(name);
 * 		2.String[] HttpServletRequest.getParameterValues(name);
 * 						: 동일한 파라미터명으로 여러값이 전달 될 때
 * 		3.Map&lt;String,String[]&gt; HttpServletRequest.getParameterMap();
 * 		4.Enumeration&lt;String&gt; HttpServletRequest.getParameterNames();
 * 	
 * 	파라미터에 특수문자가 포함된 경우
 * 	IETF에서는 웹을 통해 특수문자가 전달될 때 
 * 	%32%21....과 같은 형태로 전달하도록 규칙을 정의해둠-RFC2396규약.
 * 	
 * 	특수문자 파라미터를 확보할 때, 반드시 꺼내기 전에 디코딩 설정이 필요함.
 *  POST -> Body -> req.setCharacterEncoding(charset)
 *  GET -> Line -> 서버가 먼저 접근 -> 서버의 설정 변경 필요
 *  									ㄴserver.xml에서 포트번호변경한 곳에 코딩방식을 추가하여 새로 설정한다 
 *  										URIEncoding
 *  										useBodyEncodingForURI="true" GET에서도 setCharacterEncoding 메소드 사용 가능. 
 * 										 
 * *  
 */
//@WebServlet(loadOnStartup=1, value ="/desc.do")
public class ServletDescription extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletDescription() { //do~~메서드때는 super코드 삭제,아닐시엔 꼭 살려놔야함.
        super();
        System.out.println(this.getClass().getSimpleName()+"생성자 호출");
    }
    
    @Override
    public void init(ServletConfig config) throws ServletException {
    	super.init(config);//콘피그(xml에 이쓴ㄴ)로 파람에 알맞는 벨류를 뽑아낸다.
    	System.out.println(this.getClass().getSimpleName()+"초기화 완료");
    	Enumeration<String> en = config.getInitParameterNames();
    	while (en.hasMoreElements()) {
			String name = (String) en.nextElement();//param이름 하나
			String value = config.getInitParameter(name);
			//(오라클 드라이버 설치할때 여러번하는걸 여기서 이런식으로 한번입력으로 여러번 불러올수있고 
			//그럼 프로그래밍의 기본원칙인 하드코딩으로 인한 재수정피할수 있다.)
			System.out.printf("name:%s, value:%s", name, value);
			System.out.println();
		}
    }
    
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	System.out.println("요청이 들어왔음, service에...");
    	super.service(req, resp);//안에서 다 처리가 되고 이는 HttpServlet에 정의가 되있다는 말.
    	System.out.println("service 의 super 코드 호출 후");
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("요청이 doGet에 들어왔음");
	}

	@Override //새로운 코드를 입력하면 원래 실행되던 싱글턴객체를 garbage컬렉터해버림. 
	public void destroy() { //garbageCollection은 개발자의 영역이 아님. 그러므로 소멸을 확인 할 수 없음. 
		super.destroy(); //되기도 하고 안되기도 하는 장담할 수 없는 메소드이다. 그러므로 여기에 close 객체를 넣거나 하는 행위는 주의가 필요하다. 
		System.err.println(this.getClass().getSimpleName()+"객체소멸");
	}
	
}
