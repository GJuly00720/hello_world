package kr.or.ddit.filter.wrapper;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileUploadRequestWrapper extends HttpServletRequestWrapper {
	//문자데이터용
	private Map<String, String[]> parameterMap;
	
	// 파일데이터용  
	private Map<String, FileItem[]> fileItemMap;

	/**
	 * multipart 요청을 파싱하고,
	 * 비어있는 parameterMap을 채우기 위한 Wrapper 객체.
	 * @throws FileUploadException 
	 */
	public FileUploadRequestWrapper(HttpServletRequest request) throws IOException, FileUploadException { //multiPart요청시에만 사용.
		this(request, -1, null);
	}
	
	public FileUploadRequestWrapper(HttpServletRequest request, int sizeThreshoId, File repository) throws IOException{
		super(request);
		parameterMap = new HashMap<String, String[]>();
		fileItemMap = new HashMap<String, FileItem[]>();
		// 혹시라도 있을 queryString 데이터를 확보하기 위한 코드.
		parameterMap.putAll(request.getParameterMap()); //파라미터를 가장 먼저 꺼내는 곳
		parseRequest(request, sizeThreshoId, repository);
	}
	private void parseRequest(HttpServletRequest request, int sizeThreshoId, File repository) throws IOException {
		DiskFileItemFactory itemFactory = new DiskFileItemFactory();
		if(sizeThreshoId!=-1){
			itemFactory.setSizeThreshold(sizeThreshoId);
		}
		if(repository!=null){
			itemFactory.setRepository(repository);
		}
		ServletFileUpload handler = new ServletFileUpload(itemFactory);//핸들러 //PARCING해서 PART를 FILEiTEM으로 바꿔줌. 크기제한 이곳에서.
		handler.setSizeMax(100*1024*1024); // 업로드되는 게시물의 전체 파일의 사이즈 제한 
//		하나의 요청에 포함될 수 있는 전체 업로드 데이터 크기 제한.
		
//		handler.setFileSizeMax(1024*1204); // 하나의 게시물의 세개의 file중 한건 당의 사이즈 제한.
		List<FileItem> itemList;
		
		try{
			itemList =handler.parseRequest(request); //fileItem으로 파싱.
			for(FileItem item : itemList){
				String fieldname = item.getFieldName();//파라미터네임(input의 네임)
				
				if(item.isFormField()){ // 문자
					String value = item.getString(request.getCharacterEncoding());
					//동일 명의 엔트리가 있는지 확인
					String[] already = parameterMap.get(fieldname);
					String[] array = null;
					if(already==null){ //첫번째 반복
						array = new String[]{value};
					}else{ // 있다면already 보다 한칸 크게...  
						array = new String[already.length+1];
						System.arraycopy(already, 0, array, 0, already.length);
						array[array.length-1] = value;
					}
				
					parameterMap.put(fieldname, array);
				}else{ // 파일기반
					FileItem[] already = fileItemMap.get(fieldname);
					FileItem[] array = null;
					if(already==null){
						array = new FileItem[]{item};
					}else{
						array = new FileItem[already.length+1];
						System.arraycopy(already, 0, array, 0, already.length);
						array[array.length-1] = item;
					}
					fileItemMap.put(fieldname, array);
				}// if~else end
			}// for end
		}catch(FileUploadException e){
			  throw new IOException(e);
		}
	}
	
	@Override
	public Map<String, String[]> getParameterMap() {
		return parameterMap;
	}
	
	@Override
	public String[] getParameterValues(String name) {
		return parameterMap.get(name);
	}
	@Override
	public String getParameter(String name) {
		String value = null;
		if(parameterMap.get(name)!=null && parameterMap.get(name).length>0){
			value = parameterMap.get(name)[0];
		}
		return value;
	}
	
	@Override
	public Enumeration<String> getParameterNames() { // 맵의 키 == 파라미터 명
		final Iterator<String> names =  parameterMap.keySet().iterator();// 생존범위확장
		return new Enumeration<String>() {

			@Override
			public boolean hasMoreElements() { //다음거가 있으면
				return names.hasNext();
			}

			@Override
			public String nextElement() {
				return names.next();
			}
			
		};
	}
	
	public FileItem getFileItem(String name){
		FileItem[] array = fileItemMap.get(name);
		FileItem item = null;
		if(array!=null && array.length >0){
			item = array[0];
		}
		return item;
	}
	
	public FileItem[] getFileItems(String name){
		return fileItemMap.get(name);
	}
	
	public Enumeration<String> getFileItemNames(){
		final Iterator<String> names =  fileItemMap.keySet().iterator();// 생존범위확장
		return new Enumeration<String>() {

			@Override
			public boolean hasMoreElements() { //다음거가 있으면
				return names.hasNext();
			}

			@Override
			public String nextElement() {
				return names.next();
			}
		};
	}
}
