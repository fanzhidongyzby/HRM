package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.contract;
import model.document;
import dao.contractDao;

public class ContractAction implements Action {

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
		
		int ctrId=0;
		int staffId=0;
		String ctrNum="";
		String ctrStartDate=null;
		String ctrEndDate=null;
		String pos="";
		String cont="";
		String com="";
		
		if(request.getParameter("ctrId")!=null)
			ctrId=Integer.parseInt(request.getParameter("ctrId"));
		if(request.getParameter("staffId")!=null)
			staffId=Integer.parseInt(request.getParameter("staffId"));
		if(request.getParameter("ctrNum")!=null)
			ctrNum=request.getParameter("ctrNum");
		if(request.getParameter("ctrStartDate")!=null)
			ctrStartDate=request.getParameter("ctrStartDate");
		if(request.getParameter("ctrEndDate")!=null)
			ctrEndDate=request.getParameter("ctrEndDate");
		if(request.getParameter("pos")!=null)
			pos=request.getParameter("pos");
		if(request.getParameter("cont")!=null)
			cont=request.getParameter("cont");
		if(request.getParameter("com")!=null)
			com=request.getParameter("com");
		
		contractDao cd=new contractDao();
		contract con=null;
		if("delete".equals(opp))
		{
			StringTokenizer token =new StringTokenizer(args,"-");
			while(token.hasMoreTokens())
			{
				int cId=Integer.parseInt(token.nextToken());
				cd.delete(cId);
			}
			out.println("<script language='javascript'>" +
					"location.href='home/contract.jsp?staffId=" +staffId+
					"';</script>");
		}
		else if("add".equals(opp))
		{
			//验证
			String warning="";
			
			Date st=Date.valueOf(ctrStartDate);
			Date en=Date.valueOf(ctrEndDate);
			if(st.after(en))
				warning="开始时间应该在结束时间之前，请核对信息。";
			
			if(warning.equals(""))
			{
				con=new contract();
				con.setConID(cd.nextID());
				con.setStaffID(staffId);
				con.setConNum(ctrNum);
				con.setStartDate(Date.valueOf(ctrStartDate));
				con.setEndDate(Date.valueOf(ctrEndDate));
				con.setStfPos(pos);
				con.setConCont(cont);
				con.setConCom(com);
				cd.newContract(con);
				warning="合同信息添加成功。";
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"location.href='home/contract.jsp?staffId=" +staffId+
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
			Date st=Date.valueOf(ctrStartDate);
			Date en=Date.valueOf(ctrEndDate);
			if(st.after(en))
				warning="开始时间应该在结束时间之前，请核对信息。";
			
			if(warning.equals(""))
			{
				con=cd.findByID(ctrId);
				con.setConNum(ctrNum);
				con.setStartDate(Date.valueOf(ctrStartDate));
				con.setEndDate(Date.valueOf(ctrEndDate));
				con.setStfPos(pos);
				con.setConCont(cont);
				con.setConCom(com);
				cd.edit(con);
				warning="合同信息更新成功。";
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"location.href='home/contract.jsp?staffId=" +staffId+
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
