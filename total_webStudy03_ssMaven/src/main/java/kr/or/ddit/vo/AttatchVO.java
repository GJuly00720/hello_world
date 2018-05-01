package kr.or.ddit.vo;

import java.io.Serializable;

import kr.or.ddit.CommonException;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AttatchVO implements Serializable {
	public AttatchVO(FileItem item){//메타데이터 할당.
		this.item = item;
		
		att_originalfilename = item.getName();
		att_mime = item.getContentType();
		att_size = item.getSize();
		if(att_size>(900*1024)){
			// 이상일 경우 에러페이지 생성.
			throw new CommonException("파일크기 초과");
		}
		att_fancysize = FileUtils.byteCountToDisplaySize(att_size);
	}
	private Integer bo_no;
	private Integer att_no; //순차번호,, 자동증가.
	private String att_originalfilename;
	private String att_savepath;
	private String att_saveurl;
	private String att_mime;
	private long att_size;
	private String att_fancysize;
	private String att_date; // sysDate
	private Integer att_downcount; // basic 0
	private FileItem item;
}
