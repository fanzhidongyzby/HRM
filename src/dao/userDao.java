package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import util.DBConnection;

import model.user;

public class userDao {
	
	private Connection conn;
	 private Statement stmt;
	 private PreparedStatement pstmt;
	 private ResultSet rs;
	 
	 /**
	  * 添加一个用户
	  * @param oneUser
	  * @throws SQLException
	  */
	 public void newUser(user oneUser) throws SQLException{
		 conn = DBConnection.connect();	 
		 try{
			 String sql = "insert into t_user values(?,?,?,?,?)";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, oneUser.getUserName());
			 pstmt.setInt(2, oneUser.getStaffID());
			 pstmt.setString(3, oneUser.getPassword());
			 pstmt.setInt(4, oneUser.getUserRole());
			 pstmt.setString(5, oneUser.getDeptIDs());
			 pstmt.executeUpdate();
		 } catch (SQLException e) {
				e.printStackTrace();
			}
	    	finally {
	    		pstmt.close();
	    		conn.close();
	    	}
	 }
	 
	 /**
	  * 根据用户名查找用户
	  * @param userName
	  */
	 public user findByName(String userName){
		 user oneUser = null;
		 conn = DBConnection.connect();	 
 		 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "select * from t_user where userName = '" + userName + "'";
 			 rs = stmt.executeQuery(sql);
 			 if(rs.next()){
 				 oneUser = new user();
 				 oneUser.setUserName(userName);
 				 oneUser.setStaffID(rs.getInt("staffID"));
 				 oneUser.setPassword(rs.getString("password"));
 				 oneUser.setUserRole(rs.getInt("userRole"));
 				 oneUser.setDeptIDs(rs.getString("deptIDs"));
 				 return oneUser;
 			 }
 			 return oneUser;
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
	  * 返回所有用户
	  * @return
	  */
	 public ArrayList<user> findAll(){
		 ArrayList<user> userList = new ArrayList<user>();
		 user oneUser = null;
		 conn = DBConnection.connect();	 
 		 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "select * from t_user";
 			 rs = stmt.executeQuery(sql);
 			 while(rs.next()){
 				 oneUser = new user();
 				 oneUser.setUserName(rs.getString("userName"));
 				 oneUser.setStaffID(rs.getInt("staffID"));
 				 oneUser.setPassword(rs.getString("password"));
 				 oneUser.setUserRole(rs.getInt("userRole"));
 				 oneUser.setDeptIDs(rs.getString("deptIDs"));
 				 userList.add(oneUser);
 			 }
 			 return userList;
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
	  * 系统管理员编辑用户
	  * @param oneUser
	  * @throws SQLException
	  */
	 public void editBySA(user oneUser){
		 conn = DBConnection.connect();	 
		 try{
			 String sql = "update t_user set staffID = ?, password = ?, " 
			 		    + "userRole = ?, deptIDs = ? where userName = ?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, oneUser.getStaffID());
			 pstmt.setString(2, oneUser.getPassword());
			 pstmt.setInt(3, oneUser.getUserRole());
			 pstmt.setString(4, oneUser.getDeptIDs());
			 pstmt.setString(5, oneUser.getUserName());
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
	  * 普通管理员编辑用户
	  * @param oneUser
	  * @throws SQLException
	  */
	 public void editByA(user oneUser){
		 conn = DBConnection.connect();	 
		 try{
			 String sql = "update t_user set staffID = ?, " 
			 		    + "userRole = ?, deptIDs = ? where userName = ?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, oneUser.getStaffID());
			 pstmt.setInt(2, oneUser.getUserRole());
			 pstmt.setString(3, oneUser.getDeptIDs());
			 pstmt.setString(4, oneUser.getUserName());
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
	  * @删除一个用户
	  */
	 public void delete(String userName){
		 conn = DBConnection.connect();	 
 		 
 		 try{
 			stmt = conn.createStatement();
 			 String sql = "delete from t_user where userName = '" + userName + "'";
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

}
