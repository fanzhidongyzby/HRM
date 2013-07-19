<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="model.*" import="util.*" import="dao.*"%>
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

当前位置：&nbsp;
<%
	int staffId=Integer.parseInt(request.getParameter("staffId"));
	List<contract> ctrList = null;
	contract oneCtr = new contract();
	contractDao ctrDao = new contractDao();
	ctrList = ctrDao.findAll(staffId);
	
	staffDao sd=new staffDao();
	staff s=(staff)sd.findByID(staffId);
	int deptId=s.getDeptID();

 	ArrayList<department> dir=new ArrayList<department>();
 	deptDao dd=new deptDao();
 	department dept;
	int curDeptId=deptId;
	dept=dd.findByID(curDeptId);//当前
	String deptName=dept.getDeptName();//获取名字
	dir.add(dept);
	String affi=dept.getDeptAffi();
	StringTokenizer token=new StringTokenizer(affi,"-");//获取父子部门ID
	department parentDept=null;//父部门
	if(token.hasMoreTokens())
	{
		parentDept=dd.findByID(Integer.parseInt(token.nextToken()));
	}
	while(parentDept!=null)//有父部门继续添加
	{
		dir.add(parentDept);
		dept=dd.findByID(parentDept.getDeptID());
		affi=dept.getDeptAffi();
		token=new StringTokenizer(affi,"-");//获取父子部门ID
		if(token.hasMoreTokens())
		{
			parentDept=dd.findByID(Integer.parseInt(token.nextToken()));
		}
	}
	//逆序输出各个含有子部门的 部门
	for(int i=dir.size()-1;i>=0;i--)
	{
		if(i!=dir.size()-1)//不是第一个位置
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

&gt;&nbsp;<%=s.getStaffName() %>&nbsp;
[<a href="staffDetail.jsp?staffId=<%=s.getStaffID() %>">个人信息</a>&nbsp;&gt;&nbsp;工作合同]



</TD>
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
			int oneDeptId=Integer.parseInt(testToken.nextToken());//测试ID
			//迭代ID
			while(nowId!=0)
			{
				if(nowId==oneDeptId)
				{
					hasValid=true;
					break;
				}
				else
				{
					//向上找
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
		  <%if(hasValid){ %>
		  <input type="button" name="Submit" value="添加" onClick="javascript:location.href='contractEdit.jsp?staffId=<%=staffId %>&opp=add'">
		  <%} %>
		  </td>
		 </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!--个人资料-->
		  <TABLE  border="1" align="center"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
		  	<tr height="25" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
				<td width="13%" >合同编号</td>
				<td width="15%">开始日期</td>
				<td width="13%" >结束日期</td>
				<td width="6%" >职务</td>
				<td width="33%" >内容</td>
				<td width="13%" >备注</td>
				<td width="7%"  >操作</td>
			</tr>	
<%Iterator<contract> it = ctrList.iterator();
            while(it.hasNext()){
               oneCtr = it.next();
               String com=oneCtr.getConCom();
               if(com==null)
               		com="";
               %>
		<tr height="35" align="center" style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
			<td><%=oneCtr.getConNum() %></td>
			<td><%=oneCtr.getStartDate()%></td>
			<td><%=oneCtr.getEndDate() %></td>
			<td><%=oneCtr.getStfPos() %></td>
			<td ><%=oneCtr.getConCont() %></td>
			<td><%=com %></td><td>
				<input name="checkCtr" type="checkbox" <%if(!hasValid){ %>disabled<%} %> 	 value="<%=oneCtr.getConID() %>"/>
				<input name="editStaff" type="button" value="编辑" <%if(!hasValid){ %>disabled<%} %>
			onClick="javascript:location.href='contractEdit.jsp?staffId=<%=staffId %>&opp=edit&ctrId=<%=oneCtr.getConID() %>'"/>
			</td>
		</tr>		
			
			<%} %>
		  </TABLE><br>
		  <table border="0" align="center"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
		  <tr><TD align=right colspan="10" height=25>
<INPUT onclick="selectAll(this.checked)"; type=checkbox <%if(!hasValid){ %>disabled<%} %> name=checkAll />全选
			<input type="button" name="del" value="批量删除" <%if(!hasValid){ %>disabled<%} %> onclick='deleteSum();'/></TD></tr>
		  </table>	  
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
</FORM></BODY>
<script type="text/javascript">
function deleteSum()
{
	var checkList=document.getElementsByName("checkCtr");	
	var idList="";
	var k=0;
	for(var i=0;i<checkList.length;i++)
	{
		if(checkList[i].checked==true)
		{
			idList+=checkList[i].value+"-";
			k++;
		}
	}
	if(k==0)
	{
		alert("请先选择要删除的合同。");
		return ;
	}
	if(confirm("将要删除当前用户的"+k+"支合同，确定这么做吗？"))
	{
		window.location.href='../ActionServlet?actionPath=contract&opp=delete&staffId=<%=staffId%>&args='+idList;
	}
}
</script>

</HTML>
