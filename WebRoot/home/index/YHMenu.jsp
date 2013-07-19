<%@ page language="java" import="java.util.*" import="model.*" import="dao.*"  pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>导航</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<LINK 
href="../images/Style.css" type=text/css rel=stylesheet><LINK 
href="../images/Manage.css" type=text/css rel=stylesheet>
<STYLE type=text/css>BODY {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BACKGROUND-COLOR: #2a8dc8
}
BODY {
	FONT-SIZE: 11px; COLOR: #003366; FONT-FAMILY: 微软雅黑
}
TD {
	FONT-SIZE: 11px; COLOR: #003366; FONT-FAMILY: 微软雅黑
}
DIV {
	FONT-SIZE: 11px; COLOR: #003366; FONT-FAMILY: 微软雅黑
}
P {
	FONT-SIZE: 11px; COLOR: #003366; FONT-FAMILY: 微软雅黑
}
.mainMenu {
	FONT-WEIGHT: bold; FONT-SIZE: 14px; CURSOR: hand; COLOR: #000000
}
A.style2:link {
	PADDING-LEFT: 4px; COLOR: #0055bb; TEXT-DECORATION: none
}
A.style2:visited {
	PADDING-LEFT: 4px; COLOR: #0055bb; TEXT-DECORATION: none
}
A.style2:hover {
	PADDING-LEFT: 4px; COLOR: #ff0000; TEXT-DECORATION: none
}
A.active {
	PADDING-LEFT: 4px; COLOR: #ff0000; TEXT-DECORATION: none
}
.span {
	COLOR: #ff0000
}
</STYLE>

<%
	int curDeptId=Integer.parseInt(session.getAttribute("curDeptId").toString());
	deptDao dd=new deptDao();
	department dept=dd.findByID(curDeptId);//当前
	String affi=dept.getDeptAffi();
	StringTokenizer token=new StringTokenizer(affi,"-");//获取父子部门ID
	department parentDept=null;//父部门
	if(token.hasMoreTokens())
	{
		parentDept=dd.findByID(Integer.parseInt(token.nextToken()));
	}
 %>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>
<!--人员，机构查询模块-->
<FORM id=formDepart name=formDepart action=nextDepart.jsp method=post>
<TABLE cellSpacing=0 cellPadding=0 width=210 align=center border=0>
	<TR>
    	<TD width=15><IMG src="../images/new_005.jpg" border=0></TD>
	    <TD align=left width=180 background=../images/new_006.jpg height=35>
			<table width="100%">
				<tr><td align="left"><B><%=dept.getDeptName() %></B></td>
<td align="right">
<%if(parentDept!=null)//有父部门才有返回
{ %>
<a href="../../SwitchDept?curDeptId=<%=parentDept.getDeptID() %>"
>
<img border="0" src="../images/back.png" width="20" height="20"/></a>
<%}else{
%>&nbsp;
<%
 }%>

</td>
				</tr>
			</table>
		</TD>
    	<TD width=15><IMG src="../images/new_007.jpg" border=0></TD>
	</TR>
	<tr>
		<TD width=15 background=../images/new_008.jpg></TD>
		<TD width=180 bgColor=#ffffff>
			<TABLE cellSpacing=0 cellPadding=0 align=center border=0>
		<%
			department childDept;
			while(token.hasMoreTokens())
			{
				childDept=dd.findByID(Integer.parseInt(token.nextToken()));
				if(childDept!=null){
		%>
				<tr><TD vAlign=middle width=180 height=30 bgColor=#ffffff>
				<li><a 
				href="../../SwitchDept?curDeptId=<%=childDept.getDeptID() %>">
				<%=childDept.getDeptName() %></a></li></TD></tr>
		<% 		}else{
		%>
					<tr><TD vAlign=middle width=180 height=30 bgColor=#ffffff>
					系统暂时未初始化，请联系超级管理员添加子部门
					</TD></tr>
		<%
				}
			} %>
				
			</TABLE>
		</TD>
		<TD width=15 background=../images/new_009.jpg></TD>
	</tr>
	<TR>
    	<TD width=15><IMG src="../images/new_010.jpg" border=0></TD>
    	<TD align=middle width=180 background=../images/new_011.jpg height=15></TD>
    	<TD width=15><IMG src="../images/new_012.jpg" border=0></TD>
	</TR>
</TABLE>
</form>
<br>
<!--人事调度模块-->
<FORM id=formHScadule name=formHScadule action=formHScadule.jsp method=post>
<TABLE cellSpacing=0 cellPadding=0 width=210 align=center border=0>
	<TR>
    	<TD width=15><IMG src="../images/new_005.jpg" border=0></TD>
	    <TD align=left width=180 background=../images/new_006.jpg height=35><B>人事调度</B> </TD>
    	<TD width=15><IMG src="../images/new_007.jpg" border=0></TD>
	</TR>
	<tr>
		<TD width=15 background=../images/new_008.jpg></TD>
		<TD width=180 bgColor=#ffffff>
			<TABLE cellSpacing=0 cellPadding=0 align=center border=0>
				<tr><TD vAlign=middle width=180 height=30 bgColor=#ffffff><li><a href="../deployQuery.jsp" target="dmMain">变动查询</a></li></TD></tr>
				<tr><TD vAlign=middle width=180 height=30 bgColor=#ffffff><li><a href="../deploy.jsp" target="dmMain">人员调动</a></li></TD></tr>
			</TABLE>
		</TD>
		<TD width=15 background=../images/new_009.jpg></TD>
	</tr>
	<TR>
    	<TD width=15><IMG src="../images/new_010.jpg" border=0></TD>
    	<TD align=middle width=180 background=../images/new_011.jpg height=15></TD>
    	<TD width=15><IMG src="../images/new_012.jpg" border=0></TD>
	</TR>
</TABLE>
</form>
<br>
<%
	user u=(user)session.getAttribute("user");
	if(u.getUserRole()==0)//SA
	{
%>
		<!--系统管理模块-->
<FORM id=formSysMgr name=formSysMgr action=formSysMgr.jsp method=post>
<TABLE cellSpacing=0 cellPadding=0 width=210 align=center border=0>
	<TR>
    	<TD width=15><IMG src="../images/new_005.jpg" border=0></TD>
	    <TD align=left width=180 background=../images/new_006.jpg height=35><B>系统管理</B> </TD>
    	<TD width=15><IMG src="../images/new_007.jpg" border=0></TD>
	</TR>
	<tr>
		<TD width=15 background=../images/new_008.jpg></TD>
		<TD width=180 bgColor=#ffffff>
			<TABLE cellSpacing=0 cellPadding=0 align=center border=0>
				<tr><TD vAlign=middle width=180 height=30  bgColor=#ffffff><li><a href="../depart.jsp" target="dmMain">机构设置</a></li></TD></tr>
				<tr><TD vAlign=middle width=180 height=30 bgColor=#ffffff><li><a target='dmMain' href="../user.jsp">用户管理</a></li></TD></tr>
			</TABLE>
		</TD>
		<TD width=15 background=../images/new_009.jpg></TD>
	</tr>
	<TR>
    	<TD width=15><IMG src="../images/new_010.jpg" border=0></TD>
    	<TD align=middle width=180 background=../images/new_011.jpg height=15></TD>
    	<TD width=15><IMG src="../images/new_012.jpg" border=0></TD>
	</TR>
</TABLE>
</form>

<%	
	}
%>

