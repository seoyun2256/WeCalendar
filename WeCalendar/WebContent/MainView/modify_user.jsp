<%@page import="java.sql.DriverManager"%>
<%@page import="com.wecal.db.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
	width: 100%;
	height: 94px;
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
<table border="0" cellspacing="1" cellpadding="1" class="userT">
	<tr height="30px"></tr>
	<tr height="60px">
		<td colspan="2" class="userT_subject"><b>회원 정보</b></td>
	</tr>
	<tr height="20px"></tr>
	<tr height="100px">
		<th>이름</th>
		<td>
			<%=mdto.getMember_name() %><br>
			<input type="text" id="member_name" name="member_name">
		</td>
	</tr>
	<tr height="100px">
		<th>성별</th>
		<td>
			<%=mdto.getMember_sex() %><br>
			<label><input id="member_sex" name="member_sex" type="radio" value="남자">남자</label>
			<label><input id="member_sex" name="member_sex" type="radio" value="여자">여자</label>
			<label><input id="member_sex" name="member_sex" type="radio" value="기타">기타</label>
		</td>
	</tr>
	<tr height="100px">
		<th>생일</th>
		<td>
			<%=birth %><br>
			<input type="date" id="member_birth" name="member_birth">
		</td>
	</tr>
	<tr height="100px">
		<th>가입일</th>
		<td><%=ddd %></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" id="member_pwd" name="member_pwd"></td>
	</tr>
	<tr height="98px">
		<td colspan="2" class="user_modify" bgcolor="#ffffff"><input type="button" value="회원정보 수정" class="modify_button" onclick="javascript:location.href='<c:url value='modify_user.jsp' />'" /></td>
	</tr>
</table>
</body>
</html>