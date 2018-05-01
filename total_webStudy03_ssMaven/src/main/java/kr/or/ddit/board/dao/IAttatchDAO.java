package kr.or.ddit.board.dao;

import kr.or.ddit.vo.AttatchVO;

/**
 * 첨부파일 관리를 위한 Reresistence Layer
 * C: insertAttatct (selectkey)
 * R: 상세(다운로드) selectAttatch, DownCount증가 incrementDownCount
 * D: 삭제 deleteAttatch
 *
 */
public interface IAttatchDAO {
	/**
	 * 첨부파일 등록
	 * @param attVO
	 * @return 등록첨부파일 수 (> 0 : 성공)
	 */
	public int insertAttatct(AttatchVO attVO);
	
	/**
	 * 다운로드를 위한 상세조회
	 * @param att_no 다운로드할 파일번호
	 * @return 존재하지 않는 다면, null 반환
	 */
	public AttatchVO selectAttatch(int att_no);
	
	/**
	 * 다운로드 횟수 증가
	 * @param att_no 
	 * @return
	 */
	public int incrementDownCount(int att_no);
	
	/**
	 * 첨부파일 삭제
	 * @param att_no 삭제할 파일 번호
	 */
	public int deleteAttatch(int att_no);
}
