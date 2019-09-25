package com.wecal.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wecal.db.MeetDAO;

public class RemoveMeetWC implements CommandWC {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		MeetDAO mtdao = new MeetDAO();
		mtdao.removeMeet(Integer.parseInt(request.getParameter("meet_num").toString()));
	}

}
