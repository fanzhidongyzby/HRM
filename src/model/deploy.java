package model;

import java.util.Date;

public class deploy {
	
	private int deplID;         //���� ID
	private int staffID;        //������Ա��ID
	private Date deplTime;      //����ʱ��
	private String deplBefore;  //����ǰ״̬
	private String deplAfter;   //������״̬
	private String deplType;    //��������
	
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
