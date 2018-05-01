package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

/**
 * 회원 관리를 위한  Business Logic Layer(Service Layer) 
 * C : createMember 
 * R : retrieveMemberList, retrieveMember
 * U : modifyMember
 * D : removeMember
 * 
 * 기능을 따라 만들어진 이름들.
 */
public interface IMemberService {

	/**
	 * 신규 회원 등록
	 * @param member
	 * @return OK, FAILED, PKDUPLICATED
	 */
	public ServiceResult createMember(MemberVO member);
	
	/**
	 * 조건에 해당하는 member수 조회 
	 * @param pagingVO 
	 * @return
	 */
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO);
	
	/**
	 * 검색 조건에 해당하는 회원 목록 조회
	 * @param  pagingVO 검색 조건
	 * @return 조건에 해당하는 목록, 존재하지 않는 경우, size ==0;
	 * 
	 */
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO);
	
	/**
	 * 회원 상세 조회
	 * @param mem_id 조회할 회원의 아이디(PK);
	 * @return 존재하지 않는다면, (customException)== CommonException 발생
	 * @throws CommonException 아이디에 해당하는 회원이 존재하지 않는 경우, 발생. //
	 */
	public MemberVO retrieveMember(String mem_id);
	
	/**
	 * 회원 정보 수정
	 * @param member
	 * @return 존재하지 않는다면, (customException)== CommonException 발생
	 * 			INVALIDPASSWORD, OK, FAILED
	 * @throws CommonException 아이디에 해당하는 회원이 존재하지 않는 경우, 발생. 
	 * 
	 */
	public ServiceResult modifyMember(MemberVO member);
	
	/**
	 * 회원 탈퇴(혹은 회원정보 삭제)
	 * @param member
	 * @return 존재하지 않는다면, (customException) == CommonException 발생
	 * 			INVALIDPASSWORD, OK, FAILED
	 * @throws CommonException 아이디에 해당하는 회원이 존재하지 않는 경우, 발생. 
	 */
	public ServiceResult removeMember(MemberVO member);
}
