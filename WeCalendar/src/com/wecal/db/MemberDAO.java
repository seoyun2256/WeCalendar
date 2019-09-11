package com.wecal.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	MemberDTO mdto = null;
	
	public void join(MemberDTO mdto) {
		this.mdto = mdto;
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "insert into memberwc(member_num, member_name, member_id, member_pwd, member_date, member_birth, member_sex) values(member_seq.nextVal, ?, ?, ?, sysdate, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mdto.getMember_name());
            pstmt.setString(2, mdto.getMember_id());
            pstmt.setString(3, mdto.getMember_pwd());
            pstmt.setString(4, mdto.getMember_birth());
            pstmt.setString(5, mdto.getMember_sex());
            pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public boolean idCheck(String id) {
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "select * from memberwc where member_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
            	return false;
            }
            else {
            	return true;
            }
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
