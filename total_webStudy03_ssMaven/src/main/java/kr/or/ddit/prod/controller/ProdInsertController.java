package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.CommonException;
import kr.or.ddit.InsertGroup;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.dao.OthersDAOImpl;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.validate.ProdInsertValidator;
import kr.or.ddit.validate.CommonValidator;
import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.ProdVO;

public class ProdInsertController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		IOthersDAO othersDAO = new OthersDAOImpl();
		Map<String, Object> lprodMap = othersDAO.selectLprodList();
		List<BuyerVO> buyerList = othersDAO.selectBuyerList(null);
		req.setAttribute("lprodMap", lprodMap);
		req.setAttribute("buyerList", buyerList);

		String method = req.getMethod();
		if ("get".equalsIgnoreCase(method)) {//
			return "prod/prodForm";
		} else if ("post".equalsIgnoreCase(method)) {
			ProdVO prod = new ProdVO();
			req.setAttribute("prod", prod);
			try {
				BeanUtils.populate(prod, req.getParameterMap());
			} catch (IllegalAccessException | InvocationTargetException e) {
				throw new CommonException(e);
			}

			Map<String, String> errors = new LinkedHashMap<>();
			req.setAttribute("errors", errors);
			
			CustomValidator<ProdVO> validator = new CommonValidator<>();
			boolean valid = validator.validate(prod, errors, InsertGroup.class);
			
			String goPage = null;
			String message = null;
			if (valid) { // 검증 통
				IProdService service = ProdServiceImpl.getInstance();
				ServiceResult result = service.createProd(prod);
				if (ServiceResult.OK.equals(result)) {// ok
					goPage = "redirect:/prod/prodView.do?what=" + prod.getProd_id();
				} else {// failed
					message = "서버오류";
					goPage = "prod/prodForm";
				}
			} else {// 불통
				goPage = "prod/prodForm";
			}
			req.setAttribute("message", message);
			return goPage;
		} else {
			resp.sendError(405, method + "는 지원하지 않음");
			return null;
		}
	}
}