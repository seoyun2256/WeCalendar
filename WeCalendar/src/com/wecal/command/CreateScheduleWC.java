package com.wecal.command;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wecal.db.ScheduleDAO;
import com.wecal.db.ScheduleDTO;

public class CreateScheduleWC implements CommandWC {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		ScheduleDTO sdto = new ScheduleDTO();
		sdto.setSchedule_name(request.getParameter("schedule_name"));
		sdto.setSchedule_content(request.getParameter("schedule_content"));
		sdto.setSchedule_startDay(request.getParameter("schedule_startDay"));
		sdto.setSchedule_endDay(request.getParameter("schedule_endDay"));
		sdto.setMeet_num(Integer.parseInt(request.getParameter("meet_num").toString()));
		
		ScheduleDAO sdao = new ScheduleDAO();
		sdao.create_schedule(sdto);
		
	}

}
