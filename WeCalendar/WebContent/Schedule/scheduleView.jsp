<%@page import="com.wecal.db.ScheduleDAO"%>
<%@page import="com.wecal.db.ScheduleDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function noMaster(){
	alert("방장이 아니라서 일정을 삭제할 수 없습니다!");
}
</script>
</head>
<body>
<%
ScheduleDAO sdao = new ScheduleDAO();
ScheduleDTO sdto = sdao.oneSchedule(Integer.parseInt(request.getParameter("schedule_num").toString()));
session.setAttribute("meet_master", request.getParameter("meet_master"));
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
	<tr>
		<td>
			<c:if test="${mnum == meet_master}">
				<input type="button" value="일정 삭제" onclick="location.href='<c:url value='remove_schedule.do'/>?schedule_num=<%=sdto.getSchedule_num()%>&meet_num=<%=sdto.getMeet_num()%>'">
			</c:if>
			<c:if test="${mnum != meet_master}">
				<input type="button" value="일정 삭제" onclick="noMaster()">
			</c:if>
		</td>
	</tr>
</table>
</body>
</html>