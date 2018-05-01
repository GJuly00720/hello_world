package kr.or.ddit.db;

import java.io.IOException;
import java.io.Reader;

import kr.or.ddit.CommonException;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class CustomSqlMapClientBuilder {
	private static SqlMapClient mapper;
	static{
		try(
			Reader reader = Resources.getResourceAsReader("/kr/or/ddit/db/ibatis/SqlMapConfig.xml");
				
			//reader 를 쓴이유는 2byte 원하는 형태 모두 읽기위해 (ex.한글)
		){

			mapper =SqlMapClientBuilder.buildSqlMapClient(reader);
		}catch(IOException e){
			throw new CommonException(e); 
		}
	}
	public static SqlMapClient getSqlMapClient(){
		
		return mapper; //싱글턴 객체가 리턴된다.
	}
}
