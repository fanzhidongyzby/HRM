package model;

import java.util.Date;

public class seperation {
	
	private int staffID;       //����Ա����ID
	private String sepType;    //��������
	private String sepReason;  //����ԭ��
	private Date sepTime;      //����ʱ��
	
	public int getStaffID() {
		return staffID;
	}
	public void setStaffID(int staffID) {
		this.staffID = staffID;
	}
	public String getSepType() {
		return sepType;
	}
	public void setSepType(String sepType) {
		this.sepType = sepType;
	}
	public String getSepReason() {
		return sepReason;
	}
	public void setSepReason(String sepReason) {
		this.sepReason = sepReason;
	}
	public Date getSepTime() {
		return sepTime;
	}
	public void setSepTime(Date sepTime) {
		this.sepTime = sepTime;
	}

}
