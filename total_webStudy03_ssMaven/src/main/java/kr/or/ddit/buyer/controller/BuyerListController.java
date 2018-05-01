package kr.or.ddit.buyer.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.CommonException;
import kr.or.ddit.buyer.service.BuyerServiceImpl;
import kr.or.ddit.buyer.service.IBuyerService;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.dao.OthersDAOImpl;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.PagingVO;

public class BuyerListController implements ICommandHandler{
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		IOthersDAO othersDAO = new OthersDAOImpl();
		Map<String,Object > lprodMap =  othersDAO.selectLprodList();
		request.setAttribute("lprodMap", lprodMap);
		
		String accept = request.getHeader("Accept");
		String pageStr = request.getParameter("page");
		BuyerVO searchVO = new BuyerVO();
		try {
			BeanUtils.populate(searchVO, request.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new CommonException(e);
		}
		int currentPage = 1;
		if(StringUtils.isNumeric(pageStr)){
			currentPage = Integer.parseInt(pageStr);
		}
		IBuyerService service = new BuyerServiceImpl();
		PagingVO<BuyerVO> pagingVO = new PagingVO<BuyerVO>();
		pagingVO.setScreenSize(3);
		pagingVO.setSearchVO(searchVO);
		long totalRecode = service.retriveBuyerCount(pagingVO);
		pagingVO.setTotalRecord(totalRecode);
		pagingVO.setCurrentPage(currentPage);
		List<BuyerVO> buyerList = service.retrieveBuyerList(pagingVO);
		pagingVO.setDataList(buyerList);
		
		if(StringUtils.containsIgnoreCase(accept, "json")){
			response.setContentType("application/json;charset=UTF-8");
			ObjectMapper objectMapper = new ObjectMapper();
			try(
					PrintWriter out = response.getWriter();
					){
				objectMapper.writeValue(out, pagingVO);
			}
			return null;
		}else{
			request.setAttribute("pagingVO", pagingVO);
			String goPage = "/buyer/buyerList";
			return goPage;
		}
		
	}
}
