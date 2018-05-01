package kr.or.ddit.buyer.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.CommonException;
import kr.or.ddit.db.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.PagingVO;

public class BuyerDAOImpl implements IBuyerDAO{
	SqlMapClient mapper = CustomSqlMapClientBuilder.getSqlMapClient();
	
	@Override
	public String insertBuyer(BuyerVO buyer) {
		try {
			return (String)mapper.insert("Buyer.insertBuyer", buyer);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public BuyerVO selectBuyer(String buyer_id) {
		try {
			return (BuyerVO) mapper.queryForObject("Buyer.selectBuyer", buyer_id);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}
	
	@Override
	public int selectBuyerCount(PagingVO<BuyerVO> pagingVO) {
		try {
			return (Integer) mapper.queryForObject("Buyer.selectBuyerCount", pagingVO);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}
	
	@Override
	public List<BuyerVO> selectBuyerList(PagingVO<BuyerVO> pagingVO) {
		try {
			return mapper.queryForList("Buyer.selectBuyerList",pagingVO);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int updateBuyer(BuyerVO buyer) {
		try {
			return mapper.update("Buyer.updateBuyer", buyer);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int deleteBuyer(String buyer_id) {
		try {
			return mapper.update("Buyer.deleteBuyer", buyer_id);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	
}
