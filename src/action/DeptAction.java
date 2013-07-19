package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.department;
import model.staff;
import model.user;
import dao.deptDao;
import dao.staffDao;
import dao.userDao;

public class DeptAction implements Action {

	int oppCode=0;//操作码
	String args="";//部门ids
	String name="";//部门名称
	int deptId=0;//当前部门ID
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<html><body background='./images/bg.png'>");
		// TODO Auto-generated method stub
		
		HttpSession session=request.getSession();
		if(request.getParameter("oppCode")!=null)
		{
			oppCode=Integer.parseInt(request.getParameter("oppCode"));	
		}
		if(request.getParameter("args")!=null)
		{
			args=request.getParameter("args");
		}
		if(request.getParameter("msg")!=null)
		{
			name=request.getParameter("msg");
		}
		if(session.getAttribute("deptId")!=null)
		{
			deptId=Integer.parseInt(session.getAttribute("deptId").toString());
		}
		deptDao dd=new deptDao();
		department dept=dd.findByID(deptId);
		switch(oppCode)
		{
		case 1://添加
			department d=new department();
			int id=dd.nextID();
			d.setDeptID(id);
			d.setDeptName(name);
			d.setDeptLevel(dept.getDeptLevel()+1);
			d.setDeptAffi(deptId+"-0");
			//修改上级部门隶属关系
			String t=dept.getDeptAffi();
			if(t.endsWith("-0"))//第一个子部门
			{
				t=t.substring(0, t.length()-1)+id;
			}
			else
				t=t+"-"+id;
			dd.editAffi(deptId, t);
			dd.newDpt(d);
			break;
		case 2://编辑
			dd.editDpt(deptId, name);
			break;
		case 3://移动
			int newDeptId=dd.IDByName(name);
			if(newDeptId!=0&&validDeptId(deptId,newDeptId))//有效的部门名称,而且不能是子部门和当前的父部门
			{
				//修改当前部门隶属关系
				String affi=dept.getDeptAffi();
				dd.editAffi(deptId, newDeptId+affi.substring(affi.indexOf("-")));
				//修改原上级部门隶属关系
				StringTokenizer token=new StringTokenizer(affi,"-");//获取父子部门ID
				if(token.hasMoreTokens())
				{
					int pId=Integer.parseInt(token.nextToken());
					department parent=dd.findByID(pId);
					t=parent.getDeptAffi().replace("-"+deptId+"-","-");
					if(t.endsWith("-"+deptId))
					{
						t=t.replace("-"+deptId, "");
						if(!t.contains("-"))
							t=t+"-0";
					}
					dd.editAffi(pId, t);
				}
				//修改新上级部门隶属关系
				t=dd.findByID(newDeptId).getDeptAffi();
				if(t.endsWith("-0"))//第一个子部门
				{
					t=t.substring(0, t.length()-1)+deptId;
				}
				else
					t=t+"-"+deptId;
				dd.editAffi(newDeptId, t);				
			}
			else
			{		
				String war="部门移动失败，请输入有效的目的部门名称。";			
				out.println("<script language='javascript'>" +
						"alert('"+war+"');" +
						"</script>");

			}
			break;
		case 4://合并
			bindDept();
			
			break;
		case 5://删除
			String feedBack=deleteDept();
			out.println("<script language='javascript'>" +
					"alert('"+feedBack+"');" +
					"</script>");
			break;
		}
		if(oppCode==5)
		{
			out.println("<script>" +
					"window.location.href('./home/depart.jsp');" +
				"</script>");
		}
		else
		{
			out.println("<script>" +
					"opener.location.href('./home/depart.jsp');" +
					"window.close();" +
				"</script>");
			out.println("</body></html>");
		}		
		out.flush();
		out.close();
		
		
		
		
		
	}
	
	public boolean validDeptId(int srcId,int tarId)
	{
		if(srcId==tarId)//本身，禁止
			return false;
		deptDao dd=new deptDao();
		department d=dd.findByID(srcId);
		String affi=d.getDeptAffi();
		if(affi.startsWith(String.valueOf(tarId)+"-"))//目的是本部的父部门，没有意义
			return false;
		department tar=dd.findByID(tarId);
		while(tar!=null)
		{	if(tar.getDeptID()==srcId)//是自己的子部门
			{
				return false;
			}
			StringTokenizer token=new StringTokenizer(tar.getDeptAffi(),"-");
			if(token.hasMoreTokens())
			{
				tar=dd.findByID(Integer.parseInt(token.nextToken()));
			}
		}
		return true;
	}

	public void bindDept()
	{
		StringTokenizer token=new StringTokenizer(args,"-");//获取操作部门ID
		int id=0;
		deptDao dd=new deptDao();
		staffDao sd=new staffDao();
		userDao ud=new userDao();
		//创建合并后的新部门，先不处理子节点【相当于添加一个新的部门】
		department newBindDept=new department();
		id=dd.nextID();
		newBindDept.setDeptID(id);
		newBindDept.setDeptName(name);
		department dept=dd.findByID(deptId);//本来的上级部门
		String curAffi=dept.getDeptAffi();//上级部门的隶属关系
		newBindDept.setDeptLevel(dept.getDeptLevel()+1);
		newBindDept.setDeptAffi(""+deptId);//针对临时部门，做特殊处理，稍后添加
		//修改上级部门隶属关系
		String t=curAffi;
		if(t.endsWith("-0"))//第一个子部门
		{
			t=t.substring(0, t.length()-1)+id;
		}
		else
			t=t+"-"+id;
		curAffi=t;//编辑上级部门的尾隶属,一起保存
		dd.newDpt(newBindDept);//保存暂时生成的临时合并部门
		//处理子节点的隶属关系
		department d=null;
		String exNewBindDeptAffi="";//额外的临时部门的尾节点
		while(token.hasMoreTokens())
		{
			int did=0;
			did=Integer.parseInt(token.nextToken());
			d=dd.findByID(did);//获取目标部门
			String affi=d.getDeptAffi();
			affi=affi.substring(affi.indexOf("-"));//抽离父部门信息
			StringTokenizer tarList=new StringTokenizer(affi,"-");//处理所有目标部门子部门的上级隶属关系
			department tar=null;			
			while(tarList.hasMoreTokens())
			{
				tar=dd.findByID(Integer.parseInt(tarList.nextToken()));//得到子部门
				if(tar==null)//没有子部门
					break;
				//先添加临时部门的尾隶属关系
				exNewBindDeptAffi+="-"+tar.getDeptID();
				String tarAffi=tar.getDeptAffi();
				tarAffi=newBindDept.getDeptID()+tarAffi.substring(tarAffi.indexOf("-"));//修改父部门信息为临时新部门
				dd.editAffi(tar.getDeptID(), tarAffi);//保存修改,原部门的尾隶属关系不再处理，稍后一起删除
			}
			//修改需要动摇的staff表				
			ArrayList<staff> staffList=sd.findByDept(d.getDeptID());
			for(int i=0;i<staffList.size();i++)
			{
				staff s=staffList.get(i);
				s.setDeptID(id);
				sd.edit(s);
			}
			//修改需要动摇的user表
			ArrayList<user> allUser=ud.findAll();
			String userDeptIds="";
			user u=null;
			for(int i=0;i<allUser.size();i++)
			{
				u=allUser.get(i);
				if(u.getUserRole()==0)//SA,不再考虑
					continue;
				userDeptIds=u.getDeptIDs();
				if(userDeptIds.contains("-"+did+"-"))
				{
					u.setDeptIDs(userDeptIds.replace("-"+did+"-", "-"));
					ud.editBySA(u);
				}
				else if(userDeptIds.endsWith("-"+did))
				{
					u.setDeptIDs(userDeptIds.replace("-"+did, ""));
					ud.editBySA(u);
				}
			}
			//删除当前部门尾隶属			
			curAffi=curAffi.replace("-"+did+"-", "-");			
			if(curAffi.endsWith("-"+did))
			{
				curAffi=curAffi.replace("-"+did, "");
				if(!curAffi.contains("-"))
					curAffi+="-0";
			}
			//删除目标部门
			dd.delete(did);
		}
		//删除隶属关系
		dd.editAffi(deptId, curAffi);
		//保存临时部门尾隶属关系
		if(exNewBindDeptAffi.equals(""))//加上尾巴
			exNewBindDeptAffi="-0";
		dd.editAffi(newBindDept.getDeptID(), deptId+exNewBindDeptAffi);
	}

	public String deleteDept()
	{
		StringTokenizer token=new StringTokenizer(args,"-");//获取操作部门ID
		int count=token.countTokens();
		int failed=0;
		deptDao dd=new deptDao();
		staffDao sd=new staffDao();
		userDao ud=new userDao();
		department dept=dd.findByID(deptId);//本来的上级部门
		String curAffi=dept.getDeptAffi();//上级部门的隶属关系，"最后"根据需要删除下级部门的信息
		//处理子节点的隶属关系
		department d=null;		
		while(token.hasMoreTokens())//解析要删除的部门
		{
			boolean deletable=true;//可以删除的标记
			int did=0;
			did=Integer.parseInt(token.nextToken());
			d=dd.findByID(did);//获取目标删除部门
			String affi=d.getDeptAffi();
			if(!affi.endsWith("-0"))//有子部门!!!不能删除
			{
				deletable=false;
			}
			
			//查询staff表，确认没有员工
			ArrayList<staff> staffList=sd.findByDept(d.getDeptID());
			if(staffList.size()!=0)//还有员工隶属该部门，不能删除
			{
				deletable=false;
			}
			if(deletable==false)//不能删除
			{
				failed++;
				continue;
			}
			
			
			//真正开始删除部门
			//修改需要动摇的user表
			ArrayList<user> allUser=ud.findAll();
			String userDeptIds="";
			user u=null;
			for(int i=0;i<allUser.size();i++)
			{
				u=allUser.get(i);
				if(u.getUserRole()==0)//SA,不再考虑
					continue;
				userDeptIds=u.getDeptIDs();
				if(userDeptIds.contains("-"+did+"-"))
				{
					u.setDeptIDs(userDeptIds.replace("-"+did+"-", "-"));
					ud.editBySA(u);
				}
				else if(userDeptIds.endsWith("-"+did))
				{
					u.setDeptIDs(userDeptIds.replace("-"+did, ""));
					ud.editBySA(u);
				}
			}
			//删除当前部门尾隶属
			curAffi=curAffi.replace("-"+did+"-", "-");
			if(curAffi.endsWith("-"+did))
			{
				curAffi=curAffi.replace("-"+did, "");
				if(!curAffi.contains("-"))
					curAffi+="-0";
			}
			//删除目标部门
			dd.delete(did);
		}
		//删除隶属关系
		dd.editAffi(deptId, curAffi);
		String feedBack="";//反馈信息
		if(failed!=0)//有未删除成功的
		{
			feedBack="对"+count+"个部门中的"+(count-failed)
			+"个部门执行删除操作，其中有"+failed+"个部门没有成功删除，请确认该部门下没有子部门和员工。";
		}
		else
		{
			feedBack="成功删除所选的"+count+"个部门。";
		}
		return feedBack;
	}
}
