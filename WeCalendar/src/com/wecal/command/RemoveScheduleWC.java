package com.wecal.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wecal.db.ScheduleDAO;

public class RemoveScheduleWC implements CommandWC {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		ScheduleDAO sdao = new ScheduleDAO();
		sdao.removeSchedule(Integer.parseInt(request.getParameter("schedule_num").toString()));
	}

}
