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
import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.filter.wrapper.FileUploadRequestWrapper;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.validate.CommonValidator;
import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.AttatchVO;
import kr.or.ddit.vo.BoardVO;



public class BoardInsertController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String method = req.getMethod();
		if(StringUtils.equalsIgnoreCase(method, "get")){
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
			boolean valid = validator.validate(board, errors, InsertGroup.class);// insertGroup 신규등록인경우에 대하여. @으로 제약하는거 만든 부분볼것..
			String goPage = null;
			String message = null;
			if(valid){
				if(req instanceof FileUploadRequestWrapper){ //첨부파일이 존재
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
							}catch(CommonException e){  //어떤 BL 사용에 따라 제한생각해야함. 프로그램 전체에서 제한을 줄지? 
//								req.setAttribute("message", "용량초과");
//								resp.sendError(400,"첨부파일 크기는 900KB 미만");
//								return "/board/boardForm";
								resp.sendError(400, e.getMessage());
								return null;
							}
						}//for end
					} //if(item!=null) end
					board.setAttatchList(attatchList);
				}// req instanceof wrapper end
						
				IBoardService service = new BoardServiceImpl();
				ServiceResult result = service.createBoard(board);
				
				HttpSession session = req.getSession();  
				if(result.equals(ServiceResult.OK)){
					goPage = "redirect:/board/boardView.do?what="+board.getBo_no();
					message = "새글 등록";
					session.setAttribute("message",message);
				}else{
					goPage = "/board/boardView";
				}
			}else{
				//입력 부족!
				goPage = "/board/boardView";
				message = "입력하실거 덜입력하심요";
				
			}
			
			return goPage;
		}else{
			resp.sendError(405,method+"는 지원ㄴㄴ");
			return null;
		}
	}

}
