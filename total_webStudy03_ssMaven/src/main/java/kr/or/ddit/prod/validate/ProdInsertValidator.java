package kr.or.ddit.prod.validate;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.validate.CustomValidator;
import kr.or.ddit.vo.ProdVO;

public class ProdInsertValidator implements CustomValidator<ProdVO> {

	@Override
	public boolean validate(ProdVO prod, Map<String, String> errors, Class...groups) {
		boolean valid = true;
		if (StringUtils.isBlank(prod.getProd_name())) {
			valid = false;
			errors.put("prod_name", "상품명");
		}
		if (StringUtils.isBlank(prod.getProd_lgu())) {
			valid = false;
			errors.put("prod_lgu", "분류코드");
		}
		if (StringUtils.isBlank(prod.getProd_buyer())) {
			valid = false;
			errors.put("prod_buyer", "거래처코드");
		}
		if (prod.getProd_cost() == null) {
			valid = false;
			errors.put("prod_cost", "구매가");
		}
		if (prod.getProd_price() == null) {
			valid = false;
			errors.put("prod_price", "소비자가");
		}
		if (prod.getProd_sale() == null) {
			valid = false;
			errors.put("prod_sale", "판매가");
		}
		if (StringUtils.isBlank(prod.getProd_outline())) {
			valid = false;
			errors.put("prod_outline", "기본정보");
		}
		if (StringUtils.isBlank(prod.getProd_img())) {
			valid = false;
			errors.put("prod_img", "상품이미지");
		}
		if (prod.getProd_totalstock() == null) {
			valid = false;
			errors.put("prod_totalstock", "재고량");
		}
		if (StringUtils.isBlank(prod.getProd_insdate())) {
			valid = false;
			errors.put("prod_insdate", "입고일");
		}
		if (prod.getProd_properstock() == null) {
			valid = false;
			errors.put("prod_properstock", "안전재고량");
		}
		return valid;
	}

}
