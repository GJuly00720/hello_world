package kr.or.ddit.servlet;

public enum Operator {
	PLUS("+","red"),
	MINUS("-","blue"),
	MULTEPLE("*","green"),
	DIVIDE("/","yellow");
	public String opr;
	public String color;
	private Operator(String opr, String color) {
		this.opr = opr;
		this.color = color;
	}
}
//연산자를 상수로 사용시 
//public static final String Plus = "+";
//일일히 나열하면 너무 힘들다.
//