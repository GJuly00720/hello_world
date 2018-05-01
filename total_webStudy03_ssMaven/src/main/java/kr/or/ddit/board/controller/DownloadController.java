package kr.or.ddit.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.vo.AttatchVO;

public class DownloadController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String att_no = req.getParameter("what");
		if(!StringUtils.isNumeric(att_no)){
			resp.sendError(400,"첨부파일 번호가 이상" );
			return null;
		}
		IBoardService service = new BoardServiceImpl();
		AttatchVO attVO = service.downlaod(Integer.parseInt(att_no));
		String filename = attVO.getAtt_originalfilename();
		String savePath = attVO.getAtt_savepath();
		File saveFile = new File(savePath);
		String agent = req.getHeader("User-Agent");
		if(StringUtils.containsIgnoreCase(agent, "trident")){
			filename = URLEncoder.encode(filename, "UTF-8"); // 익스에서만.......ㅠㅠ
		}else{
			filename = new String(filename.getBytes(), "ISO-8859-1");// 데이터가 일바이트만 있어도..다 쪼개서... 
		}
		resp.setHeader("Content-Disposition", "attachment;filename=\""+filename+"\""); //공백을 해결하기위한 설정
//		resp.setContentLength((int)attVO.getAtt_size());
		resp.setHeader("Content-Length", attVO.getAtt_size()+"");
		//image/jpeg
		resp.setContentType("application/octet-stream"); // octet = 8 :: 바이트 스트림이다!
		try(
				OutputStream os = resp.getOutputStream();
		){
			FileUtils.copyFile(saveFile, os);
		}
		return null;
	}

}
