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
		alert("모임 이름을 입력해주세요!");
		$('#meet_name').focus();
		return;
	}

	$('#meetform').submit();
}
</script>
</head>
<body>
	<h1>WeCalendar 모임 생성</h1>
	<form id="meetform" action="create_meet.do" method="post" onkeydown="javascript:if(event.keyCode==13) return false;">
		<input type="hidden" id="member_num" name="member_num" value="<%=session.getAttribute("mnum") %>">
		<table>
			<tr>
				<th>모임 이름</th>
				<td><input type="text" id="meet_name" name="meet_name"></td>
			</tr>
			<tr>
				<th>한줄 소개</th>
				<td><input type="text" id="meet_content" name="meet_content"></td>
			</tr>
			<tr>
				<td><input type="button" onclick="location.href='../MainView/wecal_MainView.jsp'" value="취소" style="width: 100%;"></td>
				<td><input type="button" onclick="formCheck()" value="생성하기" style="width: 100%;"></td>
			</tr>
		</table>
	</form>
</body>
</html>