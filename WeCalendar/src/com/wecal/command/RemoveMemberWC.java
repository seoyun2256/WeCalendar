package com.wecal.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wecal.db.MemberDAO;

public class RemoveMemberWC implements CommandWC {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		MemberDAO mdao = new MemberDAO();
		mdao.removeMember(Integer.parseInt(request.getParameter("member_num").toString()));
	}

}
