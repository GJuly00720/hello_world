package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;




import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.CommonException;
import kr.or.ddit.db.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

public class MemberDAOImpl implements IMemberDAO {
	
	SqlMapClient mapper = CustomSqlMapClientBuilder.getSqlMapClient();

	@Override
	public int insertMember(MemberVO member) {
		try {
//			ibatis를 이용한 insert 쿼리 실행 방법
//			1. Object insert : selectKey를 사용해서 PK를 직접 생성해주는 경우.
//					마지막에 생성된 PK 가 리턴값으로 반환됨.
//			2. int update : selectKey를 사용하지 않고, PK를 입력받아 처리할 때.
			return mapper.update("Member.insertMember", member);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}


	@Override
	public int selectMemberCount(PagingVO<MemberVO> pagingVO) {
		try {
			return (Integer) mapper.queryForObject("Member.selectMemberCount",pagingVO);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public List<MemberVO> selectMemberList(PagingVO<MemberVO> pagingVO) {
		try {								//pMap에는?? 키이름, 파라미터 클래스의 객체
			return mapper.queryForList("Member.selectMemberList",pagingVO);
										
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public MemberVO selectMember(String mem_id) {
		try {
			//resultClass타입의 객체 <-(실행할 쿼리 아이디, 쿼리파라미터 (클래스타입의) 객체)
			//			↑ 얘로 다운캐스팅.
			//쿼리xml의 형태는 여기선언부의 시그니쳐타입(파라미터의 타입)으로 결정 
			// == 동적 xml작성 가능. 구현체 자동실시간 구현 가능 == mybatis
			return (MemberVO)mapper.queryForObject("Member.selectMember", mem_id);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int updateMember(MemberVO member) {
		try {
			return mapper.update("Member.updateMember", member);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}

	@Override
	public int deleteMember(String mem_id) {
		try {
			return mapper.update("Member.deleteMember", mem_id);
		} catch (SQLException e) {
			throw new CommonException(e);
		}
	}






}
