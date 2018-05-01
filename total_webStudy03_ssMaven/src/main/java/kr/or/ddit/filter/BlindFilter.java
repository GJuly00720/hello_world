package kr.or.ddit.filter;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BlindFilter implements Filter{
	Map<String, Integer> blindMap; // 아이피와 누적횟수
	Logger Logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		blindMap = new LinkedHashMap<String, Integer>();
		blindMap.put("192.168.205.125", 10);
		blindMap.put("192.168.205.145", 5);
		blindMap.put("192.168.205.6", 5);
		blindMap.put("192.168.205.154", 1);
		Logger.info("{} 필터 초기화", getClass().getSimpleName());
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		String uri = req.getRequestURI();
		int len = req.getContextPath().length();
		uri = uri.substring(len);
		boolean pass = false;
		if(uri.equals("/") || uri.equals("/index.jsp")){
			pass = true;
		}else{
			String ip = req.getRemoteAddr();
			Integer number = blindMap.get(ip);
			if(number!=null && number>=5){
				HttpSession session = req.getSession();
				session.setAttribute("session", ip+"차단");
				resp.sendRedirect(req.getContextPath()+"/");
			}else{
				pass= true;
			}
		}
		
		if(pass){
			chain.doFilter(request, response);
		}
		
		
	}

	@Override
	public void destroy() {
		Logger.info("{} 필터 소멸", getClass().getSimpleName());
		
	}

}
