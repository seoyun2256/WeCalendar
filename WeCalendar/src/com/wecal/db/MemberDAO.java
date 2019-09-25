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
            String sql = "insert into memberwc(member_num, member_name, member_id, member_pwd, member_date, member_birth, member_sex) values(member_seq.nextVal, ?, ?, ?, to_char(sysdate, 'YYYY-MM-DD'), ?, ?)";
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
	
	public int login(String id, String pwd) {
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "select member_num, member_pwd from memberwc where member_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	// 아이디 존재함
            	if(rs.getString("member_pwd").equals(pwd)) {
            		// 로그인 성공
            		return rs.getInt("member_num");
            	}
            	else {
            		// 비밀번호 오류
            		return -2;
            	}
            }
            
            // 아이디 존재하지 않음
        	return -1;
        	
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
		
		return -1;
	}
	
	public int modify_user(MemberDTO mdto) {
		this.mdto = mdto;
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "update memberwc set member_name=?, member_sex=?, member_birth=? where member_id=? and member_pwd=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mdto.getMember_name());
            pstmt.setString(2, mdto.getMember_sex());
            pstmt.setString(3, mdto.getMember_birth());
            pstmt.setString(4, mdto.getMember_id());
            pstmt.setString(5, mdto.getMember_pwd());
            return pstmt.executeUpdate();
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
		
		return 0;
	}
	
	public void remove_member_meet(int meet_num) {
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "delete from member_meet where meet_num=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, meet_num);
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
	
	private void removeMember_meet(int member_num) {
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "delete from member_meet where member_num=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, member_num);
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
	
	public void removeMember(int member_num) {
		
		ScheduleDAO sdao = new ScheduleDAO();
		MeetDAO mtdao = new MeetDAO();
		
		sdao.removeMemberSchedule(member_num);
		removeMember_meet(member_num);
		mtdao.remove_meet_master(member_num);
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "delete from memberwc where member_num=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, member_num);
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
	
	public void quitMeet(int member_num, int meet_num) {
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "delete from member_meet where member_num=? and meet_num=?";
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

}
