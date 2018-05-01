package kr.or.ddit.prod.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

/**
 * 상품 관리를 위한 Business Logic Layer
 * C : createProd
 * R : retrieveProdCount, retrieveProdList, retrieveProd
 * U : modifyProd
 * D :
 */
public interface IProdService {
	
	/**
	 * 신규 상품 등록
	 * 신규 상품 등록시 등록할 상품의 아이디(상품코드)는 쿼리로 직접 생성하므로 중복체크 불필요.
	 * @param prod
	 * @return OK, FAILED
	 */
	public ServiceResult createProd(ProdVO prod);
	
	/**
	 * 조건에 해당하는 상품 갯수 조회(페이징에 사용)
	 * @param pagingVO 
	 * @return
	 */
	public int retrieveProdCount(PagingVO<ProdVO> pagingVO);
	
	/**
	 * 조건에 해당하는 상품목록 조회 (페이징 적용)
	 * @param pagingVO TODO
	 * @return
	 */
	public List<ProdVO> retrieveProdList(PagingVO pagingVO);
	
	/**
	 * 상품 상세 조회
	 * @param prod_id 조회할 상품코드
	 * @return
	 * @throws CommonException 존재하지 않을 경우 발생.
	 */
	public ProdVO retrieveProd(String prod_id);
	
	/**
	 * 상품 정보 수정
	 * @param prod
	 * @return OK, FAILED
	 * @throws 수정할 상품이 존재하지 않는다면 {@link CommonException} 발생
	 */
	public ServiceResult modifyProd(ProdVO prod);
	
	
}
