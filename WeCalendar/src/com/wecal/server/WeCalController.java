package com.wecal.server;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.RequestWrapper;

import com.wecal.command.CommandWC;
import com.wecal.command.CreateMeetWC;
import com.wecal.command.JoinWC;
import com.wecal.db.MemberDAO;
import com.wecal.db.MemberDTO;


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
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response) {
		
		CommandWC comm = null;
		
		String[] arrUri = request.getRequestURI().split("/");
		String uri = arrUri[arrUri.length-1];
		String viewPage = null;
		MemberDAO mdao = new MemberDAO();
		
//		System.out.println(uri);
		switch(uri) {
		
		case "join.do":
			comm = new JoinWC();
			comm.execute(request, response);
			viewPage = "Join/joinSuccess.jsp";
			break;
			
		case "idcheck.do":
			boolean idc = false;
			if(mdao.idCheck(request.getParameter("id"))) {
				idc = true;
			}
			else {
				idc = false;
			}
			viewPage = "idcheck.jsp?idc="+idc;
			break;
			
		case "login.do":
			int mnum = mdao.login(request.getParameter("user_id"), request.getParameter("user_pwd"));
			switch(mnum) {
			case -1:
				// 아이디 존재하지 않음
				request.setAttribute("chk", 1);
				viewPage = "../Login/loginfailed.jsp";
				break;
			case -2:
				// 비밀번호 오류
				request.setAttribute("chk", 2);
				viewPage = "../Login/loginfailed.jsp";
				break;
			default:
				// 로그인 성공
				HttpSession session = request.getSession();
				session.setAttribute("mnum", mnum);
				viewPage = "wecal_MainView.jsp";
				break;
			}
			break;
			
		case "modify_user.do":
			try {
				request.setCharacterEncoding("EUC-KR");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			MemberDTO mdto = new MemberDTO();
			mdto.setMember_name(request.getParameter("member_name"));
			mdto.setMember_id(request.getParameter("member_id"));
			mdto.setMember_pwd(request.getParameter("member_pwd"));
			mdto.setMember_birth(request.getParameter("member_birth"));
			mdto.setMember_sex(request.getParameter("member_sex"));
			
			mdao = new MemberDAO();
			switch(mdao.modify_user(mdto)) {
			case 0:
				// 비밀번호 오류
				viewPage = "modify_user_failed.jsp";
				break;
			case 1:
				// 변경 성공
				viewPage = "wecal_MainView.jsp";
				break;
			}
			break;
			
		case "create_meet.do":
			comm = new CreateMeetWC();
			comm.execute(request, response);
			viewPage = "../MainView/wecal_MainView.jsp";
			break;
			
		}
		
        RequestDispatcher rd = request.getRequestDispatcher(viewPage);
        
        try {
			rd.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
