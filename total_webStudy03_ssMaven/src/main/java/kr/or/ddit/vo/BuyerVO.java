package kr.or.ddit.vo;

import java.io.Serializable;

import java.util.List;

import org.apache.tomcat.util.codec.binary.Base64;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BuyerVO implements Serializable{
	
	private String buyer_id;
	private String buyer_name;
	private String buyer_lgu;
	private String buyer_bank;
	private String buyer_bankno;
	private String buyer_bankname;
	private String buyer_zip;
	private String buyer_add1;
	private String buyer_add2;
	private String buyer_comtel;
	private String buyer_fax;
	private String buyer_mail;
	private String buyer_charger;
	private String buyer_telext;
	private byte[] buyer_img; 
	private List<ProdVO> prodList;
	
	public String getBase64Buyer_img() {
		if(buyer_img!=null) {
			return Base64.encodeBase64String(buyer_img);
		} else {
			return "";
		}
	}
	private BuyerVO buyer;//거래처와의 관계 has A buyer
}
