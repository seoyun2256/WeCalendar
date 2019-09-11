package com.wecal.server;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		switch(uri) {
		case "join.do":
			comm = new JoinWC();
			comm.execute(request, response);
			viewPage = "Join/joinSuccess.jsp";
			break;
		case "idcheck.do":
			MemberDTO mdto = new MemberDTO();
			mdto.setMember_id(request.getParameter("id"));
			
			MemberDAO mdao = new MemberDAO();
			if(mdao.idCheck(mdto)) {
				System.out.println("ok");
				request.setAttribute("idc", "ok");
			}
			else {
				System.out.println("no");
				request.setAttribute("idc", "no");
			}
			viewPage = "join.jsp";
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
