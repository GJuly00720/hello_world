package kr.or.ddit.util;

import java.util.regex.Pattern;

public class RegularDB {

	public boolean checkMemberName(String memberName) {
		boolean regName=Pattern.matches("[가-힣]{2,6}|[A-Za-z]{3,12}", memberName);
		return regName;
	}

	public boolean checkMemberPhone(String memberPhone) {
		boolean regPhone =Pattern.matches("^(01)[016789][0-9]{3,4}[0-9]{4}", memberPhone);
		return regPhone;
	}

	public boolean checkMemberPw(String memberPassword) {
		boolean regPw = Pattern.matches("[A-Z|a-z|0-9|[(!)*(@)*(#)*($)*(%)*(^)*(&)*(*)*]]{6,18}", memberPassword);
		return regPw;
	}

	public boolean checkMemberEmail(String memberEmail) {
		boolean regEmail =Pattern.matches("[A-Za-z0-9!@#$%^&*]{1,}@[A-Za-z0-9]{1,8}.[A-Za-z]{2,3}(.kr)?", memberEmail); 
		return regEmail;
	}

	public boolean validationIdCard(String memberIdcard) {
		boolean regIdCard =
		Pattern.matches("[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])([1-4])([0-9]{6})", memberIdcard); 
		return regIdCard;
	}



}
