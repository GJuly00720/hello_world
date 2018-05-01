package kr.or.ddit.member.validate;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.vo.MemberVO;

public class MemberInsertValidate extends MemberUpdateValidate {
	@Override
	public boolean validate( MemberVO member , Map<String,String> errors, Class...groups){
		boolean valid = super.validate(member, errors);
		//추가기능을 넣을 때는 직접 넣는게 아닌 상속을 통한 입력.
		
		if (StringUtils.isBlank(member.getMem_regno1())) {
		valid = false;
		errors.put("mem_regno1", "주민번호1");
		}
		if (StringUtils.isBlank(member.getMem_regno2())) {
			valid = false;
			errors.put("mem_regno2", "주민번호2");
		}
		return valid;
	}
	
}
