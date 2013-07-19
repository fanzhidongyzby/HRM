<%@ page language="java" import="java.util.*" import="model.user" pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>顶部</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<STYLE type=text/css>BODY {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BACKGROUND-COLOR: #2a8dc8
}
BODY {
	FONT-SIZE: 12px; COLOR: #003366; FONT-FAMILY: 微软雅黑
}
TD {
	FONT-SIZE: 12px; COLOR: #003366; FONT-FAMILY: 微软雅黑
}
DIV {
	FONT-SIZE: 12px; COLOR: #003366; FONT-FAMILY: 微软雅黑
}
P {
	FONT-SIZE: 12px; COLOR: #003366; FONT-FAMILY: 微软雅黑
}
</STYLE>
<% 	
	user usr=(user)session.getAttribute("user");
	String welMsg="欢迎";
	if(usr.getUserRole()==0)
		welMsg+="超级";
	welMsg+="管理员";
	String timeMsg="，";
	Calendar c=Calendar.getInstance();
	int h=c.get(Calendar.HOUR_OF_DAY);
	if(h>=6&&h<12)
		timeMsg+="上午";
	else if(h>=12&&h<18)
		timeMsg+="下午";
	else if(h>=18&&h<24)
		timeMsg+="晚上";
	else
		timeMsg+="凌晨";
	timeMsg+="好！";
	
 %>
<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>
<FORM id=form1 name=form1 action=YHTop.aspx method=post>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD width=10><IMG src="../images/new_001.jpg" border=0></TD>
    <TD background=../images/new_002.jpg><FONT size=5 style="font-family:宋体" ><B>人力资源管理系统 
      管理中心</B></FONT> </TD>
    <TD background=../images/new_002.jpg>
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR>
          <TD align=right height=35><%=welMsg %><a href="../staffDetail.jsp?staffId=<%=usr.getStaffID() %>" target="dmMain"><%=usr.getUserName() %></a><%=timeMsg %></TD></TR>
        <TR>
          <TD height=35 align="right"><A href="../../ActionServlet?actionPath=logout" target="_parent"><FONT color="black"><B>安全退出</B></FONT></A> 
      </TD></TR></TBODY></TABLE></TD>
    <TD width=10><IMG src="../images/new_003.jpg"
border=0></TD></TR></TBODY></TABLE></FORM></BODY></HTML>
