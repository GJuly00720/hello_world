package kr.or.ddit.prod.dao;

import java.util.List;

import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

/**
 * 상품관리를 위한 Persistence Layer
 * C : insertProd
 * R : selectProdCount, selectProdList, selectProd
 * U : updateProd
 * D : deleteProd
 */
public interface IProdDAO { 
	/**
	 * 신규 상품 등록
	 * @param prod 등록할 상품정보를 가진 VO
	 * @return 신규로 등록한 상품 코드(상품아이디) 새로insert한 코드의 PK(쿼리문으로 생성할것)
	 */
	public String insertProd(ProdVO prod);
	
	/**
	 * 조건에 해당하는 상품 갯수 (페이징 처리에 사용됨)
	 * @param pagingVO TODO
	 * @return
	 */
	public int selectProdCount(PagingVO<ProdVO> pagingVO);
	
	/**
	 * 조건에 해당하는 상품 목록 조회(페이징 처리가 적용됨.)
	 * @param pagingVO TODO
	 * @return
	 */
	public List<ProdVO> selectProdList(PagingVO pagingVO);
	
	/**
	 * 상품 상세조회
	 * @param prod_id 조회할 상품코드
	 * @return 존재하지 않는다면, null반환.
	 */
	public ProdVO selectProd(String prod_id);
	
	/**
	 * 상품 정보 수정
	 * @param prod 수정할 정보를 가진 VO
	 * @return &lt; 0 : 성공, &lt;= 0 : 실패
	 */ 
	public int updateProd(ProdVO prod);

	
	//CART등에 자식이 존재하므로, 삭제불가, cascade옵션도 없음, 불가
	//그럼 Flag컬럼은 있나? 없다! 불가!
//	public int deleteProd(String prod_id);

}
