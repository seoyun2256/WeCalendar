package com.wecal.server;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.RequestWrapper;

import com.wecal.command.CommandWC;
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
			switch(mdao.login(request.getParameter("user_id"), request.getParameter("user_pwd"))) {
			case 1:
				// 아이디 존재하지 않음
				System.out.println("case 1");
				request.setAttribute("chk", 1);
				viewPage = "../Login/loginfailed.jsp";
				break;
			case 2:
				// 비밀번호 오류
				System.out.println("case 2");
				request.setAttribute("chk", 2);
				viewPage = "../Login/loginfailed.jsp";
				break;
			case 3:
				// 로그인 성공
				HttpSession session = request.getSession();
				session.setAttribute("id", request.getParameter("user_id"));
				viewPage = "wecal_MainView.jsp";
				break;
			}
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
