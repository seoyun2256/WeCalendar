package com.wecal.db;

public class ScheduleDTO {

	private int schedule_num;
	private String schedule_name;
	private String schedule_content;
	private String schedule_startDay;
	private String schedule_endDay;
	private int meet_num;
	
	public int getSchedule_num() {
		return schedule_num;
	}
	public void setSchedule_num(int schedule_num) {
		this.schedule_num = schedule_num;
	}
	public String getSchedule_name() {
		return schedule_name;
	}
	public void setSchedule_name(String schedule_name) {
		this.schedule_name = schedule_name;
	}
	public String getSchedule_content() {
		return schedule_content;
	}
	public void setSchedule_content(String schedule_content) {
		this.schedule_content = schedule_content;
	}
	public String getSchedule_startDay() {
		return schedule_startDay;
	}
	public void setSchedule_startDay(String schedule_startDay) {
		this.schedule_startDay = schedule_startDay;
	}
	public String getSchedule_endDay() {
		return schedule_endDay;
	}
	public void setSchedule_endDay(String schedule_endDay) {
		this.schedule_endDay = schedule_endDay;
	}
	public int getMeet_num() {
		return meet_num;
	}
	public void setMeet_num(int meet_num) {
		this.meet_num = meet_num;
	}
	
}
