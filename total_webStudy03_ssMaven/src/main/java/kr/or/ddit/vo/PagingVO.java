package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * 페이징 프로퍼티를 결정하기 위해서,
 * setTotalRecord, setCurrentPage 를 호출해야 함.
 * 
 * @param <T> 페이징 처리 대상이 되는 domain layer
 */

@Getter
@Setter
public class PagingVO<T> implements Serializable{  
	private long totalRecord;
	private int screenSize = 10;
	private int blockSize = 5; 
	private long totalPage;
	private int currentPage;
	private int startRow;
	private int endRow;
	private long startPage;
	private long endPage;
	private T searchVO;//상품목록을 조회할때 같이 필요타입선택가능!!!올ㅋ
	private List<T> dataList; //모든 목록들을 담기위해 제너릭타입으로. 
	private String searchType;
	private String searchWord;

	public PagingVO() { //지금 그대로
		super();
	}

	public PagingVO(int screenSize, int blockSize) { //값 변경해서
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	public void setTotalRecord(long totalRecord) {
		this.totalRecord = totalRecord;
		totalPage = (long)Math.ceil(totalRecord/ (double)screenSize);
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * screenSize;
		startRow = endRow -(screenSize -1);
		startPage = ((currentPage-1)/blockSize)*blockSize+1;
		endPage = startPage + (blockSize -1);
	}

	
	public String getPagingHTML(){
		StringBuffer html=new StringBuffer("<nav><ul class='pagination'>");
		String pattern = "  <li class='page-item %s'><a class='page-link' href='?page=%d' data-page='%d'>%s</a></li>";
		if(startPage>1){					//data는 맵형태로 관리. [page='%d']
		html.append(String.format(pattern, "disabled", (startPage-blockSize), (startPage-blockSize), "이전"));
		}
		for(long pageNum = startPage; //초기값 
				pageNum<=(endPage > totalPage ? 
						totalPage : endPage);  //엔드페이지와 비교
				pageNum++){
			if(pageNum == currentPage){
//				html.append("["+pageNum+"]");
				html.append(String.format(pattern, "active", pageNum, pageNum, pageNum));
			}else{
				html.append(String.format(pattern, "", pageNum, pageNum, pageNum));
			}
		}
		if(endPage<totalPage){
			html.append(String.format(pattern, "", (endPage+1), (endPage+1), "다음"));
		}else{
			html.append(String.format(pattern, "disabled", (endPage+1), (endPage+1), "다음"));
		}
		html.append("</ul></nav>");
		return html.toString();
	}
	
	
	
	

}
