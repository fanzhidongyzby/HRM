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

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
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
		  <td align="right"><input name="moveStaff" type="button" value="����" onClick="javascript:location.href='transfer.jsp'">
		    <input name="editStaff" type="button" value="�༭"  onClick="javascript:location.href='stfDtlEdit.jsp?staffId=<%=staffId %>'"></td>
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
				<td width="6%" >ְ��</td>
				<td width="18%" ><%=s.getPosition() %></td>
<%
	String head=application.getRealPath("/")+"home/userPhoto/"+s.getStaffID()+"/photo_head.jpg";
	File fHead=new File(head);
	if(fHead.isFile())
		head="./userPhoto/"+s.getStaffID()+"/photo_head.jpg";
	else
		head="./userPhoto/AltPhoto_head.jpg";
%>
				<td rowspan="4"><img height="100" width="100"  src="<%=head %>"></img></td>
		  	</tr>
			<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
				
				<td>ѧ��</td><td colspan="5"><%=s.getEduBack() %></td>
				<td >ѧλ</td>
				<td  colspan="3" ><%=s.getDegree() %></td>
			</tr>
			<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
				<td>����</td>
				<td><%=s.getAge() %></td>
				<td>����</td>
				<td colspan="7"><%=s.getTech() %></td>
			</tr>
			<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
				<td>����</td>
				<td><%=s.getSalary() %>Ԫ/��</td>
				<td>״̬</td>
				<td><%=s.getStatus() %></td>
				<td >�籣</td>
				<td colspan="5"><%=s.getSocSec() %>Ԫ/��</td>
			</tr>
<tr height="30" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
			<td>֤��</td>
				<td colspan="10">
<%
	File f=new File(application.getRealPath("/")+"home/userPhoto/"+s.getStaffID()+"/");
	String[] files=f.list();
	for(int i=0;i<files.length;i++)
	{
		String fName=files[i];
		if("photo_head.jpg".equals(fName)||!fName.endsWith(".jpg"))
			continue;
%>
		<img height="150" width="200" src="userPhoto/<%=s.getStaffID() %>/<%=fName %>"></img>
<%		
	}
	if(files.length==0)
	{
%>
		��ʱû�и�Ա����֤����Ϣ
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
