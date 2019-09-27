<%@page import="com.wecal.db.MeetDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${meet.meet_name}</title>
</head>
<body>
	<table>
		<tr>
			<td colspan="2"><h2>[${meet.meet_name}] 의 일정</h2></td>
		</tr>
		<tr>
			<td colspan="2"><h4>${sd.schedule_name}</h4></td>
		</tr>
		<tr>
			<td>
			<h5>
				<c:if test="${sd.schedule_content eq null}">
					일정 설명이 없습니다.
				</c:if>
				<c:if test="${sd.schedule_content ne null}">
					${sd.schedule_content}
				</c:if>
			</h5>
			</td>
		</tr>
		<tr>
			<td><input type="date" value="${sd.schedule_startDay}" disabled="disabled"></td>
			<td><input type="date" value="${sd.schedule_endDay}" disabled="disabled"></td>
		</tr>
	</table>
</body>
</html>