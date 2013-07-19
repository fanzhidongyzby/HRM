<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<LINK 
href="images/Style.css" type=text/css rel=stylesheet>

<%
	int oppCode=0;
	String title="";
	String tips="";
	if(request.getParameter("oppCode")!=null)
	{
		oppCode=Integer.parseInt(request.getParameter("oppCode"));
		switch(oppCode)
		{
		case 1:
			title="添加部门";
			tips="请输入新的部门的名称：";			
			break;
		case 2:
			title="编辑部门";
			tips="请输入该部门新名称：";
			break;
		case 3:
			title="移动部门";
			tips="移动至部门的名称为：";
			break;
		case 4:
			title="合并部门";
			tips="合并后的新部门的名称为：";
			break;
		case 5:
			title="删除部门";
			tips="请保证删除部门下无在职人员。";
			break;
		}
	}
	String args="";
	if(request.getParameter("args")!=null)
	{
		args=request.getParameter("args");
	}
 %>


  <head>
    <base href="<%=basePath%>">
    
    <title><%=title %></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
<script type="text/javascript">
	function valid()
	{
		var t=document.all.msg.value;
		if(t!="")
		{
			document.all.form1.submit();
		}
		else
		{
			var tip=document.all.tips;
			tip.innerHTML="<font color='white'>提交前请正确填写信息。</font>";
			tip.style.display="block";
		}
	}
</script>
  <body bgcolor='lightgray'>
<FORM id=form1 name=form1 method=post action='ActionServlet?oppCode=<%=oppCode %>&args=<%=args %>'>
          <input type="hidden" id="actionPath" name="actionPath" value="department"/>
	<table width="103%" align="center">	
		<tr align="center">
		<td width="13%">&nbsp;</td>
		<td width="55%" align="left" valign="middle"><%=tips %></td>
		<td width="32%" align="left"><input type="button" name="Submit" value="确定" onclick='valid();' /></td>
		</tr>
		<tr align="center">
		<td>&nbsp;</td><td align="left"><input name="msg" type="text" /></td><td align="left"><input type="reset" name="Reset" onClick='javascript:window.close();' value="取消" /></td>
		</tr>
		<tr align="center">
		<td>&nbsp;</td>
		<td colspan="2" align="left"><div align="left" id="tips" style="display:none"><font color="white">该名称的部门不存在</font></div></td>
		</tr>
	</table>
</form>
  </body>
</html>
