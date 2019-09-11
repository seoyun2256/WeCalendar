<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
table {
	margin-left: auto;
	margin-right: auto;
}
#subject {
	font-size: 30px;
}
</style>
</head>
<body>
	<form action="../join.do" method="post">
		<table>
			<tr>
				<th colspan="2" id="subject">회원가입 정보입력</th>
			</tr>
			<tr>
				<td class="text">이름</td>
				<td><input type="text" id="member_name" name="member_name"></td>
			</tr>
			<tr>
				<td class="text">아이디</td>
				<td><input type="text" id="member_id" name="member_id"><input type="button" value="중복확인"></td>
			</tr>
			<tr>
				<td class="text">비밀번호</td>
				<td><input type="text" id="member_pwd" name="member_pwd"></td>
			</tr>
			<tr>
				<td class="text">비밀번호 확인</td>
				<td><input type="text" id="member_pwd_check"></td>
			</tr>
			<tr>
				<td class="text">생년월일</td>
				<td><input type="date" id="member_birth" name="member_birth"></td>
			</tr>
			<tr>
				<td class="text">성별</td>
				<td>
					<label><input id="member_sex" name="member_sex" type="radio" value="남자">남자</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="여자">여자</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="기타">기타</label>
				</td>
			</tr>
			<tr>
				<td><input type="button" value="취소"></td>
				<td><input type="submit" value="회원가입"></td>
			</tr>
		</table>
	</form>
</body>
</html>