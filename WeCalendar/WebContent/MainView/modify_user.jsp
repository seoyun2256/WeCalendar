<%@page import="java.sql.DriverManager"%>
<%@page import="com.wecal.db.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<style type="text/css">
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
	width: 45%;
	height: 94px;
	margin-right: 5px;
}
.back_button {
	width: 45%;
	height: 94px;
	margin-left: 5px;
}
</style>
</head>
<body>
<%
Connection  conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
MemberDTO mdto = null;

String[] births = null;
String[] ddds = null;
String birth = "";
String ddd = "";

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
<form action="modify_user.do" method="post" onkeydown="javascript:if(event.keyCode==13) return false;">
	<table border="0" cellspacing="1" cellpadding="1" class="userT">
		<tr height="30px"></tr>
		<tr height="60px">
			<td colspan="2" class="userT_subject"><b>회원 정보</b></td>
		</tr>
		<tr height="20px"></tr>
		<tr height="100px">
			<th>이름</th>
			<td>
				<input type="hidden" id="member_id" name="member_id" value="<%=mdto.getMember_id() %>">
				<input type="text" id="member_name" name="member_name" value="<%=mdto.getMember_name() %>">
			</td>
		</tr>
		<tr height="100px">
			<th>성별</th>
			<td>
				<%
				if(mdto.getMember_sex() != null){
					if(mdto.getMember_sex().equals("남자")){
						%>
						<label><input id="member_sex" name="member_sex" type="radio" value="남자" checked="checked">남자</label>
						<label><input id="member_sex" name="member_sex" type="radio" value="여자">여자</label>
						<label><input id="member_sex" name="member_sex" type="radio" value="기타">기타</label>
						<%
					}
					else if(mdto.getMember_sex().equals("여자")){
						%>
						<label><input id="member_sex" name="member_sex" type="radio" value="남자">남자</label>
						<label><input id="member_sex" name="member_sex" type="radio" value="여자" checked="checked">여자</label>
						<label><input id="member_sex" name="member_sex" type="radio" value="기타">기타</label>
						<%
					}
					else{
						%>
						<label><input id="member_sex" name="member_sex" type="radio" value="남자">남자</label>
						<label><input id="member_sex" name="member_sex" type="radio" value="여자">여자</label>
						<label><input id="member_sex" name="member_sex" type="radio" value="기타" checked="checked">기타</label>
						<%
					}
				}
				else{
					%>
					<label><input id="member_sex" name="member_sex" type="radio" value="남자">남자</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="여자">여자</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="기타">기타</label>
					<%
				}
				%>
			</td>
		</tr>
		<tr height="100px">
			<th>생일</th>
			<td>
				<%
				if(mdto.getMember_birth() == null){
				%>
					<input type="date" id="member_birth" name="member_birth">
				<%
				}
				else{
				%>
					<input type="date" id="member_birth" name="member_birth" value="<%=mdto.getMember_birth() %>">
				<%
				}
				%>
			</td>
		</tr>
		<tr height="100px">
			<th>가입일</th>
			<td><%=mdto.getMember_date() %></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" id="member_pwd" name="member_pwd"></td>
		</tr>
		<tr height="98px">
			<td colspan="2" class="user_modify" bgcolor="#ffffff">
				<input type="submit" value="회원정보 수정" class="modify_button"/><input type="button" value="뒤로" class="back_button" onclick="location.href='wecal_MainView.jsp'">
			</td>
		</tr>
	</table>
</form>
</body>
</html>