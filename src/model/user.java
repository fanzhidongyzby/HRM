package model;

public class user {
	
	private String userName;     //�û���
	private int staffID;         //�󶨵�Ա��ID
	private String password;     //����
	private int userRole;        //�û���ɫ
	private String deptIDs;      //����Ļ���ID
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getStaffID() {
		return staffID;
	}
	public void setStaffID(int staffID) {
		this.staffID = staffID;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getUserRole() {
		return userRole;
	}
	public void setUserRole(int userRole) {
		this.userRole = userRole;
	}
	public String getDeptIDs() {
		return deptIDs;
	}
	public void setDeptIDs(String deptIDs) {
		this.deptIDs = deptIDs;
	}

}
