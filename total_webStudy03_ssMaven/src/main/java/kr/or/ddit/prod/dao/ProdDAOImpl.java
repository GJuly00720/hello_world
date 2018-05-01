package kr.or.ddit.prod.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.CommonException;
import kr.or.ddit.db.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

public class ProdDAOImpl implements IProdDAO {
	SqlMapClient mapper = CustomSqlMapClientBuilder.getSqlMapClient();
	
	private ProdDAOImpl(){//생성자 묶기
		super();
	}
	
	private static IProdDAO prodDAO;
	
	public static IProdDAO getInstance(){//생성자 역활할 게터
		if(prodDAO==null){
			prodDAO= new ProdDAOImpl();
		}
		return prodDAO;
	}
	
	@Override
	public String insertProd(ProdVO prod) { //클라이언트에게 상품아이디 코드를 입력받지않음.
		try {
			return (String) mapper.insert("Prod.insertProd", prod);  // selectkey의 resultclass에 따라 다운캐스팅. return값은 셀렉트키에서 만들어지는 그 파라미터..?
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int selectProdCount(PagingVO<ProdVO> pagingVO) {
		try {
			return (Integer) mapper.queryForObject("Prod.selectProdCount", pagingVO);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public List<ProdVO> selectProdList(PagingVO pagingVO) {
		try {
			return mapper.queryForList("Prod.selectProdList",pagingVO);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public ProdVO selectProd(String prod_id) {
		try {
			return (ProdVO) mapper.queryForObject("Prod.selectProd", prod_id);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int updateProd(ProdVO prod) {
		try {
			return mapper.update("Prod.updateProd", prod);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

}
