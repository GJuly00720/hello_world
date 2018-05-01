package kr.or.ddit.vo;

import lombok.Data;

@Data
public class FileVO {
	private String originalFileName; // 원본파일명
	private String savePath; // 파일시스템상의 저장 경로
	private String saveUrl; //웹서버상의 저장 url
	private String mime; 
	private long size; 
}