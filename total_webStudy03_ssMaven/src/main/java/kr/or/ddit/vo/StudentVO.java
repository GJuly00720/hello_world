package kr.or.ddit.vo;

import java.util.Arrays;

public class StudentVO {
	private String name;
	private int age;
	private String mail;
	private String grade;
	private String hp;
	private String addr;
	private String gen;
	private String[] lic;
	private String[] hobby;
	//프로퍼티선언 후 캡슐화까지 완료
	
	@Override
	public String toString() {
		return "StudentVO [name=" + name + ", age=" + age + ", mail=" + mail
				+ ", grade=" + grade + ", hp=" + hp + ", addr=" + addr
				+ ", gen=" + gen + ", lic=" + Arrays.toString(lic) + ", hobby="
				+ Arrays.toString(hobby) + "]";
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getGen() {
		return gen;
	}
	public void setGen(String gen) {
		this.gen = gen;
	}
	public String[] getLic() {
		return lic;
	}
	public void setLic(String[] lic) {
		this.lic = lic;
	}
	public String[] getHobby() {
		return hobby;
	}
	public void setHobby(String[] hobby) {
		this.hobby = hobby;
	}
	
	
	
	
}
