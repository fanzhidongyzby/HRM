<%@ page language="java" import="java.util.*"  import="model.*" import="dao.*"  pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>模板</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gbk"><LINK 
href="images/Style.css" type=text/css rel=stylesheet><LINK 
href="images/Manage.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/FrameDiv.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="images/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=javascript src="images/Common.js"></SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR>
<style type="text/css">
<!--
.STYLE1 {font-size: 24px}
-->
</style>
</HEAD>


<script type="text/javascript">
var childWindow=null;
function opp(oppCode,args)
{	
　　childWindow=window.open ("./dialog.jsp?oppCode="+oppCode+"&args="+args, "newwindow", "height=100, width=320, top=280,  left=500, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
}

</script>



<BODY>
<FORM id=form1 name=form1 
method=post>

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
          <TD width="66%" >机构设置：&nbsp;
<%
 	ArrayList<department> dir=new ArrayList<department>();
 	deptDao dd=new deptDao();
 	department dept;
	int curDeptId=Integer.parseInt(session.getAttribute("deptId").toString());	
	dept=dd.findByID(curDeptId);//当前
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
	for(int i=dir.size()-1;i>0;i--)
	{
		if(i!=dir.size()-1)//不是第一个位置
		{
%>
			&gt;&nbsp;
<%					
		}
%>

		<a
		href="../departMgr?deptId=<%=dir.get(i).getDeptID() %>" 
		>
		<%=dir.get(i).getDeptName() %></a>&nbsp;
<%			
	}
	//第一个添加的即最后一个部门看是否有下一级在处理	
	//判断输出最后一个节点部门
	if(dir.size()!=1)//顶级部门
	{
%>
		&gt;&nbsp;
<%	
	}
%>
<%=dir.get(0).getDeptName() %>&nbsp;

</TD>
		  <td width="34%" align="right">
		  	<input type="button" name="Submit" value="移动当前机构" onClick='opp(3,"");'>
		  	<input type="button" name="Submit4" value="添加隶属机构" onClick="opp(1,'');">
		  	<input type="button" name="Submit2" value="编辑当前机构" onClick="opp(2,'');"></td>
        </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!-- 代码 -->
		  <table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tbody>
<%
	dept=dd.findByID(curDeptId);
	affi=dept.getDeptAffi();
	token=new StringTokenizer(affi,"-");//获取父子部门ID
	int size=token.countTokens();
	if(token.hasMoreTokens())
	{
		token.nextToken();
	}
 %>
    <tr>
      <td width="47%" height="60" align="right" valign="middle"><img src="./images/quan.gif" width="15" height="15" align="center" /></td>
	  <td width="53%" height="60" align="left" valign="middle"><div align="left"><span class="STYLE5 STYLE1"> <font color="#FF0000"><%=dept.getDeptName() %></font></span></div></td>
    </tr>
    <tr>
      <td align="center" colspan="2"><img src="./images/sep_short.gif" width="100%" height="1" /></td>
    </tr>
    <tr height="10">
      <td></td>
    </tr>
    <tr>
      <td align="center" colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tbody>
            <tr>
              <td align="right" valign="baseline">&nbsp;</td>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="right" valign="baseline">&nbsp;</td>
              <td align="right" valign="middle">&nbsp;</td>
              <td align="left" valign="baseline">&nbsp;</td>
            </tr>
<%
	department child=null;	
	int i=1;
	while(token.hasMoreTokens())
	{
		child=dd.findByID(Integer.parseInt(token.nextToken()));
		if(child==null)//没有子部门
		{
%>
			<tr>
			<td align="center">该部门下当前无子部门，请尝试添加子部门，或兼并其他部门。</td>
			</tr>
			<tr height=25>
			  <td align="right" valign="baseline">&nbsp;</td>
			  <td valign="middle">&nbsp;</td>
			  <td align="right" valign="baseline">&nbsp;</td>
			  <td align="left" valign="middle">&nbsp;</td>
		      <td align="left" valign="baseline">&nbsp;</td>
		</tr>
<%			
			break;
		}
		if(i%2!=0)//左边
		{
%>
			<tr>
              <td width="330" align="right" valign="baseline">
              <input type="checkbox" name="deptId" value="<%=child.getDeptID() %>" /></td>
              <td width="450" align="left" valign="middle">
			  <div align="left"><img src="./images/arrow.gif" width="9" height="10" /> 
			  <a href="../departMgr?deptId=<%=child.getDeptID() %>" >
			  <%=child.getDeptName() %></a></div></td>
<%	
			if(i==size-1)//最后一个
			{
%>
				</tr>
			<tr height=25>
			  <td colspan="10">&nbsp;</td>
			</tr>
<%				
			}
		}
		else//右边
		{
%>
			<td width="40" align="right" valign="baseline">              
              <input type="checkbox" name="deptId" value="<%=child.getDeptID() %>" /></td>
              <td width="370" align="left" valign="middle">
			  <div align="left">
			  <img src="./images/arrow.gif" width="9" height="10" />
			  <a href="../departMgr?deptId=<%=child.getDeptID() %>" >
			  <%=child.getDeptName() %></a></div></td>
              <td width="10" align="left" valign="baseline">&nbsp;</td>   
			</tr>
			<tr height=25>
			  <td colspan="10">&nbsp;</td>
			</tr>         
<%		
		}
		i++;
	}
%>            
            
              
              
			
			
          </tbody>
      </table>	  </td>
    </tr>
	<tr>
      <td align="center" colspan="2"><img src="./images/sep_short.gif" width="100%" height="1" /></td>
    </tr>
	<tr height="20">
      
    </tr>
	<tr>
      <td align="right" colspan="2"><input type="checkbox" name="checkAll" value="checkbox" onClick="selectAll(this.checked)" />
      全选
        <input type="button" name="Submit3" value="合并" onClick="BindDept();">
      <input name="" type="button" value="删除" onClick="DeleteDept();"></td>
    </tr>
  </tbody>
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
</FORM>
</BODY>
<script type="text/javascript">
function  selectAll(flag) {
    var  arrObj  = document.all; 
    for(var  i  =  0;  i  <  arrObj.length;i++)  
       { 
           if(typeof  arrObj[i].type  !=  "undefined"  &&  arrObj[i].type=='checkbox' && arrObj[i].name=='deptId')
		      arrObj[i].checked = flag;  

	   }
}
function BindDept()
{
	var checkList=document.getElementsByName("deptId");	
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
	if(k<2)//低于两个部门，不能执行合并
	{
		alert("请至少选择两个部门进行合并");
		return ;
	}
	if(confirm("将要当前"+k+"个部门合并为一个部门，确定这么做吗？"))
	{
		opp(4,idList);
	}
}
function DeleteDept()
{
	var checkList=document.getElementsByName("deptId");	
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
		alert("请先选择要删除的部门。");
		return ;
	}
	if(confirm("将要删除当前"+k+"个部门，确定这么做吗？"))
	{
		window.location.href='../ActionServlet?actionPath=department&oppCode=5&args='+idList;
	}
}
</script>
</HTML>
