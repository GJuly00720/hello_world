package kr.or.ddit.servlet;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//ImageForm.jsp를 대신해서 요청을 받아줄 서블릿

@WebServlet("/imageForm.do")
public class ImageFormServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		File folder = new File("d:/contents");
		String[] fileList = folder.list(new FilenameFilter(){
			public boolean accept(File dir, String name){
				return name.endsWith(".jpg") || name.endsWith(".gif"); 
			}
		});
		req.setAttribute("fileList", fileList); //공유하는 데이터 속성들에는 제한이 없다.Object타입
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/semImageForm.jsp");
		rd.forward(req, resp);
	
	}

}
