package model;

import java.sql.Date;

public class contract {
	
	private int conID;        //��ͬID
	private int staffID;      //����Ա��ID
	private String conNum;    //��ͬ���
	private Date startDate;   //��ʼʱ��
	private Date endDate;     //����ʱ��
	private String stfPos;    //Ա��ְλ
	private String conCont;   //��ͬ����
	private String conCom;    //��ע
	
	public int getConID() {
		return conID;
	}
	public void setConID(int conID) {
		this.conID = conID;
	}
	public int getStaffID() {
		return staffID;
	}
	public void setStaffID(int staffID) {
		this.staffID = staffID;
	}
	public String getConNum() {
		return conNum;
	}
	public void setConNum(String conNum) {
		this.conNum = conNum;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getStfPos() {
		return stfPos;
	}
	public void setStfPos(String stfPos) {
		this.stfPos = stfPos;
	}
	public String getConCont() {
		return conCont;
	}
	public void setConCont(String conCont) {
		this.conCont = conCont;
	}
	public String getConCom() {
		return conCom;
	}
	public void setConCom(String conCom) {
		this.conCom = conCom;
	}

}
