package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.dao.OthersDAOImpl;
import kr.or.ddit.vo.BuyerVO;

public class BuyerAjaxController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String Prod_lgu = req.getParameter("prod_lgu");
		
		String accept = req.getHeader("Accept");
		
		IOthersDAO othersDAO = new OthersDAOImpl();
		List<BuyerVO> buyerList = othersDAO.selectBuyerList(Prod_lgu);
		//Jackson을 이용한 Marshalling
		ObjectMapper objectMapper = new ObjectMapper(); //메이븐 - 의존성관리, 소스, 도큐먼트관리까지 
//		String json = objectMapper.writeValueAsString(buyerList); //마샬링 
		
		if(StringUtils.containsIgnoreCase(accept, "json")){
			resp.setContentType("application/json;charset=UTF-8"); 
			//Serialization
			try(
				PrintWriter out = resp.getWriter();
					){
//			out.println(json);//직렬화
			objectMapper.writeValue(out, buyerList);//마샬링과 직렬화 한번에 처리				
//			out.close();
			}
		}
		return null;
	}

}
