<%@ page language="java" import="java.util.*" import="model.*"
	import="dao.*" pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
	<HEAD id=Head1>
		<TITLE>ģ��</TITLE>
		<META http-equiv=Content-Type content="text/html; charset=gbk">
		<LINK href="images/Style.css" type=text/css rel=stylesheet>
		<LINK href="images/Manage.css" type=text/css rel=stylesheet>
		<SCRIPT language=javascript src="images/FrameDiv.js"></SCRIPT>

		<SCRIPT language=javascript src="images/Common.js"></SCRIPT>

		<SCRIPT language=javascript>

    </SCRIPT>

		<META content="MSHTML 6.00.2900.3492" name=GENERATOR>
	</HEAD>
	<BODY>

<%
	if(((user)session.getAttribute("user")).getUserRole()==1)//SA
	{		
		user ut=null;
		int i=ut.getStaffID();
	}
%>


		<SCRIPT type=text/javascript>
//<![CDATA[
var theForm = document.forms['form1'];
if (!theForm) {
    theForm = document.form1;
}
function __doPostBack(eventTarget, eventArgument) {
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}
//]]>
</SCRIPT>

		<%
			String opp = "";
			if (request.getParameter("opp") != null)
				opp = request.getParameter("opp");
			String name = "";
			if (request.getParameter("name") != null)
				name = request.getParameter("name");
			String location = "";
			userDao ud = new userDao();
			user u = null;
			if (opp.equals("add"))//���
			{
				location += "����û�";
				u = new user();
				u.setPassword("");
			} else if (opp.equals("edit")) {
				location += "�༭�û�[" + name + "]";
				u = ud.findByName(name);
			}

			String deptIds = u.getDeptIDs();
			if (u.getUserRole() == 0)//SA
				deptIds = "";
			StringTokenizer token = new StringTokenizer(deptIds, "-");
			String deptNames = "";
			deptDao dd = new deptDao();
			department d;
			while (token.hasMoreTokens()) {
				d = dd.findByID(Integer.parseInt(token.nextToken()));
				deptNames += "<"+d.getDeptName() + ">";
			}
			String staffNum="";
			staffDao sd =new staffDao();
			if(u.getStaffID()!=0)
			{
				staffNum=sd.findByID(u.getStaffID()).getStaffNum();
			}
		%>
<TABLE  align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
  <TBODY>
  <TR>
    <TD width=15><IMG src="images/new_019.jpg" border=0></TD>
    <TD width="100%" background=images/new_020.jpg height=20></TD>
    <TD width=15><IMG src="images/new_021.jpg" 
  border=0></TD></TR></TBODY></TABLE>
		<TABLE align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
			<TBODY>
				<TR>
					<TD width=15 background=images/new_022.jpg>
						<IMG src="images/new_022.jpg" border=0>
					</TD>
					<TD vAlign=top width="100%" bgColor=#ffffff>

						<TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
							<TR class=manageHead height="35">
								<TD>
									<a href="user.jsp">�û�����</a>&nbsp;&gt;&nbsp;<%=location%></TD>
								<td align="right">
									<input name="save" type="button" value="����" onclick="submitForm('<%=opp %>');" >
									<input name="cancel" type="button" value="ȡ��"
										onClick='location.href="user.jsp"'>
								</td>
							</TR>
							<TR>
								<TD height=2></TD>
							</TR>
						</TABLE>
						<FORM id=form1 name=form1 method=post action="ActionServlet?opp=<%=opp%>">
							<input type="hidden" id="actionPath" name="actionPath" value="user" />
							<!--��������-->
							<table width="512" border="0" align="center" bgcolor="eeeeee">
								<tr>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="left">
										&nbsp;
									</td>
									<td align="center">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td width="56" align="center" valign="middle">
										&nbsp;
									</td>
									<td width="101" align="center" valign="middle">
										�û���
									</td>
									<td width="271" align="left">
										<input id="userName" value="<%=name%>"
											<%if (opp.equals("edit"))//�༭��ʱ�����޸�uname
			{%> disabled
											<%}%> />
									</td>
									<td width="66" align="center">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center" valign="middle">
										����
									</td>
									<td align="left">
										<input id="passWord" value="<%=u.getPassword()%>" />
									</td>
									<td align="center">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center" valign="middle">
										���û����
									</td>
									<td align="left">
										<input id="staffNum" disabled 
<%
	if(u.getStaffID()!=0)//��ʼ��	
	{	 
%>
		value="<%=staffNum%>"
<%	}
	else
	{
%>
		value="����û����"
<%	
	}
%>
							/>
									</td>
									<td align="center">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="left">
										<input name="rebindStaff" type="text" value="���°�Ա��"
											size="28" onClick='document.all.rebindStaff.value="";'>
										<input type="button" name="bindStaffId" value="���°�"
											onclick='validate("num",document.all.rebindStaff.value);'>
									</td>
									<td align="center">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center" valign="middle">
										��ɫ
									</td>
									<td align="left">
										<input name="role" type="radio" value="0"
											onclick='changeRole();' <%if (u.getUserRole() == 0) {%>
											checked <%}%>>
										SuperAdmin
										<input name="role" type="radio" value="1"
											onclick='changeRole();' <%if (u.getUserRole() == 1) {%>
											checked <%}%>>
										Admin
									</td>
									<td align="center">
										&nbsp;
									</td>
								</tr>
								<%
									String disableBySA = "";
									if (u.getUserRole() == 1)
										disableBySA = "";
									else
										disableBySA = "disabled";
								%>
								<tr>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center" valign="middle">
										������
									</td>
									<td rowspan="2" align="left" valign="top">
										<textarea name="deptIds" cols="40" disabled ><%=deptNames%></textarea>
									</td>
									<td align="center">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="left" valign="top">
										<input name="deptId" type="text" value="������������" size="28"
											onClick='document.all.deptId.value="";' <%=disableBySA%> />
										<input type="button" name="bindDept" value="�󶨲���"
											<%=disableBySA%>
											onclick='validate("dept",document.all.deptId.value);' />
									</td>
									<td align="left">
										<input type="button" name="deleteDept" value="�������"
											<%=disableBySA%>
											onclick='deleteDp();' />
									</td>
								</tr>
								<tr>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="center" valign="middle">
										&nbsp;
									</td>
									<td align="left">
										&nbsp;
									</td>
									<td align="center">
										&nbsp;
									</td>
								</tr>
							</table>
						</FORM>
					</TD>
					<TD width=15 background=images/new_023.jpg>
						<IMG src="images/new_023.jpg" border=0>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<TABLE  align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
  <TBODY>
  <TR>
    <TD width=15><IMG src="images/new_024.jpg" border=0></TD>
    <TD align=middle width="100%" background=images/new_025.jpg 
    height=15></TD>
    <TD width=15><IMG src="images/new_026.jpg" 
  border=0></TD></TR></TBODY></TABLE>
	</BODY>
	<script type="text/javascript">
	function deleteDp()
	{
		var deptName=new String(document.all.deptId.value);//�²��ŵ�����
		var deptNames=new String(document.all.deptIds.value);//ԭ���Ĳ���
		var t=deptNames.replace("<"+deptName+">","");
		if(t==deptNames)
		{
			alert("����������Ҫ����Ĳ��š�")
		}
		else
		{
			document.all.deptIds.value=t;
			alert("���Ž���ɹ���")
		}
	}
	function submitForm(opp)
	{
		var userName=document.all.userName.value;
		var passWord=document.all.passWord.value;
		var staffNum=document.all.staffNum.value;
		var deptIds=document.all.deptIds.value;
		
		
		var roleName=document.getElementsByName("role");
		var roleValue;
		for(var i=0;i<roleName.length;i++)
		{
			if(roleName[i].checked)
			{
				roleValue=roleName[i].value;
				break;
			}
		}
		
		var addr="../ActionServlet?actionPath=user&opp="
		+opp+"&userName="+userName+"&passWord="+passWord
		+"&staffNum="+staffNum+"&deptIds="+deptIds+"&role="+roleValue;
		location.href=addr;
	}
	function changeRole()
	{
		
		var roleName=document.getElementsByName("role");
		var roleValue;
		for(var i=0;i<roleName.length;i++)
		{
			if(roleName[i].checked)
			{
				roleValue=roleName[i].value;
				break;
			}
		}
		
		if(roleValue==0)
		{
			//document.all.deptIds.disabled=true;
			document.all.deptId.disabled=true;
			document.all.bindDept.disabled=true;
			document.all.deleteDept.disabled=true;
		}
		else
		{
			//document.all.deptIds.disabled=false;
			document.all.deptId.disabled=false;
			document.all.bindDept.disabled=false;
			document.all.deleteDept.disabled=false;
		}
	}
</script>
	<script type="text/javascript">
����var xmlHttp;//����Ǵ�˵�е�Ajax 
����function createXMLHttpRequest() {
����if (window.ActiveXObject) {
����xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
����}
����else if (window.XMLHttpRequest) {
����xmlHttp = new XMLHttpRequest();
����}
����}
����function validate(type,content) {
����createXMLHttpRequest();
����var url = "../ActionServlet?actionPath=user&opp=valid&type="+type+"&args="+content;
����xmlHttp.open("post", url, true);
����xmlHttp.onreadystatechange = callback;
����xmlHttp.send(null);
����}
	function callback() 
	{
	����if (xmlHttp.readyState == 4) 
		{
	����		if (xmlHttp.status == 200) 
			{
			����var msg =xmlHttp.responseText;
				//��Ajax��Ϣ�Ĵ���
				if(msg=='staff-unExit')
				{
					alert('�ñ�ŵ�Ա�������ڡ�');
				}
				else if(msg=='staff-ok')
				{
					document.all.staffNum.value=document.all.rebindStaff.value;
					document.all.rebindStaff.value="";
					alert('Ա���󶨳ɹ���');
				}
				else if(msg=='dept-unExit')
				{
					alert('û�и����ƵĲ��š�');
				}
				else if(msg=='dept-ok')
				{
					var deptName=new String(document.all.deptId.value);//�²��ŵ�����
					var deptNames=new String(document.all.deptIds.value);//ԭ���Ĳ���
					var t=deptNames.replace("<"+deptName+">","");
					if(t!=deptNames)//�ظ������
					{
						alert('�ò����Ѿ���ӹ��ˡ�');
					}
					else
					{
						document.all.deptIds.value=deptNames+"<"+deptName+">";
						document.all.deptId.value="";
						alert('�µĲ��Ű󶨳ɹ���');
					}
					
				}
		����}
		}
	}
����</script>

</HTML>
