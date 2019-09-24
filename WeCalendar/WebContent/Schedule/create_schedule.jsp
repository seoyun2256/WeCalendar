<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 생성하기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
function formCheck(){
	
	var sDay = new Date($('#schedule_startDay').val());
	var eDay = new Date($('#schedule_endDay').val());
	
	if($('#schedule_name').val() == ""){
		alert("일정 이름을 입력하세요!");
		$('#schedule_name').focus();
		return;
	}
	if($('#schedule_startDay').val() == ""){
		alert("시작일을 설정하세요!");
		return;
	}
	if($('#schedule_endDay').val() == ""){
		alert("종료일을 설정하세요!");
		return;
	}
	if(sDay > eDay){
		alert("시작일이 종료일보다 뒤에 있을 수 없습니다!");
		return;
	}
	
	$('#schedule_form').submit();
}
</script>
</head>
<body>
	<form action="create_schedule.do" method="post" onkeydown="javascript:if(event.keyCode==13) return false;" id="schedule_form">
		<table>
			<tr>
				<th colspan="2"><%=request.getParameter("meet_name") %> 일정 생성하기</th>
			</tr>
			<tr>
				<th>일정 이름</th>
				<td><input type="text" id="schedule_name" name="schedule_name"><input type="hidden" id="meet_num" name="meet_num" value="<%=request.getParameter("meet_num")%>"></td>
			</tr>
			<tr>
				<th>일정 설명</th>
				<td><input type="text" id="schedule_content" name="schedule_content"></td>
			</tr>
			<tr>
				<th>시작일</th>
				<th>종료일</th>
			</tr>
			<tr>
				<td align="center"><input type="date" id="schedule_startDay" name="schedule_startDay"></td>
				<td align="center"><input type="date" id="schedule_endDay" name="schedule_endDay"></td>
			</tr>
			<tr>
				<td><input type="button" value="취소" onclick="location.href='../Meet/meetView.jsp'" style="width: 100%;"></td>
				<td><input type="button" value="생성하기" onclick="formCheck()" style="width: 100%;"></td>
			</tr>
		</table>
	</form>
</body>
</html>