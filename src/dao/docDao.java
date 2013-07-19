package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.document;
import util.DBConnection;

public class docDao {
	
	private Connection conn;
	 private Statement stmt;
	 private PreparedStatement pstmt;
	 private ResultSet rs;
	 
	 /**
	 *
	 * @找到下个ID，方便添加新档案
	 */
	 public int nextID(){
		 conn = DBConnection.connect();	 
		 int currentId = -1;
	    	try {	 
	    		stmt = conn.createStatement();
	    		String sql = "select max(docID) from t_doc";
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
	  * 添加一条文档
	  * @param oneDoc
	  */
	 public void newDoc(document oneDoc){
		 conn = DBConnection.connect();	
		 try{
			 String sql = "insert into t_doc values(?,?,?,?,?,?,?)";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, oneDoc.getDocID());
			 pstmt.setInt(2, oneDoc.getStaffID());
			 pstmt.setString(3, oneDoc.getDocNum());
			 pstmt.setString(4, oneDoc.getDocName());
			 pstmt.setString(5, oneDoc.getDocAbs());
			 pstmt.setString(6, oneDoc.getDocCom());
			 pstmt.setString(7, oneDoc.getDocType());
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
	 
	 /*
	  * 按编号查找doc
	  */
	 public document findByID(int docID){
		 document oneDoc = null;
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "select * from t_doc where docID = " + docID + "";
 			 rs = stmt.executeQuery(sql);
 			 if(rs.next()){
 				 oneDoc = new document();
 				 oneDoc.setDocID(rs.getInt("docID"));
 				 oneDoc.setStaffID(rs.getInt("staffID"));
 				 oneDoc.setDocNum(rs.getString("docNum"));
 				 oneDoc.setDocName(rs.getString("docName"));
 				 oneDoc.setDocAbs(rs.getString("docAbs"));
 				 oneDoc.setDocCom(rs.getString("docCom"));
 				 oneDoc.setDocType(rs.getString("docType"));
 				 return oneDoc;
 			 }
 			 return oneDoc;
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
	 
	 /**
	  * 编辑一条档案
	  * @param oneDoc
	  */
	 public void edit(document oneDoc){
		 conn = DBConnection.connect();	
		 try{
			 String sql = "update t_doc set docName = ?, docAbs = ?, docCom = ?, docType = ?" 
			 		    + "where docNum = ?";
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1, oneDoc.getDocName());
			 pstmt.setString(2, oneDoc.getDocAbs());
			 pstmt.setString(3, oneDoc.getDocCom());
			 pstmt.setString(4, oneDoc.getDocType());
			 pstmt.setString(5, oneDoc.getDocNum());
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
	  * 删除一条档案
	  * @param docID
	  */
	 public void delete(int docID){
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "delete from t_doc where docID = " + docID + "";
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
	  * 某个员工的所有档案
	  * @param staffID
	  */
	 public ArrayList<document> findAll(int staffID){
		 ArrayList<document> docList = new ArrayList<document>();
		 document oneDoc = null;
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "select * from t_doc where staffID = " + staffID + "";
 			 rs = stmt.executeQuery(sql);
 			 while(rs.next()){
 				 oneDoc = new document();
 				 oneDoc.setDocID(rs.getInt("docID"));
 				 oneDoc.setStaffID(rs.getInt("staffID"));
 				 oneDoc.setDocNum(rs.getString("docNum"));
 				 oneDoc.setDocName(rs.getString("docName"));
 				 oneDoc.setDocAbs(rs.getString("docAbs"));
 				 oneDoc.setDocCom(rs.getString("docCom"));
 				 oneDoc.setDocType(rs.getString("docType"));
 				 docList.add(oneDoc);
 			 }
 			 return docList;
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
