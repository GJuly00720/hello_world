package kr.or.ddit.board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.util.CookieUtil;

public class LikeController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String bo_no = req.getParameter("what");
		String flag = req.getParameter("likeFlag");
		
		if(StringUtils.isBlank("likeFlag")){
			resp.sendError(400,"잘못된 접근입니다.");
		}
		
		String cookieValue = new CookieUtil(req).getCookieValue("likeCookie");
		String[] bo_nos=null;
		if(StringUtils.isNotBlank(cookieValue)&& !cookieValue.contains(bo_no)){ 
			//배열을 만들어 쿠키에 이저의 봤던 글번호들을 넣어준다.
			String[] array = cookieValue.split(","); 
			bo_nos = new String[array.length+1];
			System.arraycopy(array, 0, bo_nos, 0, array.length);
			bo_nos[bo_nos.length-1]=bo_no;
			
		}else{
			bo_nos = new String[]{bo_no};
		}
		String lastCookieValue = StringUtils.join(bo_nos, ",");
		Cookie likeCookie = CookieUtil.createCookie("likeCookie", lastCookieValue, 60*60*24*7);//좋아요싫어요 버튼에 적용될 쿠키
		resp.addCookie(likeCookie);
		String data = null;
//		if(!bo_no.equals(cookieValue)){// 쿠키에 해당보드넘버가 없다면
		if(!StringUtils.contains(cookieValue, bo_no)){
			IBoardService service = new BoardServiceImpl();
			if("likeBtn".equals(flag)){
				service.incrementLike(Integer.parseInt(bo_no));
			}else if("hateBtn".equals(flag)){
				service.incrementHate(Integer.parseInt(bo_no));
			}
			data = "Success";
		}else{
			data = "Failed";
		}
		
		//텍스트로 나가기 때문에 응답데이터의 직렬화.
		resp.setContentType("text/plain;charset=UTF-8");
		try (
				PrintWriter out = resp.getWriter();
				){
			out.print("success");
		}
		return data;
	}

}

