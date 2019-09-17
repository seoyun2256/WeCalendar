<%@page import="com.wecal.db.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Calendar cal = Calendar.getInstance();

String strYear = request.getParameter("year");
String strMonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH);
int date = cal.get(Calendar.DATE);

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
<meta charset="EUC-KR">
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
	font-size:16pt; color:#000000; text-decoration:none;
}
a:visited {
	font-size:16pt; color:#000000; text-decoration:none;
}
a:active {
	font-size:16pt; color:red; text-decoration:none;
}
a:hover {
	font-size:16pt; color:red;text-decoration:none;
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
</style>
</head>
<%

Connection  conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
MemberDTO mdto = null;

String[] births = null;
String[] ddds = null;
String birth = "";
String ddd = "";

System.out.println(session.getAttribute("id"));

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
    String sql = "select * from memberwc where member_id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, session.getAttribute("id").toString());
    rs = pstmt.executeQuery();
    
    mdto = new MemberDTO();
    while(rs.next()){
    	mdto.setMember_name(rs.getString("member_name"));
    	mdto.setMember_sex(rs.getString("member_sex"));
    	mdto.setMember_birth(rs.getString("member_birth"));
    	mdto.setMember_date(rs.getString("member_date"));
    	mdto.setMember_id(rs.getString("member_id"));
    }

    births = mdto.getMember_birth().split(" ");
    birth = births[0];
    ddds = mdto.getMember_date().split(" ");
    ddd = ddds[0];
	
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
		<h1>We Calendar</h1>
	</header>
		<table class="mainT">
			<tr>
				<td width="20%">
					<!-- ����� ȭ�� -->
					<table border="0" cellspacing="1" cellpadding="1" class="userT">
						<tr height="30px"></tr>
						<tr height="60px">
							<td colspan="2" class="userT_subject"><b>ȸ�� ����</b></td>
						</tr>
						<tr height="20px"></tr>
						<tr height="100px">
							<th>�̸�</th>
							<td><%=mdto.getMember_name() %></td>
						</tr>
						<tr height="100px">
							<th>����</th>
							<td><%=mdto.getMember_sex() %></td>
						</tr>
						<tr height="100px">
							<th>����</th>
							<td><%=birth %></td>
						</tr>
						<tr height="100px">
							<th>������</th>
							<td><%=ddd %></td>
						</tr>
						<tr height="98px">
							<td colspan="2" class="user_modify" bgcolor="#ffffff"><input type="button" value="ȸ������ ����" class="modify_button" onclick="javascript:location.href='<c:url value='modify_user.jsp'/>'" /></td>
						</tr>
					</table>
				</td>
				<td width="60%">
					<table width="100%" border="0" cellspacing="1" cellpadding="1">
						<tr>
							<td align ="right">
								<input type="button" onclick="javascript:location.href='<c:url value='wecal_MainView.jsp' />'" value="����"/>
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
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year-1%>&month=<%=month%>'>
									<b>&lt;&lt;</b>
								</a>
								<%if(month > 0){ %>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year%>&month=<%=month-1%>'>
									<b>&lt;</b>
								</a>
								<%} else {%>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year-1%>&month=11'>
									<b>&lt;</b>
								</a>
								<%} %>
								&nbsp;&nbsp;
								<%=year %>��
								
								<%=month+1 %>��
								&nbsp;&nbsp;
								<%if(month < 11){ %>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year%>&month=<%=month+1%>'>
									<b>&gt;</b>
								</a>
								<%} else { %>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year+1%>&month=0'>
									<b>&gt;</b>
								</a>
								<%} %>
								<a href='<c:url value='wecal_MainView.jsp'/>?year=<%=year+1%>&month=<%=month%>'>
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
					<table border="0" cellspacing="1" cellpadding="1" class="calBody">
						<thead>	
							<tr bgcolor="#cecece">
								<td width="100px;"><div align="center"><font color="red">��</font></div></td>
								<td width="100px;"><div align="center">��</div></td>
								<td width="100px;"><div align="center">ȭ</div></td>
								<td width="100px;"><div align="center">��</div></td>
								<td width="100px;"><div align="center">��</div></td>
								<td width="100px;"><div align="center">��</div></td>
								<td width="100px;"><div align="center"><font color="#529dbc">��</font></div></td>
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
									<font color="<%=color%>"><%=i %></font>
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
				<td width="20%">
					<!-- ���� ȭ�� -->
				</td>
			</tr>
		</table>
	<footer>
		Copyright &copy; 2019 All right reserved.
	</footer>
</body>
</html>