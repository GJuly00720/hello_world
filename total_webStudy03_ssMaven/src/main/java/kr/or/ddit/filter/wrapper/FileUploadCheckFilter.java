package kr.or.ddit.filter.wrapper;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.CommonException;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 파일 업로드 요청(multiPart request) 인지 여부를 확인하고,
 * 원본요청을 Wrapper로 바꿔서 다음 필터에게 전달.
 * 
 *
 */
public class FileUploadCheckFilter implements Filter{
	Logger logger  =LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("{} 필터 초기화" , getClass().getSimpleName());
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		//멀티파트요청 포함인지 확인
//		encType 속성 ==> request 의 Content-type 헤더 :: request의 헤더
		HttpServletRequest req = (HttpServletRequest) request;
		String mime = req.getHeader("content-type");
//		if(mime!=null && mime.startsWith("multipart")){
		if(ServletFileUpload.isMultipartContent(req)){ // multipart요청 ↑ 와 동일 동작.
			
			FileUploadRequestWrapper wrapper;
			try {
				wrapper = new FileUploadRequestWrapper(req);
				chain.doFilter(wrapper, response); // 파싱과 맵채우기!
			} catch (FileUploadException e) {
				throw new CommonException(e);
			} 
			
		}else{ // 일반 요청
			chain.doFilter(request, response);
		}
				
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

}
