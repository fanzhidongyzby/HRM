package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.staff;
import util.DBConnection;
import util.PageModel;

public class staffDao {
	
	 private Connection conn;
	 private Statement stmt;
	 private PreparedStatement pstmt;
	 private ResultSet rs;
	 
	 /**
	 *
	 * @找到下个ID，方便添加新员工
	 */
	 public int nextID(){
		 conn = DBConnection.connect();	 
		 int currentId = -1;
	    	try {	    	
	    		stmt = conn.createStatement();
	    		String sql = "select max(staffID) from t_staff";
	    		rs = stmt.executeQuery(sql);
	    		if(rs.next())
	    			currentId = rs.getInt(1);
	    		//return (currentId + 1);
	    	} catch (SQLException e) {
				e.printStackTrace();
			}
	    	finally {
	    		try {
					rs.close();
					stmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	    	return (currentId + 1);
	 }
	 
	 /**
	  * 添加一个员工
	 * @throws SQLException  
	  */
	 public void newStaff(staff oneStaff){
		 conn = DBConnection.connect();	 
 		 try{
 			 String sql = "insert into t_staff values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
 			 pstmt = conn.prepareStatement(sql);
 			 pstmt.setInt(1, oneStaff.getStaffID());
 			 pstmt.setString(2, oneStaff.getStaffNum());
 			 pstmt.setString(3, oneStaff.getStaffName());
 			 pstmt.setInt(4, oneStaff.getSex());
 			 
 			 pstmt.setString(5, oneStaff.getEduBack());
 			 pstmt.setString(6, oneStaff.getDegree());
 			 pstmt.setString(7, oneStaff.getEduBack());
 			 pstmt.setInt(8, oneStaff.getDeptID());
 			 pstmt.setString(9, oneStaff.getPosition());
 			 pstmt.setString(10, oneStaff.getStatus());
 			 pstmt.setInt(11, oneStaff.getSalary());
 			 pstmt.setInt(12, oneStaff.getSocSec());
 			pstmt.setInt(13, oneStaff.getAge());
 			 pstmt.executeUpdate();
 		 } catch (SQLException e) {
				e.printStackTrace();
			}
	    	finally {
	    		try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	 }

	 /**
	  * @删除一个员工
	  */
	 public void delete(int id){
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "delete from t_staff where staffID = " + id + "";
 			 stmt.executeUpdate(sql);
 		 }catch (SQLException e) {
				e.printStackTrace();
			}
	    	finally {
	    		try {
					stmt.close();
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	 }
	 
	 /**
	  * 按ID找到一个员工
	 * @throws SQLException 
	  */
	 public staff findByID(int id){
		 conn = DBConnection.connect();	 
 		 staff oneStaff = null;
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "select * from t_staff where staffID = " + id + "";
 			 rs = stmt.executeQuery(sql);
 			 if(rs.next()){
 				 oneStaff = new staff();
 				 oneStaff.setStaffID(id);
 				 oneStaff.setStaffNum(rs.getString("staffNum"));
 				 oneStaff.setStaffName(rs.getString("staffName"));
 				 oneStaff.setSex(rs.getInt("sex"));
 				 oneStaff.setAge(rs.getInt("age"));
 				 oneStaff.setEduBack(rs.getString("eduBack"));
 				 oneStaff.setDegree(rs.getString("degree"));
 				 oneStaff.setTech(rs.getString("tech"));
 				 oneStaff.setDeptID(rs.getInt("deptID"));
 				 oneStaff.setPosition(rs.getString("position"));
 				 oneStaff.setStatus(rs.getString("status"));
 				 oneStaff.setSalary(rs.getInt("salary"));
 				 oneStaff.setSocSec(rs.getInt("socSec"));
 				 return oneStaff;
 			 }
 			 return oneStaff;
 		 }catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
	    	finally {
	    		try {
					rs.close();
					stmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	 }
	 
	 /**
	  * 返回某个部门下的所有员工
	  * @param deptID
	  * @return
	  */
	 public ArrayList<staff> findByDept(int deptID){
		 ArrayList<staff> staffList = new ArrayList<staff>();
		 staff oneStaff = null;
		 conn = DBConnection.connect();
		 try{
			 stmt = conn.createStatement();
			 String sql = "select * from t_staff where deptID = " + deptID + "";
			 rs = stmt.executeQuery(sql);
			 while(rs.next()){
				 oneStaff = new staff();
				 oneStaff.setStaffID(rs.getInt("staffID"));
				 oneStaff.setStaffNum(rs.getString("staffNum"));
 				 oneStaff.setStaffName(rs.getString("staffName"));
 				 oneStaff.setSex(rs.getInt("sex"));
 				 oneStaff.setAge(rs.getInt("age"));
 				 oneStaff.setEduBack(rs.getString("eduBack"));
 				 oneStaff.setDegree(rs.getString("degree"));
 				 oneStaff.setTech(rs.getString("tech"));
 				 oneStaff.setDeptID(rs.getInt("deptID"));
 				 oneStaff.setPosition(rs.getString("position"));
 				 oneStaff.setStatus(rs.getString("status"));
 				 oneStaff.setSalary(rs.getInt("salary"));
 				 oneStaff.setSocSec(rs.getInt("socSec"));
 				 staffList.add(oneStaff);
			 }
			 return staffList;
		 }catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
	    	finally {
	    		try {
					rs.close();
					stmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	 }
	 
	 /**
	  * 返回某个部门下的所有员工(分页)
	  * @param deptID
	  * @return
	  */
	 public PageModel findByDept(int pageNo, int pageSize, int deptID){
		 ArrayList<staff> staffList = new ArrayList<staff>();
		 staff oneStaff = null;
		 conn = DBConnection.connect();
		 StringBuffer sbSql = new StringBuffer();
			sbSql.append("select * from ")
				.append("(")
					.append("select rownum rn, t.* from ")
					.append("(")
						.append("select * from t_staff where deptID = " + deptID + "")
						.append(") t where rownum <=?")
				.append(") where rn>?");
			
			PageModel pageModel = null;
		 try{
			 pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setInt(1, pageNo * pageSize);
				pstmt.setInt(2, (pageNo -1)*pageSize);
				rs = pstmt.executeQuery();
			 while(rs.next()){
				 oneStaff = new staff();
				 oneStaff.setStaffID(rs.getInt("staffID"));
				 oneStaff.setStaffNum(rs.getString("staffNum"));
 				 oneStaff.setStaffName(rs.getString("staffName"));
 				 oneStaff.setSex(rs.getInt("sex"));
 				 oneStaff.setAge(rs.getInt("age"));
 				 oneStaff.setEduBack(rs.getString("eduBack"));
 				 oneStaff.setDegree(rs.getString("degree"));
 				 oneStaff.setTech(rs.getString("tech"));
 				 oneStaff.setDeptID(rs.getInt("deptID"));
 				 oneStaff.setPosition(rs.getString("position"));
 				 oneStaff.setStatus(rs.getString("status"));
 				 oneStaff.setSalary(rs.getInt("salary"));
 				 oneStaff.setSocSec(rs.getInt("socSec"));
 				 staffList.add(oneStaff);
			 }
			 pageModel = new PageModel();
				pageModel.setPageSize(pageSize);
				pageModel.setPageNo(pageNo);
				pageModel.setList(staffList);
				pageModel.setTotalRecords(getTotalRecords(deptID));
		 }catch (SQLException e) {
				e.printStackTrace();
			}
	    	finally {
	    		try {
					rs.close();
					pstmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	    	return pageModel;
	 }
	 
	 public int getTotalRecords(int deptID) {
		    String sql = "select count(*) from t_staff where deptID = " + deptID + "";
			int totalRecords = 0;
			try {
				conn = DBConnection.connect();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				rs.next();
				totalRecords = rs.getInt(1);
			}catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {
					rs.close();
					stmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return totalRecords;
		}
	 
	 /**
	  * 按编号查找员工
	  * @param staffNum
	  */
	 public staff findByNum(String staffNum){
		 staff oneStaff = null;
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "select * from t_staff where staffNum = '" + staffNum + "'";
 			 rs = stmt.executeQuery(sql);
 			 if(rs.next()){
 				 oneStaff = new staff();
 				 oneStaff.setStaffID(rs.getInt("staffID"));
 				 oneStaff.setStaffNum(rs.getString("staffNum"));
 				 oneStaff.setStaffName(rs.getString("staffName"));
 				 oneStaff.setSex(rs.getInt("sex"));
 				 oneStaff.setAge(rs.getInt("age"));
 				 oneStaff.setEduBack(rs.getString("eduBack"));
 				 oneStaff.setDegree(rs.getString("degree"));
 				 oneStaff.setTech(rs.getString("tech"));
 				 oneStaff.setDeptID(rs.getInt("deptID"));
 				 oneStaff.setPosition(rs.getString("position"));
 				 oneStaff.setStatus(rs.getString("status"));
 				 oneStaff.setSalary(rs.getInt("salary"));
 				 oneStaff.setSocSec(rs.getInt("socSec"));
 				 return oneStaff;
 			 }
 			 return oneStaff;
 		 }catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
	    	finally {
	    		try {
					rs.close();
					stmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	 }
	 
	 /**
	  * 全局查询
	  * @throws SQLException
	  */
	 public PageModel findByOther(int pageNo, int pageSize, String staffName, int sex, int ageL, int ageH, String degree, String position, String tech){
		 ArrayList<staff> staffList = new ArrayList<staff>();
		 staff oneStaff = null;
		 conn = DBConnection.connect();	
		 String sql = "select * from t_staff where ";
			 if(staffName!=null&&staffName!="")
				 sql = sql + "staffName = '" +staffName + "' and ";
			 if(sex != -1){
				 sql = sql + "sex = " + sex + " and "; 
			 }
			 if(ageL != 0){
				 sql = sql + "age between " + ageL + " and " + ageH + " and ";
			 }
			 if(degree != null&&degree!=""){
				 sql = sql + "degree like '%" + degree + "%' and ";
			 }
			 if(position != null&&position!=""){
				 sql = sql + "position = '" + position + "' and ";
			 }
			 if(tech != null&&tech!=""){
				 sql = sql + "tech like '%" + tech + "%' and ";
			 }
			 sql = sql + "1=1";
			 System.out.println(sql);
			 
			 StringBuffer sbSql = new StringBuffer();
				sbSql.append("select * from ")
					.append("(")
						.append("select rownum rn, t.* from ")
						.append("(")
							.append(sql)
							.append(") t where rownum <=?")
					.append(") where rn>?");
				
				PageModel pageModel = null;
 		 try{
 			 stmt = conn.createStatement();
 			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setInt(1, pageNo * pageSize);
			pstmt.setInt(2, (pageNo -1)*pageSize);
			rs = pstmt.executeQuery();

 			 while(rs.next()){
 				 oneStaff = new staff();
 				 oneStaff.setStaffID(rs.getInt("staffID"));
 				 oneStaff.setStaffNum(rs.getString("staffNum"));
 				 oneStaff.setStaffName(rs.getString("staffName"));
 				 oneStaff.setSex(rs.getInt("sex"));
 				 oneStaff.setAge(rs.getInt("age"));
 				 oneStaff.setEduBack(rs.getString("eduBack"));
 				 oneStaff.setDegree(rs.getString("degree"));
 				 oneStaff.setTech(rs.getString("tech"));
 				 oneStaff.setDeptID(rs.getInt("deptID"));
 				 oneStaff.setPosition(rs.getString("position"));
 				 oneStaff.setStatus(rs.getString("status"));
 				 oneStaff.setSalary(rs.getInt("salary"));
 				 oneStaff.setSocSec(rs.getInt("socSec"));
 				 staffList.add(oneStaff);
 			 }
 			pageModel = new PageModel();
			pageModel.setPageSize(pageSize);
			pageModel.setPageNo(pageNo);
			pageModel.setList(staffList);
			pageModel.setTotalRecords(getTotalRecordsSrch(staffName, sex, ageL, ageH, degree, position, tech));
 		 }catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
	    	finally {
	    		try {
					rs.close();
					pstmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	    	return pageModel;
	 }
	 
	 public int getTotalRecordsSrch(String staffName, int sex, int ageL, int ageH, String degree, String position, String tech) {
		 String sql = "select count(*) from t_staff where ";
		 if(staffName!=null)
			 sql = sql + "staffName = '" +staffName + "' and ";
		 if(sex != -1){
			 sql = sql + "sex = " + sex + " and "; 
		 }
		 if(ageL != 0){
			 sql = sql + "age between " + ageL + " and " + ageH + " and ";
		 }
		 if(degree != null&&degree!=""){
			 sql = sql + "degree = '" + degree + "' and ";
		 }
		 if(position != null&&position!=""){
			 sql = sql + "position = '" + position + "' and ";
		 }
		 if(tech != null&&tech!=""){
			 sql = sql + "tech = '" + tech + "' and ";
		 }
		 sql = sql + "1=1";
			int totalRecords = 0;
			try {
				conn = DBConnection.connect();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				rs.next();
				totalRecords = rs.getInt(1);
			}catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {
					rs.close();
					stmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return totalRecords;
		}
	 
	 /**
	  * 修改一个员工的信息
	  * @throws SQLException
	  */
	 public void edit(staff oneStaff){
		 conn = DBConnection.connect();	 
 		 try{
 			 String sql = "update t_staff set age = ?, eduBack = ?, degree = ?," 
 				        + " tech = ?, deptID = ?, position = ?, status = ?," 
 				        + "salary = ?, socSec = ? where staffID = ?";
 			 pstmt = conn.prepareStatement(sql);
 			 pstmt.setInt(1, oneStaff.getAge());
 			 pstmt.setString(2, oneStaff.getEduBack());
 			 pstmt.setString(3, oneStaff.getDegree());
 			 pstmt.setString(4, oneStaff.getTech());
 			 pstmt.setInt(5, oneStaff.getDeptID());
 			 pstmt.setString(6, oneStaff.getPosition());
 			 pstmt.setString(7, oneStaff.getStatus());
 			 pstmt.setInt(8, oneStaff.getSalary());
 			 pstmt.setInt(9, oneStaff.getSocSec());
 			 pstmt.setInt(10, oneStaff.getStaffID());
 			 pstmt.executeUpdate();
 		 }catch (SQLException e) {
				e.printStackTrace();
			}
	    	finally {
	    		try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	 }
	 
	 /**
	  * 调动同步
	  */
	 public void deploy(int staffID, int deptID, String position){
		 conn = DBConnection.connect();	 
		 String sql = null;
		 if(deptID==0){
			 sql = "update t_staff set deptID = null, position=null where staffID = " + staffID + "";
		 }else{
			 sql = "update t_staff set deptID = " + deptID + ", position = '" + position + "' where staffID = " + staffID + "";
		 }
		 try{
			 stmt = conn.createStatement();
			 stmt.executeUpdate(sql);
		 }catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					stmt.close();
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
	 }
	 
	 /**
	  * 退休人员预测
	  */
	 public PageModel retire(int pageNo, int pageSize){
		 ArrayList<staff> staffList = new ArrayList<staff>();
		 staff oneStaff = null;
		 conn = DBConnection.connect();
		 StringBuffer sbSql = new StringBuffer();
			sbSql.append("select * from ")
				.append("(")
					.append("select rownum rn, t.* from ")
					.append("(")
						.append("select * from t_staff where sex=0 and age>=50 union select * from t_staff where sex=1 and age>=60")
						.append(") t where rownum <=?")
				.append(") where rn>?");
			
			PageModel pageModel = null;
		 try{
			 pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setInt(1, pageNo * pageSize);
				pstmt.setInt(2, (pageNo -1)*pageSize);
				rs = pstmt.executeQuery();
			 while(rs.next()){
				 oneStaff = new staff();
				 oneStaff.setStaffID(rs.getInt("staffID"));
				 oneStaff.setStaffNum(rs.getString("staffNum"));
 				 oneStaff.setStaffName(rs.getString("staffName"));
 				 oneStaff.setSex(rs.getInt("sex"));
 				 oneStaff.setAge(rs.getInt("age"));
 				 oneStaff.setEduBack(rs.getString("eduBack"));
 				 oneStaff.setDegree(rs.getString("degree"));
 				 oneStaff.setTech(rs.getString("tech"));
 				 oneStaff.setDeptID(rs.getInt("deptID"));
 				 oneStaff.setPosition(rs.getString("position"));
 				 oneStaff.setStatus(rs.getString("status"));
 				 oneStaff.setSalary(rs.getInt("salary"));
 				 oneStaff.setSocSec(rs.getInt("socSec"));
 				 staffList.add(oneStaff);
			 }
			 pageModel = new PageModel();
				pageModel.setPageSize(pageSize);
				pageModel.setPageNo(pageNo);
				pageModel.setList(staffList);
				pageModel.setTotalRecords(getTotalRecordsRtr());
		 }catch (SQLException e) {
				e.printStackTrace();
			}
	    	finally {
	    		try {
					rs.close();
					pstmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	    	return pageModel;
	 }
	 
	 public int getTotalRecordsRtr() {
		    String sqlFemale = "select count(*) from t_staff where sex=0 and age>=50";
		    String sqlMale = "select count(*) from t_staff where sex=1 and age>=60";
			int totalRecords = 0;
			try {
				conn = DBConnection.connect();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sqlFemale);
				rs.next();
				totalRecords = rs.getInt(1);
				rs =stmt.executeQuery(sqlMale);
				rs.next();
				totalRecords = totalRecords + rs.getInt(1);
			}catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {
					rs.close();
					stmt.close();
		    		conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return totalRecords;
		}
}
