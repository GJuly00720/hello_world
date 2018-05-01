package kr.or.ddit.commons.service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.MemberVO;

public interface IAuthenticateService {
	
	/**
	 * 인증여부 판단 후, 
	 * 인증 실패라면 ServiceResult 반환.
	 * 인증 성공이라면 인증에 성공한 회원의 정보(MemberVO) 반환.
	 * @param member
	 * @return
	 */
	public Object authenticate(MemberVO member);
}
