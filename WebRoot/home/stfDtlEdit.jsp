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

　var xmlHttp;//这就是传说中的Ajax 
　　function createXMLHttpRequest() {
　　if (window.ActiveXObject) {
　　xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
　　}
　　else if (window.XMLHttpRequest) {
　　xmlHttp = new XMLHttpRequest();
　　}
　　}
　　function deptVerify(dept) {
    if(dept=="") return;
　　createXMLHttpRequest();
　　var url = "../ActionServlet?actionPath=staff&command=deptVerify&deptName=" + dept;
　　xmlHttp.open("post", url, true);
　　xmlHttp.onreadystatechange = callback;
　　xmlHttp.send(null);
　　}
	function callback() 
	{
	　　if (xmlHttp.readyState == 4) 
		{
	　　		if (xmlHttp.status == 200) 
			{
			    var msg =xmlHttp.responseXML.getElementsByTagName("verify")[0].firstChild.data;
			    if(msg=="illegal"){
			    alert("部门不存在，请重新输入！");
			    document.all.newDept.value="";
			    document.all.newDept.focus();
			    }
			
		　　}
		}
	}
       
       function editStaff(staffId){
          document.forms[0].action="/HRM/ActionServlet?command=editStaff&staffID=" + staffId;
		  document.forms[0].method="post";
		  document.forms[0].submit();
       }
        function newStaff(){
          if(document.all.dept.value==""){
           alert("请输入新部门！");
           document.all.dept.focus();
           }else{
          document.forms[0].action="/HRM/ActionServlet?command=newStaff";
		  document.forms[0].method="post";
		  document.forms[0].submit();
		  }
       }
       
    </SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>
<form id="form1" name="form1" method="post" action="/HRM/ActionServlet">
     <input type="hidden" id="actionPath" name="actionPath" value="staff"/>

<SCRIPT type=text/javascript>

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
<%  String flag="editStaff";
    staffDao sd=new staffDao();
    staff s = new staff();
    String deptName = "";
	int staffId=Integer.parseInt(request.getParameter("staffId"));
	if(staffId==0){
	flag="newStaff";
	}else{

	s=(staff)sd.findByID(staffId);
	int deptId=s.getDeptID();

 	ArrayList<department> dir=new ArrayList<department>();
 	deptDao dd=new deptDao();
 	department dept;
	int curDeptId=deptId;
	dept=dd.findByID(curDeptId);//当前
	deptName=dept.getDeptName();//获取名字
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
<%} %>

&gt;&nbsp;<%=(flag=="editStaff")?s.getStaffName():"" %>&nbsp;
[<%if(flag=="editStaff"){ %><a href="staffDetail.jsp?staffId=<%=s.getStaffID() %>">个人信息</a><%}else {%>个人信息<%} %>&nbsp;&gt;&nbsp;信息编辑：<%=(flag=="editStaff")?s.getStaffName():"新员工" %>]
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
					String t_affi=new deptDao().findByID(nowId).getDeptAffi();
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
		  <td align="right">
		  <%if(flag=="editStaff"){ %>
		  <input name="ok" type="button" value="保存" onClick="editStaff(<%=staffId %>)">
		    <input name="cancel" type="button" value="取消" onClick="location.href='staffDetail.jsp?staffId=<%=staffId %>'" >
          <%}else{ %>
          <input name="ok" type="button" value="保存" onClick="newStaff()">
          <input name="cancel" type="button" value="取消" onClick="location.href='deploy.jsp'" >
          <%} %>
        </td></TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!--个人资料-->
		  <table width="386" border="0" align="center" bgcolor="eeeeee">
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="left">&nbsp;</td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td width="10" align="center" valign="middle">&nbsp;</td>
              <td width="127" align="center" valign="middle">编号</td>
              <td width="190" align="left"><input name="staffNum" id ="staffNum" align='center' value="<%=(flag=="editStaff")?s.getStaffNum():"" %>" <%if(flag=="editStaff"){ %>disabled<%} %> /></td>
              <td width="41" align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">姓名</td>
              <td align="left"><input name="staffName" id="staffName" align='center' value="<%=(flag=="editStaff")?s.getStaffName():"" %>" <%if(flag=="editStaff"){ %>disabled<%} %> /></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">性别</td>
			<td align="left">
			<%if(flag=="newStaff"){ %>
			<input type="radio" name="radiobutton" value="0" checked/>女
            <input type="radio" name="radiobutton" value="1"/>男
            <%}else{ %>
            <input type="hidden" name="sex" value="<%=s.getSex() %>"/>
<%
	if(s.getSex()==0)
	{
	%>
		<input type="radio" name="radiobutton" value="0" checked disabled/>女
        <input type="radio" name="radiobutton" value="1" disabled/>男
	<%
	}else{
	%>
		<input type="radio" name="radiobutton" value="0" disabled/>女
        <input type="radio" name="radiobutton" value="1" checked disabled/>男
	<%
	}
 %><%} %>
			</td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">年龄</td>
              <td align="left"><input name="age" id="age" align='center' value="<%=(flag=="editStaff")?s.getAge():"" %>" /></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">部门</td>
              <td align="left"><input type="text" name="dept" value="<%=deptName %>" onBlur="deptVerify(this.value)"></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">职务</td>
              <td align="left"><input type="text" name="pos" value="<%=(flag=="editStaff")?s.getPosition():"" %>"></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">学历</td>
              <td align="left"><input type="text" name="eduBk" value="<%=(flag=="editStaff")?s.getEduBack():"" %>"></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">学位</td>
              <td align="left"><input type="text" name="degree" value="<%=(flag=="editStaff")?s.getDegree():"" %>"></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">技术</td>
              <td align="left"><input type="text" name="tech" value="<%=(flag=="editStaff")?s.getTech():"" %>"></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">工资</td>
              <td align="left"><input type="text" name="salary" value="<%=(flag=="editStaff")?s.getSalary():"" %>"></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">状态</td>
              <td align="left"><input type="text" name="status" value="<%=(flag=="editStaff")?s.getStatus():"" %>"></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">社保</td>
              <td align="left"><input type="text" name="socSec" value="<%=(flag=="editStaff")?s.getSocSec():"" %>"></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">个人照片</td>
              <td align="left"><label></label>
                <label>
                <input type="button" name="up_head" value="上传头像">
              </label></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">证书图片</td>
              <td align="left"><label><input type="button" name="up_cert" value="上传证书"></label></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="left">&nbsp;</td>
              <td align="center">&nbsp;</td>
            </tr>
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
</FORM></BODY></HTML>
