package kr.or.ddit.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Front Controller 이후에 동작할 각 커맨드 핸들러들에 대한 추상화.
 *
 */
public interface ICommandHandler {
	/**
	 * 각 커맨드를 실질적으로 처리 할 핸들러 메소드
	 * @param req
	 * @param resp
	 * @return View Layer에 대한 정보(논리적인 View네임)
	 * @throws ServletException
	 * @throws IOException
	 */
	public String process(HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException;
}
