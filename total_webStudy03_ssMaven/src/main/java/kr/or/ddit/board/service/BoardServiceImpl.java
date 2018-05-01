package kr.or.ddit.board.service;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.CommonException;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.board.dao.AttatchDAOImpl;
import kr.or.ddit.board.dao.BoardDAOImpl;
import kr.or.ddit.board.dao.IAttatchDAO;
import kr.or.ddit.board.dao.IBoardDAO;
import kr.or.ddit.db.CustomSqlMapClientBuilder;
import kr.or.ddit.util.EncryptUtils;
import kr.or.ddit.vo.AttatchVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PagingVO;

public class BoardServiceImpl implements IBoardService {
	IBoardDAO boardDAO = new BoardDAOImpl();// 싱글턴패턴 으로 하는게 맞다. 상품쪽이랑 비교해보자.
	IAttatchDAO attDAO = new AttatchDAOImpl();
	File saveFolder = new File("d:/saveFiles");

	@Override
	public ServiceResult createBoard(BoardVO board) {
		passwordEncrypt(board);
		SqlMapClient mapper = CustomSqlMapClientBuilder.getSqlMapClient();
		// ---------- 여기부터 트랜잭션 직접관리
		try { // dao에서 사용되는부분이 service에서 나오는 비정상적 의존관계. - Spring에서 해소
				// mapper는 어떤 상황에서도 예외 발생
			mapper.startTransaction();

			Integer bo_no = boardDAO.insertBoard(board);
			ServiceResult result = null;
			if (bo_no > 0) {
				List<AttatchVO> attatchList = board.getAttatchList();
				if (attatchList != null && attatchList.size() > 0) { // 파일 有
					mapper.startBatch(); // buffer에 모임. for문 종료시
					for (AttatchVO attVO : attatchList) {
						// if (1 == 1) {
						// throw new RuntimeException(
						// "트랜잭션 관리여부를 확인하기위해 강제발생 예외");
						// }
						attVO.setBo_no(bo_no); // 게시글과의 관계 형성
						attatchFile(attVO); // 이진데이터 저장
						attDAO.insertAttatct(attVO); // 첨부파일의 메타데이터 DB에 저장.
					} // for end
					mapper.executeBatch(); // 여기서 한번에 출력.
				} // if end
					// ----------
				result = ServiceResult.OK;
				mapper.commitTransaction(); // 예외없이 트랜잭션완료시 commit
			} else {
				result = ServiceResult.FAILED;
			}
			return result;
		} catch (SQLException e) {
			throw new CommonException(e);
		} finally {
			try {
				mapper.endTransaction(); // 커밋되지 않은 데이터는 모두 롤백.
			} catch (SQLException e) {
				throw new CommonException(e);
			}
		}
	}

	private void attatchFile(AttatchVO attVO) {
		// 파일의 body 저장 , savePath , saveURL
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		String saveName = UUID.randomUUID().toString();
		File saveFile = new File(saveFolder, saveName);
		try {
			FileUtils.copyInputStreamToFile(attVO.getItem().getInputStream(),
					saveFile);
			attVO.setAtt_savepath(saveFile.getAbsolutePath());
		} catch (IOException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int retrieveBoardCount(PagingVO<BoardVO> pagingVO) {
		return boardDAO.selectBoardCount(pagingVO);
	}

	@Override
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> pagingVO) {
		List<BoardVO> boardList = boardDAO.selectBoardList(pagingVO);
		return boardList;
	}

	@Override
	public BoardVO retrieveBoard(int bo_no) {
		BoardVO board = boardDAO.selectBoard(bo_no);
		if (board == null) {
			throw new CommonException(bo_no + "에 해당하는 글이 없다.");
		}
		boardDAO.incrementHit(bo_no);
		return board;
	}

	@Override
	public void incrementLike(int bo_no) {
		boardDAO.incrementHit(bo_no);
	}

	@Override
	public void incrementHate(int bo_no) {
		boardDAO.incrementHate(bo_no);
	}

	@Override
	public ServiceResult modifyBoard(BoardVO board) {
		BoardVO savedBoard = boardDAO.selectBoard(board.getBo_no());
		if (savedBoard == null) {
			throw new CommonException(board.getBo_no() + "에 해당하는 글이 없음");
		}
		passwordEncrypt(board);
		SqlMapClient mapper = CustomSqlMapClientBuilder.getSqlMapClient();
		try {
			String savedPass = savedBoard.getBo_pass();
			String inputPass = board.getBo_pass();
			ServiceResult result = null;
			if (savedPass.equals(inputPass)) {
				mapper.startTransaction();
				int rowCnt = boardDAO.updateBoard(board);
				if (rowCnt > 0) {
					// 기존 파일 삭제
					Integer[] delAttNos = board.getDelAttNos();
					mapper.startBatch(); // buffer에 모임. for문 종료시
					if(delAttNos!=null && delAttNos.length > 0){
						for(Integer attNo : delAttNos){
							// 파일 BODY(실제 파일) 삭제
//							List<AttatchVO> attList =  savedBoard.getAttatchList();
//							AttatchVO at = attDAO.selectAttatch(attNo);
//							FileUtils.deleteQuietly(at.getAtt_savepath());
							// 메타데이터만 삭제
							attDAO.deleteAttatch(attNo);
						}
					}

					List<AttatchVO> attatchList = board.getAttatchList();
					if (attatchList != null && attatchList.size() > 0) { // 파일 有
						for (AttatchVO attVO : attatchList) {
							// if (1 == 1) {
							// throw new RuntimeException(
							// "트랜잭션 관리여부를 확인하기위해 강제발생 예외");
							// }
							attVO.setBo_no(board.getBo_no()); // 게시글과의 관계 형성
							attatchFile(attVO); // 이진데이터 저장
							attDAO.insertAttatct(attVO); // 첨부파일의 메타데이터 DB에 저장.
						} // for end
						mapper.executeBatch(); // 여기서 한번에 출력.
					} // if end
						// ----------
					mapper.commitTransaction();
					result = ServiceResult.OK;
				} else {
					result = ServiceResult.FAILED;
				}
			} else {
				result = ServiceResult.INVALIDPASSWORD;
			}
			return result;
		} catch (SQLException e) {
			throw new CommonException(e);
		} finally {
			try {
				mapper.endTransaction(); // 커밋되지 않은 데이터는 모두 롤백.
			} catch (SQLException e) {
				throw new CommonException(e);
			}
		}
	}

	private void passwordEncrypt(BoardVO board) { // 암호화확인 단방향 메서드 //콜바이레퍼런스..?
		String inputPass = board.getBo_pass(); // 입력 온 패스 암호화.
		try {
			inputPass = EncryptUtils.oneWayEncryptWithSha256(inputPass); // salt한하고
																			// 단방향
																			// 암호화
			board.setBo_pass(inputPass); // 함호화한것으로 넣기.
		} catch (NoSuchAlgorithmException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public ServiceResult removeBoard(BoardVO board) {
		BoardVO savedBoard = boardDAO.selectBoard(board.getBo_no());
		if (savedBoard == null) {
			throw new CommonException(board.getBo_no() + "에 해당하는 글이 없음");
		}
		passwordEncrypt(board);

		String savedPass = savedBoard.getBo_pass();
		String inputPass = board.getBo_pass();
		ServiceResult result = null;
		if (savedPass.equals(inputPass)) {
			int rowCnt = boardDAO.deleteBoard(board.getBo_no());
			if (rowCnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		return result;
	}

	@Override
	public AttatchVO downlaod(int att_no) {
		AttatchVO attVO = attDAO.selectAttatch(att_no);
		if (attVO == null) {
			throw new CommonException(att_no + "는 존재하지 않습니다.");
		}
		attDAO.incrementDownCount(att_no);
		return attVO;
	}

}
