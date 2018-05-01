package kr.or.ddit.prod.service;

import java.util.List;

import kr.or.ddit.CommonException;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.prod.dao.IProdDAO;
import kr.or.ddit.prod.dao.ProdDAOImpl;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

public class ProdServiceImpl implements IProdService {
	IProdDAO prodDAO = ProdDAOImpl.getInstance(); 
	
	private ProdServiceImpl(){
		super();
	}
	private static IProdService service;
	
	public static IProdService getInstance(){
		if(service==null){
			service = new ProdServiceImpl();
		}
		return service;
	}
	
	@Override
	public ServiceResult createProd(ProdVO prod) {
		String prod_id = prodDAO.insertProd(prod);
		ServiceResult result = null;
		if(prod_id!=null){
			result =ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public int retrieveProdCount(PagingVO<ProdVO> pagingVO) {
		return prodDAO.selectProdCount(pagingVO);
	}

	@Override
	public List<ProdVO> retrieveProdList(PagingVO pagingVO) {
		return prodDAO.selectProdList(pagingVO);
	}

	@Override
	public ProdVO retrieveProd(String prod_id) {
		ProdVO prod = prodDAO.selectProd(prod_id);
		if(prod==null){
			throw new CommonException(prod_id+"에 해당하는 상품이 없다.");
		}
		return prod;
	}

	@Override
	public ServiceResult modifyProd(ProdVO prod) {
		int cnt = prodDAO.updateProd(prod);
		ServiceResult result = null;
		if (cnt>0) {
			result = ServiceResult.OK;
		} else{
			result = ServiceResult.FAILED;
		}
		return result;
	}

}
