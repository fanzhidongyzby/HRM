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
          <TD width="88%" >


当前位置：&nbsp;
<%
	String opp=request.getParameter("opp");
	boolean isAdd="add".equals(opp);
	docDao docd=new docDao();
	document doc=null;
	String title="";
	if(isAdd)//添加
	{
		doc=new document();
		title="添加档案";
	}
	else
	{
		doc=docd.findByID(Integer.parseInt(request.getParameter("docId")));
		title="编辑档案："+doc.getDocNum();
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
&nbsp;&gt;&nbsp;<a href="doc.jsp?staffId=<%=staffId %>">员工档案</a>&nbsp;&gt;&nbsp;<%=title %>]




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
	
	if(!hasValid)
	{
		user us=null;
		us.getPassword();
	}
 %>
		  <td width="12%" align="right"><input type="button" name="save" value="保存" onclick='valid();'>
		    <label>
		    <input type="button" name="cancel" value="取消" onClick="location.href='doc.jsp?staffId=<%=staffId %>';">
		    </label>		  </td>
		 </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!--个人资料-->
<FORM id=form1 name=form1 method=post action="../ActionServlet?opp=<%=opp%>&staffId=<%=staffId %>&docId=<%=doc.getDocID() %>">
<input type="hidden" id="actionPath" name="actionPath" value="document" />
		  <table width="390" height="204" border="0" align="center" bgcolor="eeeeee">
            <tr>
              <td height="22" align="center" valign="middle">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="22" align="center" valign="middle">档案编号</td>
              <td><label>
<%
	if(!isAdd)
	{
%>
		<input type="text" name="docNum" value="<%=doc.getDocNum() %>" readonly />
<%	
	}else{
%>
		<input type="text" name="docNum" value=""  />
<%	} %>
           
              </label></td>
            </tr>
            <tr>
              <td width="100" height="22" align="center" valign="middle">档案名称</td>
              <td width="280"><label>
<%
	if(!isAdd)
	{
%>
		<input type="text" name="docName" value="<%=doc.getDocName() %>" />
<%	
	}else{
%>
		<input type="text" name="docName" value="">
<%	} %>
                
              </label></td>
            </tr>
            
            <tr>
              <td height="53" align="center" valign="middle" bgcolor="eeeeee">内容摘要</td>
              <td><label>
<%
	if(!isAdd&&doc.getDocAbs()!=null)
	{
%>
		<textarea name="docAbs" cols="40" rows="3"><%=doc.getDocAbs() %></textarea>
<%	
	}else{
%>
		<textarea name="docAbs" cols="40" rows="3"></textarea>
<%	} %>
                
              </label></td>
            </tr>
            <tr>
              <td height="17" align="center" valign="middle">备注</td>
              <td><label>
<%
	if(!isAdd&&doc.getDocCom()!=null)
	{
%>
		<textarea name="docCom" cols="40" rows="3"><%=doc.getDocCom() %></textarea>
<%	
	}else{
%>
		<textarea name="docCom" cols="40" rows="3"></textarea>
<%	} %>
                
              </label></td>
            </tr>
            <tr>
              <td height="14" align="center" valign="middle">类别</td>
              <td><label>
                <select name="docType" id="docType"  >
                  <option value="0">选择</option>
                  <option value="1" <%if("进修".equals(doc.getDocType())){%>selected<%} %>>进修</option>
                  <option value="2" <%if("处分".equals(doc.getDocType())){%>selected<%} %>>处分</option>
                  <option value="3" <%if("奖励".equals(doc.getDocType())){%>selected<%} %>>奖励</option>
                  <option value="4" <%if("其他".equals(doc.getDocType())){%>selected<%} %>>其他</option>
                </select>
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
	var num=document.all.docNum.value;
	var name=document.all.docName.value;
	var docType=document.all.docType.value;
	var tips="";
	if(num=="")
		tips="档案编号不能为空。";
	else if(name=="")
		tips="档案名称不能为空。";
	else if(docType=="0")
		tips="请选择档案类型。";
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
