<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>上传图片</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <%
  	int staffId=Integer.parseInt(request.getParameter("staffId"));
  	String type=request.getParameter("type");
  	session.setAttribute("staffId",staffId);
  	session.setAttribute("type",type);
  	//System.out.println(staffId+"  "+type);
   %>
  <body bgcolor='lightGray'>
  <table width="60%" align="center">
	<tr height="30"></tr>
  	<tr>

	</tr>
	<tr><td align="center">
	<FORM if="form1" METHOD="post" ACTION="home/upLoad" ENCTYPE="multipart/form-data">
<INPUT TYPE="file" NAME="image">
<INPUT TYPE="submit" value="上传文件"  > </FORM>
	</td></tr>
<tr>
</tr>
  </table>
    
  </body>
</html>
