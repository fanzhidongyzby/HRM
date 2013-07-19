package model;

public class document {
	
	private int docID;       //档案ID
	private int staffID;     //所属员工ID
	private String docNum;   //档案编号
	private String docName;  //档案名称
	private String docAbs;   //档案摘要
	private String docCom;   //档案备注
	private String docType;  //档案类型
	
	public int getDocID() {
		return docID;
	}
	public void setDocID(int docID) {
		this.docID = docID;
	}
	public int getStaffID() {
		return staffID;
	}
	public void setStaffID(int staffID) {
		this.staffID = staffID;
	}
	public String getDocNum() {
		return docNum;
	}
	public void setDocNum(String docNum) {
		this.docNum = docNum;
	}
	public String getDocName() {
		return docName;
	}
	public void setDocName(String docName) {
		this.docName = docName;
	}
	public String getDocAbs() {
		return docAbs;
	}
	public void setDocAbs(String docAbs) {
		this.docAbs = docAbs;
	}
	public String getDocCom() {
		return docCom;
	}
	public void setDocCom(String docCom) {
		this.docCom = docCom;
	}
	public String getDocType() {
		return docType;
	}
	public void setDocType(String docType) {
		this.docType = docType;
	}
	

}
