package kr.or.ddit.prod.validate;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.vo.ProdVO;

public class ProdUpdateValidator extends ProdInsertValidator {
	@Override
	public boolean validate(ProdVO prod, Map<String, String> errors, Class...groups) {
		boolean valid =super.validate(prod, errors);
		if(StringUtils.isBlank(prod.getProd_id())){
			valid = false;
			errors.put("prod_id","상품아이디는 필수데이터");
		}
		return valid;
	}
}
