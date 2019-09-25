package com.wecal.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wecal.db.MemberDAO;

public class QuitMeetWC implements CommandWC {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		MemberDAO mdao = new MemberDAO();
		mdao.quitMeet(Integer.parseInt(request.getParameter("member_num").toString()), Integer.parseInt(request.getParameter("meet_num").toString()));
	}

}
