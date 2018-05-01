package kr.or.ddit.member.dao;

import java.util.List;

import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

/**
 * 회원 관리를 위한 Persistence Layer
 * C : insertMember
 * R : selectMemberList, selectMember
 * U : updateMember
 * D : deleteMember
 *
 */
public interface IMemberDAO {
	
	/**
	 * 신규 등록
	 * @param member 등록할 정보를 가진 vo
	 * @return &lt;0 : 성공, &lt;= : 실패
	 */
	public int insertMember(MemberVO member);
	
	/**
	 * totalRecord를 구하는 메소드
	 * @return 총 레코드의 수를 반환
	 */
	public int selectMemberCount(PagingVO<MemberVO> pagingVO);
	
	/**
	 * 회원 목록 조회
	 * @param pagingVO 검색 조건을 가진 Map 
	 * @return 검색 조건에 해당하는 목록, 
	 * 			검색 조건에 해당하는 데이터가 없는 경우, size == 0
	 */
	public List<MemberVO> selectMemberList(PagingVO<MemberVO> pagingVO);
	
	/**
	 * 회원 정보 상세 조회
	 * @param mem_id
	 * @return 아이디에 해당하는 회원 정보, 
	 * 			존재하지 않는다면 null 반환.
	 */
	public MemberVO selectMember(String mem_id);
	
	/**
	 * 회원 정보 수정
	 * @param member 수정할 정보를 가지 VO
	 * @return &lt; 0: 성공, &lt; = : 실패
	 */
	public int updateMember(MemberVO member); //성공 실패여부 확인을 위한 int return
	
	/**
	 * 회원 정보 삭제
	 * @param mem_id 삭제할 회원의 아이디(pK)
	 * @return &lt; 0 : 성공, &lt;= : 실패
	 */
	public int deleteMember(String mem_id);
}
