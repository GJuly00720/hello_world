package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.board.dao.IBoardDAO;
import kr.or.ddit.vo.AttatchVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PagingVO;

/**
 * 게시판 Business Logic Layer
 *
 */
public interface IBoardService {

	/**
	 * 새글 작성
	 * @param board
	 * @return OK/FAILED
	 */
	public ServiceResult createBoard(BoardVO board); //글번호는 selectKey를 이용하여
	
	/**
	 * 
	 * @param pagingVO
	 * @return
	 */
	public int retrieveBoardCount(PagingVO<BoardVO> pagingVO);
	
	
	/**
	 * 조건에 맞는 목록 조회
	 * @param pagingVO
	 * @return 없다면 size ==0
	 */
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> pagingVO);
	
	/**
	 * 상세조회, 존재한다면, 조회수를 증가.
	 * @param bo_no 글번호
	 * @return 존재하지 않는다면, CommonException 발생
	 * @throws CommonException
	 */
	public BoardVO retrieveBoard(int bo_no);
	
	/**
	 * 추천수 증가
	 * @param bo_no
	 */
	public void incrementLike(int bo_no);
	
	/**
	 * 비추수 증가
	 * @param bo_no
	 */
	public void incrementHate(int bo_no);
	
	
	/**
	 * 글 수정
	 * @param board
	 * @return 존재하지 않는다면, CommonException, INVALIDPASSWORD, OK, FAILED
	 */
	public ServiceResult modifyBoard(BoardVO board);
	
	/**
	 * 글 삭제
	 * @param board
	 * @return  존재하지 않는다면, CommonException, INVALIDPASSWORD, OK, FAILED
	 */
	public ServiceResult removeBoard(BoardVO board);
	
	/**
	 * 첨부파일 다운로드, 존재한다면, downCount 증가.
	 * @param att_no 다운로드할 파일번호
	 * @return 존재하지 않는 경우, CommonException 발생.
	 */
	public AttatchVO downlaod(int att_no);
}
