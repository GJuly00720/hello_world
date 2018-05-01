package kr.or.ddit.buyer.dao;

import java.util.List;

import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.PagingVO;

/**
 * c : insertBuyer
 * r : selectedBuyer selectedListBuyer
 * U : updateBuyer
 * d : deleteBuyer
 */
public interface IBuyerDAO {
	
	/**
	 * 신규등록
	 * @param buyer 등록될 정보 VO 
	 * @return &gt; 0 : 성공 ,  &lt;= : 실패
	 */
	public String insertBuyer(BuyerVO buyer);
	
	/**
	 * 거래처 정보 상세 조회
	 * @param mem_id
	 * @return 아이디에 해당하는 거래처 정보, 
	 * 			존재하지 않는다면 null 반환.
	 */
	public BuyerVO selectBuyer(String buyer_id);
	
	/**
	 * totalRecord를 구하는 메소드
	 * @param pagingVO
	 * @return 총 레코드의 수를 반환
	 */
	public int selectBuyerCount(PagingVO<BuyerVO> pagingVO); 
	
	/**
	 * 거래처 목록 조회
	 * @param pMap 검색 조건을 가진 Map 
	 * @return 검색 조건에 해당하는 목록, 
	 * 			검색 조건에 해당하는 데이터가 없는 경우, size == 0
	 */
	public List<BuyerVO> selectBuyerList(PagingVO<BuyerVO> pagingVO);
	
	/**
	 * 거래처 정보 수정
	 * @param member 수정할 정보를 가진 VO
	 * @return &lt; 0: 성공, &lt; = : 실패
	 */
	public int updateBuyer(BuyerVO buyer);
	
	/**
	 * 거래처 정보 삭제
	 * @param buyer_id 삭제할 거래처의 아이디(pK)
	 * @return &lt; 0 : 성공, &lt;= : 실패
	 */
	public int deleteBuyer(String buyer_id);
	
}
