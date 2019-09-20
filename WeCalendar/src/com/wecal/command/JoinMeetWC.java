package com.wecal.command;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wecal.db.MeetDAO;
import com.wecal.db.Member_MeetDTO;

public class JoinMeetWC implements CommandWC {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		Member_MeetDTO mmdto = new Member_MeetDTO();
		mmdto.setMember_num(Integer.parseInt(request.getSession().getAttribute("mnum").toString()));
		mmdto.setMeet_num(Integer.parseInt(request.getParameter("meet_num").toString()));
		MeetDAO mdao = new MeetDAO();
		mdao.join_meet(mmdto);
		
	}

}
