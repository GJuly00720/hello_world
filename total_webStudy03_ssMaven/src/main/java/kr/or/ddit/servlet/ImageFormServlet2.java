package kr.or.ddit.servlet;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.util.CookieUtil;
import kr.or.ddit.util.CookieUtil.textType;

//ImageForm.jsp를 대신해서 요청을 받아줄 서블릿

@WebServlet("/imageForm2.do")
public class ImageFormServlet2 extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		File folder = new File("d:/contents");
		String[] fileList = folder.list(new FilenameFilter(){
			public boolean accept(File dir, String name){
				return name.endsWith(".jpg") || name.endsWith(".gif"); 
			}
		});
		CookieUtil cookieUtil = new CookieUtil(req);
		String cookieValue = cookieUtil.getCookieValue(ImageStreamingServlet2.IMGCOOKIENAME);
		String[] imageNames = null;
		if(cookieValue!=null){
			imageNames = cookieValue.split(",");
		}
		req.setAttribute("fileList", fileList); //공유하는 데이터 속성들에는 제한이 없다.Object타입
		req.setAttribute("imageNames", imageNames);
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/semImageForm2.jsp");
		rd.forward(req, resp);
	
	}

}
