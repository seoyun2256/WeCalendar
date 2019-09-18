package com.wecal.db;

public class MeetDTO {
	private int meet_num;
	private String meet_name;
	private String meet_content;
	private int meet_master;
	private String master_name;
	
	public String getMaster_name() {
		return master_name;
	}
	public void setMaster_name(String master_name) {
		this.master_name = master_name;
	}
	public int getMeet_master() {
		return meet_master;
	}
	public void setMeet_master(int meet_master) {
		this.meet_master = meet_master;
	}
	public int getMeet_num() {
		return meet_num;
	}
	public void setMeet_num(int meet_num) {
		this.meet_num = meet_num;
	}
	public String getMeet_name() {
		return meet_name;
	}
	public void setMeet_name(String meet_name) {
		this.meet_name = meet_name;
	}
	public String getMeet_content() {
		return meet_content;
	}
	public void setMeet_content(String meet_content) {
		this.meet_content = meet_content;
	}
}
