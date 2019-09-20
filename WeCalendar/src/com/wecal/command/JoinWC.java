package com.wecal.command;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wecal.db.MemberDAO;
import com.wecal.db.MemberDTO;

public class JoinWC implements CommandWC {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
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
		
		MemberDAO mdao = new MemberDAO();
		mdao.join(mdto);
	}

}
