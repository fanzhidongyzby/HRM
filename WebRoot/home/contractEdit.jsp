<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="model.*" import="util.*" import="dao.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>模板</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="images/Style.css" type=text/css rel=stylesheet><LINK 
href="images/Manage.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/FrameDiv.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="images/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=javascript src="images/Common.js"></SCRIPT>

<SCRIPT language=javascript>
        function selectallbox()
        {
            var list = document.getElementsByName('setlist');
            var listAllValue='';
             if(document.getElementById('checkAll').checked)
             {
                  for(var i=0;i<list.length;i++)
                  {
                    list[i].checked = true;
                    if(listAllValue=='')
                        listAllValue=list[i].value;
                    else
                        listAllValue = listAllValue + ',' + list[i].value;
                  }
                  document.getElementById('boxListValue').value=listAllValue;
             }
             else 
             {
                  for(var i=0;i<list.length;i++)
                  {
                    list[i].checked = false;
                  }
                  document.getElementById('boxListValue').value='';
             }
         } 
    </SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>

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
	String opp=request.getParameter("opp");
	boolean isAdd="add".equals(opp);
	contractDao cd=new contractDao();
	contract c=null;
	String title="";
	if(isAdd)//添加
	{
		c=new contract();
		title="添加合同";
	}
	else
	{
		c=cd.findByID(Integer.parseInt(request.getParameter("ctrId")));
		title="编辑合同："+c.getConNum();
	}
%>
<%
	int staffId=Integer.parseInt(request.getParameter("staffId"));
	
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
[<a href="staffDetail.jsp?staffId=<%=s.getStaffID() %>">个人信息</a>
&nbsp;&gt;&nbsp;<a href="contract.jsp?staffId=<%=staffId %>">工作合同</a>&nbsp;&gt;&nbsp;<%=title %>]</TD>
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
	
	if(!hasValid)
	{
		user us=null;
		us.getPassword();
	}
 %>
		  <td align="right"><input type="button" name="save" value="保存"  onclick='valid();'>
		    <label>
		    <input type="button" name="cancel" value="取消" onClick="location.href='contract.jsp?staffId=<%=staffId %>';">
		    </label>		  </td>
		 </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!--个人资料-->


<FORM id=form1 name=form1 method=post action="../ActionServlet?opp=<%=opp%>&staffId=<%=staffId %>&ctrId=<%=c.getConID() %>">
<input type="hidden" id="actionPath" name="actionPath" value="contract" />
		  <table width="390" height="204" border="0" align="center" bgcolor="eeeeee">
            <tr>
              <td height="22" align="center" valign="middle">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="22" align="center" valign="middle">合同编号</td>
              <td><label>
<%
	if(!isAdd)
	{
%>
		<input type="text" name="ctrNum" value="<%=c.getConNum() %>" readonly />
<%	
	}else{
%>
		<input type="text" name="ctrNum" value="" />	
<%	} %>
                
              </label></td>
            </tr>
            <tr>
              <td width="100" height="22" align="center" valign="middle">开始日期</td>
              <td width="280"><label>
<%
	if(!isAdd)
	{
%>
		 <input class="Wdate" name="ctrStartDate" type="text" value="<%=c.getStartDate() %>" onClick="WdatePicker()">
<%	
	}else{
%>
		 <input class="Wdate" name="ctrStartDate" type="text" value="" onClick="WdatePicker()">
<%	} %>
                
              </label></td>
            </tr>
            <tr>
              <td height="18" align="center" valign="middle">结束日期</td>
              <td><label>
<%
	if(!isAdd)
	{
%>
		 <input class="Wdate" name="ctrEndDate" type="text" value="<%=c.getEndDate() %>" onClick="WdatePicker()"> 
<%	
	}else{
%>
		 <input class="Wdate" name="ctrEndDate" type="text" value="" onClick="WdatePicker()"> 
<%	} %>
                
              </label></td>
            </tr>
            <tr>
              <td height="18" align="center" valign="middle">职务</td>
              <td><label>
<%
	if(!isAdd)
	{
%>
		<input type="text" value="<%=c.getStfPos() %>" name="pos"> 
<%	
	}else{
%>
		<input type="text" value="" name="pos"> 
<%	} %>
                
              </label></td>
            </tr>
            <tr>
              <td height="53" align="center" valign="middle" bgcolor="eeeeee">内容</td>
              <td><label>
<%
	if(!isAdd)
	{
%>
		<textarea name="cont"  cols="40" rows="3"><%=c.getConCont() %></textarea> 
<%	
	}else{
%>
		<textarea name="cont"  cols="40" rows="3"></textarea> 
<%	} %>
                
              </label></td>
            </tr>
            <tr>
              <td height="17" align="center" valign="middle">备注</td>
              <td><label>
<%
	if(!isAdd&&c.getConCom()!=null)
	{
%>
		<textarea name="com" cols="40" rows="3"><%=c.getConCom() %></textarea> 
<%	
	}else{
%>
		<textarea name="com" cols="40" rows="3"></textarea> 
<%	} %>
                
              </label></td>
            </tr>
            <tr>
              <td height="14" align="center" valign="middle">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table></FORM>
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
</BODY>
<script type="text/javascript">
function valid()
{
	var num=document.all.ctrNum.value;
	var s=document.all.ctrStartDate.value;
	var e=document.all.ctrEndDate.value;
	var po=document.all.pos.value;
	var con=document.all.cont.value;
	var tips="";
	if(num=="")
		tips="合同编号不能为空。";
	else if(s=="")
		tips="起始时间不能为空。";
	else if(e=="")
		tips="结束时间不能为空。";
	else if(po=="")
		tips="职务不能为空";
	else if(con=="")
		tips="合同内容不能为空。";
	if(tips=="")
	{
		document.all.form1.submit();
	}
	else
	{
		alert(tips);
	}
}
</script>
</HTML>
