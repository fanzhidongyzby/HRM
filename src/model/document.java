package model;

public class document {
	
	private int docID;       //����ID
	private int staffID;     //����Ա��ID
	private String docNum;   //�������
	private String docName;  //��������
	private String docAbs;   //����ժҪ
	private String docCom;   //������ע
	private String docType;  //��������
	
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
