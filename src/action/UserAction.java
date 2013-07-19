package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.staff;
import model.user;
import dao.deptDao;
import dao.staffDao;
import dao.userDao;

public class UserAction implements Action {

	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String opp="";
		String args="";		
		String userName="";
		String passWord="";
		String staffNum="";
		String role="";
		String deptIds="";
		
		if(request.getParameter("opp")!=null)
			opp=request.getParameter("opp");
		if(request.getParameter("args")!=null)
			args=request.getParameter("args");
		
		if(request.getParameter("userName")!=null)
			userName=request.getParameter("userName");		
		if(request.getParameter("passWord")!=null)
			passWord=request.getParameter("passWord");		
		if(request.getParameter("staffNum")!=null)
			staffNum=request.getParameter("staffNum");		
		if(request.getParameter("role")!=null)
			role=request.getParameter("role");		
		if(request.getParameter("deptIds")!=null)
			deptIds=request.getParameter("deptIds");
		
		/*System.out.println("userName="+userName);
		System.out.println("passWord="+passWord);
		System.out.println("staffNum="+staffNum);
		System.out.println("role="+role);
		System.out.println("deptIds="+deptIds);*/
		
		//////执行Action
		userDao ud=new userDao();
		if(opp.equals("delete"))//删除
		{
			String feedBack="已经将用户";
			StringTokenizer token=new StringTokenizer(args,"-");
			while(token.hasMoreTokens())
			{
				String t=token.nextToken();
				feedBack+=" "+t;
				ud.delete(t);
			}
			feedBack+=" 删除成功。";
			out.println("<script language='javascript'>" +
					"alert('"+feedBack+"');" +
					"location.href='home/user.jsp';</script>");
			//response.sendRedirect("user.jsp");
		}
		else if(opp.equals("valid"))//验证
		{
			String type="";
			if(request.getParameter("type")!=null)
				type=request.getParameter("type");
			String warning="";
			//System.out.println("type="+type+"  content="+args);
			if(type.equals("num"))//编号验证
			{
				staffDao sd=new staffDao();
				staff s=sd.findByNum(args);
				if(s==null)
				{
					warning="staff-unExit";
				}
				else
				{
					warning="staff-ok";
				}		
			}
			else if(type.equals("dept"))//部门验证
			{
				deptDao dd=new deptDao();
				int deptId=dd.IDByName(args);
				if(deptId==0)
				{
					warning="dept-unExit";
				}
				else
				{
					warning="dept-ok";
				}
			}
			out.print(warning);//千万不要换行！！！
		}
		else
		{			
			if(opp.equals("add"))//添加
			{
				/*String userName="";
		String passWord="";
		String staffNum="";
		String role="";
		String deptIds="";*/
				String warning="";				
				if(userName.equals(""))
				{
					warning="用户名不能为空。";
				}
				else if(ud.findByName(userName)!=null)
				{
					warning="用户名已经存在。";
				}
				else if(passWord.equals(""))
				{
					warning="密码不能为空。";
				}
				else
				{
					try
					{
						Integer.parseInt(staffNum);
					}
					catch(Exception e)
					{
						warning="请绑定有效的员工编号。";
					}
				}
				if(warning.equals(""))
				{
					StringTokenizer token=new StringTokenizer(deptIds,"<>");
					String ids="";
					deptDao dd=new deptDao();
					staffDao sd=new staffDao();
					while(token.hasMoreTokens())
					{
						ids+="-"+dd.IDByName(token.nextToken())+"-";
					}				
					user oneUser=new user();
					oneUser.setDeptIDs(ids);
					oneUser.setPassword(passWord);
					oneUser.setStaffID(sd.findByNum(staffNum).getStaffID());
					oneUser.setUserName(userName);
					oneUser.setUserRole(Integer.parseInt(role));
					try {
						ud.newUser(oneUser);
						warning="新用户添加成功。";
						out.println("<script language='javascript'>" +
								"alert('"+warning+"');" +
								"location.href='home/user.jsp';</script>");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				else
				{
					out.println("<script language='javascript'>" +
							"alert('"+warning+"');" +
							"history.go(-1);</script>");
				}
				
				
			}
			else if(opp.equals("edit"))//编辑
			{
				String warning="";				
				if(passWord.equals(""))
				{
					warning="密码不能为空。";
				}
				if(warning.equals(""))
				{
					StringTokenizer token=new StringTokenizer(deptIds,"<>");
					String ids="";
					deptDao dd=new deptDao();
					staffDao sd=new staffDao();
					while(token.hasMoreTokens())
					{
						ids+="-"+dd.IDByName(token.nextToken())+"-";
					}				
					user oneUser=new user();
					oneUser.setDeptIDs(ids);
					oneUser.setPassword(passWord);
					oneUser.setStaffID(sd.findByNum(staffNum).getStaffID());
					oneUser.setUserName(userName);
					oneUser.setUserRole(Integer.parseInt(role));
					ud.editBySA(oneUser);
					warning="用户信息更新成功。";
					out.println("<script language='javascript'>" +
							"alert('"+warning+"');" +
							"location.href='home/user.jsp';</script>");
				}
				else
				{
					out.println("<script language='javascript'>" +
							"alert('"+warning+"');" +
							"history.go(-1);</script>");
				}
				
			}
		}
	}

}
