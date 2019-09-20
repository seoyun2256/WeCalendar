package com.wecal.command;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wecal.db.MeetDAO;
import com.wecal.db.MeetDTO;

public class CreateMeetWC implements CommandWC {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {try {
		request.setCharacterEncoding("UTF-8");
	} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	}
	
	MeetDTO mdto = new MeetDTO();
	mdto.setMeet_name(request.getParameter("meet_name"));
	mdto.setMeet_content(request.getParameter("meet_content"));
	
	MeetDAO mdao = new MeetDAO();
	mdao.create_meet(mdto, Integer.parseInt(request.getParameter("member_num").toString()));
	mdao.create_member_meet(Integer.parseInt(request.getParameter("member_num").toString()), mdao.findSeq());
	
	}

}
