package kr.or.ddit.member.service;

import java.sql.ResultSet;
import java.util.List;

import kr.or.ddit.CommonException;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.dao.MemberDAOImpl;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

public class MemberServiceImpl implements IMemberService {
	IMemberDAO memberDAO = new MemberDAOImpl(); // db에서 받아온 정보를 로직생성하는곳을 받아오기
				//DAO와의 의존관계 형성
	
	@Override
	public ServiceResult createMember(MemberVO member) {
//		MemberVO savedMember = memberDAO.selectMember(member.getMem_id());
		ServiceResult result =null;
		try{ 
		/*MemberVO savedMember =*/ retrieveMember(member.getMem_id()); 
			//id가 존재하지 않는다면 예외가 발생하는 로직으로 예외가 발생되어도 되게 try문안에 넣어주고
			//존재한다면 ???
			result = ServiceResult.PKDUPLICATED;
		}catch(CommonException e){
//		if(savedMember==null){
			int rowCnt = memberDAO.insertMember(member);
			if(rowCnt>0){
				result =ServiceResult.OK;
			}else{
				result = ServiceResult.FAILED;
			}
		}
//		}else{
//			result = ServiceResult.PKDUPLICATED;
//		}
		return result; //null이 넘어가면 enum은 가지도 않고 그냥 통과임.
	}
	
	@Override
	public int retrieveMemberCount(PagingVO<MemberVO> pagingVO) {
		return memberDAO.selectMemberCount(pagingVO);
	}

	@Override
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO) {
		List<MemberVO> memberList = memberDAO.selectMemberList(pagingVO);
		//가공해주는 로직
		
		return memberList;
	}

	@Override
	public MemberVO retrieveMember(String mem_id) {
		MemberVO member = memberDAO.selectMember(mem_id);
		if(member==null){
			throw new CommonException(mem_id+"는 존재 ㄴㄴ");
		}
		return member;
	}

	@Override
	public ServiceResult modifyMember(MemberVO member) {//가져온데이터
		MemberVO savedMember = retrieveMember(member.getMem_id());//저장되는 정보 
		//↑ (존재하지 않는 아이디)예외가 발생하는 부분은 여기서 처리함. 걸려버림. 
		String savedPass = savedMember.getMem_pass();
		String inputPass = member.getMem_pass();
		ServiceResult result = null; //serviceresult
		if(savedPass.equals(inputPass)){
			int rowCnt = memberDAO.updateMember(member);
			if(rowCnt>0){
				result=ServiceResult.OK;
			}else{
				result =ServiceResult.FAILED;
			}
		}else{
			result = ServiceResult.INVALIDPASSWORD;
		}
//		ServiceResult serviceResult = null;
//		if(result<=0){
//			serviceResult = ServiceResult.OK;
//		} 
		return result ;
	}

	@Override
	public ServiceResult removeMember(MemberVO member) {
		MemberVO savedMember = retrieveMember(member.getMem_id());
		String savePass = savedMember.getMem_pass();
		String inputPass = member.getMem_pass();
		ServiceResult result= null;
		if(savePass.equals(inputPass)){
			result = ServiceResult.OK;
		}else{
			result = ServiceResult.INVALIDPASSWORD;
		}
		
		return result;
	}


}
