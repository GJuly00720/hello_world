package kr.or.ddit.buyer.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.CommonException;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.UpdateGroup;
import kr.or.ddit.buyer.service.BuyerServiceImpl;
import kr.or.ddit.buyer.service.IBuyerService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.validate.CommonValidator;
import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.BuyerVO;

public class BuyerUpdateController implements ICommandHandler{

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		BuyerVO buyer = new BuyerVO();
		req.setAttribute("buyer", buyer);
		Map<String, String[]> parameterMap = req.getParameterMap();
		Set<String> paramNames = parameterMap.keySet();
		try {
			BeanUtils.populate(buyer, parameterMap);
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new CommonException(e);
		}
		
		Map<String, String> errors = new LinkedHashMap<>();
		req.setAttribute("errors", errors);
		
		CustomValidator<BuyerVO> validator = new CommonValidator<BuyerVO>();
		
		boolean valid = validator.validate(buyer, errors, UpdateGroup.class);
		
		String goPage = null;
		String message = null;
		
		if(valid){
			IBuyerService service = new BuyerServiceImpl();
			ServiceResult result = service.modifyBuyer(buyer);
			switch (result) {
			case OK:
				goPage = "redirect:/buyer/buyerView.do?who="+buyer.getBuyer_id();
				break;
			case FAILED : 
				message= "서버오류";
				goPage = "buyer/buyerView";
				break;
			default:
				message = "필수 정보누락";
				goPage="buyer/buyerView";
			}
		} else {
			goPage = "buyer/buyerView";
		}
		req.setAttribute("message", message);
		
		return goPage;
	}

}
