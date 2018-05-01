package kr.or.ddit.prod.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BuyerVO;

public interface IOthersDAO {
	/**
	 * LPROD 의 모든 분류 정보 조회
	 * @return 분류코드를 키로, 분류명을 value로 갖는 엔트리 집합.
	 */
	public Map<String, Object> selectLprodList(); 
	
	/**
	 * 거래처 목록 조회
	 * @return 거래처 코드, 거래처명, 거래처 분류코드 
	 */
	public List<BuyerVO>selectBuyerList(String buyer_lgu);
}