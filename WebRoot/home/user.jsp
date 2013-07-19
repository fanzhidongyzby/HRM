<%@ page language="java" import="java.util.*"  import="model.*" import="dao.*"  pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>模板</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="images/Style.css" type=text/css rel=stylesheet><LINK 
href="images/Manage.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/FrameDiv.js"></SCRIPT>

<SCRIPT language=javascript src="images/Common.js"></SCRIPT>

<SCRIPT language=javascript>
function  selectAll(flag) {
    var  arrObj  = document.all; 
    if(flag) {
       for(var  i  =  0;  i  <  arrObj.length;i++)  
       {  
           if(typeof  arrObj[i].type  !=  "undefined"  &&  arrObj[i].type=='checkbox')
		      arrObj[i].checked = true;  

	   }
    }  
    else {
       for(var  i  =  0;  i  <  arrObj.length;i++)  
       {  
           if(typeof  arrObj[i].type  !=  "undefined"  &&  arrObj[i].type=='checkbox')
		      arrObj[i].checked = false;  

	   }
    }
}  
    </SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>

<%
	if(((user)session.getAttribute("user")).getUserRole()==1)//SA
	{		
		user ut=null;
		int i=ut.getStaffID();
	}
%>


<FORM id=form1 name=form1 
action=YHChannelApply.aspx?pages=4&amp;item=&amp;client=&amp;flag=0&amp;start=&amp;end=&amp;channel= 
method=post>
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
	userDao ud=new userDao();
	deptDao dd=new deptDao();
	ArrayList<user> allUser=ud.findAll();
	Iterator<user> it=allUser.iterator();
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
          <TD >用户管理</TD>
		  <td align="right"><input type="button" name="Submit" value="添加" onClick="javascript:location.href='userEdit.jsp?opp=add'">
		  </td>
		 </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!--个人资料-->
		  <TABLE  border="1" align="center"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
		  	<tr height="25" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
				<td width="14%" >用户名</td>
				<td width="15%">密码</td>
				<td width="9%" >角色</td>
				<td width="52%" >负责部门</td>
				<td width="10%"  >操作</td>
			</tr>	
<%
	user u;
	String r="Admin";
	while(it.hasNext())
	{
		u=it.next();
		if(u.getUserRole()==0)
			r="SuperAdmin";
		else
			r="Admin";
%>
		<tr height="35" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
			<td><a href="staffDetail.jsp?staffId=<%=u.getStaffID() %>"><%=u.getUserName() %></a></td>
			<td><%=u.getPassword() %></td>
			<td><%=r %></td><td>

<%
		String ids=u.getDeptIDs();
		if(u.getUserRole()==0)//SA
			ids="1";//最高
		if(ids==null)	
			ids="";		
		StringTokenizer token=new StringTokenizer(ids,"-");
		while(token.hasMoreTokens())
		{
			int id=Integer.parseInt(token.nextToken());
			department dept=dd.findByID(id);
%>
			<a href="../departMgr?deptId=<%=id %>"><%=dept.getDeptName() %></a>&nbsp;
<%	
		}
%>
			</td><td><input name="user" type="checkbox" value="<%=u.getUserName() %>">
		<input name="editStaff" type="button" value="编辑" onClick="javascript:location.href='userEdit.jsp?opp=edit&name=<%=u.getUserName() %>'">
			</td>
		</tr>
<%		
	}
%>				
		  </TABLE>
		  <br>
		  <table border="0" align="center"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
		  <tr><TD align=right colspan="10" height=25><INPUT onclick="selectAll(this.checked)"; type=checkbox name=checkAll>全选
			<input type="button" name="del" value="批量删除" onClick='deleteSum();'></TD></tr>
		  </table>	  
      </TD>
    <TD width=15 background=images/new_023.jpg><IMG 
      src="images/new_023.jpg" border=0> </TD></TR></TBODY></TABLE>
<script type="text/javascript">
function deleteSum()
{
	var checkList=document.getElementsByName("user");	
	var nameList="";
	var k=0;
	for(var i=0;i<checkList.length;i++)
	{
		if(checkList[i].checked==true)
		{
			nameList+=checkList[i].value+"-";
			k++;
		}
	}
	if(k==0)
	{
		alert("请先选择要删除的用户。");
		return ;
	}
	if(confirm("将要删除当前"+k+"个用户，确定这么做吗？"))
	{
		window.location.href='../ActionServlet?actionPath=user&opp=delete&args='+nameList;
	}
}
</script>

<TABLE  align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
  <TBODY>
  <TR>
    <TD width=15><IMG src="images/new_024.jpg" border=0></TD>
    <TD align=middle width="100%" background=images/new_025.jpg 
    height=15></TD>
    <TD width=15><IMG src="images/new_026.jpg" 
  border=0></TD></TR></TBODY></TABLE>
</FORM></BODY></HTML>
