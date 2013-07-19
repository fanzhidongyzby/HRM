package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.resume;
import dao.resumeDao;

public class ResumeAction implements Action {

	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<body background='home/images/bg.png'>");
		String opp="";
		String args="";
		
		if(request.getParameter("opp")!=null)
			opp=request.getParameter("opp");
		if(request.getParameter("args")!=null)
			args=request.getParameter("args");
		System.out.print("args="+args);
		int rsmId=0;
		int staffId=0;
		String start="";
		String end="";
		String cont="";
		String rslt="";
		
		if(request.getParameter("rsmId")!=null)
			rsmId=Integer.parseInt(request.getParameter("rsmId"));
		if(request.getParameter("staffId")!=null)
			staffId=Integer.parseInt(request.getParameter("staffId"));
		if(request.getParameter("start")!=null)
			start=request.getParameter("start");
		if(request.getParameter("end")!=null)
			end=request.getParameter("end");
		if(request.getParameter("cont")!=null)
			cont=request.getParameter("cont");
		if(request.getParameter("rslt")!=null)
			rslt=request.getParameter("rslt");
		
		resumeDao rd=new resumeDao();
		resume rsm=null;
		if("delete".equals(opp))
		{
			StringTokenizer token =new StringTokenizer(args,"-");
			while(token.hasMoreTokens())
			{
				int rId=Integer.parseInt(token.nextToken());
				rd.delete(rId);
			}
			out.println("<script language='javascript'>" +
					"location.href='home/resume.jsp?staffId=" +staffId+
					"';</script>");
		}
		else if("add".equals(opp))
		{
			//验证
			String warning="";
			Date st=Date.valueOf(start);
			Date en=Date.valueOf(end);
			if(st.after(en))
				warning="开始时间应该在结束时间之前，请核对信息。";
			if(warning.equals(""))
			{
				rsm=new resume();
				rsm.setRsmID(rd.nextID());
				rsm.setStaffID(staffId);
				rsm.setStartTime(Date.valueOf(start));
				rsm.setEndTime(Date.valueOf(end));
				rsm.setRsmCont(cont);
				rsm.setResult(rslt);
				rd.newResume(rsm);
				warning="履历信息添加成功。";
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"location.href='home/resume.jsp?staffId=" +staffId+
						"';</script>");
			}
			else
			{
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"history.go(-1);</script>");
			}
		}
		else if("edit".equals(opp))
		{
			//验证
			String warning="";
			Date st=Date.valueOf(start);
			Date en=Date.valueOf(end);
			if(st.after(en))
				warning="开始时间应该在结束时间之前，请核对信息。";
			if(warning.equals(""))
			{
				rsm=rd.findByID(rsmId);
				rsm.setStartTime(Date.valueOf(start));
				rsm.setEndTime(Date.valueOf(end));
				rsm.setRsmCont(cont);
				rsm.setResult(rslt);
				rd.editResume(rsm);
				warning="履历信息更新成功。";
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"location.href='home/resume.jsp?staffId=" +staffId+
						"';</script>");
			}
			else
			{
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"history.go(-1);</script>");
			}
		}
		out.print("</body>");
		out.close();
		
	}

}
