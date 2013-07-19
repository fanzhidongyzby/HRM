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

	int oppCode=0;//������
	String args="";//����ids
	String name="";//��������
	int deptId=0;//��ǰ����ID
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
		case 1://���
			department d=new department();
			int id=dd.nextID();
			d.setDeptID(id);
			d.setDeptName(name);
			d.setDeptLevel(dept.getDeptLevel()+1);
			d.setDeptAffi(deptId+"-0");
			//�޸��ϼ�����������ϵ
			String t=dept.getDeptAffi();
			if(t.endsWith("-0"))//��һ���Ӳ���
			{
				t=t.substring(0, t.length()-1)+id;
			}
			else
				t=t+"-"+id;
			dd.editAffi(deptId, t);
			dd.newDpt(d);
			break;
		case 2://�༭
			dd.editDpt(deptId, name);
			break;
		case 3://�ƶ�
			int newDeptId=dd.IDByName(name);
			if(newDeptId!=0&&validDeptId(deptId,newDeptId))//��Ч�Ĳ�������,���Ҳ������Ӳ��ź͵�ǰ�ĸ�����
			{
				//�޸ĵ�ǰ����������ϵ
				String affi=dept.getDeptAffi();
				dd.editAffi(deptId, newDeptId+affi.substring(affi.indexOf("-")));
				//�޸�ԭ�ϼ�����������ϵ
				StringTokenizer token=new StringTokenizer(affi,"-");//��ȡ���Ӳ���ID
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
				//�޸����ϼ�����������ϵ
				t=dd.findByID(newDeptId).getDeptAffi();
				if(t.endsWith("-0"))//��һ���Ӳ���
				{
					t=t.substring(0, t.length()-1)+deptId;
				}
				else
					t=t+"-"+deptId;
				dd.editAffi(newDeptId, t);				
			}
			else
			{		
				String war="�����ƶ�ʧ�ܣ���������Ч��Ŀ�Ĳ������ơ�";			
				out.println("<script language='javascript'>" +
						"alert('"+war+"');" +
						"</script>");

			}
			break;
		case 4://�ϲ�
			bindDept();
			
			break;
		case 5://ɾ��
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
		if(srcId==tarId)//������ֹ
			return false;
		deptDao dd=new deptDao();
		department d=dd.findByID(srcId);
		String affi=d.getDeptAffi();
		if(affi.startsWith(String.valueOf(tarId)+"-"))//Ŀ���Ǳ����ĸ����ţ�û������
			return false;
		department tar=dd.findByID(tarId);
		while(tar!=null)
		{	if(tar.getDeptID()==srcId)//���Լ����Ӳ���
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
		StringTokenizer token=new StringTokenizer(args,"-");//��ȡ��������ID
		int id=0;
		deptDao dd=new deptDao();
		staffDao sd=new staffDao();
		userDao ud=new userDao();
		//�����ϲ�����²��ţ��Ȳ������ӽڵ㡾�൱�����һ���µĲ��š�
		department newBindDept=new department();
		id=dd.nextID();
		newBindDept.setDeptID(id);
		newBindDept.setDeptName(name);
		department dept=dd.findByID(deptId);//�������ϼ�����
		String curAffi=dept.getDeptAffi();//�ϼ����ŵ�������ϵ
		newBindDept.setDeptLevel(dept.getDeptLevel()+1);
		newBindDept.setDeptAffi(""+deptId);//�����ʱ���ţ������⴦���Ժ����
		//�޸��ϼ�����������ϵ
		String t=curAffi;
		if(t.endsWith("-0"))//��һ���Ӳ���
		{
			t=t.substring(0, t.length()-1)+id;
		}
		else
			t=t+"-"+id;
		curAffi=t;//�༭�ϼ����ŵ�β����,һ�𱣴�
		dd.newDpt(newBindDept);//������ʱ���ɵ���ʱ�ϲ�����
		//�����ӽڵ��������ϵ
		department d=null;
		String exNewBindDeptAffi="";//�������ʱ���ŵ�β�ڵ�
		while(token.hasMoreTokens())
		{
			int did=0;
			did=Integer.parseInt(token.nextToken());
			d=dd.findByID(did);//��ȡĿ�겿��
			String affi=d.getDeptAffi();
			affi=affi.substring(affi.indexOf("-"));//���븸������Ϣ
			StringTokenizer tarList=new StringTokenizer(affi,"-");//��������Ŀ�겿���Ӳ��ŵ��ϼ�������ϵ
			department tar=null;			
			while(tarList.hasMoreTokens())
			{
				tar=dd.findByID(Integer.parseInt(tarList.nextToken()));//�õ��Ӳ���
				if(tar==null)//û���Ӳ���
					break;
				//�������ʱ���ŵ�β������ϵ
				exNewBindDeptAffi+="-"+tar.getDeptID();
				String tarAffi=tar.getDeptAffi();
				tarAffi=newBindDept.getDeptID()+tarAffi.substring(tarAffi.indexOf("-"));//�޸ĸ�������ϢΪ��ʱ�²���
				dd.editAffi(tar.getDeptID(), tarAffi);//�����޸�,ԭ���ŵ�β������ϵ���ٴ����Ժ�һ��ɾ��
			}
			//�޸���Ҫ��ҡ��staff��				
			ArrayList<staff> staffList=sd.findByDept(d.getDeptID());
			for(int i=0;i<staffList.size();i++)
			{
				staff s=staffList.get(i);
				s.setDeptID(id);
				sd.edit(s);
			}
			//�޸���Ҫ��ҡ��user��
			ArrayList<user> allUser=ud.findAll();
			String userDeptIds="";
			user u=null;
			for(int i=0;i<allUser.size();i++)
			{
				u=allUser.get(i);
				if(u.getUserRole()==0)//SA,���ٿ���
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
			//ɾ����ǰ����β����			
			curAffi=curAffi.replace("-"+did+"-", "-");			
			if(curAffi.endsWith("-"+did))
			{
				curAffi=curAffi.replace("-"+did, "");
				if(!curAffi.contains("-"))
					curAffi+="-0";
			}
			//ɾ��Ŀ�겿��
			dd.delete(did);
		}
		//ɾ��������ϵ
		dd.editAffi(deptId, curAffi);
		//������ʱ����β������ϵ
		if(exNewBindDeptAffi.equals(""))//����β��
			exNewBindDeptAffi="-0";
		dd.editAffi(newBindDept.getDeptID(), deptId+exNewBindDeptAffi);
	}

	public String deleteDept()
	{
		StringTokenizer token=new StringTokenizer(args,"-");//��ȡ��������ID
		int count=token.countTokens();
		int failed=0;
		deptDao dd=new deptDao();
		staffDao sd=new staffDao();
		userDao ud=new userDao();
		department dept=dd.findByID(deptId);//�������ϼ�����
		String curAffi=dept.getDeptAffi();//�ϼ����ŵ�������ϵ��"���"������Ҫɾ���¼����ŵ���Ϣ
		//�����ӽڵ��������ϵ
		department d=null;		
		while(token.hasMoreTokens())//����Ҫɾ���Ĳ���
		{
			boolean deletable=true;//����ɾ���ı��
			int did=0;
			did=Integer.parseInt(token.nextToken());
			d=dd.findByID(did);//��ȡĿ��ɾ������
			String affi=d.getDeptAffi();
			if(!affi.endsWith("-0"))//���Ӳ���!!!����ɾ��
			{
				deletable=false;
			}
			
			//��ѯstaff��ȷ��û��Ա��
			ArrayList<staff> staffList=sd.findByDept(d.getDeptID());
			if(staffList.size()!=0)//����Ա�������ò��ţ�����ɾ��
			{
				deletable=false;
			}
			if(deletable==false)//����ɾ��
			{
				failed++;
				continue;
			}
			
			
			//������ʼɾ������
			//�޸���Ҫ��ҡ��user��
			ArrayList<user> allUser=ud.findAll();
			String userDeptIds="";
			user u=null;
			for(int i=0;i<allUser.size();i++)
			{
				u=allUser.get(i);
				if(u.getUserRole()==0)//SA,���ٿ���
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
			//ɾ����ǰ����β����
			curAffi=curAffi.replace("-"+did+"-", "-");
			if(curAffi.endsWith("-"+did))
			{
				curAffi=curAffi.replace("-"+did, "");
				if(!curAffi.contains("-"))
					curAffi+="-0";
			}
			//ɾ��Ŀ�겿��
			dd.delete(did);
		}
		//ɾ��������ϵ
		dd.editAffi(deptId, curAffi);
		String feedBack="";//������Ϣ
		if(failed!=0)//��δɾ���ɹ���
		{
			feedBack="��"+count+"�������е�"+(count-failed)
			+"������ִ��ɾ��������������"+failed+"������û�гɹ�ɾ������ȷ�ϸò�����û���Ӳ��ź�Ա����";
		}
		else
		{
			feedBack="�ɹ�ɾ����ѡ��"+count+"�����š�";
		}
		return feedBack;
	}
}
