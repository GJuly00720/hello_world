package kr.or.ddit.filter;

import java.io.IOException;
import java.net.Authenticator;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.ResourceVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 보호되는 자원을 요청했고, 인증을 거친 클라이언트라면,
 * 자원에 허가된 권한과 현재 클라이언트의 롤의 매칭 여부 확인.
 * 
 * 보호되지 않는 자원에대한 요청 == pass
 * 보호중인 자원에 대환 요청 - 매칭 OK :
 * 							- 매칭 Fales : 403,401
 */
public class AutherizationFilter implements Filter{
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("{} 필터 초기화", getClass().getSimpleName());
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		List<ResourceVO> secureResources = (List<ResourceVO>) request.getServletContext().getAttribute(AuthrnticationFilter.SECUREDRESNAME);
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		String uri = req.getRequestURI();
		int len = req.getContextPath().length();
		uri = uri.substring(len);
		
		List<String> authorities = null;
		boolean secureFlag = false;
		
		for(ResourceVO resVO : secureResources){
			authorities = matches(resVO, uri);
			if(authorities!=null){
				secureFlag = true; // 보호가 필요없는 요청
				break;
			}
		}
		boolean pass = false;
		if(secureFlag){
			HttpSession session = req.getSession();
			MemberVO authMember = (MemberVO) session.getAttribute("authMember");
			List<String> roles = authMember.getRoles();
			if(matches(roles, authorities)){ //매칭O
				pass =true;
			}else{ // 매칭x
				pass =false;
			}
			
		}else{ // 보호안해도 되는 자원에 대한 요청인 경우
			pass = true;
		}
		if(pass){
			chain.doFilter(request, response);
		}else{ // 로그인 했지만 권한에 맞지않는 요청을 한 경우
			resp.sendError(HttpServletResponse.SC_FORBIDDEN); //금지하다. 403 /unAuthoried. 허가되지 않다. 401 정책에따라.
		}
	}

	private boolean matches(List<String> roles, List<String> authorities) {
		boolean maches = false;
		for(String role : roles){
			for(String auth : authorities){
				if(role.equals(auth)){ // 자원설정권한과 갖고있는권한이 일치
					maches = true;
					break;
				}
			}
			if(maches){
				break;
			}
		}
		return maches;
	}

	private List<String> matches(ResourceVO resVO, String uri) {
		List<String> authrities = null;
		if(resVO.getRes_url().equals(uri)){
			authrities =resVO.getAuthorities();
		}
		return authrities;
	}

	@Override
	public void destroy() {
		logger.info("{} 필터 소멸", getClass().getSimpleName());
		
	}

}
