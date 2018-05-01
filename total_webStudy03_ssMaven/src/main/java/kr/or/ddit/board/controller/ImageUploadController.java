package kr.or.ddit.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.filter.wrapper.FileUploadRequestWrapper;
import kr.or.ddit.mvc.ICommandHandler;

public class ImageUploadController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		if(req instanceof FileUploadRequestWrapper){
			FileItem item = ((FileUploadRequestWrapper) req).getFileItem("upload");
			if(item!=null){
				// 업로드 처리 (웹리소스? 파일시스템리스소? //주소必?) <img src="주소"/>
				// 저장위치 : /boardImgs
				String saveFolderUrl = "/boardImgs";
				File saveFolder = new File(req.getServletContext().getRealPath(saveFolderUrl)); // 파일시스템상의 실제 path
				if(!saveFolder.exists()){
					saveFolder.mkdirs();
				}
				String saveName = UUID.randomUUID().toString();
				File savefile = new File(saveFolder, saveName);
				resp.setContentType("application/json;charset=UTF-8");
				try(
						InputStream is = item.getInputStream();
						PrintWriter out = resp.getWriter();
						){
					FileUtils.copyInputStreamToFile(is, savefile);
					String saveUrl = saveFolderUrl+"/"+saveName;// savePath, url 생성
					Map<String, Object> resultMap = new HashMap<String, Object>();
					resultMap.put("fileName", item.getName());
					resultMap.put("uploaded", 1);
					resultMap.put("url", req.getContextPath()+saveUrl);
					ObjectMapper mapper = new ObjectMapper();
					mapper.writeValue(out, resultMap);// 마샬링 && 직렬화를 한번에. json형태.
				}
			}
		}
		
		return null;
	}

}
