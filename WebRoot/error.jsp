<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>����</title>
    <LINK 
href="./home/images/Style.css" type=text/css rel=stylesheet>


	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
<br><br><br><br><br><br><br><br><br><br>
<table width="40%" align="center">
	<tr>
		<td align="right" rowspan="2"><IMG src="login_files/error.gif" width="144" height="125"></td>	
	  <td  height="69"><font color="red">�ܱ�Ǹ��������ַ������������ƴд���ٳ��ԡ�</font></td>		
	</tr>
	<tr><td align="center"><a href="login.jsp">����</a></td></tr>
</table>
  </body>
</html>
