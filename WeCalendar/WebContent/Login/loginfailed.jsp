<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>We Calendar Login</title>
<style type="text/css">
html {
	width: 100%;
	height: 100%;
}
body {
	width: 95%;
	height: 90%;
	padding: 5px 5px 5px 5px;
}
header {
	height: 40%;
}
article {
	height: 40%;
}
footer {
	height: 20%;
}
header h1 {
	padding-top: 200px;
	color: red;
}
article form table {
	margin-left: auto;
	margin-right: auto;
}
.login_subject {
	font-size: 60px;
}
#id_text, #pwd_text {
	font-size: 25px;
}
#user_id, #user_pwd {
	width: 200px;
}
#join {
	font-size: 30px;
	text-decoration: none;
	color: black;
}
#join:visited {
	color: black;
}
#login_btn {
	width: 60px;
	height: 60px;
}
</style>
</head>
<body>
	<header>
		<h1 class="login_subject" align="center">
		<%
		if(request.getAttribute("chk").equals(1)){
		%>
			�������� �ʴ� ���̵� �Դϴ�
		<%
		}
		else if(request.getAttribute("chk").equals(2)){
		%>
			���̵��� ��й�ȣ�� ��ġ���� �ʽ��ϴ�
		<%
		}
		%>
		</h1>
	</header>
	<article>
		<form action="login.do" method="post">
			<table>
				<tr>
					<td><b id="id_text">�� �� ��</b></td>
					<td style="padding-left: 10px;"><input type="text" name="user_id" id="user_id"></td>
					<td rowspan="2" style="padding-left: 10px;"><input type="submit" value="�α���" id="login_btn"></td>
				</tr>
				<tr>
					<td><b id="pwd_text">��й�ȣ</b></td>
					<td style="padding-left: 10px;"><input type="password" name="user_pwd" id="user_pwd"></td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<h5 align="right"><a href="../Join/join.jsp" id="join">ȸ������</a></h5>
	</footer>
</body>
</html>