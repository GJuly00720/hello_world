package kr.or.ddit.prod.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.vo.ProdVO;

public class ProdViewController implements ICommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String prod_id = request.getParameter("what");
		if (StringUtils.isBlank(prod_id)) {
			response.sendError(400, "상품코드 주셈");
			return null;
		}

		IProdService service = ProdServiceImpl.getInstance();
		ProdVO prod = service.retrieveProd(prod_id);//거래처 정보와 상품정보.
		request.setAttribute("prod", prod);
		
		return "prod/prodView";
	}

}
