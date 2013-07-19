package model;

public class staff {
	
	private int staffID;        //员工ID
	private String staffNum;    //员工编号
	private String staffName;   //员工姓名
	private int sex;            //性别
	private int age;            //年龄
	private String eduBack;     //学历
	private String degree;      //学位
	private String tech;        //技术
	private int deptID;         //所属部门ID
	private String position;    //职位
	private String status;      //状态（在职、离职）
	private String imgDir;      //图片存放路径	
	private int salary;         //工资
	private int socSec;         //社保
	
	public int getStaffID() {
		return staffID;
	}
	public void setStaffID(int staffID) {
		this.staffID = staffID;
	}
	public String getStaffNum() {
		return staffNum;
	}
	public void setStaffNum(String staffNum) {
		this.staffNum = staffNum;
	}
	public String getStaffName() {
		return staffName;
	}
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getEduBack() {
		return eduBack;
	}
	public void setEduBack(String eduBack) {
		this.eduBack = eduBack;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getTech() {
		return tech;
	}
	public void setTech(String tech) {
		this.tech = tech;
	}
	public int getDeptID() {
		return deptID;
	}
	public void setDeptID(int deptID) {
		this.deptID = deptID;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getImgDir() {
		return imgDir;
	}
	public void setImgDir(String imgDir) {
		this.imgDir = imgDir;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	public int getSocSec() {
		return socSec;
	}
	public void setSocSec(int socSec) {
		this.socSec = socSec;
	}
	
}
