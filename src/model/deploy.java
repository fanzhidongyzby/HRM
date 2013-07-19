package model;

import java.util.Date;

public class deploy {
	
	private int deplID;         //调动 ID
	private int staffID;        //调动的员工ID
	private Date deplTime;      //调动时间
	private String deplBefore;  //调动前状态
	private String deplAfter;   //调动后状态
	private String deplType;    //调动类型
	
	public int getDeplID() {
		return deplID;
	}
	public void setDeplID(int deplID) {
		this.deplID = deplID;
	}
	public int getStaffID() {
		return staffID;
	}
	public void setStaffID(int staffID) {
		this.staffID = staffID;
	}
	public Date getDeplTime() {
		return deplTime;
	}
	public void setDeplTime(Date deplTime) {
		this.deplTime = deplTime;
	}
	public String getDeplBefore() {
		return deplBefore;
	}
	public void setDeplBefore(String deplBefore) {
		this.deplBefore = deplBefore;
	}
	public String getDeplAfter() {
		return deplAfter;
	}
	public void setDeplAfter(String deplAfter) {
		this.deplAfter = deplAfter;
	}
	public String getDeplType() {
		return deplType;
	}
	public void setDeplType(String deplType) {
		this.deplType = deplType;
	}

}
