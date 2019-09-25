package com.wecal.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class MeetDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	MeetDTO mdto = null;
	Member_MeetDTO mmdto = null;
	
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
	
	public MeetDTO oneMeet(int meet_num) {
		
		MeetDTO mtdto = new MeetDTO();
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "select m.member_name, t.* from memberwc m, meetwc t where meet_num=? and meet_master=member_num";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, meet_num);
            rs = pstmt.executeQuery();
            while(rs.next()) {
            	mtdto.setMeet_num(rs.getInt("meet_num"));
            	mtdto.setMeet_name(rs.getString("meet_name"));
            	mtdto.setMeet_content(rs.getString("meet_content"));
            	mtdto.setMeet_master(rs.getInt("meet_master"));
            	mtdto.setMaster_name(rs.getString("member_name"));
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
		
		return mtdto;
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
				if(rs != null) rs.close();
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
	
	public ArrayList<MeetDTO> select_meet(String search, int member_num) {
		
		ArrayList<MeetDTO> mtdtos = new ArrayList<MeetDTO>();
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "select m.member_name, t.* from memberwc m, meetwc t where meet_num not in (select meet_num from member_meet where member_num=?) and member_num=meet_master and meet_name like '%'||?||'%'";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, member_num);
            pstmt.setString(2, search);
            rs = pstmt.executeQuery();
            while(rs.next()) {
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
        
        return mtdtos;
		
	}
	
	private int meetCnt(String search, int member_num) {
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "select count(*) from meetwc where meet_num not in (select meet_num from member_meet where member_num=?) and meet_name like '%'||?||'%'";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, member_num);
            pstmt.setString(2, search);
            rs = pstmt.executeQuery();
            while(rs.next()) {
            	return rs.getInt(1);
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
		
		return 0;
	}
	
	public void join_meet(Member_MeetDTO mmdto) {
		this.mmdto = mmdto;
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "insert into member_meet(member_num, meet_num) values(?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, mmdto.getMember_num());
            pstmt.setInt(2, mmdto.getMeet_num());
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
	
	public PagingVO meet_paging(String search, int currPage, int member_num) {
		
		// 전체 게시글 수
		int listCnt = meetCnt(search, member_num);
		PagingVO pv = new PagingVO();
		
		pv.setListCnt(listCnt);//listCnt
		pv.setPageCnt((int)(Math.ceil((pv.getListCnt()*1.0)/pv.getPageSize())));//pageCnt
		pv.setRangeCnt((int)(Math.ceil((pv.getPageCnt()*1.0)/pv.getRangeSize())));//rangeCnt
		
//		System.out.println("전체 갯수: "+pv.getListCnt());
//		System.out.println("전체 페이지: "+pv.getPageCnt());
//		System.out.println("전체 블럭: "+pv.getRangeCnt());
//		System.out.println();
		
		pv.setCurrPage(currPage);//currPage;
//		System.out.println("현재페이지: "+pv.getCurrPage());
		pv.setStartPage(((pv.getCurrPage()-1)/pv.getRangeSize())*pv.getRangeSize()+1);
//		System.out.println("시작페이지: "+pv.getStartPage());
		pv.setEndPage(pv.getStartPage()+pv.getRangeSize()-1);
		pv.setCurrRange(pv.getEndPage()/10);
//		System.out.println("현재 블럭: "+pv.getCurrRange());
		if(pv.getEndPage() > pv.getPageCnt()) {
			pv.setEndPage(pv.getPageCnt());
		}
//		System.out.println("끝페이지: "+pv.getEndPage());
		pv.setStartIndex(((pv.getCurrPage()*pv.getPageSize())-(pv.getPageSize()-1))-1);
//		System.out.println("시작 인덱스: "+pv.getStartIndex());
		pv.setEndIndex(pv.getCurrPage()*pv.getPageSize()-1);
		if(pv.getEndIndex() >= pv.getListCnt()) {
			pv.setEndIndex(pv.getListCnt()-1);
		}
//		System.out.println("끝 인덱스: "+pv.getEndIndex());
//		System.out.println();
		
		return pv;
		
	}
	
	public void removeMeet(int meet_num) {
		ScheduleDAO sdao = new ScheduleDAO();
		MemberDAO mdao = new MemberDAO();
		
		sdao.removeMeetSchedule(meet_num);
		mdao.remove_member_meet(meet_num);
		
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "delete from meetwc where meet_num=?";
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
	
	public void remove_meet_master(int meet_master) {
		try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","wecal_admin","oracle_11g");
            String sql = "delete from meetwc where meet_master=?";
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
