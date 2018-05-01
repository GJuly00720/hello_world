package kr.or.ddit.buyer.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.buyer.service.BuyerServiceImpl;
import kr.or.ddit.buyer.service.IBuyerService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.dao.OthersDAOImpl;
import kr.or.ddit.vo.BuyerVO;

import org.apache.commons.lang3.StringUtils;

public class BuyerViewController implements ICommandHandler{
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		IOthersDAO othersDAO = new OthersDAOImpl();
		Map<String,Object > lprodMap =  othersDAO.selectLprodList();
		request.setAttribute("lprodMap", lprodMap);
		String buyer_id = request.getParameter("who");
		if(StringUtils.isBlank(buyer_id)){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "필수 파라미터 누락");
			return null;
		}
		IBuyerService service = new BuyerServiceImpl();
		BuyerVO buyer = service.retrieveBuyer(buyer_id);
		
		request.setAttribute("buyer", buyer);
		String goPage = "/buyer/buyerView";
		return goPage;
		
	}
}
