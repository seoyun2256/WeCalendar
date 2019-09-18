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
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		CommandWC comm = null;
		
		String[] arrUri = request.getRequestURI().split("/");
		String uri = arrUri[arrUri.length-1];
		RequestDispatcher rd = null;
		MemberDAO mdao = new MemberDAO();
		
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
				// ���̵� �������� ����
				request.setAttribute("chk", 1);
				rd = request.getRequestDispatcher("../Login/loginfailed.jsp");
				rd.forward(request, response);
				break;
			case -2:
				// ��й�ȣ ����
				request.setAttribute("chk", 2);
				rd = request.getRequestDispatcher("../Login/loginfailed.jsp");
				rd.forward(request, response);
				break;
			default:
				// �α��� ����
				request.getSession().setAttribute("mnum", mnum);
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
				// ��й�ȣ ����
				rd = request.getRequestDispatcher("modify_user_failed.jsp");
				rd.forward(request, response);
				break;
			case 1:
				// ���� ����
				response.sendRedirect("wecal_MainView.jsp");
				break;
			}
			break;
			
		case "create_meet.do":
			comm = new CreateMeetWC();
			comm.execute(request, response);
			response.sendRedirect("../MainView/wecal_MainView.jsp");
			break;
			
		}
		
	}

}
