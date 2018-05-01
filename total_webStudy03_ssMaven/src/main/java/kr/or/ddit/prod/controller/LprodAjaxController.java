package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.prod.dao.IOthersDAO;
import kr.or.ddit.prod.dao.OthersDAOImpl;

public class LprodAjaxController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException { // 비동기 요청시.
		//요구되는 파라미터의 형식 확인. 요청의 accept확인
		String accept = req.getHeader("Accept");
		IOthersDAO othersDAO = new OthersDAOImpl();
		Map<String,Object> lprodMap = othersDAO.selectLprodList();
//		{	"P101":"전자제품",	"P102":"화장품" 	} <- 마샬링.
		// Marshalling : 데이터의 공통 표현방식에 따라 변환하는 작업(to JSON, XML)
		StringBuffer json = new StringBuffer("{");
		String ptrn = "\"%s\":\"%s\",";
		for(Entry<String,Object> entry : lprodMap.entrySet()){ 
			String propName= entry.getKey();
			Object propValue = entry.getValue();
			json.append(String.format(ptrn, propName, propValue.toString()));
		}
		json.deleteCharAt(json.lastIndexOf(","));
		json.append("}");
		// UnMarshalling : 공통 표현방식으로 전달된 데이터를 특정 언어로 다시 변환하는 작업(From JSON, XML)
		// 비동기에 대한 처리구조 ↑ 요청과 응답에 따라 끊임없이 반복.
		
		
		if(StringUtils.containsIgnoreCase(accept, "json")){ //포함하고 있으면
			resp.setContentType("application/json;charset=UTF-8"); // 응답의 형태 요청과 동일하게 지정.
			try(
					PrintWriter out = resp.getWriter();
			){
				// 직렬화(Serialize)
				out.print(json);
			}
		}
		return null; //ui가 아닌 데이터만 나감.
		//json : 서로다른 언어시스템들 사이에 통용되는 언어? 
		//마샬링,언마샬링 : 다른 언어시스템들을 서로 통역해주는..? 
	}

}
 