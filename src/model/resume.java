package model;

import java.util.Date;

public class resume {
	
	private int rsmID;        //����ID
	private int staffID;      //����Ա��ID
	private String rsmCont;   //��������
	private Date startTime;   //��ʼʱ��
	private Date endTime;     //����ʱ��
	private String result;    //ҵ��
	
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
