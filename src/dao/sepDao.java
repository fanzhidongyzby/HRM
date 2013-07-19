package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import model.seperation;
import util.DBConnection;
import util.PageModel;

public class sepDao {

	 private Connection conn;
	 private Statement stmt;
	 private PreparedStatement pstmt;
	 private ResultSet rs;
	 
	 /**
	  * 添加离职人员
	  * @param oneSep
	  */
	 public void newSep(seperation oneSep){
		 conn = DBConnection.connect();	
		 try{
			 String sql = "insert into t_seperation values(?,?,?,?)";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, oneSep.getStaffID());
			 pstmt.setString(2, oneSep.getSepType());
			 pstmt.setString(3, oneSep.getSepReason());
			 pstmt.setDate(4, (Date)oneSep.getSepTime());
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
	  * 返回所有离职人员信息
	  * @return
	  */
	 public PageModel findAll(int pageNo, int pageSize){
		 ArrayList<seperation> sepList = new ArrayList<seperation>();
		 seperation oneSep = null;
		 conn = DBConnection.connect();
		 StringBuffer sbSql = new StringBuffer();
			sbSql.append("select * from ")
				.append("(")
					.append("select rownum rn, t.* from ")
					.append("(")
						.append("select * from t_seperation")
						.append(") t where rownum <=?")
				.append(") where rn>?");
			
			PageModel pageModel = null;
 		 try{
 			 pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setInt(1, pageNo * pageSize);
				pstmt.setInt(2, (pageNo -1)*pageSize);
				rs = pstmt.executeQuery();
 			 while(rs.next()){
 				 oneSep = new seperation();
 				 oneSep.setStaffID(rs.getInt("staffID"));
 				 oneSep.setSepType(rs.getString("sepType"));
 				 oneSep.setSepReason(rs.getString("sepReason"));
 				 oneSep.setSepTime(rs.getDate("sepTime"));
 				 sepList.add(oneSep);
 			 }
 			pageModel = new PageModel();
			pageModel.setPageSize(pageSize);
			pageModel.setPageNo(pageNo);
			pageModel.setList(sepList);
			pageModel.setTotalRecords(getTotalRecords());
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
	 
	 public int getTotalRecords() {
		    String sql = "select count(*) from t_seperation";
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
	 
	 public String countType(){
		 ArrayList<String> sqlList = new ArrayList<String>();
		 String sql1 = "select count(*) from t_seperation where sepType = '退休'";
		 String sql2 = "select count(*) from t_seperation where sepType = '辞职'";
		 String sql3 = "select count(*) from t_seperation where sepType = '解雇'";
		 String sql4 = "select count(*) from t_seperation where sepType = '意外'";
		 sqlList.add(sql1);sqlList.add(sql2);sqlList.add(sql3);sqlList.add(sql4);
		 String ratio = "";
			int recordsNum = 0;
			try {
				conn = DBConnection.connect();
				stmt = conn.createStatement();
				Iterator<String> it = sqlList.iterator();
				while(it.hasNext()) {
					rs = stmt.executeQuery((String)it.next());
					rs.next();
					recordsNum = rs.getInt(1);
					ratio += recordsNum + "-";
				}
               // System.out.println(ratio);
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
			return ratio;
	 }
	
}
