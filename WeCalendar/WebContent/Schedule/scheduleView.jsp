<%@page import="com.wecal.db.ScheduleDAO"%>
<%@page import="com.wecal.db.ScheduleDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
ScheduleDAO sdao = new ScheduleDAO();
ScheduleDTO sdto = sdao.oneSchedule(Integer.parseInt(request.getParameter("schedule_num").toString()));
%>
<table>
	<tr>
		<td colspan="2"><h2><%=sdto.getSchedule_name() %></h2></td>
	</tr>
	<tr>
		<td colspan="2">
			<h5>
			<%
			if(sdto.getSchedule_content() == null){
			%>
				일정 설명이 없습니다.
			<%
			}
			else{
			%>
				<%=sdto.getSchedule_content()%>
			<%
			}
			%>
			</h5>
		</td>
	</tr>
	<tr>
		<td><input type="date" value="<%=sdto.getSchedule_startDay()%>" disabled="disabled"></td>
		<td><input type="date" value="<%=sdto.getSchedule_endDay()%>" disabled="disabled"></td>
	</tr>
</table>
</body>
</html>