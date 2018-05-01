package kr.or.ddit.buyer.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.CommonException;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.buyer.dao.BuyerDAOImpl;
import kr.or.ddit.buyer.dao.IBuyerDAO;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.PagingVO;

public class BuyerServiceImpl implements IBuyerService{
	IBuyerDAO buyerDAO = new BuyerDAOImpl();
	
	@Override
	public ServiceResult createBuyer(BuyerVO buyer) { //입력받은 정보갖고 검증ㄱㄱ
		String buyer_id = buyerDAO.insertBuyer(buyer);
		
		ServiceResult result = null;
		if(StringUtils.isNotBlank(buyer_id)){
			result = ServiceResult.OK;
		}else{
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public BuyerVO retrieveBuyer(String buyer_id) {
		BuyerVO buyer = buyerDAO.selectBuyer(buyer_id);
		if(buyer==null){
			throw new CommonException(buyer_id+"에 해당하는 거래처 코드가 존재하지 않습니다.");
		}
		return buyer;
	}
	
	@Override
	public int retriveBuyerCount(PagingVO<BuyerVO> pagingVO) {
		return buyerDAO.selectBuyerCount(pagingVO);
	}

	
	@Override
	public List<BuyerVO> retrieveBuyerList(PagingVO<BuyerVO> pagingVO) {
		List<BuyerVO> buyerList = buyerDAO.selectBuyerList(pagingVO);
			
		return buyerList;
	}

	@Override
	public ServiceResult modifyBuyer(BuyerVO buyer) {
		BuyerVO vo = retrieveBuyer(buyer.getBuyer_id());
		String saveId = vo.getBuyer_id();
		String buyerID = buyer.getBuyer_id();
		ServiceResult result = null;
		if(saveId.equals(buyerID)){
			int rowCnt = buyerDAO.updateBuyer(buyer);
			if(rowCnt>0){
				result=ServiceResult.OK;
			}else{
				result=ServiceResult.FAILED;
			}
		}else{
			result=ServiceResult.PKDUPLICATED;
		}
		return result;
	}

	@Override
	public ServiceResult removeBuyer(BuyerVO buyer) {
		BuyerVO vo = retrieveBuyer(buyer.getBuyer_id());
		String saveId = vo.getBuyer_id();
		String buyerID = buyer.getBuyer_id();
		ServiceResult result =null;
		if(saveId.equals(buyerID)){
			int rowCnt = buyerDAO.deleteBuyer(vo.getBuyer_id());
			if(rowCnt>0){
				result=ServiceResult.OK;
			}else{
				result=ServiceResult.FAILED;
			}
		} else{
			 result = ServiceResult.PKDUPLICATED;
		}
		return result;
	}


}
