package kr.or.ddit.orm;

import java.util.List;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import kr.or.ddit.vo.PersonVO;

public class SpringORMTestView {
	public static void main(String[] args) {
		ConfigurableApplicationContext context =
				new ClassPathXmlApplicationContext(
						"kr/or/ddit/conf/jdbc-context.xml",
						"kr/or/ddit/conf/orm-context.xml"
						);
		SqlMapClientTemplate template = context.getBean(SqlMapClientTemplate.class);
		// ↓d얘가 SqlException -> DataAccessException(unckeched) 전환
		List<PersonVO> list = template.queryForList("Person.selectPersonList"); // 예외가 template안에서 처리된다. (계속처리하던 commonException.)
		for(PersonVO person:list){
			System.out.println(person);
		}
		
	}
}
