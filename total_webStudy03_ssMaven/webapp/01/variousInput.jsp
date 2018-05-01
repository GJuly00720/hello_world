<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>01/variousInput.jsp</title>
</head>
<body>
<!-- 대덕인재개발원의 학생을 등록하기 위해, -->
<!-- 개인정보를 입력을 받을수 있도록. UI 구성.  -->
<!-- 이름(name), 나이(age), 성별(gen), 전화번호(hp), 주소(addr), 이메일(mail), 학력(grade), 자격증(lic), 취미(hobby) -->
	<form action="/webStudy01/regist.do" method="post">
		<TABLE>
			<tr>
				<th>이름</th>
				<td>
					<INPUT type="text" name="name" />
				</td>
			</tr>
			<tr>
				<th>나이</th>
				<td>
					<INPUT type="number" min="18" max="50" name="age"
						value="<%=request.getParameter("age") %>"
					 />
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<label><INPUT type="radio"  name="gen" value="F"/>여</label>
					<!-- label로 텍스트도 묶어주면 트리거가 걸려서 텍스트로 클릭해도 체크가 된다. -->
					<label><INPUT type="radio"  name="gen" value="M"/>남</label>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<INPUT type="text" name="hp" placeholder="000-0000-0000" pattern="\d{3}-\d{3,4}-\d{4}" />
						<!-- placehorder: 툴 띄워놓기  -->
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<INPUT type="text" name="addr" />
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<INPUT type="email" name="mail" />
				</td>
			</tr>
			<tr>
				<th>학력</th>
				<td>
					<SELECT name="grade">
						<option value>학력</option>
						<option value="G001">고졸</option>
						<option value="G002">대재</option>
						<option value="G003">초대졸</option>
						<option value="G004">대졸</option>
						<!-- 서버와 db와의 인코딩방식이 다를수있기 때문에 영문으로 된 코드형식을 사용하는 것이 좋다 -->
						<!-- 하지만 하드코딩의 경우 후에 옵션이 추가될경우 다 수정해야한다. 
						그러므로 db에 미리지정되있는 테이블값을 갖고 와 입력하게하는 방식의 코드입력으로 값을 수정되게 하는것이 좋다. 
						중프때 시퀀스갖고 오듯-->
					</SELECT>
				</td>
			</tr>
			<tr>
				<th>자격증</th>
				<td>
					<select name="lic" multiple="multiple" size="10">
						<option value>자격증</option>
						<option value="L001">정보처리산업기사</option>
						<option value="L002">정보처리기사</option>
						<option value="L003">정보보안산업기사</option>
						<option value="L004">정보보안기사</option>		
					</select>		
				</td>
			</tr>
			<tr>
				<th>취미</th>
				<td>
					<input type="checkbox" name="hobby" value="h1"/>게임
					<input type="checkbox" name="hobby" value="h1"/>오락
					<input type="checkbox" name="hobby" value="h1"/>롤
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="등록"/>
					<input type="reset" value="취소"/>
					<input type="button" value="그냥버튼"/>
				</td>
			</tr>
		</TABLE>
	</form>
</body>
</html>