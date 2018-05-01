package kr.or.ddit.vo;

import java.io.Serializable;


import kr.or.ddit.InsertGroup;
import kr.or.ddit.UpdateGroup;
import kr.or.ddit.validate.rules.NotBlank;
import kr.or.ddit.validate.rules.Range;
import lombok.Data;

@Data
public class ProdVO implements Serializable{
	private long rnum;
	
	
	@NotBlank(group=UpdateGroup.class)
	private String prod_id;
	@NotBlank
	private String prod_name;
	@NotBlank
	private String prod_lgu;
	private String lprod_nm;
	@NotBlank
	private String prod_buyer;
	private String buyer_name;
	
	@NotBlank
	private Integer prod_cost;
	private Integer prod_price;
	private Integer prod_sale;
	private String prod_outline;
	private String prod_detail;
	private String prod_img; //db접근용
	private Integer prod_totalstock;
	private String prod_insdate;
	private Integer prod_properstock;
	@NotBlank(group=InsertGroup.class)
	private String prod_size;
	private String prod_color;
	private String prod_delivery;
	private String prod_unit;
	
	@Range(min=1000, max=8000)
	private Integer prod_qtyin;
	private Integer prod_qtysale;
	
	@Range(min=1000, max=8000)
	private Integer prod_mileage;
	
	
	//거래처와의 has A관계
	private BuyerVO buyer;
	
	
	@Override
	public String toString() {
		return "ProdVO [prod_id=" + prod_id + ", prod_name=" + prod_name
				+ ", prod_lgu=" + prod_lgu + ", prod_buyer=" + prod_buyer
				+ ", prod_cost=" + prod_cost + ", prod_price=" + prod_price
				+ ", prod_sale=" + prod_sale + ", prod_outline=" + prod_outline
				+ ", prod_detail=" + prod_detail + ", prod_img=" + prod_img
				+ ", prod_totalstock=" + prod_totalstock + ", prod_insdate="
				+ prod_insdate + ", prod_properstock=" + prod_properstock
				+ ", prod_size=" + prod_size + ", prod_color=" + prod_color
				+ ", prod_delivery=" + prod_delivery + ", prod_unit="
				+ prod_unit + ", prod_qtyin=" + prod_qtyin + ", prod_qtysale="
				+ prod_qtysale + ", prod_mileage=" + prod_mileage
				+ "]";
	}
	
}
