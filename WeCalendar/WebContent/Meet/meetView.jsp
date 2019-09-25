<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.wecal.db.ScheduleDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Calendar cal = Calendar.getInstance();

String strYear = request.getParameter("year");
String strMonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH);
int date = cal.get(Calendar.DATE);

int[] colors;

ArrayList<ScheduleDTO> sdtos = (ArrayList<ScheduleDTO>)session.getAttribute("schedule");
colors = new int[sdtos.size()+2];
for(int c=0; c<colors.length; c++){
	colors[c] = (int)(Math.floor(Math.random()*(255-0+1))+0);
}

if(strYear != null){
	year = Integer.parseInt(strYear);
}
if(strMonth != null){
	month = Integer.parseInt(strMonth);
}

cal.set(year, month, 1);

int startDay = cal.getMinimum(Calendar.DATE);
int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
int start = cal.get(Calendar.DAY_OF_WEEK);
int newLine = 0;

Calendar todayCal = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 일정</title>
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
.mainT {
	width: 100%;
	height: 70%;
}
.calHead {
	width: 100%;
	border: 1px solid #ced99c;
	background-color: #f3f9d7;
}
.calBody {
	background-color: #ffffff;
}

a:link { 
	color:#000000; text-decoration:none;
}
a:visited {
	color:#000000; text-decoration:none;
}
a:active {
	color:red; text-decoration:none;
}
a:hover {
	color:red;text-decoration:none;
}

#schedule_frame {
	border: 1px solid;
	width: 100%;
	height: 100%;
}
</style>
<script type="text/javascript">
function noMaster(){
	alert("방장이 아니라서 일정을 생성할 수 없습니다!");
}
function quitMeet(meet_name, meet_num, mnum){
	var qm = confirm("정말로 ["+meet_name+"] 모임을 탈퇴하시겠습니까?");
	if(qm == true){
		location.href="quit_meet.do?meet_num="+meet_num+"&member_num="+mnum;
	}
	else{
		return;
	}
}
function removeMeet(meet_name, meet_num){
	var rm = confirm("정말로 ["+meet_name+"] 모임을 삭제하시겠습니까?\n해당 모임의 일정이 전부 삭제됩니다.");
	if(rm == true){
		location.href="remove_meet.do?meet_num="+meet_num;
	}
	else{
		return;
	}
}
</script>
</head>
<body>
	<table class="mainT">
		<tr>
			<td colspan="2"><!-- 제목 -->
				<h1>${meet.meet_name }</h1>
				<h5>방장: ${meet.master_name }</h5>
			</td>
		</tr>
		<tr>
			<td><!-- 달력 -->
				<table width="100%" border="0" cellspacing="1" cellpadding="1">
					<tr>
						<td align ="right">
							<input type="button" onclick="javascript:location.href='<c:url value='meetView.jsp' />'" value="오늘"/>
						</td>
					</tr>
				</table>
				<table class="calHead" cellspacing="1" cellpadding="1">
					<tr>
						<td height="10">
						</td>
					</tr>
					<tr>
						<td align="center">
							<a href='<c:url value='meetView.jsp'/>?year=<%=year-1%>&month=<%=month%>' style="font-size: 16pt;">
								<b>&lt;&lt;</b>
							</a>
							<%if(month > 0){ %>
							<a href='<c:url value='meetView.jsp'/>?year=<%=year%>&month=<%=month-1%>' style="font-size: 16pt;">
								<b>&lt;</b>
							</a>
							<%} else {%>
							<a href='<c:url value='meetView.jsp'/>?year=<%=year-1%>&month=11' style="font-size: 16pt;">
								<b>&lt;</b>
							</a>
							<%} %>
							&nbsp;&nbsp;
							<%=year %>년
							
							<%=month+1 %>월
							&nbsp;&nbsp;
							<%if(month < 11){ %>
							<a href='<c:url value='meetView.jsp'/>?year=<%=year%>&month=<%=month+1%>' style="font-size: 16pt;">
								<b>&gt;</b>
							</a>
							<%} else { %>
							<a href='<c:url value='meetView.jsp'/>?year=<%=year+1%>&month=0' style="font-size: 16pt;">
								<b>&gt;</b>
							</a>
							<%} %>
							<a href='<c:url value='meetView.jsp'/>?year=<%=year+1%>&month=<%=month%>' style="font-size: 16pt;">
								<b>&gt;&gt;</b>
							</a>
						</td>
					</tr>
					<tr>
						<td height="10">
						</td>
					</tr>
				</table>
				<br>
				<table border="0" cellspacing="1" cellpadding="1" class="calBody" width="100%;">
					<thead>	
						<tr bgcolor="#cecece">
							<td width="100px;"><div align="center"><font color="red">일</font></div></td>
							<td width="100px;"><div align="center">월</div></td>
							<td width="100px;"><div align="center">화</div></td>
							<td width="100px;"><div align="center">수</div></td>
							<td width="100px;"><div align="center">목</div></td>
							<td width="100px;"><div align="center">금</div></td>
							<td width="100px;"><div align="center"><font color="#529dbc">토</font></div></td>
						</tr>
					</thead>
					<tbody>
						<tr>
						<%
						for(int i=1; i<start; i++){
						%>
							<td>&nbsp;</td>
						<%
							newLine++;
						}
						
						for(int i=1; i<=endDay; i++){
							String color = "";
							
							if(newLine == 0){
								color="RED";
							}
							else if(newLine == 6){
								color="529dbc";
							}
							else{
								color="BLACK";
							}
							
							%>
							<%
							Calendar today = Calendar.getInstance();
							if(today.get(Calendar.YEAR) == year && today.get(Calendar.MONTH) == month && today.get(Calendar.DAY_OF_MONTH) == i){
							%>
								<td valign="top" align="left" height="92px" bgcolor="#ff0000" nowrap="nowrap">
							<%
							}
							else{
							%>
								<td valign="top" align="left" height="92px" bgcolor="#efefef" nowrap="nowrap">
							<%
							}
							%>
								<div style="height: 100%; overflow: auto;">
								<font color="<%=color%>"><%=i %></font>
								<c:if test="${schedule.size() != 0}">
									<%
									for(int j=0; j<sdtos.size(); j++){
										String MM = (month+1 < 10)? "0"+(month+1):String.valueOf(month+1);
										String DD = (i < 10)? "0"+i:String.valueOf(i);
										
										LocalDate toDay = LocalDate.parse(year+"-"+MM+"-"+DD);
										LocalDate sDay = LocalDate.parse(sdtos.get(j).getSchedule_startDay());
										LocalDate eDay = LocalDate.parse(sdtos.get(j).getSchedule_endDay());
										
										if(!toDay.isBefore(sDay) && toDay.isBefore(eDay.plusDays(1))){
										%>
										<a href="../Schedule/scheduleView.jsp?schedule_num=<%=sdtos.get(j).getSchedule_num()%>&meet_master=${meet.meet_master}" target="schedule_frame"><div style="background-color: rgb(<%=colors[j]%>,<%=colors[j+1]%>,<%=colors[j+2]%>);"><font style="text-shadow: 0 0 4px #000000; color: white;"><%=sdtos.get(j).getSchedule_name()%></font></div></a>
										<%
										}
									}
									%>
								</c:if>
								</div>
							</td>
							<%
							newLine++;
							
							if(newLine == 7){
								%>
								</tr>
								<%
								if(i <= endDay){
									%>
									<tr>
									<%
								}
								newLine = 0;
							}
						}
						
						while(newLine > 0 && newLine < 7){
							%>
							<td>&nbsp;</td>
							<%
							newLine++;
						}
						%>
						</tr>
					</tbody>
				</table>
			</td>
			<td rowspan="2">
				<iframe id="schedule_frame" name="schedule_frame">
				</iframe>
			</td>
		</tr>
		<tr>
			<td align="right">
				<input type="button" value="뒤로가기" onclick="location.href='../MainView/main.do?mnum=${mnum}'">
				<c:if test="${mnum == meet.meet_master }">
					<input type="button" value="일정 생성하기" onclick="location.href='../Schedule/create_schedule.jsp?meet_name=${meet.meet_name}&meet_num=${meet.meet_num}'">
				</c:if>
				<c:if test="${mnum != meet.meet_master }">
					<input type="button" value="일정 생성하기" onclick="noMaster()">
				</c:if>
				<c:if test="${mnum == meet.meet_master }">
					<input type="button" value="모임 탈퇴하기" disabled="disabled">
				</c:if>
				<c:if test="${mnum != meet.meet_master }">
					<input type="button" value="모임 탈퇴하기" onclick="quitMeet('${meet.meet_name}', ${meet.meet_num}, ${mnum})">
				</c:if>
				<c:if test="${mnum == meet.meet_master }">
					<input type="button" value="모임 삭제하기" onclick="removeMeet('${meet.meet_name}', ${meet.meet_num})">
				</c:if>
				<c:if test="${mnum != meet.meet_master }">
					<input type="button" value="모임 삭제하기" disabled="disabled">
				</c:if>
			</td>
		</tr>
	</table>
</body>
</html>