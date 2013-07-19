package model;

import java.util.Date;

public class resume {
	
	private int rsmID;        //履历ID
	private int staffID;      //所属员工ID
	private String rsmCont;   //履历内容
	private Date startTime;   //开始时间
	private Date endTime;     //结束时间
	private String result;    //业绩
	
	public int getRsmID() {
		return rsmID;
	}
	public void setRsmID(int rsmID) {
		this.rsmID = rsmID;
	}
	public int getStaffID() {
		return staffID;
	}
	public void setStaffID(int staffID) {
		this.staffID = staffID;
	}
	public String getRsmCont() {
		return rsmCont;
	}
	public void setRsmCont(String rsmCont) {
		this.rsmCont = rsmCont;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}

}
