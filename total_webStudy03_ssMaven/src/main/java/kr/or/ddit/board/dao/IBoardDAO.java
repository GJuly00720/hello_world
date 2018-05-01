package kr.or.ddit.board.dao;

import java.util.List;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PagingVO;


/**
 * 게시판 Persistence Layer
 *
 */
public interface IBoardDAO {
	
	/**
	 * 새글 작성
	 * @param board
	 * @return 작성된 글 번호
	 */
	public Integer insertBoard(BoardVO board); //int = 업데이트된 행수 , integer 인서트된 로우카운트
	
	/**
	 * 조건에 맞는 목록 수
	 * @param paging
	 * @return
	 */
	public int selectBoardCount(PagingVO<BoardVO> pagingVO);
	
	/**
	 * 조건에 맞는 글 목록
	 * @param pagingVO
	 * @return 존재하지 않는다면  size == 0
	 */
	public List<BoardVO>selectBoardList(PagingVO<BoardVO> pagingVO);
	
	/**
	 * 글 상세 조회
	 * @param bo_no 조회할 글 번호
	 * @return 존재하지 않는다면 null반환
	 */
	public BoardVO selectBoard(int bo_no);
	
	/**
	 * 조회수 증가
	 * @param bo_no 보고있는 현재 글번호
	 * @return 
	 */
	public int incrementHit(int bo_no);
	
	/**
	 * 추천수 증가
	 * @param bo_no 글번호
	 * @return
	 */
	public int incrementLike(int bo_no);
	
	/**
	 * 비추수 증가
	 * @param bo_no 글번호
	 * @return
	 */
	public int incrementHate(int bo_no);
	
	/**
	 * 글수정
	 * @param board
	 * @return
	 */
	public int updateBoard(BoardVO board);
	
	/**
	 * 글 삭제
	 * @param bo_no 삭제할 글 번호
	 * @return
	 */
	public int deleteBoard(int bo_no);	
	
}
