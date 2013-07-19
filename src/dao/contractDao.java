package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.contract;
import util.DBConnection;

public class contractDao {
	
	private Connection conn;
	 private Statement stmt;
	 private PreparedStatement pstmt;
	 private ResultSet rs;
	 
	 /**
	 *
	 * @找到下个ID，方便添加新合同项
	 */
	 public int nextID(){
		 conn = DBConnection.connect();	 
		 int currentId = -1;
	    	try {	    	
	    		stmt = conn.createStatement();
	    		String sql = "select max(conID) from t_contract";
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
	  * 添加一个合同项
	  * @param oneContract
	  * @throws SQLException
	  */
	 public void newContract(contract oneContract){
		 conn = DBConnection.connect();
		 try{
			 String sql = "insert into t_contract values(?,?,?,?,?,?,?,?)";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, oneContract.getConID());
			 pstmt.setInt(2, oneContract.getStaffID());
			 pstmt.setString(3, oneContract.getConNum());
			 pstmt.setDate(4, (Date) oneContract.getStartDate());
			 pstmt.setDate(5, (Date) oneContract.getEndDate());
			 pstmt.setString(6, oneContract.getStfPos());
			 pstmt.setString(7, oneContract.getConCont());
			 pstmt.setString(8, oneContract.getConCom());
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
	  * 编辑一条合同
	  * @param oneContract
	  * @throws SQLException
	  */
	 public void edit(contract oneContract){
		 conn = DBConnection.connect();
		 try{
			 String sql = "update t_contract set startDate = ?, endDate = ?, stfPos = ?," 
			 		    + "conCont = ?, conCom = ? where conID = ?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setDate(1, (Date)oneContract.getStartDate());
			 pstmt.setDate(2, (Date)oneContract.getEndDate());
			 pstmt.setString(3, oneContract.getStfPos());
			 pstmt.setString(4, oneContract.getConCont());
			 pstmt.setString(5, oneContract.getConCom());
			 pstmt.setInt(6, oneContract.getConID());
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
	  * @删除一条合同
	  */
	 public void delete(int id){
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "delete from t_contract where conID = " + id + "";
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
	 
	 public contract findByID(int conID){
		 contract oneContract = null;
		 conn = DBConnection.connect();
		 try{
			 stmt = conn.createStatement();
			 String sql = "select * from t_contract where conID = " + conID + "";
			 rs = stmt.executeQuery(sql);
			 if(rs.next()){
				 oneContract = new contract();
				 oneContract.setConID(conID);
				 oneContract.setStaffID(rs.getInt("staffID"));
				 oneContract.setConNum(rs.getString("conNum"));
				 oneContract.setStartDate(rs.getDate("startDate"));
				 oneContract.setEndDate(rs.getDate("endDate"));
				 oneContract.setStfPos(rs.getString("stfPos"));
				 oneContract.setConCont(rs.getString("conCont"));
				 oneContract.setConCom(rs.getString("conCom"));
				 return oneContract;
			 }
			 return oneContract;
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
	  * 返回某员工的所有合同项
	  * @param staffID
	  */
	 public ArrayList<contract> findAll(int staffID){
		 ArrayList<contract> conList = new ArrayList<contract>();
		 contract oneContract = null;
		 conn = DBConnection.connect();
		 try{
			 stmt = conn.createStatement();
			 String sql = "select * from t_contract where staffID = " + staffID + "";
			 rs = stmt.executeQuery(sql);
			 while(rs.next()){
				 oneContract = new contract();
				 oneContract.setConID(rs.getInt("conID"));
				 oneContract.setStaffID(rs.getInt("staffID"));
				 oneContract.setConNum(rs.getString("conNum"));
				 oneContract.setStartDate(rs.getDate("startDate"));
				 oneContract.setEndDate(rs.getDate("endDate"));
				 oneContract.setStfPos(rs.getString("stfPos"));
				 oneContract.setConCont(rs.getString("conCont"));
				 oneContract.setConCom(rs.getString("conCom"));
				 conList.add(oneContract);
			 }
			 return conList;
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

}
