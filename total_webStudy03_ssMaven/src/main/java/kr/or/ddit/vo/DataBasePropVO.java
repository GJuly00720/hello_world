package kr.or.ddit.vo;

import java.io.Serializable;

/**
 * 오라클의 DataBase_Properties 뷰의 레코드 정보를 가진 Value Object
 * VO(Value Object), DTO(Data Transfer Object)//데이터 전달, Model
 * 						네트웤 단위							<<<이둘을 묶어서 Model 
 * :: 데이터 전달시 묶어서 한번에 전달하는 방법.
 * EJB 규약(JavaBeans 규약)에 따른 VO 정의 방법.
 * 1. 값을 가질수 있는 Property(field) 정의 (전역변수)
 * 2. 적절한 접근 제어 설정 (캡슐화)
 * 3. 제어되는 방식에 따른 인터페이스 방식 제공. 즉, 캡슐화 되어있는 데이터에 접근 방법을 제공.
 * 		getter/setter : get[set] 프로퍼티명의 첫 문자를 대문자로.
 * 4. 값을 확인 하는 방법 제공 (toString()). 
 * 		물론 다른거 써도 되지만 모든 객체는 object를 물려받은 toString을 을 갖고있으니 공통적인 방법을 통해 확인 할 수 있도록
 * 5. 상태 값을 비교할 수 있는 방법 제공 (equals) 
 * 6. 직렬화 가능. (implements Serializable) <- 직렬화 가능한 객체인지 확인해줌.
 * 		직렬화 : 매체를 통해 전송이나 저장하기 위해 객체를 바이트 배열로 스트림화.(변경하는것.) 
 * 						ex) readObject , writeObject .. etc;
 */

public class DataBasePropVO implements Serializable{ // 1.클래스 생성 (내부 변수에 대한 접근 권한 (3.)을 해당 클래스가 갖고 있음.)
	private String property_name; //2. 값들의 변수 생성 
	private String property_value;
	private String description; 
	// 3. 직접접근을 막기위한 private화 //캡슐화
	
	// 4. getter setter 생성 (Value Object) 
	public String getProperty_name() {
		return property_name;
	}
	public void setProperty_name(String property_name) {
		this.property_name = property_name;
	}
	public String getProperty_value() {
		return property_value;
	}
	public void setProperty_value(String property_value) {
		this.property_value = property_value;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString() { //값을 확인하는 방법 제공
		return "DataBasePropVO [property_name=" + property_name
				+ ", property_value=" + property_value + ", description="
				+ description + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((property_name == null) ? 0 : property_name.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) { //상태 비교 방법 제공
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DataBasePropVO other = (DataBasePropVO) obj;
		if (property_name == null) {
			if (other.property_name != null)
				return false;
		} else if (!property_name.equals(other.property_name))
			return false;
		return true;
	}
	 
}
