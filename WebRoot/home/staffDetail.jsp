<%@ page language="java" import="java.util.*"  import="model.*" import="dao.*" import="java.io.File;"  pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>ģ��</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="images/Style.css" type=text/css rel=stylesheet><LINK 
href="images/Manage.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/FrameDiv.js"></SCRIPT>

<SCRIPT language=javascript src="images/Common.js"></SCRIPT>

<SCRIPT language=javascript>

    </SCRIPT>
<META   HTTP-EQUIV= "pragma "   CONTENT= "no-cache "> 
        <META   HTTP-EQUIV= "Cache-Control "   CONTENT= "no-cache,   must-revalidate "> 
        <META   HTTP-EQUIV= "expires "   CONTENT= "Mon,   23   Jan   1978   20:52:30   GMT "> 
</HEAD>
<BODY>
<FORM id=form1 name=form1 method=post>
<%
	int staffId=Integer.parseInt(request.getParameter("staffId"));
	staffDao sd=new staffDao();
	staff s=(staff)sd.findByID(staffId);
	int deptId=s.getDeptID();
	String sex="";
	if(s.getSex()==0)
		sex="Ů";
	else
		sex="��";
%>

<TABLE  align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
  <TBODY>
  <TR>
    <TD width=15><IMG src="images/new_019.jpg" border=0></TD>
    <TD width="100%" background=images/new_020.jpg height=20></TD>
    <TD width=15><IMG src="images/new_021.jpg" 
  border=0></TD></TR></TBODY></TABLE>
<TABLE  align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
  <TBODY>
  <TR>
    <TD width=15 background=images/new_022.jpg><IMG 
      src="images/new_022.jpg" border=0> </TD>
    <TD vAlign=top width="100%" bgColor=#ffffff>
      <TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
        <TR class=manageHead height="35">
          <TD >
��ǰλ�ã�&nbsp;
<%
 	ArrayList<department> dir=new ArrayList<department>();
 	deptDao dd=new deptDao();
 	department dept;
	int curDeptId=deptId;
	dept=dd.findByID(curDeptId);//��ǰ
	String deptName=dept.getDeptName();//��ȡ����
	dir.add(dept);
	String affi=dept.getDeptAffi();
	StringTokenizer token=new StringTokenizer(affi,"-");//��ȡ���Ӳ���ID
	department parentDept=null;//������
	if(token.hasMoreTokens())
	{
		parentDept=dd.findByID(Integer.parseInt(token.nextToken()));
	}
	while(parentDept!=null)//�и����ż������
	{
		dir.add(parentDept);
		dept=dd.findByID(parentDept.getDeptID());
		affi=dept.getDeptAffi();
		token=new StringTokenizer(affi,"-");//��ȡ���Ӳ���ID
		if(token.hasMoreTokens())
		{
			parentDept=dd.findByID(Integer.parseInt(token.nextToken()));
		}
	}
	//����������������Ӳ��ŵ� ����
	for(int i=dir.size()-1;i>=0;i--)
	{
		if(i!=dir.size()-1)//���ǵ�һ��λ��
		{
%>
			&gt;&nbsp;
<%					
		}
%>

		<a 
		href="../SwitchDept?curDeptId=<%=dir.get(i).getDeptID() %>" >
		<%=dir.get(i).getDeptName() %></a>&nbsp;
<%			
	}
%>

&gt;&nbsp;<%=s.getStaffName() %>&nbsp;[������Ϣ]</TD>
<%
	boolean hasValid=false;
	int nowId=s.getDeptID();
	user u=(user)session.getAttribute("user");
	if(u.getUserRole()==1)//A,
	{
		String depts=u.getDeptIDs();
		StringTokenizer testToken=new StringTokenizer(depts,"-");
		while(testToken.hasMoreTokens())
		{
			int oneDeptId=Integer.parseInt(testToken.nextToken());//����ID
			//����ID
			while(nowId!=0)
			{
				if(nowId==oneDeptId)
				{
					hasValid=true;
					break;
				}
				else
				{
					//������
					String t_affi=dd.findByID(nowId).getDeptAffi();
					t_affi=t_affi.substring(0,t_affi.indexOf('-'));
					nowId=Integer.parseInt(t_affi);
				}
			}
			if(hasValid)
				break;
		} 
	}
	else
	{
		hasValid=true;
	}
	
	
 %>
  <td align="right">
 <%
 	if(hasValid)
 	{
%>
		<input name="moveStaff" type="button" value="����" onClick="javascript:location.href='transfer.jsp?staffId=<%=staffId %>'">
		    <input name="editStaff" type="button" value="�༭"  onClick="javascript:location.href='stfDtlEdit.jsp?staffId=<%=staffId %>'">
<% 	
 	}
  %>
		 </td>
        </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!--��������-->
		  <TABLE  border="1" align="center"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
		  	<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
				<td width="6%">���</td>
				<td width="14%"><%=s.getStaffNum() %></td>
				<td width="6%">����</td>
				<td width="11%"><%=s.getStaffName() %></td>
				<td width="6%">�Ա�</td>
				<td width="6%"><%=sex %></td>		
				<td width="6%" >����</td>
				<td width="21%" ><%=deptName %></td>
<%
	String pos=s.getPosition();
	if(pos==null)
		pos="";
%>				
				<td width="6%" >ְ��</td>
				<td width="18%" ><%=pos %></td>
				<td rowspan="4">
<%
	//�����ļ���
	File staffDir=new File(application.getRealPath("/")+"home/userPhoto/"+s.getStaffID());
	if(!staffDir.exists())
		staffDir.mkdir();
	String head=application.getRealPath("/")+"home/userPhoto/"+s.getStaffID()+"/photo_head.jpg";
	File fHead=new File(head);
	if(fHead.exists())
	{
%>
		<a href="#" 
		onclick='window.open ("up.jsp?staffId=<%=staffId %>&type=head", "newwindow", "height=100, width=320, top=280,  left=500, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");'
		>
				<img height="100"  border="0" width="100" 
				 src="./userPhoto/<%=s.getStaffID() %>/photo_head.jpg"></img></a>
<%	
	}else
	{
		head=application.getRealPath("/")+"home/userPhoto/"+s.getStaffID()+"/t_photo_head.jpg";
	    fHead=new File(head);
	    if(fHead.exists())
	    {
%>
			<a href="#"
			onclick='window.open ("up.jsp?staffId=<%=staffId %>&type=head", "newwindow", "height=100, width=320, top=280,  left=500, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");'
			>
				<img height="100"  border="0" width="100" 
				 src="./userPhoto/<%=s.getStaffID() %>/t_photo_head.jpg"></img></a>
<%	    
	    }else{
%>
		<a href="#"
		onclick='window.open ("up.jsp?staffId=<%=staffId %>&type=head", "newwindow", "height=100, width=320, top=280,  left=500, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");'
		>
				<img height="100"  border="0" width="100" 
				 src="./userPhoto/AltPhoto_head.jpg"></img></a>
<%	
	}}
%>				
				
				</td>
		  	</tr>
			<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
<%
	String edu=s.getEduBack();
	if(edu==null)
		edu="";
	String dgr=s.getDegree();
	if(dgr==null)
		dgr="";
	String te=s.getTech();
	if(te==null)
		te="";
%>	
				<td>ѧ��</td><td colspan="5"><%=edu %></td>
				<td >ѧλ</td>
				<td  colspan="3" ><%=dgr %></td>
			</tr>
			<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
				<td>����</td>
				<td><%=s.getAge() %></td>
				<td>����</td>
				<td colspan="7"><%=te %></td>
			</tr>
<%
	String sl=s.getSalary()+"Ԫ/��";
	if(s.getSalary()==0)
		sl="";
	String st=s.getStatus();
	if(st==null)
		st="";
	String ss=s.getSocSec()+"Ԫ/��";
	if(s.getSocSec()==0)
		ss="";
%>	
			<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
				<td>����</td>
				<td><%=sl %></td>
				<td>״̬</td>
				<td><%=st %></td>
				<td >�籣</td>
				<td colspan="5"><%=ss%></td>
			</tr>
<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
			<td>֤��</td>
				<td colspan="10">
<%
	File f=new File(application.getRealPath("/")+"home/userPhoto/"+s.getStaffID()+"/");
	String[] files=f.list();
	int k=0;
	for(int i=0;i<files.length;i++)
	{
		String fName=files[i];
		if("photo_head.jpg".equals(fName)||!fName.endsWith(".jpg")||"t_photo_head.jpg".equals(fName))
			continue;
		k++;
%>
		<a href="#"
		onclick='window.open ("up.jsp?staffId=<%=staffId %>", "newwindow", "height=100, width=320, top=280,  left=500, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");'
		><img border="0" height="150" width="200" src="userPhoto/<%=s.getStaffID() %>/<%=fName %>"></img></a>
<%		
	}
	if(k==0)
	{
%>
		��ʱû��<a href='#' 
		onclick='window.open ("up.jsp?staffId=<%=staffId %>", "newwindow", "height=100, width=320, top=280,  left=500, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");'
		>�ϴ�</a>��Ա����֤����Ϣ
<%	
	}
%>
				</td>
			</tr>
			<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
			<td>�߼���Ϣ</td>
				<td colspan="10">
				<a href="./resume.jsp?staffId=<%=s.getStaffID() %>">��������</a>
				<a href="./doc.jsp?staffId=<%=s.getStaffID() %>">Ա������</a>
				<a href="./contract.jsp?staffId=<%=s.getStaffID() %>">������ͬ</a>
				</td>
			</tr>
			
		  </TABLE>
      </TD>
    <TD width=15 background=images/new_023.jpg><IMG 
      src="images/new_023.jpg" border=0> </TD></TR></TBODY></TABLE>
<TABLE  align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
  <TBODY>
  <TR>
    <TD width=15><IMG src="images/new_024.jpg" border=0></TD>
    <TD align=middle width="100%" background=images/new_025.jpg 
    height=15></TD>
    <TD width=15><IMG src="images/new_026.jpg" 
  border=0></TD></TR></TBODY></TABLE>
</FORM></BODY></HTML>
