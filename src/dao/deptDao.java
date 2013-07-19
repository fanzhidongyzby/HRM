package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import model.department;
import util.DBConnection;

public class deptDao {
	
	 private Connection conn;
	 private Statement stmt;
	 private PreparedStatement pstmt;
	 private ResultSet rs;
	 
	 /**
	 *
	 * @找到下个ID，方便添加新部门
	 */
	 public int nextID(){
		 conn = DBConnection.connect();	
		 int currentId = -1;
	    	try {
	    		stmt = conn.createStatement();
	    		String sql = "select max(deptID) from t_dept";
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
	  * 添加一个部门
	  * @param oneDpt
	  * @throws SQLException
	  */
	 public void newDpt(department oneDpt){
		 conn = DBConnection.connect();
		 try{
			 String sql = "insert into t_dept values(?,?,?,?)";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, oneDpt.getDeptID());
			 pstmt.setString(2, oneDpt.getDeptName());
			 pstmt.setString(3, oneDpt.getDeptAffi());
			 pstmt.setInt(4, oneDpt.getDeptLevel());
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
	  * @删除一个部门
	  */
	 public void delete(int id){
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "delete from t_dept where deptID = " + id + "";
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
	 
	 public department findByID(int deptID){
		 department oneDept = null;
		 conn = DBConnection.connect();
		 try{
			 stmt = conn.createStatement();
			 String sql = "select * from t_dept where deptID = " + deptID + "";
			 rs = stmt.executeQuery(sql);
			 if(rs.next()){
				 oneDept = new department();
				 oneDept.setDeptID(rs.getInt("deptID"));
				 oneDept.setDeptName(rs.getString("deptName"));
				 oneDept.setDeptAffi(rs.getString("deptAffi"));
				 oneDept.setDeptLevel(rs.getInt("deptLevel"));
				 return oneDept;
			 }
			 return oneDept;
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
	  * 编辑机构名称
	  * @param id
	  * @param deptName
	  */
	 public void editDpt(int id, String deptName){
		 conn = DBConnection.connect();	 
		 try{
			 stmt = conn.createStatement();
			 String sql = "update t_dept set deptName = '" + deptName 
			            + "' where deptID= " + id + "";
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
	  * 编辑机构隶属关系
	  * @param id
	  * @param affi
	  */
	 public void editAffi(int id, String affi){
		 conn = DBConnection.connect();	 
		 try{
			 stmt = conn.createStatement();
			 String sql = "update t_dept set deptAffi = '" + affi 
			            + "' where deptID= " + id + "";
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
	  * 返回部门ID
	  * @param deptName
	  */
	 public int IDByName(String deptName){
		 conn = DBConnection.connect();	 
		 int deptID = 0;
	    	try {	  
	    		stmt = conn.createStatement();
	    		String sql = "select deptID from t_dept where deptName = '" + deptName + "'";
	    		rs = stmt.executeQuery(sql);
	    		if(rs.next())
	    			deptID = rs.getInt("deptID");
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
	    	return deptID;
	 }

}
