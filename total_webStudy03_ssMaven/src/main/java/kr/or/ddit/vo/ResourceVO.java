package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ResourceVO {
	private String res_id;
	private String res_url;
	private String res_note;
	
	private List<String> authorities;
}
