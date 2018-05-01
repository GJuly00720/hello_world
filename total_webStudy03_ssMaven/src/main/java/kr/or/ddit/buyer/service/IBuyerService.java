package kr.or.ddit.buyer.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.PagingVO;

public interface IBuyerService {
	public ServiceResult createBuyer(BuyerVO buyer);
	
	public BuyerVO retrieveBuyer(String buyer_id);
	
	public int retriveBuyerCount(PagingVO<BuyerVO> pagingVO);
	
	public List<BuyerVO> retrieveBuyerList(PagingVO<BuyerVO> pagingVO);
	
	public ServiceResult modifyBuyer(BuyerVO buyer);
	
	public ServiceResult removeBuyer(BuyerVO buyer);
}	
