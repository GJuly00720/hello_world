package kr.or.ddit.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;


/**
 * 쿠키 생성과 사용을 용이하도록 지원하는 클래스
 */
public class CookieUtil { // 입셉션은 jsp가 알아서 처리할거야... 그럼 상태코드로 바꿔서 보여주겠지.
	
	Map<String, Cookie> cookieMap;
	//의존성 역전의 법칙  //외부로부터 주입받음. //결합력을 낮추기 위함.
//	// 결합력을 낮춘고 응집력은 높인다. //전략적패턴 HCLC
	private HttpServletRequest req;
	
	
	public CookieUtil(HttpServletRequest req){ //필수라면 생성자 주입방식.
		this.req = req; 
		cookieMap = new LinkedHashMap<String, Cookie>();
		Cookie[] cookies = req.getCookies();
		if(cookies!=null){
			for(Cookie tmp:cookies){
				cookieMap.put(tmp.getName(),tmp);
			}
		}
	}
//	public void setReq(HttpServletResponse req){ //setter 호출해야만 사용가능 //optional이라면
//		this.req = req;
//	}
//	public void setCookieMap(Map<String, Cookie> cookieMap) {
//		this.cookieMap = cookieMap;
//	}

	public Map<String, Cookie> getCookieMap(){
		return cookieMap;
	}
	
	/**
	 * @param name 찾을 쿠키명
	 * @return 쿠키명에 해당하는 쿠키객체
	 */
	public Cookie getCookie(String name){
		return cookieMap.get(name);
	}
	/**
	 * @param name 찾을 쿠키명
	 * @return 쿠키명에 해당하는 쿠키값, 존재하지 않는 경우 null반환.
	 * @throws UnsupportedEncodingException 
	 */
	public String getCookieValue(String name) throws UnsupportedEncodingException{
		Cookie cookie = cookieMap.get(name);
		String retValue = null;
		if(cookie!=null){
			retValue = URLEncoder.encode(cookie.getValue(), "UTF-8");
		}
		return retValue;
	}
	
	/**
	 * 단축키 alt+shft+j :: 독주석 단축키 
	 * 
	 * 쿠키생성메소드
	 * @param name 쿠키명
	 * @param value 쿠키값(UTF-8로 인코딩)
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static Cookie createCookie(String name, String value)
			throws UnsupportedEncodingException {
		// cookie는 문자열데이터만 저장가능
		Cookie cookie = new Cookie(name, URLEncoder.encode(value, "UTF-8"));
		// 예외의 두 종류 :: checked 입셉션, Unchecked 입셥션.
		return cookie;
	}

	/**
	 * 쿠키생성
	 * 
	 * @param name 쿠키명
	 * @param value 쿠키값(UTF-8로 인코딩)
	 * @param maxAge 초단위 만료시간
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static Cookie createCookie(String name, String value, int maxAge)
			throws UnsupportedEncodingException {
		Cookie cookie = createCookie(name, value);
		cookie.setMaxAge(maxAge);
		return cookie;
	}

	// 플래그변수: 들어올 텍스트가 경로인지 호스트인지 boolean으로 처리
	// 상수,
	// 상수자체가 의미를 갖고있진 않음.
//	final int path = 3;
//	final int domain = 4;

	// 이넘 ::값이 범위설정, 값의 의미부여가능, 직접 설정?? 할필요 없음
	public static enum textType {
		PATH, HOST
	}

	// 이름,값,도메인
	// 이름,값, 경로
//	public static Cookie createCookie(String name, String value, String text,
//			boolean flag) throws UnsupportedEncodingException {
//		Cookie cookie = creatCookie(name, value);
//		cookie.setPath(text);
//		return cookie;
//	}
//
//	public static Cookie createCookie(String name, String value, String text,
//			int a) throws UnsupportedEncodingException {
//		Cookie cookie = creatCookie(name, value);
//		cookie.setPath(text);
//		return cookie;
//	}

	/**
	 * 쿠키생성
	 * 
	 * @param name
	 * @param value
	 * @param text 경로 혹은 도메인
	 * @param type text 인수를 경로로 설정할지, 도메인으로 설정할지 여부
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static Cookie createCookie(String name, String value, String text,
			textType type) throws UnsupportedEncodingException {
		Cookie cookie = createCookie(name, value);
		if (type != null) {// 그래서 이렇게 한번 검증해야함.
			switch (type) { // 스위치에서 null타면 default로 가는게 아니고 nullpoint뜸↑
			case PATH:
				cookie.setPath(text);
				break;
			default:
				cookie.setDomain(text);
				break;
			}
		}
		return cookie;
	}

	/**
	 * 쿠키생성
	 * 
	 * @param name
	 * @param value
	 * @param text 경로 혹은 도메인
	 * @param type text 인수를 경로로 설정할지, 도메인으로 설정할지 여부
	 * @param maxAge 초단위 만료시간
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static Cookie createCookie(String name, String value, String text,
			textType type, int maxAge) throws UnsupportedEncodingException {
		Cookie cookie = createCookie(name, value, text, type);
		cookie.setMaxAge(maxAge);
		return cookie;
	}
	
//	네임 벨류 패쓰 도메인

	public static Cookie createCookie(String name, String value, String domain, String path, textType type) throws UnsupportedEncodingException{
		Cookie cookie = createCookie(name, value);
		cookie.setPath(path);
		cookie.setDomain(domain);
		return cookie;
	}
	//네임 벨류 패쓰 도메인 멕스에이지
	public static Cookie createCookie(String name, String value, String domain, String path, int maxAge ) throws UnsupportedEncodingException{
		Cookie cookie = createCookie(name, value);
		cookie.setPath(path);
		cookie.setDomain(domain);
		cookie.setMaxAge(maxAge);
		return cookie;
	}
}