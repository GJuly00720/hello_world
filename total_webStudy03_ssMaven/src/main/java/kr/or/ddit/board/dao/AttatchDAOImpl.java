package kr.or.ddit.board.dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.CommonException;
import kr.or.ddit.db.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.AttatchVO;

public class AttatchDAOImpl implements IAttatchDAO {
	SqlMapClient mapper = CustomSqlMapClientBuilder.getSqlMapClient();

	@Override
	public int insertAttatct(AttatchVO attVO) {
		try {
			return mapper.update("Attatch.insertAttatct", attVO);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public AttatchVO selectAttatch(int att_no) {
		try {
			return (AttatchVO) mapper.queryForObject("Attatch.selectAttatch", att_no);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int incrementDownCount(int att_no) {
		try {
			return mapper.update("Attatch.incrementDownCount",att_no);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int deleteAttatch(int att_no) {
		try {
			return mapper.delete("Attatch.deleteAttatch",att_no);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

}
