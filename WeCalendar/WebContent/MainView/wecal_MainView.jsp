<%@page import="java.time.LocalDate"%>
<%@page import="com.wecal.db.ScheduleDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wecal.db.MeetDTO"%>
<%@page import="com.wecal.db.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
<title>We Calendar</title>
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
	height: 15%;
}
.mainT {
	width: 100%;
	height: 70%;
}
footer {
	height: 15%;
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

.userT_subject {
	border: 1px solid #ced99c;
	background-color: #f3f9d7;
}
.userT th {
	
}
.userT td {
	text-align: center;
	font-size: 15px;
	padding: 10px;
}
.user_modify {
	padding: 0px;
}
.modify_button {
	width: 100%;
	height: 94px;
}

#logout_btn {
	float: right;
	border: 0px;
	background-color: red;
	width: 100px;
	height: 30px;
	color: white;
	font-weight: 600;
	font-size: 12pt;
}
</style>
</head>
<%

Connection  conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
MemberDTO mdto = null;
ArrayList<MeetDTO> mtdtos = null;

String[] births = null;
String[] ddds = null;
String birth = "";
String ddd = "";

System.out.println(session.getAttribute("mnum"));

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
    String sql = "select * from memberwc where member_num=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(session.getAttribute("mnum").toString()));
    rs = pstmt.executeQuery();
    
    mdto = new MemberDTO();
    while(rs.next()){
    	mdto.setMember_name(rs.getString("member_name"));
    	mdto.setMember_sex(rs.getString("member_sex"));
    	mdto.setMember_birth(rs.getString("member_birth"));
    	mdto.setMember_date(rs.getString("member_date"));
    	mdto.setMember_id(rs.getString("member_id"));
    }
	
} catch (Exception e) {
	e.printStackTrace();
} finally {
	try {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}

%>
<body>
	<header>
		<div>
			<h1>We Calendar</h1>
			<input type="button" value="로그아웃" id="logout_btn" name="logout_btn" onclick="javascript:location.href='<c:url value='logout.do'/>'">
		</div>
	</header>
		<table class="mainT">
			<tr>
				<td width="20%" align="center">
					<!-- 사용자 화면 -->
					<table border="0" cellspacing="1" cellpadding="1" class="userT">
						<tr height="30px"></tr>
						<tr height="60px">
							<td colspan="2" class="userT_subject"><b>회원 정보</b></td>
						</tr>
						<tr height="20px"></tr>
						<tr height="100px">
							<th>이름</th>
							<td><%=mdto.getMember_name() %></td>
						</tr>
						<tr height="100px">
							<th>성별</th>
							<td><%=mdto.getMember_sex() %></td>
						</tr>
						<tr height="100px">
							<th>생일</th>
							<td><%=mdto.getMember_birth() %></td>
						</tr>
						<tr height="100px">
							<th>가입일</th>
							<td><%=mdto.getMember_date() %></td>
						</tr>
						<tr height="98px">
							<td colspan="2" class="user_modify" bgcolor="#ffffff"><input type="button" value="회원정보 수정" class="modify_button" onclick="javascript:location.href='<c:url value='modify_user.jsp'/>'" /></td>
						</tr>
					</table>
				</td>
				<td width="60%">
					<table width="100%" border="0" cellspacing="1" cellpadding="1">
						<tr>
							<td align ="right">
								<input type="button" onclick="javascript:location.href='<c:url value='wecal_MainView.jsp' />'" value="오늘"/>
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
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year-1%>&month=<%=month%>' style="font-size: 16pt;">
									<b>&lt;&lt;</b>
								</a>
								<%if(month > 0){ %>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year%>&month=<%=month-1%>' style="font-size: 16pt;">
									<b>&lt;</b>
								</a>
								<%} else {%>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year-1%>&month=11' style="font-size: 16pt;">
									<b>&lt;</b>
								</a>
								<%} %>
								&nbsp;&nbsp;
								<%=year %>년
								
								<%=month+1 %>월
								&nbsp;&nbsp;
								<%if(month < 11){ %>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year%>&month=<%=month+1%>' style="font-size: 16pt;">
									<b>&gt;</b>
								</a>
								<%} else { %>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year+1%>&month=0' style="font-size: 16pt;">
									<b>&gt;</b>
								</a>
								<%} %>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year+1%>&month=<%=month%>' style="font-size: 16pt;">
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
								<td valign="top" align="left" height="92px" bgcolor="#efefef" nowrap="nowrap">
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
											<div style="background-color: rgb(<%=colors[j]%>,<%=colors[j+1]%>,<%=colors[j+2]%>);"><font style="text-shadow: 0 0 4px #000000; color: white;"><%=sdtos.get(j).getSchedule_name()%></font></div>
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
				<%
				try {
				    Class.forName("oracle.jdbc.driver.OracleDriver");
				    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
				    String sql = "select m.member_name, t.* from memberwc m, meetwc t where meet_num in (select meet_num from member_meet where member_num=?) and member_num=meet_master";
				    pstmt = conn.prepareStatement(sql);
				    pstmt.setInt(1, Integer.parseInt(session.getAttribute("mnum").toString()));
				    rs = pstmt.executeQuery();
				    
				    mtdtos = new ArrayList<MeetDTO>();
				    
				    while(rs.next()){
					    MeetDTO mtdto = new MeetDTO();
					    mtdto.setMeet_num(rs.getInt("meet_num"));
				    	mtdto.setMeet_name(rs.getString("meet_name"));
				    	mtdto.setMeet_content(rs.getString("meet_content"));
				    	mtdto.setMeet_master(rs.getInt("meet_master"));
				    	mtdto.setMaster_name(rs.getString("member_name"));
				    	mtdtos.add(mtdto);
				    }
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				%>
				<td width="20%" style="padding-left: 10px;">
					<!-- 모임 화면 -->
					<div style="background-color: #bdecb6;"><b>가입한 모임</b></div>
					<div style="overflow: auto; background-color: #f3f9d7; width: 100%; height: 80%;">
					<%
					for(int i=0; i<mtdtos.size(); i++){
					%>
						<p>
							<a href="<c:url value='meet_view.do'/>?meet_num=<%=mtdtos.get(i).getMeet_num() %>">
								<b><%=mtdtos.get(i).getMeet_name() %></b> - [방장: <%=mtdtos.get(i).getMaster_name() %>]<br><%=mtdtos.get(i).getMeet_content() %>
							</a>
						</p>
						<hr>
					<%
					}
					%>
					</div>
					<div>
						<p><input type="button" value="모임 생성하기" style="width: 100%; height: 30px;" onclick="javascript:location.href='<c:url value='../Meet/create_meet.jsp'/>'"></p>
						<p><input type="button" value="모임 가입하기" style="width: 100%; height: 30px;" onclick="javascript:location.href='<c:url value='join_meet.do'/>?currPage=1'"></p>
					</div>
				</td>
			</tr>
		</table>
	<footer>
		Copyright &copy; 2019 All right reserved.
	</footer>
</body>
</html>