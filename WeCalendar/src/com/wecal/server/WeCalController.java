package com.wecal.server;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wecal.command.CommandWC;
import com.wecal.command.CreateMeetWC;
import com.wecal.command.CreateScheduleWC;
import com.wecal.command.JoinMeetWC;
import com.wecal.command.JoinWC;
import com.wecal.db.MeetDAO;
import com.wecal.db.MemberDAO;
import com.wecal.db.MemberDTO;
import com.wecal.db.PagingVO;
import com.wecal.db.ScheduleDAO;
import com.wecal.db.ScheduleDTO;


@WebServlet("*.do")
public class WeCalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public WeCalController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		CommandWC comm = null;
		
		String[] arrUri = request.getRequestURI().split("/");
		String uri = arrUri[arrUri.length-1];
		RequestDispatcher rd = null;
		MemberDAO mdao = new MemberDAO();
		MeetDAO mtdao = new MeetDAO();
		ScheduleDAO sdao = new ScheduleDAO();
		
//		System.out.println(uri);
		switch(uri) {
		
		case "join.do":
			comm = new JoinWC();
			comm.execute(request, response);
			rd = request.getRequestDispatcher("Join/joinSuccess.jsp");
			rd.forward(request, response);
			break;
			
		case "idcheck.do":
			boolean idc = false;
			if(mdao.idCheck(request.getParameter("id"))) {
				idc = true;
			}
			else {
				idc = false;
			}
			rd = request.getRequestDispatcher("idcheck.jsp?idc="+idc);
			rd.forward(request, response);
			break;
			
		case "login.do":
			int mnum = mdao.login(request.getParameter("user_id"), request.getParameter("user_pwd"));
			switch(mnum) {
			case -1:
				// 아이디 존재하지 않음
				request.setAttribute("chk", 1);
				rd = request.getRequestDispatcher("../Login/loginfailed.jsp");
				rd.forward(request, response);
				break;
			case -2:
				// 비밀번호 오류
				request.setAttribute("chk", 2);
				rd = request.getRequestDispatcher("../Login/loginfailed.jsp");
				rd.forward(request, response);
				break;
			default:
				// 로그인 성공
				request.getSession().setAttribute("mnum", mnum);
				request.getSession().setAttribute("schedule", sdao.member_schedule(mnum));
				response.sendRedirect("wecal_MainView.jsp");
				break;
			}
			break;
			
		case "logout.do":
			request.getSession().invalidate();
			rd = request.getRequestDispatcher("../Login/logout.jsp");
			rd.forward(request, response);
			break;
			
		case "modify_user.do":
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			MemberDTO mdto = new MemberDTO();
			mdto.setMember_name(request.getParameter("member_name"));
			mdto.setMember_id(request.getParameter("member_id"));
			mdto.setMember_pwd(request.getParameter("member_pwd"));
			mdto.setMember_birth(request.getParameter("member_birth"));
			mdto.setMember_sex(request.getParameter("member_sex"));
			
			switch(mdao.modify_user(mdto)) {
			case 0:
				// 비밀번호 오류
				rd = request.getRequestDispatcher("modify_user_failed.jsp");
				rd.forward(request, response);
				break;
			case 1:
				// 변경 성공
				response.sendRedirect("wecal_MainView.jsp");
				break;
			}
			break;
			
		case "create_meet.do":
			comm = new CreateMeetWC();
			comm.execute(request, response);
			response.sendRedirect("../MainView/wecal_MainView.jsp");
			break;
			
		case "join_meet.do":
			request.setCharacterEncoding("UTF-8");

			int member_num = Integer.parseInt(request.getSession().getAttribute("mnum").toString());
			PagingVO pv = mtdao.meet_paging(request.getParameter("search"), Integer.parseInt(request.getParameter("currPage")), member_num);
			request.getSession().setAttribute("pv", pv);
			request.getSession().setAttribute("meet", mtdao.select_meet(request.getParameter("search"), member_num));
			request.getSession().setAttribute("search", request.getParameter("search"));
			
			response.sendRedirect("../Meet/join_meet.jsp");
			break;
			
		case "member_meet.do":
			comm = new JoinMeetWC();
			comm.execute(request, response);
			rd = request.getRequestDispatcher("join_meet.do?currPage=1");
			rd.forward(request, response);
			break;
			
		case "meet_view.do":
			int meet_num = Integer.parseInt(request.getParameter("meet_num").toString());
			request.getSession().setAttribute("schedule", sdao.meet_schedule(meet_num));
			request.getSession().setAttribute("meet", mtdao.oneMeet(meet_num));
			response.sendRedirect("../Meet/meetView.jsp");
			break;
			
		case "create_schedule.do":
			comm = new CreateScheduleWC();
			comm.execute(request, response);
			response.sendRedirect("meet_view.do?meet_num="+request.getParameter("meet_num"));
			break;
			
		}
		
	}

}
