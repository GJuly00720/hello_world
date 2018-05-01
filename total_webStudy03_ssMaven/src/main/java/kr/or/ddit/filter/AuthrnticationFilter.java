package kr.or.ddit.filter;

import java.io.IOException;
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

import kr.or.ddit.auth.dao.IResourcesDAO;
import kr.or.ddit.auth.dao.ResourcesDAOImpl;
import kr.or.ddit.vo.ResourceVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// 보호되는 자원을보호하기위한 필터
/**
 *	보호되고 있는 자원에 대한 요청이 발생했을 때,
 *  현재 클라이언트의 인증여부를 확인하기 위한 필터 
 * 						↑ login 여부
 */
public class AuthrnticationFilter implements Filter {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private List<ResourceVO> securedResources;
	public static final String SECUREDRESNAME = "securedResources";	
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("{} 필터 초기화", getClass().getSimpleName()); // {} 메세지 아규먼트 
		IResourcesDAO resDAO = new ResourcesDAOImpl();
		securedResources = resDAO.selectResources();
		filterConfig.getServletContext().setAttribute(SECUREDRESNAME, securedResources); // 타입안정성 보장.
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
//		logger.info(securedResources.toString());
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp =  (HttpServletResponse) response;
		String uri = req.getRequestURI();
		int len = req.getContextPath().length();
		uri = uri.substring(len);
		boolean secureFlag = false;
		for(ResourceVO resVO: securedResources){
			if(matches(resVO, uri)){ // 보호되는 자원
				secureFlag = true;
				break;
			}
		}
		HttpSession session = req.getSession();
		boolean pass = false;
		if(secureFlag){ // 보호되는 자원이기 때문에 유저 인증 필요.
			if(session.getAttribute("authMember")!=null){ // 인증이 된 경우
				pass= true;
			}else{ // 로그인을 안했을 경우
				pass= false;
			}
		}else{ // 보호할 필요없는 자원에 대한 요청
			pass = true;
		}

		if(pass){
			chain.doFilter(request, response);
		}else{
			resp.sendRedirect(req.getContextPath()+"/login/loginForm.jsp");
		}
	}

	private boolean matches(ResourceVO resVO, String uri) {
		return resVO.getRes_url().equals(uri); // 보호되고있는 자원.
	}

	@Override
	public void destroy() {
		logger.info("{} 필터 소멸", getClass().getSimpleName()); 
		
	} 
}
