package kr.or.ddit.buyer.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.buyer.service.BuyerServiceImpl;
import kr.or.ddit.buyer.service.IBuyerService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.vo.BuyerVO;

public class BuyerDeleteController implements ICommandHandler{

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String buyer_id = req.getParameter("buyer_id");
		
		if(StringUtils.isBlank(buyer_id)){
			resp.sendError(400, "아이디불일치");
			return null;
		}
		IBuyerService service = new BuyerServiceImpl();
		BuyerVO buyer = new BuyerVO(); 
		buyer.setBuyer_id(buyer_id);
		ServiceResult result  = service.removeBuyer(buyer);
		
		String goPage = null;
		boolean redirect = false;
		String message = null;
		switch (result) {
		case OK:
			goPage = "redirect:/buyer/buyerList.do";
			message = "삭제 성공적! 일주일간 동일아이디 재가입불가";
			break;
		default:
			goPage = "/buyer/buyerList.do?who="+buyer.getBuyer_id();
			message = "다시 시도해주세요.";
			break;
		}
		HttpSession session = req.getSession();
		session.setAttribute("message", message);
		return goPage;
	}
}
