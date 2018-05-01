package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import kr.or.ddit.InsertGroup;
import kr.or.ddit.validate.rules.NotBlank;
import kr.or.ddit.validate.rules.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor //기본생성자!! 안전을 위해 넣어주는것이 좋다.
public class BoardVO implements Serializable {
	
	private Integer rnum;
	@NotNull
	private Integer bo_no;
	@NotBlank(message="제목은 필수")
	private String bo_title;
	@NotBlank
	private String bo_writer;
	@NotBlank
	private String bo_pass;
	private String bo_mail;
	@NotBlank(group=InsertGroup.class)
	private String bo_ip;
	private String bo_content;
	private String bo_date;
	private Integer bo_hit;
	private Integer bo_like;
	private Integer bo_hate;
	private List<AttatchVO> attatchList;
	private Integer[] delAttNos;
	
}
