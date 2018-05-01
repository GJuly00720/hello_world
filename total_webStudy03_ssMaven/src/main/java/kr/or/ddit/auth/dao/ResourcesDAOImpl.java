package kr.or.ddit.auth.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.CommonException;
import kr.or.ddit.db.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.ResourceVO;

public class ResourcesDAOImpl implements IResourcesDAO {
	SqlMapClient mapper = CustomSqlMapClientBuilder.getSqlMapClient();
	
	@Override
	public List<ResourceVO> selectResources() {
		try {
			return mapper.queryForList("Resource.selectResources");
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

}
