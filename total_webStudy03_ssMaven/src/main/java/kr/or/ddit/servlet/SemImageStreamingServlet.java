package kr.or.ddit.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//imageForm.jsp에서 

@WebServlet("/image/getImage.do")
public class SemImageStreamingServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String selImage = req.getParameter("selImage");
		
		if(selImage ==null){ //클라이언트가 준 request가 잘못되었다.
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST,"이미지 파라미터가 전달되지 않았음.");
		}else{
			File folder = new File("d:/contents");
			File imageFile = new File(folder, selImage);
			if(imageFile.exists()){  
				resp.setContentType("image/jpeg");
				try(
					FileInputStream fis = new FileInputStream(imageFile);
					OutputStream os = resp.getOutputStream();
				){
				
					byte[] buffer = new byte[1024];
					int cnt = -1;
					while((cnt = fis.read(buffer))!=-1){
						os.write(buffer);
					}
				}
			}else{ // 클라이언트가 준 요청에 해당하는 자료가 우리에겐 없다.
				resp.sendError(HttpServletResponse.SC_NOT_FOUND,"이미지가 존재하지 않음.");
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String selImage = req.getParameter("selImage");
		if(selImage ==null){ //클라이언트가 준 request가 잘못되었다.
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST,"이미지 파라미터가 전달되지 않았음.");
		}else{
			File folder = new File("d:/contents");
			File imageFile = new File(folder, selImage);
			if(imageFile.exists()){  
				resp.setContentType("image/jpeg");
				try(
					FileInputStream fis = new FileInputStream(imageFile);
					OutputStream os = resp.getOutputStream();
				){
				
					byte[] buffer = new byte[1024];
					int cnt = -1;
					while((cnt = fis.read(buffer))!=-1){
						os.write(buffer);
					}
				}
			}else{ // 클라이언트가 준 요청에 해당하는 자료가 우리에겐 없다.
				resp.sendError(HttpServletResponse.SC_NOT_FOUND,"이미지가 존재하지 않음.");
			}
		}
	}
	
}
