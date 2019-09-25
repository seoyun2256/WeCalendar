package com.wecal.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ScheduleDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public void create_schedule(ScheduleDTO sdto) {
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "insert into schedulewc(schedule_num, schedule_name, schedule_content, schedule_startDay, schedule_endDay, meet_num) values(schedule_seq.nextVal, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, sdto.getSchedule_name());
            pstmt.setString(2, sdto.getSchedule_content());
            pstmt.setString(3, sdto.getSchedule_startDay());
            pstmt.setString(4, sdto.getSchedule_endDay());
            pstmt.setInt(5, sdto.getMeet_num());
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
	
	public ArrayList<ScheduleDTO> meet_schedule(int meet_num) {
		
		ArrayList<ScheduleDTO> sdtos = new ArrayList<ScheduleDTO>();
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "select * from schedulewc where meet_num=? order by schedule_startDay, schedule_endDay";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, meet_num);
            rs = pstmt.executeQuery();
            while(rs.next()) {
            	ScheduleDTO sdto = new ScheduleDTO();
            	sdto.setSchedule_num(rs.getInt("schedule_num"));
            	sdto.setSchedule_name(rs.getString("schedule_name"));
            	sdto.setSchedule_content(rs.getString("schedule_content"));
            	sdto.setSchedule_startDay(rs.getString("schedule_startDay"));
            	sdto.setSchedule_endDay(rs.getString("schedule_endDay"));
            	sdto.setMeet_num(rs.getInt("meet_num"));
            	sdtos.add(sdto);
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
		
		return sdtos;
	}
	
	public ArrayList<ScheduleDTO> member_schedule(int member_num){
		
		ArrayList<ScheduleDTO> sdtos = new ArrayList<ScheduleDTO>();
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "select * from schedulewc where meet_num in (select meet_num from meetwc where meet_num in (select meet_num from member_meet where member_num=?)) order by schedule_startDay, schedule_endDay";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, member_num);
            rs = pstmt.executeQuery();
            while(rs.next()) {
            	ScheduleDTO sdto = new ScheduleDTO();
            	sdto.setSchedule_num(rs.getInt("schedule_num"));
            	sdto.setSchedule_name(rs.getString("schedule_name"));
            	sdto.setSchedule_content(rs.getString("schedule_content"));
            	sdto.setSchedule_startDay(rs.getString("schedule_startDay"));
            	sdto.setSchedule_endDay(rs.getString("schedule_endDay"));
            	sdto.setMeet_num(rs.getInt("meet_num"));
            	sdtos.add(sdto);
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
		
		return sdtos;
	}
	
	public ScheduleDTO oneSchedule(int schedule_num) {
		ScheduleDTO sdto = new ScheduleDTO();
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "select * from schedulewc where schedule_num=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, schedule_num);
            rs = pstmt.executeQuery();
            while(rs.next()) {
            	sdto.setSchedule_num(rs.getInt("schedule_num"));
            	sdto.setSchedule_name(rs.getString("schedule_name"));
            	sdto.setSchedule_content(rs.getString("schedule_content"));
            	sdto.setSchedule_startDay(rs.getString("schedule_startDay"));
            	sdto.setSchedule_endDay(rs.getString("schedule_endDay"));
            	sdto.setMeet_num(rs.getInt("meet_num"));
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
		
		return sdto;
	}
	
	public void removeSchedule(int schedule_num) {
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "delete from schedulewc where schedule_num=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, schedule_num);
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
	
	public void removeMeetSchedule(int meet_num) {
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "delete from schedulewc where meet_num=?";
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
	
	public void removeMemberSchedule(int meet_master) {
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "delete from schedulewc where meet_num in (select meet_num from meetwc where meet_master=?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, meet_master);
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
