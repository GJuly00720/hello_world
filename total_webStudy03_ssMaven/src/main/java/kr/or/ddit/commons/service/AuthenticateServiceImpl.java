package kr.or.ddit.commons.service;

import java.security.NoSuchAlgorithmException;

import kr.or.ddit.CommonException;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.dao.MemberDAOImpl;
import kr.or.ddit.util.EncryptUtils;
import kr.or.ddit.vo.MemberVO;

public class AuthenticateServiceImpl implements IAuthenticateService {
	IMemberDAO memberDAO = new MemberDAOImpl();
	
	@Override
	public Object authenticate(MemberVO member) {
		MemberVO savedMember = memberDAO.selectMember(member.getMem_id());
		Object result = null;
		if(savedMember==null){
			result = ServiceResult.NOTEXIST;
		}else{
			String inputPass = member.getMem_pass(); // 평문
			inputPass = inputPass +"{"+member.getMem_id()+"}"; // merge salt.
			try {
				inputPass = EncryptUtils.oneWayEncryptWithSha256(inputPass); // encrypted.
			} catch (NoSuchAlgorithmException e) {
				throw new CommonException(e);
			}  
			String savedPass = savedMember.getMem_pass(); // 암호문
			if(savedPass.equals(inputPass)){
				result = savedMember; //성공시 본인 정보리턴
			}else{
				result = ServiceResult.INVALIDPASSWORD;
			}
		}
		return result;
	}

}
