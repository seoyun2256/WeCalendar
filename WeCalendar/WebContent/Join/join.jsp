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
				<th colspan="2" id="subject">ȸ������ �����Է�</th>
			</tr>
			<tr>
				<td class="text">�̸�</td>
				<td><input type="text" id="member_name" name="member_name"></td>
			</tr>
			<tr>
				<td class="text">���̵�</td>
				<td><input type="text" id="member_id" name="member_id"><input type="button" value="�ߺ�Ȯ��"></td>
			</tr>
			<tr>
				<td class="text">��й�ȣ</td>
				<td><input type="text" id="member_pwd" name="member_pwd"></td>
			</tr>
			<tr>
				<td class="text">��й�ȣ Ȯ��</td>
				<td><input type="text" id="member_pwd_check"></td>
			</tr>
			<tr>
				<td class="text">�������</td>
				<td><input type="date" id="member_birth" name="member_birth"></td>
			</tr>
			<tr>
				<td class="text">����</td>
				<td>
					<label><input id="member_sex" name="member_sex" type="radio" value="����">����</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="����">����</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="��Ÿ">��Ÿ</label>
				</td>
			</tr>
			<tr>
				<td><input type="button" value="���"></td>
				<td><input type="submit" value="ȸ������"></td>
			</tr>
		</table>
	</form>
</body>
</html>