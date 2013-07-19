package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.deploy;
import model.staff;
import util.PageModel;
import dao.deployDao;
import dao.deptDao;
import dao.staffDao;

public class DeployAction implements Action {
	
	deployDao dplDao = new deployDao();
	staffDao stfDao = new staffDao();
	PageModel pageModel = new PageModel();

	@SuppressWarnings("deprecation")
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		response.setContentType("text/html; charset=GBK");
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		String command = request.getParameter("command");
		
		if(command!=null&&"show".equals(command)){
			int pageNo = Integer.parseInt(request.getParameter("pageNo"));
			int pageSize = Integer.parseInt(request.getParameter("pageSize"));
			request.setAttribute("pageNo", pageNo);
		    request.setAttribute("pageSize", pageSize);
		    request.getRequestDispatcher("home/deployQuery.jsp").forward(request, response);
		}
		
		if(command!=null&&"searchByNum".equals(command)){
			int pageNo = Integer.parseInt(request.getParameter("pageNo"));
			int pageSize = Integer.parseInt(request.getParameter("pageSize"));
			String staffNum = request.getParameter("staffNum");
		    String startDate = null;
		    String endDate = null;
		    
		    if(request.getParameter("startDate".toString()) !=""){
					startDate = request.getParameter("startDate".toString());
			    }
		    if(request.getParameter("endDate".toString()) !=""){
					endDate = request.getParameter("endDate".toString());
			    }
		    int type = 0;
		    if(request.getParameter("type")!=null)
		    {
		    	type = Integer.parseInt(request.getParameter("type"));
		    }
		    String deplType = null;
		    switch(type){
		       case 0: deplType = "";break;
		       case 1: deplType = "新进（聘任）";break;
		       case 2: deplType = "平级调动";break;
		       case 3: deplType = "降职";break;
		       case 4: deplType = "升职";break;
		       case 5: deplType = "离退";
		    }
		    pageModel = dplDao.findByNum(pageNo, pageSize, staffNum, startDate, endDate, deplType);
		    int totalNum = dplDao.getTotalRecordsByNum(staffNum, startDate, endDate, deplType);
		    request.setAttribute("pageNo", pageNo);
		    request.setAttribute("pageSize", pageSize);
		    request.setAttribute("staffNum", staffNum);
		    request.setAttribute("startDate", startDate);
		    request.setAttribute("endDate", endDate);
		    request.setAttribute("type", type);
		    request.setAttribute("pageModel", pageModel);
		    request.setAttribute("flag", "searchByNum");
		    request.setAttribute("totalNum", totalNum);
			request.getRequestDispatcher("home/deployQuery.jsp").forward(request, response);
		}
		
		if(command!=null&&"searchByOther".equals(command)){
			int pageNo = Integer.parseInt(request.getParameter("pageNo"));
			int pageSize = Integer.parseInt(request.getParameter("pageSize"));
			String staffName = request.getParameter("staffName"); 
		    String position = request.getParameter("position");
		    //DateFormat format = new SimpleDateFormat("yyyy-MM-dd");        
		    //Date startDate = (Date)request.getAttribute("startDate");
		    //Date endDate = (Date)request.getAttribute("endDate");
		    //System.out.println(startDate);
		    String startDate = null;
		    String endDate = null;
		    
		    if(request.getParameter("startDate".toString()) !=null){
		    	//System.out.println(request.getParameter("startDate".toString()));
					startDate = request.getParameter("startDate".toString());
			    }
		    if(request.getParameter("endDate".toString()) !=null){
					endDate = request.getParameter("endDate".toString());
			    }
		    int type = 0;
		    if(request.getParameter("type")!=null)
		    {
		    	type = Integer.parseInt(request.getParameter("type"));
		    }
		    String deplType = null;
		    switch(type){
		       case 0: deplType = "";break;
		       case 1: deplType = "新进（聘任）";break;
		       case 2: deplType = "平级调动";break;
		       case 3: deplType = "降职";break;
		       case 4: deplType = "升职";break;
		       case 5: deplType = "离退";
		    }
		    pageModel = dplDao.findByOther(pageNo, pageSize, staffName, position, startDate, endDate, deplType);
		    int totalNum = dplDao.getTotalRecordsByOther(staffName, position, startDate, endDate, deplType);
		    request.setAttribute("pageNo", pageNo);
		    request.setAttribute("pageSize", pageSize);
		    request.setAttribute("staffName", staffName);
		    request.setAttribute("position", position);
		    request.setAttribute("startDate", startDate);
		    request.setAttribute("endDate", endDate);
		    request.setAttribute("type", type);
		    request.setAttribute("pageModel", pageModel);
		    request.setAttribute("flag", "searchByOther");
		    request.setAttribute("totalNum", totalNum);
			request.getRequestDispatcher("home/deployQuery.jsp").forward(request, response);
		}
		
		/*if(command!=null&&"PreviousPage".equals(command)){
			pageModel = (PageModel)request.getAttribute("pageModel");
			
		}*/
			
		if(command!=null&&"delete".equals(command)){
			String deplIDs[] = request.getParameterValues("deplid");
			for(int k = 0; k < deplIDs.length; k++){
			    dplDao.delete(Integer.parseInt(deplIDs[k]));
			}
			response.sendRedirect("/HRM/home/deployQuery.jsp");
		}
		
		if(command!=null&&"retrieve".equals(command)){
			response.setContentType("text/xml; charset=utf-8");
			String staffNum = request.getParameter("staffNum");
			staff oneStaff = null;
			deptDao dptDao = new deptDao();
			staffDao stfDao = new staffDao();

			oneStaff = stfDao.findByNum(staffNum);

			if(oneStaff!=null){
				out.print("<response>");
				out.print("<option>" + "a" + "</option>");
				out.print("<staffName>" + oneStaff.getStaffName() + "</staffName>");
				out.print("<oldDept>" + dptDao.findByID(oneStaff.getDeptID()).getDeptName() + "</oldDept>");
				out.print("<oldPos>" + oneStaff.getPosition() + "</oldPos>");
				out.print("</response>");
				out.close();
				//System.out.println(oneStaff.getStaffName()+dptDao.findByID(oneStaff.getDeptID()).getDeptName()+oneStaff.getPosition());
			} else{
				out.print("<response>");
				out.print("<option>" + "a" + "</option>");
				out.print("<staffName>" + "@" + "</staffName>");
				out.print("<oldDept>" + "@" + "</oldDept>");
				out.print("<oldPos>" + "@" + "</oldPos>");
				out.print("</response>");
				out.close();
			}
			//request.getRequestDispatcher("seperate.jsp").forward(request, response);
		}
		
		/*if(command!=null&&"deptVerify".equals(command)){
			response.setContentType("text/xml; charset=utf-8");
			String deptName = request.getParameter("deptName");
			deptDao dptDao = new deptDao();
			int deptID = dptDao.IDByName(deptName);
			department dpt = dptDao.findByID(deptID);
			if(dpt==null&&request.getParameter("deptName")!=null){
				out.print("<response>");
				out.print("<optio>" + "a" + "</optio>");
				out.print("<option>" + "b" + "</option>");
				out.print("<verify>" + "illegal" + "</verify>");
				out.print("</response>");
				out.close();
			}
		}*/
		
		if(command!=null&&"newDepl".equals(command)){
			deptDao dptDao = new deptDao();
			int deplID = dplDao.nextID();
			String staffNum = request.getParameter("staffNum");
			int staffID = stfDao.findByNum(staffNum).getStaffID();
			String deplBefore = dptDao.findByID(stfDao.findByNum(staffNum).getDeptID()).getDeptName() + stfDao.findByNum(staffNum).getPosition();
			String deplAfter = request.getParameter("newDept") + request.getParameter("newPos");
			SimpleDateFormat   sDateFormat   =   new   SimpleDateFormat("yyyy-MM-dd"); 
			String deplTime = sDateFormat.format(new java.util.Date());
			
			int type = 0;
		    if(request.getParameter("type")!=null)
		    {
		    	type = Integer.parseInt(request.getParameter("type"));
		    }
		    String deplType = null;
		    switch(type){
		       case 0: deplType = "";break;
		       case 1: deplType = "平级调动";break;
		       case 2: deplType = "降职";break;
		       case 3: deplType = "升职";break;
		    }
		    deploy oneDepl = new deploy();
		    oneDepl.setDeplID(deplID);
		    oneDepl.setStaffID(staffID);
		    oneDepl.setDeplTime(Date.valueOf(deplTime));
		    oneDepl.setDeplBefore(deplBefore);
		    oneDepl.setDeplAfter(deplAfter);
		    oneDepl.setDeplType(deplType);
		    dplDao.newDepl(oneDepl);
		    stfDao.deploy(staffID, stfDao.findByNum(staffNum).getDeptID(), request.getParameter("newPos"));
		    response.sendRedirect("home/deployQuery.jsp");
			
		}

	}

}
