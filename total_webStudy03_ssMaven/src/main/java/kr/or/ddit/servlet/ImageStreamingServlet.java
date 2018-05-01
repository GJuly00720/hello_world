package kr.or.ddit.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
// /image/getImage.do 로 매핑 설정.
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//@WebServlet("/image/getImage.do")
public class ImageStreamingServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("image/jpeg");
		String name = req.getParameter("chooseImage");
		System.out.println(name);
		
		String filePath = "d:/contents/"+ name;
		
		File file = new File(filePath);
		FileInputStream fis = new FileInputStream(file);
		OutputStream os = resp.getOutputStream();
		byte[] buffer = new byte[1024];
		while(fis.read(buffer) != -1){
			os.write(buffer);
		}
		if(os!=null)
			os.close();
		if(fis!=null)
			fis.close();
		}
	
	
	
}
