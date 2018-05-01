package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.vo.BoardVO;

public class BoardViewController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String no = req.getParameter("what");
		if(StringUtils.isBlank(no)){
			resp.sendError(400,"잘못된요청");
			return null;
		}
		int bo_no = 0;
		if(StringUtils.isNumeric(no)){
			bo_no = Integer.parseInt(no);
		}
		IBoardService service = new BoardServiceImpl();
		BoardVO boardVO = service.retrieveBoard(bo_no);
		
		req.setAttribute("board", boardVO);
		String goPage = "/board/boardView";
		return goPage;
	}
}
