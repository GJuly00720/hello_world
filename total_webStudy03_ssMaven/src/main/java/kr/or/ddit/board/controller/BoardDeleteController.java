package kr.or.ddit.board.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.util.BeanUtil;

import kr.or.ddit.CommonException;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.vo.BoardVO;

public class BoardDeleteController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String no = req.getParameter("what");
		String pass = req.getParameter("password");
		if(!StringUtils.isNumeric(no)){
			resp.sendError(400, "글번호가 이상합니다.");
			return null;
		}
		int bo_no = Integer.parseInt(no);
		BoardVO board = new BoardVO();
		try {
			BeanUtils.populate(board, req.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new CommonException(e);
		}
		board.setBo_no(bo_no);
		board.setBo_pass(pass);
		
		IBoardService service = new BoardServiceImpl();
		ServiceResult result = service.removeBoard(board);
		String goPage = null;
		String message = null;
		
		switch (result) {
		case OK:
			goPage = "redirect:/board/boardList.do";
			break;
		case FAILED:
			goPage = "redirect:/board/boardView.do?what="+bo_no;
			message = "서버오류";
			break;

		default:
			goPage ="redirect:/board/boardView.do?what="+bo_no;
			message = "비밀번호 오류";
			break;
		}
		
		HttpSession session = req.getSession();
		session.setAttribute("message", message);
		return goPage;
	}

}
