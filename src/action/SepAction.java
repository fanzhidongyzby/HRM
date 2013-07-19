package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.seperation;
import model.staff;
import dao.sepDao;
import dao.staffDao;

public class SepAction implements Action {
	
	sepDao spDao = new sepDao();
	staffDao stfDao = new staffDao();

	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		response.setContentType("text/html; charset=utf-8");
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		String command = request.getParameter("command");
		
		if(command!=null&&"retrieve".equals(command)){
			response.setContentType("text/xml; charset=utf-8");
			String staffNum = request.getParameter("staffNum");
			staff oneStaff = null;

			oneStaff = stfDao.findByNum(staffNum);

			if(oneStaff!=null){
				out.print("<response>");
				out.print("<staffName>" + oneStaff.getStaffName() + "</staffName>");
				out.print("<position>" + oneStaff.getPosition() + "</position>");
				out.print("</response>");
				out.close();
			} else{
				out.print("<response>");
				out.print("<staffName>" + "@" + "</staffName>");
				out.print("<position>" + "@" + "</position>");
				out.print("</response>");
				out.close();
			}
			//request.getRequestDispatcher("seperate.jsp").forward(request, response);
		}
		
		if(command!=null&&"newSep".equals(command)){
			String staffNum = request.getParameter("staffNum");
			String sepDate = request.getParameter("sepDate");
			int sepType = 0;
			String type = null;
			sepType = Integer.parseInt(request.getParameter("sepType"));
			switch(sepType){
			case 0: break;
			case 1: type = "退休"; break;
			case 2: type = "辞职"; break;
			case 3: type = "解雇"; break;
			case 4: type = "意外"; break;
			}
			String sepReason = request.getParameter("sepReason");
			seperation oneSep = new seperation();
			oneSep.setStaffID(stfDao.findByNum(staffNum).getStaffID());
			oneSep.setSepTime(Date.valueOf(sepDate));
			oneSep.setSepType(type);
			oneSep.setSepReason(sepReason);
			spDao.newSep(oneSep);
			stfDao.deploy(stfDao.findByNum(staffNum).getStaffID(), 0, "");
			response.sendRedirect("/HRM/home/sepDoc.jsp");
		}
	}

}
