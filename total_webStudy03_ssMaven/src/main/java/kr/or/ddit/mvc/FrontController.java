package kr.or.ddit.mvc;

import java.io.IOException;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.member.controller.MemberListController;
import kr.or.ddit.member.controller.MemberViewController;

public class FrontController extends HttpServlet {
	Map<String, ICommandHandler> handlerMap;//properties에서 쓰기위한 가장 유사한 fwc =Map!
	Logger logger =LoggerFactory.getLogger(this.getClass()); // Interface이기때문에 factory라는걸 받아주고.
									//로거의 이름을 정해주는데 보통 해당 클래스의 콸러파이드 네임으로 쓴다. 
	@Override
	public void init(ServletConfig config) throws ServletException {
		handlerMap = new LinkedHashMap<String, ICommandHandler>();
		super.init(config);
		//어플리케이션이 시작되면, 제일 먼저 실행되는 코드를 넣기 위해..
//		getServletContext().setAttribute("cPath", getServletContext().getContextPath()); //리스너로 교체.
			
		logger.info(getServletContext().getInitParameter("admin"));
//		ResourceBundle bundle = ResourceBundle.getBundle("kr/or/ddit/uriHandlerMapping"); //모든 곳에서 이렇게 사용되지 않고 하드코딩 ㄴㄴ;
		ResourceBundle bundle = ResourceBundle.getBundle(config.getInitParameter("mappingInfo")); 
		
		Enumeration<String > keys = bundle.getKeys();
		while(keys.hasMoreElements()){
			String uri = (String) keys.nextElement();
			String qualifiedName = bundle.getString(uri);//클래스의 객체를 생성하기 위한 네임받아오기.
			try {
				Class<? extends ICommandHandler> handlerClass = (Class<? extends ICommandHandler>) Class.forName(qualifiedName.trim());//다받되 ICH의것만?
				ICommandHandler handler = handlerClass.newInstance(); //핸들러 생성
				
				handlerMap.put(uri.trim(), handler); //특정커멘드를 처리가능한 uri와 핸들러 확보(키:uri,값:handler)
				logger.info("{}에 대한 핸들러 : {}", uri, handlerClass.getName()); //message 아규먼트.
//				System.out.printf("%s에 대한 핸들러 : %s\n", uri, handlerClass.getName());
				
											//예외생긴다면 ↓기본생성자가 없다  //  ↓ 기본생성자가 있지만 외부접근 불가능 private
			} catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
				logger.error(e.getMessage());
//				System.err.println(e.getMessage());
				continue; //다음반복으로 가서 거기서 처리함
			}
		}
	}
	
	// 클라이언트로부터의 요청을 얘만받아야 하기때문에 다른애들은 servlet이 될필요가 없다.
	@Override
	protected void service(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws ServletException, IOException {
		// super.service(req, res);// controller에서 반복되는 부분을 템플릿처럼 갖고있는거기때문에 응답과
		// 요청을 얘가 처리할 필요 없음.
		req.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();
		uri = uri.substring(req.getContextPath().length()).split(";")[0];
		System.out.println(uri);
		// 1. 이 frontController는 커맨드 핸들러를 호출하고 , 그로부터 gopage를 반환.
		// 2. 이동방식.
		String goPage = null;
		ICommandHandler handler = handlerMap.get(uri);

		if (uri.equals("/member/memberList.do")) {
			handler = new MemberListController();
		} else if (uri.equals("/member/memberView.do")) {
			handler = new MemberViewController();
		} else if (uri.equals("/member/memberDelete.do")){
			handler = new MemberListController();
		}
		
		if (handler == null) { // ↑ 못통과 //핸들러에서 오는 정보가 null이거나 위의 if를 못통과(=우리가 처리못할주소)
			resp.sendError(404, "제공되는 서비스 아님");
			return;
		}
		
		goPage = handler.process(req, resp);
		if (goPage == null) { // 강제로 개발자가 null을 넣었거나
			if (!resp.isCommitted()) { // 정상적인종료가 아니라면! == 개발자가 잘못짜서 null;
				resp.sendError(500, "view에 대한 정보가 코드수정하세요;"); 
				// throw new CommonException("view에 대한 정보가 없음");// ↑ 동일
			}
		} else {
			boolean redirect = goPage.startsWith("redirect:"); //시작이 redirect:
			String prefix = "/WEB-INF/views/";
			String suffix = ".jsp"; //모든 커멘드핸들러에서 이 두가지를 제거 가능하다.( 논리적인 view 네임.)
			if (redirect) { // 이동하는 코드 별도의 모듈화 //때에 따라 메소드로 분리 가능.
				goPage = goPage.substring("redirect:".length());
				resp.sendRedirect(req.getContextPath() + goPage);
			} else {
				RequestDispatcher rd = req.getRequestDispatcher(prefix+goPage+suffix);
				rd.forward(req, resp);
			}
		}
	}
}
