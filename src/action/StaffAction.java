package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.department;
import model.deploy;
import model.staff;
import util.PageModel;
import dao.deployDao;
import dao.deptDao;
import dao.staffDao;

public class StaffAction implements Action {
	
	staffDao stfDao = new staffDao();
	deptDao dptDao = new deptDao();
	PageModel pageModel = new PageModel();

	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		response.setContentType("text/html; charset=GBK");
		
		HttpSession session = request.getSession();

		String command = request.getParameter("command");
		
		if(command!=null&&"show".equals(command)){
			int pageNo = Integer.parseInt(request.getParameter("pageNo"));
			int pageSize = Integer.parseInt(request.getParameter("pageSize"));
			request.setAttribute("pageNo", pageNo);
		    request.setAttribute("pageSize", pageSize);
		    request.getRequestDispatcher("home/index/YHChannelApply.jsp").forward(request, response);
		}
		
		if(command!=null&&"delete".equals(command)){
			String staffIDs[] = request.getParameterValues("staffid");
			for(int k = 0; k < staffIDs.length; k++){
			    stfDao.delete(Integer.parseInt(staffIDs[k]));
			}
			response.sendRedirect("/HRM/home/index/YHChannelApply.jsp");
		}
		
		if(command!=null&&"searchByNum".equals(command)){

			String staffNum = request.getParameter("staffNum");
			staff oneStaff = null;
			oneStaff = stfDao.findByNum(staffNum);
			request.setAttribute("oneStaff", oneStaff);
			request.setAttribute("flag", "searchByNum");
			request.getRequestDispatcher("home/index/YHChannelApply.jsp").forward(request, response);
		}
		
		if(command!=null&&"searchByOther".equals(command)){
			int pageNo = Integer.parseInt(request.getParameter("pageNo"));
			int pageSize = Integer.parseInt(request.getParameter("pageSize"));
			String staffName = request.getParameter("staffName");
			int sex = -1;
			if(request.getParameter("sex")!=null){
				sex = Integer.parseInt(request.getParameter("sex"));
			}
			int ageL = 0;
			int ageH = 0;
			int agePeriod = Integer.parseInt(request.getParameter("agePeriod"));
			switch(agePeriod){
			case 1: ageL = 16; ageH = 18; break;
			case 2: ageL = 18; ageH = 25; break;
			case 3: ageL = 26; ageH = 30; break;
			case 4: ageL = 31; ageH = 40; break;
			case 5: ageL = 41; ageH = 50; break;
			case 6: ageL = 51; ageH = 60; break;
			case 0: break;
			}
			String degr = null;
			int degree = Integer.parseInt(request.getParameter("degree"));
			switch(degree){
			case 0:
			case 1: degr = null; break;
			case 2: degr = "小"; break;
			case 3: degr = "专"; break;
			case 4: degr = "本"; break;
			case 5: degr = "硕"; break;
			case 6: degr = "博"; break;
			}
		    String position = request.getParameter("position"); 
		    String tech = request.getParameter("tech");
		    
		    pageModel = stfDao.findByOther(pageNo, pageSize, staffName, sex, ageL, ageH, degr, position, tech);
		    int totalNum = stfDao.getTotalRecordsSrch(staffName, sex, ageL, ageH, degr, position, tech);
		    request.setAttribute("pageNo", pageNo);
		    request.setAttribute("pageSize", pageSize);
		    request.setAttribute("staffName", staffName);
		    request.setAttribute("sex", sex);
            request.setAttribute("agePeriod", agePeriod);
            request.setAttribute("degree", degree);
            request.setAttribute("position", position);
            request.setAttribute("tech", tech);
		    request.setAttribute("pageModel", pageModel);
		    request.setAttribute("flag", "searchByOther");
		    request.setAttribute("totalNum", totalNum);
			request.getRequestDispatcher("home/index/YHChannelApply.jsp").forward(request, response);
		}
		
		if(command!=null&&"deptVerify".equals(command)){
			response.setContentType("text/xml; charset=utf-8");
			PrintWriter out = response.getWriter();
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
		}
		
		if(command!=null&&"editStaff".equals(command)){
			int staffID = Integer.parseInt(request.getParameter("staffID"));
			String staffNum = request.getParameter("staffNum");
			String staffName = request.getParameter("staffName");
			int sex = Integer.parseInt(request.getParameter("sex"));
			int age = Integer.parseInt(request.getParameter("age"));
			String deptName = request.getParameter("dept");
			int deptID = dptDao.IDByName(deptName);
			String position = request.getParameter("pos");
			String eduBack = request.getParameter("eduBk");
			String degree = request.getParameter("degree");
			String tech = request.getParameter("tech");
			int salary = Integer.parseInt(request.getParameter("salary"));
			String status = request.getParameter("status");
			int socSec = Integer.parseInt(request.getParameter("socSec"));
			
			deployDao dplDao = new deployDao();
			int deplID = dplDao.nextID();
			String deplBefore = dptDao.findByID(stfDao.findByID(staffID).getDeptID()).getDeptName()+stfDao.findByID(staffID).getPosition();
			String deplAfter = dptDao.findByID(deptID).getDeptName()+position;
			SimpleDateFormat   sDateFormat   =   new   SimpleDateFormat("yyyy-MM-dd"); 
			String deplTime = sDateFormat.format(new java.util.Date());
			deploy oneDepl = new deploy();
		    oneDepl.setDeplID(deplID);
		    oneDepl.setStaffID(staffID);
		    oneDepl.setDeplTime(Date.valueOf(deplTime));
		    oneDepl.setDeplBefore(deplBefore);
		    oneDepl.setDeplAfter(deplAfter);
		    oneDepl.setDeplType("普通调动");
		    dplDao.newDepl(oneDepl);
			
			staff oneStaff = new staff();
			oneStaff.setStaffID(staffID);
			oneStaff.setStaffNum(staffNum);
			oneStaff.setStaffName(staffName);
			oneStaff.setSex(sex);
			oneStaff.setAge(age);
			oneStaff.setDeptID(deptID);
			oneStaff.setPosition(position);
			oneStaff.setEduBack(eduBack);
			oneStaff.setDegree(degree);
			oneStaff.setTech(tech);
			oneStaff.setSalary(salary);
			oneStaff.setStatus(status);
			oneStaff.setSocSec(socSec);
			stfDao.edit(oneStaff);
			response.sendRedirect("home/staffDetail.jsp?staffId=" + staffID);
		}
		
		if(command!=null&&"newStaff".equals(command)){
			int staffID = stfDao.nextID();
			String staffNum = request.getParameter("staffNum");
			String staffName = request.getParameter("staffName");
			int sex = Integer.parseInt(request.getParameter("radiobutton"));
			int age = Integer.parseInt(request.getParameter("age"));
			String deptName = request.getParameter("dept");
			int deptID = dptDao.IDByName(deptName);
			String position = request.getParameter("pos");
			String eduBack = request.getParameter("eduBk");
			String degree = request.getParameter("degree");
			String tech = request.getParameter("tech");
			int salary = 0;
			if(request.getParameter("salary")!=""){
				salary = Integer.parseInt(request.getParameter("salary"));
			}
			String status = request.getParameter("status");
			int socSec = 0;
			if(request.getParameter("socSec")!=""){
				socSec = Integer.parseInt(request.getParameter("socSec"));
			}
			staff oneStaff = new staff();
			oneStaff.setStaffID(staffID);
			oneStaff.setStaffNum(staffNum);
			oneStaff.setStaffName(staffName);
			oneStaff.setSex(sex);
			oneStaff.setAge(age);
			oneStaff.setDeptID(deptID);
			oneStaff.setPosition(position);
			oneStaff.setEduBack(eduBack);
			oneStaff.setDegree(degree);
			oneStaff.setTech(tech);
			oneStaff.setSalary(salary);
			oneStaff.setStatus(status);
			oneStaff.setSocSec(socSec);
			stfDao.newStaff(oneStaff);
		    
			response.sendRedirect("home/staffDetail.jsp?staffId=" + staffID);
		}

	}

}
