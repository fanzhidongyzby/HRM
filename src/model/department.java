package model;

public class department {
	
	private int deptID;        //机构ID
	private String deptName;   //机构名称
	private String deptAffi;   //机构之间的隶属关系
	private int deptLevel;     //机构级别
	
	public int getDeptID() {
		return deptID;
	}
	public void setDeptID(int deptID) {
		this.deptID = deptID;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getDeptAffi() {
		return deptAffi;
	}
	public void setDeptAffi(String deptAffi) {
		this.deptAffi = deptAffi;
	}
	public int getDeptLevel() {
		return deptLevel;
	}
	public void setDeptLevel(int deptLevel) {
		this.deptLevel = deptLevel;
	}

}
