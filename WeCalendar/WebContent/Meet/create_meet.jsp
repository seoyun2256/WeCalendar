<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
function formCheck(){
	if($('#meet_name').val() == ""){
		alert("���� �̸��� �Է����ּ���!");
		$('#meet_name').focus();
		return;
	}

	$('#meetform').submit();
}
</script>
</head>
<body>
	<h1>WeCalendar ���� ����</h1>
	<form id="meetform" action="create_meet.do" method="post" onkeydown="javascript:if(event.keyCode==13) return false;">
		<input type="hidden" id="member_num" name="member_num" value="<%=session.getAttribute("mnum") %>">
		<table>
			<tr>
				<th>���� �̸�</th>
				<td><input type="text" id="meet_name" name="meet_name"></td>
			</tr>
			<tr>
				<th>���� �Ұ�</th>
				<td><input type="text" id="meet_content" name="meet_content"></td>
			</tr>
			<tr>
				<td><input type="button" onclick="location.href='../MainView/wecal_MainView.jsp'" value="���" style="width: 100%;"></td>
				<td><input type="button" onclick="formCheck()" value="�����ϱ�" style="width: 100%;"></td>
			</tr>
		</table>
	</form>
</body>
</html>