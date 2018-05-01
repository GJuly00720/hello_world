package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.CommonException;
import kr.or.ddit.db.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PagingVO;

public class BoardDAOImpl implements IBoardDAO {
	SqlMapClient mapper = CustomSqlMapClientBuilder.getSqlMapClient();
	
	
	@Override
	public Integer insertBoard(BoardVO board) {
		try {
			return (Integer) mapper.insert("Board.insertBoard", board);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int selectBoardCount(PagingVO<BoardVO> pagingVO) {
		try {
			return (Integer) mapper.queryForObject("Board.selectBoardCount", pagingVO);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public List<BoardVO> selectBoardList(PagingVO<BoardVO> pagingVO) {
		try {
			return mapper.queryForList("Board.selectBoardList", pagingVO);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public BoardVO selectBoard(int bo_no) {
		try {
			return (BoardVO) mapper.queryForObject("Board.selectBoard", bo_no);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int incrementHit(int bo_no) {
		try {
			return mapper.update("Board.incrementHit",bo_no);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int incrementLike(int bo_no) {
		try {
			return mapper.update("Board.incrementLike",bo_no);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int incrementHate(int bo_no) {
		try {
			return mapper.update("Board.incrementHate",bo_no);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int updateBoard(BoardVO board) { //인트로 되어있으면 업뎃 객체로되어있음 인서트!!!!
		try {
			return mapper.update("Board.updateBoard", board);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int deleteBoard(int bo_no) {
		try {
			return mapper.delete("Board.deleteBoard", bo_no);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}
}
