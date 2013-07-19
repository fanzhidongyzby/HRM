package action;

import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.user;
import dao.userDao;

public class LoginAction implements Action {

	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
		String name=request.getParameter("txtName").trim();
		String pwd=request.getParameter("txtPwd").trim();
		String code=request.getParameter("txtCode").trim();
		HttpSession session=request.getSession();
		String rand=session.getAttribute("rand").toString().trim();
		user usr=new userDao().findByName(name);
		if(usr!=null&&name.equals(usr.getUserName())&&pwd.equals(usr.getPassword())&&code.equals(rand))
		{
			session.setAttribute("user", usr);
			int curDeptId=1;
			int role=usr.getUserRole();
			if(role!=0)//A
			{
				String deptIds=usr.getDeptIDs();
				if(deptIds==null)
					deptIds="";
				StringTokenizer token=new StringTokenizer(deptIds,"-");
				if(token.hasMoreTokens())
				{
					curDeptId=Integer.parseInt(token.nextToken());//默认选择第一个部门作为首页菜单
				}
			}
			else
			{
				session.setAttribute("deptId",1);//针对SA设置管理机构的信息
			}
			session.removeAttribute("realCurDeptId");//删除无用的Session
			session.setAttribute("curDeptId",curDeptId);			
			response.sendRedirect("home/index.jsp");
		}
		else
		{
			int errorCode=-1;
			if(usr==null)//没有该用户
			{
				//request.setAttribute("error", 0);
				errorCode=0;
			}
			else if(!pwd.equals(usr.getPassword()))//密码错误
			{
				//request.setAttribute("error", 1);
				errorCode=1;
			}
			else if(!code.equals(rand))//验证码错误
			{
				//request.setAttribute("error", 2);
				errorCode=2;
			}
			//response.sendRedirect("login.jsp?error="+errorCode+"&userName=admin");
			request.setAttribute("error", errorCode);
			request.setAttribute("userName", name);
			RequestDispatcher dispatcher=request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}		
	}
}
