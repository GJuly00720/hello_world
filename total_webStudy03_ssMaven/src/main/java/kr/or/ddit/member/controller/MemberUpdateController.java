package kr.or.ddit.member.controller;

import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.CommonException;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.UpdateGroup;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.validate.MemberUpdateValidate;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.validate.CommonValidator;
import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.MemberVO;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

//@WebServlet("/member/memberUpdate.do")
public class MemberUpdateController implements ICommandHandler{
	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
//		req.setCharacterEncoding("UTF-8");// 있으나 마나.
		MemberVO member = new MemberVO();
		req.setAttribute("member",member);
		Map<String, String[]> parameterMap = req.getParameterMap();
		Set<String> paramNames = parameterMap.keySet();
//		<jsp:setProperty name="member" property="*"/>     ←얘 한줄이  ↓밑에 얘를 다해줌 개쩔음
//		for(String name : paramNames){
//			MemberVO.class.getDeclaredField(name);
//			PropertyDescriptor pd = new PropertyDescriptor(name, MemberVO.class);
//			Method setter = pd.getWriteMethod();//위에서 읽어온 것이 method타입으로 돌아온다.
//			setter.invoke(member, req.getParameter(name));
//		}
		try {
			BeanUtils.populate(member, parameterMap);
			//(여기로 옮겨줌,여기값을); //	↑위에서 한 불확실성을 기반으로하는 리플렉션과 바인딩 작업을 한번에 해줌.
		} catch (IllegalAccessException | InvocationTargetException e) {// |자바빈규약을 안지켜서 setter가 안뜬다면
			throw new CommonException(e);
		} 
		
		Map<String, String> errors = new LinkedHashMap<>(); //검증 결과 메세지존재
		req.setAttribute("errors", errors); //검증통과 못할 시를 위해 요청에 담아 메세지 보존
		
		CustomValidator<MemberVO> validator = new CommonValidator<MemberVO>(); 
		//벨리데이트가 아닌 커스텀이 갖고있는  벨리데이터를 사용
		
		//한 소스안에 모든 것을 넣지않고 모듈화를 했을 때의 장점 : 코드가 완성되지 않아도 사용할 수 있다. : 분업가능!!
		boolean valid = validator.validate(member, errors, UpdateGroup.class);//검증만들 담당하는 별도의 메소드.(모듈화!!)
		
		String goPage = null;
		String message = null; //스코프통해 전달
		
		if (valid) { //검증 통과
			IMemberService service = new MemberServiceImpl();
			ServiceResult result = service.modifyMember(member);
			switch (result) {
			case OK:
				goPage = "redirect:/memberView.do?who=" + member.getMem_id();
							//redirect로 나갔다 새로 들어오는 요청이기때문에 servlet이 잡는다.
				break;
			case INVALIDPASSWORD:
				message = "비번오류";
				goPage = "member/memberView"; // 클래스의  return type 이 string인건 이 논리적view네임때문임.
				//얘넨 dispatch이기 때문에 처음들어온 요청이 계속 존재하니까 바로 접근 가능.
				break;
			default: //FAILED
				message = "서버오류";
				goPage = "member/memberView";
				//얘넨 dispatch이기 때문에 처음들어온 요청이 계속 존재하니까 바로 접근 가능.
			
			}
		} else { //불통
			goPage = "member/memberView";
		}
		req.setAttribute("message", message);
		
	
		return goPage;
	}
	
}
