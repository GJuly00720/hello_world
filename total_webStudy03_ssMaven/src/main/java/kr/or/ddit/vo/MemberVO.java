package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.apache.commons.codec.binary.Base64;

import kr.or.ddit.Constants;
import kr.or.ddit.InsertGroup;
import kr.or.ddit.validate.rules.DatePattern;
import kr.or.ddit.validate.rules.NotBlank;
import kr.or.ddit.validate.rules.Range;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 회원 한명의 정보를 담기 위한 객체
 * 1:N  -> has Many 관계로 반영 --> prodList
 * 1:1  -> has a 관계 
 */

@Data
@NoArgsConstructor //기본생성자.. <-얘가있어야 아이바티스가..
@AllArgsConstructor // 모든프로퍼티사용하여 생성자.
public class MemberVO implements Serializable, HttpSessionBindingListener{ //바인딩과 동시에 이벤트 핸들러가 된다.

	@NotBlank(message="회원아이디 필수")
	private String mem_id;
	@NotBlank
	private String mem_pass;
	@NotBlank
	private String mem_name;
	@NotBlank(group=InsertGroup.class)
	private String mem_regno1;
	@NotBlank(group=InsertGroup.class)
	private String mem_regno2;
	@DatePattern("yyyy-MM-dd") //얜 서버사이드 검증 ,datePicker로 클라이언트사이드검증
	private String mem_bir;
	@NotBlank
	private String mem_zip;
	@NotBlank
	private String mem_add1;
	@NotBlank
	private String mem_add2;
	private String mem_hometel;
	private String mem_comtel;
	private String mem_hp;
	private String mem_mail;
	private String mem_job;
	private String mem_like;
	private String mem_memorial;
	@DatePattern("yyyy-MM-dd")
	private String mem_memorialday;
	@Range(min=5000,max=5000)
	private Integer mem_mileage;
	private String mem_delete;

	private byte[] mem_img; //바이너리데이터. DB access용
	public String getBase64Mem_img(){
		if(mem_img!=null){
			return Base64.encodeBase64String(mem_img); // null이 아닐시 getter호출시 인코딩됨.
		}else{
			return "";
		}
	}
	
	private List<ProdVO>prodList; //prod 접근 가능하게 관계 가능성 has many.. 
	private List<String> roles;
	
	
	public String getTestel(){
		return "EL테스트용";
	}
	
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((mem_id == null) ? 0 : mem_id.hashCode());
		return result;
	}
	
	
	@Override
	public boolean equals(Object obj) { //ID 동일한지 여부
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MemberVO other = (MemberVO) obj;
		if (mem_id == null) {
			if (other.mem_id != null)
				return false;
		} else if (!mem_id.equals(other.mem_id))
			return false;
		return true;
	}



	public MemberVO(String mem_id, String mem_pass) {
		super();
		this.mem_id = mem_id;
		this.mem_pass = mem_pass;
	}


	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		if("authMember".equals(event.getName())){
			ServletContext application = event.getSession().getServletContext();
			Map<String, MemberVO> userList = (Map<String, MemberVO>) application.getAttribute(Constants.CURRENTUSERLISTNAME);
			userList.put(mem_id, this);
		}		
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		if("authMember".equals(event.getName())){
			ServletContext application = event.getSession().getServletContext();
			Map<String, MemberVO> userList = (Map<String, MemberVO>) application.getAttribute(Constants.CURRENTUSERLISTNAME);
			userList.remove(mem_id);
		}
		
	}
	
	
}

