package kr.or.ddit.member.validate;

import java.util.Map;

import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.MemberVO;

import org.apache.commons.lang3.StringUtils;

public class MemberUpdateValidate  implements CustomValidator<MemberVO>{
	
	@Override
	public boolean validate(MemberVO member, Map<String, String> errors, Class...groups) { 
		//데이터 검증 //테이블의 스키마와 제약조건
	boolean valid = true;
	if (StringUtils.isBlank(member.getMem_id())) {
		valid = false;
		errors.put("mem_id", "회원아이디");
	}
	if (StringUtils.isBlank(member.getMem_pass())) {
		valid = false;
		errors.put("mem_pass", "비밀번호");
	}
	if (StringUtils.isBlank(member.getMem_name())) {
		valid = false;
		errors.put("mem_name", "회원명");
	}
//	if (StringUtils.isBlank(member.getMem_regno1())) { 업데이트에선 해당 구문을 고치지 못하기 떄문에 필요없음.
//		valid = false;
//		errors.put("mem_regno1", "주민번호1");
//		}
//	if (StringUtils.isBlank(member.getMem_regno2())) {
//		valid = false;
//		errors.put("mem_regno2", "주민번호2");
//	}
	if (StringUtils.isBlank(member.getMem_zip())) {
		valid = false;
		errors.put("mem_zip", "우편번호");
	}
	if (StringUtils.isBlank(member.getMem_add1())) {
		valid = false;
		errors.put("mem_add1", "주소1");
	}
	if (StringUtils.isBlank(member.getMem_add2())) {
		valid = false;
		errors.put("mem_add2", "주소2");
	}
	if (StringUtils.isBlank(member.getMem_hometel())) {
		valid = false;
		errors.put("mem_hometel", "집전화");
	}
	if (StringUtils.isBlank(member.getMem_comtel())) {
		valid = false;
		errors.put("mem_comtel", "회사전화");
	}
	if (StringUtils.isBlank(member.getMem_mail())) {
		valid = false;
		errors.put("mem_mail", "메일");
	}

	return valid;
}
	
	
}
