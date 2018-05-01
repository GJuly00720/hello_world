package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.CommonException;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

public class ProdListController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String accept = req.getHeader("accept");
		
		String pagestr = req.getParameter("page");
		ProdVO searchVO = new ProdVO(); //검색되는 조건은 모두 vo에서 받아올수 있기 떄문에 vo사용.  
		try {
			BeanUtils.populate(searchVO, req.getParameterMap());//beanUtils 맵형식으로. 처리.
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new CommonException(e);
		}
		
		int currentPage =1;
		if(StringUtils.isNumeric(pagestr)){ //숫자다.
			currentPage = Integer.parseInt(pagestr);
		}
		IProdService service = ProdServiceImpl.getInstance();
		
		PagingVO<ProdVO> pagingVO = new PagingVO<ProdVO>();
		//제너릭타입이기때문에 들어가는 값의 타입에 대해 여기서 결정해준다.
		pagingVO.setScreenSize(3);
		pagingVO.setSearchVO(searchVO); //검색에관한부분도 paging쪽에넘김. 
		
		long totalRecord = service.retrieveProdCount(pagingVO); 
		
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		//페이징 프로퍼티 결정완료.
		
		List<ProdVO> prodList = service.retrieveProdList(pagingVO);
		pagingVO.setDataList(prodList);
//		req.setAttribute("prodList", prodList);

		
		//공유하고 뷰를 사용하면 동기 
		//비동기면 뷰를 사용할 필요도 공유할 필요도 x
		if(StringUtils.containsIgnoreCase(accept, "json")){ //비동기
			resp.setContentType("application/json;charset=UTF-8");
			ObjectMapper objectMapper = new ObjectMapper();
			try(
					PrintWriter out = resp.getWriter();
					){
				objectMapper.writeValue(out, pagingVO);//보내는 데이터는 동기든 비동기든 같다.
			}
			return null;
			
		}else{ //동기처리
			req.setAttribute("pagingVO", pagingVO);
			return "prod/prodList";
		}
		
	}

}
