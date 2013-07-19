package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.resume;
import util.DBConnection;

public class resumeDao {
	
	 private Connection conn;
	 private Statement stmt;
	 private PreparedStatement pstmt;
	 private ResultSet rs;
	 
	 /**
	 *
	 * @找到下个ID，方便添加新履历项
	 */
	 public int nextID(){
		 conn = DBConnection.connect();	 
		 int currentId = -1;
	    	try {	   
	    		stmt = conn.createStatement();
	    		String sql = "select max(rsmID) from t_resume";
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
	  * 根据履历ID找到一条履历
	  * @param id
	  * @return
	  * @throws SQLException
	  */
	 public resume findByID(int id){
		 conn = DBConnection.connect();	 
		 resume oneResume = null;
		 try{
			 String sql = "select * from t_resume where rsmID =" + id + "";
			 stmt = conn.createStatement();
			 rs = stmt.executeQuery(sql);
			 if(rs.next()){
				 oneResume = new resume();
				 oneResume.setRsmID(rs.getInt("rsmID"));
				 oneResume.setStaffID(rs.getInt("staffID"));
				 oneResume.setRsmCont(rs.getString("rsmCont"));
				 oneResume.setStartTime(rs.getDate("startTime"));
				 oneResume.setEndTime(rs.getDate("endTime"));
				 oneResume.setResult(rs.getString("result"));
				 return oneResume;
			 }
			 return oneResume;
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
	  * 添加一条履历
	  * @param oneResume
	  * @throws SQLException
	  */
	 public void newResume(resume oneResume){
		 conn = DBConnection.connect();	 
		 try{
			 String sql = "insert into t_resume values(?,?,?,?,?,?)";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, oneResume.getRsmID());
			 pstmt.setInt(2, oneResume.getStaffID());
			 pstmt.setString(3, oneResume.getRsmCont());
			 pstmt.setDate(4, (Date) oneResume.getStartTime());
			 pstmt.setDate(5, (Date) oneResume.getEndTime());
			 pstmt.setString(6, oneResume.getResult());
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
	  * @删除一条履历
	  */
	 public void delete(int id){
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "delete from t_resume where rsmID = " + id + "";
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
	  * 修改一条履历
	  * @param oneResume
	  * @throws SQLException
	  */
	 public void editResume(resume oneResume){
		 conn = DBConnection.connect();	 
		 try{
			 String sql = "update t_resume set rsmCont = ?, startTime = ?," 
			 		    + "endTime = ?, result = ? where rsmID = ?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, oneResume.getRsmCont());
			 pstmt.setDate(2, (Date) oneResume.getStartTime());
			 pstmt.setDate(3, (Date) oneResume.getEndTime());
			 pstmt.setString(4, oneResume.getResult());
			 pstmt.setInt(5, oneResume.getRsmID());
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
	  * 某个员工的所有履历
	  * @param staffID
	  * @return
	  * @throws SQLException
	  */
	 public ArrayList<resume> findAll(int staffID){
		 ArrayList<resume> resumeList = new ArrayList<resume>();
		 resume oneResume = null;
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "select * from t_resume where staffID = " + staffID + "";
 			 rs = stmt.executeQuery(sql);
 			 while(rs.next()){
 				 oneResume = new resume();
 				 oneResume.setRsmID(rs.getInt("rsmID"));
 				 oneResume.setStaffID(rs.getInt("staffID"));
 				 oneResume.setRsmCont(rs.getString("rsmCont"));
 				 oneResume.setStartTime(rs.getDate("startTime"));
 				 oneResume.setEndTime(rs.getDate("endTime"));
 				 oneResume.setResult(rs.getString("result"));
 				 resumeList.add(oneResume);
 			 }
 			 return resumeList;
 		 }catch (SQLException e) {
				e.printStackTrace();
				return null;
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
