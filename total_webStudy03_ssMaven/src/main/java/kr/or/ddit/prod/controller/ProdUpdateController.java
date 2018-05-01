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
import kr.or.ddit.ServiceResult;
import kr.or.ddit.UpdateGroup;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.dao.OthersDAOImpl;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.validate.ProdUpdateValidator;
import kr.or.ddit.validate.CommonValidator;
import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.ProdVO;

public class ProdUpdateController implements ICommandHandler{

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		IOthersDAO othersDAO = new OthersDAOImpl();
		Map<String, Object> lprodMap = othersDAO.selectLprodList();
		List<BuyerVO> buyerList = othersDAO.selectBuyerList(null);
		req.setAttribute("lprodMap", lprodMap);
		req.setAttribute("buyerList", buyerList);
		
		String method = req.getMethod();
		if("post".equalsIgnoreCase(method)){
			ProdVO prod = new ProdVO();
			//기존입력데이터 공유.↓
			req.setAttribute("prod", prod);
			try { 
				BeanUtils.populate(prod, req.getParameterMap());
			} catch (IllegalAccessException | InvocationTargetException e) {
				throw new CommonException(e);
			}

			Map<String, String> errors = new LinkedHashMap<>();
			req.setAttribute("errors", errors);
			
			CustomValidator<ProdVO> validator = new CommonValidator<ProdVO>();
			boolean valid = validator.validate(prod, errors, UpdateGroup.class);
			
			String goPage = null;
			String message = null;
			if (valid) { // 검증 통
				IProdService service = ProdServiceImpl.getInstance();
				ServiceResult result = service.modifyProd(prod);
				if (ServiceResult.OK.equals(result)) {// ok
					goPage = "redirect:/prod/prodView.do?what=" + prod.getProd_id(); //수정이 완료됬다면 db에도 입력되서 정보를 남겨둘 필요가 없으니 redirect로 
				} else {// failed
					message = "서버오류";
					goPage = "prod/prodForm"; 
				}
			} else {// 불통
				goPage = "prod/prodForm";
			}
			req.setAttribute("message", message);
			return goPage;
			
		}else if("get".equalsIgnoreCase(method)){ 
			String prod_id = req.getParameter("what");
			if (StringUtils.isBlank(prod_id)) { // 잘못된 접근
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "상품코드가 없음");
				return null;
			}
			IProdService service = ProdServiceImpl.getInstance();
			ProdVO prod = service.retrieveProd(prod_id);
			req.setAttribute("prod", prod); //기존의 상품정보 보냄.
			return"prod/prodForm"; // do로 보내면 안되죠...
		}else{
			resp.sendError(405, method+"는 지원하지 않음");
		}
		return null;
	}
	
	

}
