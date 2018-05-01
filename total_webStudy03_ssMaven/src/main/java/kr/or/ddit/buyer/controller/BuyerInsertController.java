package kr.or.ddit.buyer.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.CommonException;
import kr.or.ddit.InsertGroup;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.buyer.service.BuyerServiceImpl;
import kr.or.ddit.buyer.service.IBuyerService;
import kr.or.ddit.filter.wrapper.FileUploadRequestWrapper;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.dao.OthersDAOImpl;
import kr.or.ddit.validate.CommonValidator;
import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.BuyerVO;

public class BuyerInsertController implements ICommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IOthersDAO othersDAO = new OthersDAOImpl();
		Map<String, Object> lprodMap = othersDAO.selectLprodList();
		req.setAttribute("lprodMap", lprodMap);

		String goPage = null;
		String method = req.getMethod();
		if ("GET".equalsIgnoreCase(method)) {
			goPage = doGet(req, resp);
		} else if ("post".equalsIgnoreCase(method)) {
			goPage = doPost(req, resp);
		} else {
			resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, method + "는 지원하지 않습니다.");
		}
		return goPage;
	}

	public String doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String goPage = "/buyer/buyerForm";
		return goPage;

	}

	public String doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		BuyerVO buyer = new BuyerVO();
		request.setAttribute("buyer", buyer);
		Map<String, String[]> parameterMap = request.getParameterMap();
		try {
			BeanUtils.populate(buyer, parameterMap);
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new CommonException(e);
		}

		Map<String, String> errors = new LinkedHashMap<>();
		request.setAttribute("errors", errors);

		CustomValidator<BuyerVO> validator = new CommonValidator<BuyerVO>();
		boolean valid = validator.validate(buyer, errors, InsertGroup.class);

		String goPage = null;
		boolean redirect = false;
		String message = null;

		if (errors.size() == 0) {
			if (request instanceof FileUploadRequestWrapper) {
				FileItem item = ((FileUploadRequestWrapper) request).getFileItem("buyer_image");
				if (item != null && StringUtils.isNotBlank(item.getName())) {
					buyer.setBuyer_img(item.get());
				}
			}
		}

		if (valid) {
			IBuyerService service = new BuyerServiceImpl();
			ServiceResult result = service.createBuyer(buyer);
			HttpSession session = request.getSession();
			switch (result) {
			case OK:
				goPage = "redirect:/buyer/buyerList.do";
				session.setAttribute("message", buyer.getBuyer_id() + " 등록 완료");
				redirect = true;
				break;
			case PKDUPLICATED:
				message = "아이디 중복";
				goPage = "/buyer/buyerForm";
				break;
			default:
				message = "오류";
				goPage = "/buyer/buyerForm";
			}

		} else {
			goPage = "/buyer/buyerForm";
		}
		request.setAttribute("message", message);
		return goPage;

	}
}
