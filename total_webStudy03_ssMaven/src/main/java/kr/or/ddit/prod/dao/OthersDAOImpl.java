package kr.or.ddit.prod.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import kr.or.ddit.CommonException;
import kr.or.ddit.db.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.BuyerVO;

public class OthersDAOImpl implements IOthersDAO {
	SqlMapClient mapper = CustomSqlMapClientBuilder.getSqlMapClient(); 
	
	@Override
	public Map<String, Object> selectLprodList() {
		try {
			return mapper.queryForMap("Others.selectLprodList", null, "lprod_gu", "lprod_nm");
							
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public List<BuyerVO> selectBuyerList(String buyer_lgu) {
		try {
			return mapper.queryForList("Others.selectBuyerList",buyer_lgu);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

}
