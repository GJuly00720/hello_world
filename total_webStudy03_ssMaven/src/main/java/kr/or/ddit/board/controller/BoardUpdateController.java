package kr.or.ddit.board.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.CommonException;
import kr.or.ddit.InsertGroup;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.UpdateGroup;
import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.filter.wrapper.FileUploadRequestWrapper;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.validate.CommonValidator;
import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.AttatchVO;
import kr.or.ddit.vo.BoardVO;

public class BoardUpdateController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String method = req.getMethod();
		if(StringUtils.equalsIgnoreCase(method, "get")){
			String bo_no = req.getParameter("what");
			if(!StringUtils.isNumeric(bo_no)){
				resp.sendError(400, "글번호가 이상함");
				return null;
			}
			IBoardService service = new BoardServiceImpl();
			BoardVO board = service.retrieveBoard(Integer.parseInt(bo_no));
			req.setAttribute("board", board);
			
			return "board/boardForm";
			
		}else if(StringUtils.equalsIgnoreCase(method, "post")){
			BoardVO board = new BoardVO();
			req.setAttribute("board", board);
			
			try {
				BeanUtils.populate(board, req.getParameterMap());
			} catch (IllegalAccessException | InvocationTargetException e) {
				throw new CommonException(e);
			}
			
			Map<String,String> errors = new LinkedHashMap<String, String>(); //검증결과메세지 공유를 위한.
			req.setAttribute("errors", errors);
			
			CustomValidator<BoardVO> validator = new CommonValidator<BoardVO>();
			boolean valid = validator.validate(board, errors, UpdateGroup.class);// UpdateGroup 수정인경우에 대하여. @으로 제약하는거 만든 부분볼것..
			String goPage = null;
			String message = null;
			if(valid){
				if(req instanceof FileUploadRequestWrapper){ //첨부파일 존재
					FileItem[] items = ((FileUploadRequestWrapper) req).getFileItems("bo_files");
					List<AttatchVO> attatchList = null;
					if(items != null){
						attatchList = new ArrayList<AttatchVO>();
						for(FileItem item : items){
							if(StringUtils.isBlank(item.getName())){//선택 안됐다면
								continue;
							}
							try{
							AttatchVO attVO = new AttatchVO(item);
							attatchList.add(attVO);
							}catch(CommonException e){
								req.setAttribute("message", "용량초과");
								return "board/boardForm";
							}
						}//for end
					} //if(item!=null) end
					board.setAttatchList(attatchList);
				}// req instanceof wrapper end
				
				IBoardService service = new BoardServiceImpl();
				ServiceResult result = service.modifyBoard(board);
				
				HttpSession session = req.getSession();  
				if(result.equals(ServiceResult.OK)){
					goPage = "redirect:/board/boardView.do?what="+board.getBo_no();
					message = "수정완료";
					session.setAttribute("message",message);
				}else if(result.equals(ServiceResult.INVALIDPASSWORD)){
					message = "비번오류";
					goPage = "/board/boardForm";
				}else{
					message="서버오류";
					goPage = "/board/boardForm";
				}
			}else{
				goPage = "/board/boardForm";
				message = "입력하실거 덜입력하심요";
			}
			req.setAttribute("message", message);
			return goPage;
		}else{
			resp.sendError(405,method+"는 지원하지 않는다.");
			return null;
		}
	}

}
