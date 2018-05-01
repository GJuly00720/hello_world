package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PagingVO;

public class BoardListController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String pagestr = req.getParameter("page");
		String searchType = req.getParameter("searchType");
		String searchWord = req.getParameter("searchWord");
		
		int currentPage = 1; //없다면 기본 1page.
		if(StringUtils.isNumeric(pagestr)){
			currentPage = Integer.parseInt(pagestr);
		}
		
		IBoardService service = new BoardServiceImpl();
		PagingVO<BoardVO> pagingVO = new PagingVO<BoardVO>(10,5);
		
//		pagingVO.setSearchVO(searchVO);
//		BoardVO searchVO = new BoardVO();
//		if( "bo_title".equals(searchType){
//			searchVO.setBo_title(searchWord);
//		}else if("bo_writer".equals(searchType){
//			searchVO.setBo_writer(searchWord);
//		}else if("bo_content".equals(searchType)){
//			searchVO.setBo_content(searchWord);
//		}else{
//			searchVO.setBo_title(searchWord);
//			searchVO.setBo_writer(searchWord);
//			searchVO.setBo_content(searchWord);
//		}
		
		pagingVO.setSearchWord(searchWord);
		pagingVO.setSearchType(searchType);
		
		int totalRecord = service.retrieveBoardCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<BoardVO> boardList = service.retrieveBoardList(pagingVO);
		
		pagingVO.setDataList(boardList);
		
		req.setAttribute("pagingVO", pagingVO);
		String goPage = "board/boardList";
		return goPage;
	}

}
