package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//import java.util.Date;

import model.deploy;
import util.DBConnection;
import util.PageModel;

public class deployDao {

	 private Connection conn;
	 private Statement stmt;
	 private PreparedStatement pstmt;
	 private ResultSet rs;
	 
	 /**
	 *
	 * @找到下个ID，方便添加新调动项
	 */
	 public int nextID(){
		 conn = DBConnection.connect();	 
		 int currentId = -1;
	    	try {	    	
	    		stmt = conn.createStatement();
	    		String sql = "select max(deplID) from t_deploy";
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
	  * 添加一次调动项
	  * @param oneDepl
	  * @throws SQLException
	  */
	 public void newDepl(deploy oneDepl){
		 conn = DBConnection.connect();	 
		 try{
			 String sql = "insert into t_deploy values(?,?,?,?,?,?)";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, oneDepl.getDeplID());
			 pstmt.setInt(2, oneDepl.getStaffID());
			 pstmt.setDate(3, (Date)oneDepl.getDeplTime());
			 pstmt.setString(4, oneDepl.getDeplBefore());
			 pstmt.setString(5, oneDepl.getDeplAfter());
			 pstmt.setString(6, oneDepl.getDeplType());
			 pstmt.executeQuery();
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
	  * @删除一个调动项
	  */
	 public void delete(int id){
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "delete from t_deploy where deplID = " + id + "";
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
	 
	 public deploy findByID(int deplID){
		 deploy oneDeploy = null;
		 conn = DBConnection.connect();	 
 		 try{
 			 stmt = conn.createStatement();
 			 String sql = "select * from t_deploy where deplID = " + deplID + "";
 			 rs = stmt.executeQuery(sql);
 			if(rs.next()){
				 oneDeploy = new deploy();
				 oneDeploy.setDeplID(rs.getInt("deplID"));
				 oneDeploy.setStaffID(rs.getInt("staffID"));
				 oneDeploy.setDeplTime(rs.getDate("deplTime"));
				 oneDeploy.setDeplBefore(rs.getString("deplBefore"));
				 oneDeploy.setDeplAfter(rs.getString("deplAfter"));
				 oneDeploy.setDeplType(rs.getString("deplType"));
				 return oneDeploy;
 			}
 			return oneDeploy;
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
	  * 按员工(ID)编号查找变动项
	  * @param staffNum
	  * @return
	  * @throws SQLException
	  */
	 public PageModel findByNum(int pageNo, int pageSize, String staffNum, String startDate, String endDate, String deplType){
		 ArrayList<deploy> deplList = new ArrayList<deploy>();
		 deploy oneDeploy = null;
		 conn = DBConnection.connect();	
		 String sql = "select * from t_deploy where staffID in " 
	 		    + "(select staffID from t_staff where staffNum = '" + staffNum + "') and " ;
		    if(startDate != null){
				 sql = sql + "deplTime >= to_date('" + startDate + "', 'yyyy-mm-dd') and ";
			 }
			 if(endDate != null){
				 sql = sql + "deplTime <= to_date('" + endDate + "', 'yyyy-mm-dd') and ";
			 }
			 if(deplType != ""){
				 sql = sql + "deplType = '" + deplType + "' and "; 
			 }    
			 sql = sql + "1=1";
			 //System.out.println(sql);
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
 			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setInt(1, pageNo * pageSize);
			pstmt.setInt(2, (pageNo -1)*pageSize);
			rs = pstmt.executeQuery();
 			 while(rs.next()){
 				 oneDeploy = new deploy();
 				 oneDeploy.setDeplID(rs.getInt("deplID"));
 				 oneDeploy.setStaffID(rs.getInt("staffID"));
 				 oneDeploy.setDeplTime(rs.getDate("deplTime"));
 				 oneDeploy.setDeplBefore(rs.getString("deplBefore"));
 				 oneDeploy.setDeplAfter(rs.getString("deplAfter"));
 				 oneDeploy.setDeplType(rs.getString("deplType"));
 				deplList.add(oneDeploy);
			 }
			 pageModel = new PageModel();
				pageModel.setPageSize(pageSize);
				pageModel.setPageNo(pageNo);
				pageModel.setList(deplList);
				pageModel.setTotalRecords(getTotalRecordsByNum(staffNum, startDate, endDate, deplType));
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
	 
	 public int getTotalRecordsByNum(String staffNum, String startDate, String endDate, String deplType) 
		{
		    String sql = "select count(*) from t_deploy where staffID in " 
	 		    + "(select staffID from t_staff where staffNum = '" + staffNum + "') and " ;
		    if(startDate != null){
				 sql = sql + "deplTime >= to_date('" + startDate + "', 'yyyy-mm-dd') and ";
			 }
			 if(endDate != null){
				 sql = sql + "deplTime <= to_date('" + endDate + "', 'yyyy-mm-dd') and ";
			 }
			 if(deplType != ""){
				 sql = sql + "deplType = '" + deplType + "' and "; 
			 }    
			 sql = sql + "1=1";
			 
			int totalRecords = 0;
			try {
				conn = DBConnection.connect();
				try {
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql);
					rs.next();
					totalRecords = rs.getInt(1);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
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
	  * 全局查询
	  */
	 public PageModel findByOther(int pageNo, int pageSize,String staffName, String position, String startTime, String endTime, String deplType){
		 ArrayList<deploy> deplList = new ArrayList<deploy>();
		 deploy oneDeploy = null;
		 conn = DBConnection.connect();	 
		 String sql = "select * from t_deploy where staffID in (select staffID from t_staff where ";
			 if(staffName != ""){
			 sql = sql + "staffName = '" + staffName + "' and ";
		 }
		 if(position != ""){
			 sql = sql + "position = '" + position + "' and ";
		 }
		 sql = sql + "1=1) and ";
		 if(startTime != null){
			 sql = sql + "deplTime >= to_date('" + startTime + "', 'yyyy-mm-dd') and ";
		 }
		 if(endTime != null){
			 sql = sql + "deplTime <= to_date('" + endTime + "', 'yyyy-mm-dd') and ";
		 }
		 if(deplType != ""){
			 sql = sql + "deplType = '" + deplType + "' and "; 
		 }
		 sql = sql + "1=1";
		// System.out.println(startTime+"dao");
		// System.out.println(sql);
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
 			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setInt(1, pageNo * pageSize);
			pstmt.setInt(2, (pageNo -1)*pageSize);
			rs = pstmt.executeQuery();
 		
			 //System.out.println(sql);
			 
			 while(rs.next()){
				 oneDeploy = new deploy();
				 oneDeploy.setDeplID(rs.getInt("deplID"));
				 oneDeploy.setStaffID(rs.getInt("staffID"));
				 oneDeploy.setDeplTime(rs.getDate("deplTime"));
				 oneDeploy.setDeplBefore(rs.getString("deplBefore"));
				 oneDeploy.setDeplAfter(rs.getString("deplAfter"));
				 oneDeploy.setDeplType(rs.getString("deplType"));
				 deplList.add(oneDeploy);
			 }
			 pageModel = new PageModel();
				pageModel.setPageSize(pageSize);
				pageModel.setPageNo(pageNo);
				pageModel.setList(deplList);
				pageModel.setTotalRecords(getTotalRecordsByOther(staffName, position, startTime, endTime, deplType) );
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
	 
	 public int getTotalRecordsByOther(String staffName, String position, String startTime, String endTime, String deplType) 
		{
		 String sql = "select count(*) from t_deploy where staffID in (select staffID from t_staff where ";
		 if(staffName != ""){
		 sql = sql + "staffName = '" + staffName + "' and ";
	 }
	 if(position != ""){
		 sql = sql + "position = '" + position + "' and ";
	 }
	 sql = sql + "1=1) and ";
	 if(startTime != null){
		 sql = sql + "deplTime >= to_date('" + startTime + "', 'yyyy-mm-dd') and ";
	 }
	 if(endTime != null){
		 sql = sql + "deplTime <= to_date('" + endTime + "', 'yyyy-mm-dd') and ";
	 }
	 if(deplType != ""){
		 sql = sql + "deplType = '" + deplType + "' and "; 
	 }
	 sql = sql + "1=1";
			int totalRecords = 0;
			try {
				conn = DBConnection.connect();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				rs.next();
				totalRecords = rs.getInt(1);
			}catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
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
			return totalRecords;
		}
	 
	 /**
	  * 最新十次变动
	  */
	 public PageModel findRct(int pageNo, int pageSize){
		 
		 int i = 1;
		 ArrayList<deploy> deplList = new ArrayList<deploy>();
		 deploy oneDeploy = null;
		 conn = DBConnection.connect();	 
		 StringBuffer sbSql = new StringBuffer();
			sbSql.append("select * from ")
				.append("(")
					.append("select rownum rn, t.* from ")
					.append("(")
						.append("select * from t_deploy where rownum<=10 order by deplID desc")
						.append(") t where rownum <=?")
				.append(") where rn>?");
			
			PageModel pageModel = null;
 		 try{
 			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setInt(1, pageNo * pageSize);
			pstmt.setInt(2, (pageNo -1)*pageSize);
			rs = pstmt.executeQuery();
			
 			 while(rs.next()){
 				 oneDeploy = new deploy();
 				 oneDeploy.setDeplID(rs.getInt("deplID"));
 				 oneDeploy.setStaffID(rs.getInt("staffID"));
 				 oneDeploy.setDeplTime(rs.getDate("deplTime"));
 				 oneDeploy.setDeplBefore(rs.getString("deplBefore"));
 				 oneDeploy.setDeplAfter(rs.getString("deplAfter"));
 				 oneDeploy.setDeplType(rs.getString("deplType"));
 				 deplList.add(oneDeploy);
 			 }
 			pageModel = new PageModel();
			pageModel.setPageSize(pageSize);
			pageModel.setPageNo(pageNo);
			pageModel.setList(deplList);
			pageModel.setTotalRecords(getTotalRecordsRct());
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
	 
	 public int getTotalRecordsRct() 
		throws SQLException {
		    String sql = "select count(*) from t_deploy where rownum<=10 order by deplID desc";
			int totalRecords = 0;
			try {
				conn = DBConnection.connect();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				rs.next();
				totalRecords = rs.getInt(1);
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
