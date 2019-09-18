package com.wecal.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class MeetDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	MeetDTO mdto = null;
	
	public void create_member_meet(int member_num, int meet_num) {
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "insert into member_meet(member_num, meet_num) values(?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, member_num);
            pstmt.setInt(2, meet_num);
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
	
	public int findSeq() {
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "select meet_seq.nextVal from dual";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            if(rs.next()) {
            	return rs.getInt(1)-1;
            }
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
		
		return -1;
	}
	
	public void create_meet(MeetDTO mdto, int member_num) {
		this.mdto = mdto;
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "insert into meetwc(meet_num, meet_name, meet_content, meet_master) values(meet_seq.nextVal, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mdto.getMeet_name());
            if(mdto.getMeet_content().equals("")) {
            	pstmt.setString(2, "한줄 소개가 없습니다.");
            }
            else {
            	pstmt.setString(2, mdto.getMeet_content());
            }
            pstmt.setInt(3, member_num);
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
	
}
