package kr.or.ddit.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import kr.or.ddit.util.CookieUtil;
import kr.or.ddit.util.CookieUtil.textType;

//imageForm.jsp에서 폼이 전송되면 발생하는 요청을 처리할 서블릿.

@WebServlet("/image2/getImage.do")
public class ImageStreamingServlet2 extends HttpServlet{
	public static final String IMGCOOKIENAME = "imgCookie";
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
					CookieUtil cookieUtil = new CookieUtil(req);
					String alreadyImgs = cookieUtil.getCookieValue(IMGCOOKIENAME);
					String[] array = null;
					if(alreadyImgs!=null){
						String[] temp = alreadyImgs.split(",");//문자열의 ,를 기준으로 파싱 //문자열을 ,을 시켜서 배열로
						Arrays.sort(temp);
						if(Arrays.binarySearch(temp, selImage)>=0){//temp에 sel
							array = temp;
						}else{
							array = new String[temp.length+1];
							System.arraycopy(temp, 0, array, 0, temp.length); //복사:: 깊은:클론만듬, 얕은:
							array[array.length-1]=selImage; //마지막번째 방에 선택된 이미지를 넣는다.
						}
					}else{
						array = new String[]{selImage};
					}
					selImage = Arrays.deepToString(array).replaceAll("[\\[\\]\\s]","");// 배열을 문자열로 변경
					//[]는 정규문자내에서 메타문자로서 담기는 문자의 범위를 나타내주기 때문에 []를 사용 하고싶다면 \\를 사용해서 하나하나 지정해줘야 하다. \\는 \하나가 들어간것..... ㅠㅠ 어려움..ㅠ
					Cookie imgCookie = 
							CookieUtil.createCookie(IMGCOOKIENAME, selImage, 
									req.getContextPath(), textType.PATH, 60*60*24*2);
					resp.addCookie(imgCookie);
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
