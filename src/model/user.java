package model;

public class user {
	
	private String userName;     //用户名
	private int staffID;         //绑定的员工ID
	private String password;     //密码
	private int userRole;        //用户角色
	private String deptIDs;      //管理的机构ID
	
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
