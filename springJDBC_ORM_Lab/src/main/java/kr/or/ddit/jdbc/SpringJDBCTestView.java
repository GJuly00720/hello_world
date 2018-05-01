package kr.or.ddit.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

import kr.or.ddit.vo.PersonVO;

public class SpringJDBCTestView {
	public static void main(String[] args) {
		ConfigurableApplicationContext context = new ClassPathXmlApplicationContext("kr/or/ddit/conf/jdbc-context.xml");
		JdbcTemplate template = context.getBean(JdbcTemplate.class); // 개발자가
																		// 짜야하는
																		// 코드의
																		// 축소!!
																		// 여기서
																		// exception
																		// 관리도
																		// 해주고...크으..
		NamedParameterJdbcTemplate namedParameterJdbcTemplate = context.getBean(NamedParameterJdbcTemplate.class); // jdbcTemplate을
																													// 상속받음.
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT PERSON_ID, FIRST_NAME, LAST_NAME ");
		sql.append(" FROM PEOPLE ");
		List<PersonVO> list = template.query(sql.toString(), new RowMapper<PersonVO>() {
			@Override
			public PersonVO mapRow(ResultSet rs, int index) throws SQLException {
				return new PersonVO(rs.getInt("PERSON_ID"), rs.getString("FIRST_NAME"), rs.getString("LAST_NAME"));
			}
		});
		for (PersonVO person : list) {
			System.out.println(person);
		}
		sql.append(" WHERE PERSON_ID = :person_id AND FIRST_NAME = :first_name "); // 스프링의
																					// 인라인
																					// 파라미터
																					// 문법
																					// :파라미터네임
		PersonVO searchVO = new PersonVO();
		searchVO.setPerson_id(1);
		searchVO.setFirst_name("혜선"); // ↓쿼리파라미터를 빈프로퍼티로부터 찾는다
		List<PersonVO> searchList = namedParameterJdbcTemplate.query(sql.toString(),
				new BeanPropertySqlParameterSource(searchVO), new BeanPropertyRowMapper(PersonVO.class));
		System.out.println(searchList);

		StringBuffer insertSql = new StringBuffer();
		insertSql.append(" INSERT INTO PEOPLE(            ");
		insertSql.append(" 		FIRST_NAME, LAST_NAME   ");
		insertSql.append(" )VALUES(                       ");
		insertSql.append(" 		:first_name, :last_name ");
		insertSql.append(" )                              ");
		PersonVO person = new PersonVO("영은", "조");
		int rowCnt = namedParameterJdbcTemplate.update(insertSql.toString(),
				new BeanPropertySqlParameterSource(person));
		if (rowCnt > 0) {
			System.out.println("등록성공");
			searchVO.setPerson_id(3);
			searchVO.setFirst_name("소은");
			PersonVO searchedPerson = namedParameterJdbcTemplate.queryForObject(sql.toString(),
					new BeanPropertySqlParameterSource(searchVO), new BeanPropertyRowMapper<>(PersonVO.class));
			System.out.println(searchedPerson);
		} else {
			System.out.println("등록실패");
		}
	}
}
