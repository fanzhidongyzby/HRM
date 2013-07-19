package model;

import java.sql.Date;

public class contract {
	
	private int conID;        //合同ID
	private int staffID;      //所属员工ID
	private String conNum;    //合同编号
	private Date startDate;   //开始时间
	private Date endDate;     //结束时间
	private String stfPos;    //员工职位
	private String conCont;   //合同内容
	private String conCom;    //备注
	
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
