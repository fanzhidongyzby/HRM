<%@ page language="java" import="java.util.*"  import="model.*" import="dao.*"  pageEncoding="gbk"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<STYLE type=text/css>BODY {
	FONT-SIZE: 12px; COLOR: #ffffff; FONT-FAMILY: 微软雅黑
}
TD {
	FONT-SIZE: 12px; COLOR: #ffffff; FONT-FAMILY: 微软雅黑
}
</STYLE>
<title>登录</title>
<META content="MSHTML 6.00.6000.16809" name=GENERATOR></HEAD>
<BODY>



<DIV id=UpdatePanel1> 	
<DIV id=div1 
style="LEFT: 0px; POSITION: absolute; TOP: 0px; BACKGROUND-COLOR: #0066ff"></DIV>
<DIV id=div2 
style="LEFT: 0px; POSITION: absolute; TOP: 0px; BACKGROUND-COLOR: #0066ff"></DIV>

<%
	user u=(user)session.getAttribute("user");
	if(u!=null)//有用户会话
	{
		response.sendRedirect("home/index.jsp");
	}
%>
<DIV>&nbsp;&nbsp; </DIV>
<DIV>


<TABLE cellSpacing=0 cellPadding=0 width=900 align=center border=0>
  <TBODY>
  <TR>
    <TD style="HEIGHT: 105px"><IMG src="login_files/login_1.gif" 
  border=0></TD></TR>
  <TR>
    <TD background=login_files/login_2.jpg height=300>


      <TABLE height=300 cellPadding=0 width=900 border=0>
        <TBODY>
        <TR>
          <TD colSpan=2 height=35></TD></TR>
        <TR>
          <TD width=360></TD>
          <TD>
          <FORM id=form1 name=form1 method=post action=ActionServlet>
          <input type="hidden" id="actionPath" name="actionPath" value="login"/>
            <TABLE cellSpacing=0 cellPadding=2 border=0>
              <TBODY>
              <tr><td>&nbsp;</td>
				</tr>
<tr><td>&nbsp;</td>
				</tr>
              <TR height>
                <TD width=80>登 录 名：</TD>
                <TD width=150><input name="txtName"
                  style="WIDTH: 130px" type="text" value="admin" /></TD>
                <TD width=370>
<div id="nameValid" style="display:none; font-weight:bold; color:#FFFFFF">&nbsp;</div></TD></TR>
              <TR height=28>
                <TD >登录密码：</TD>
                <TD ><INPUT name="txtPwd" style="WIDTH: 130px" 
                  type=password  value="admin" /></TD>
                <TD>
<div id="pwdValid" style="display:none; font-weight:bold; color:#FFFFFF">&nbsp;</div></TD></TR>
              <TR height=28>
                <TD >验证码：</TD>
                <TD ><INPUT name="txtCode" value="admin"
                  style="WIDTH: 130px" onFocus="javascript:document.all.valid.innerHTML='<img border=0 src=num.jsp height=20></img>'"/></TD>
                <TD><div id="valid">点击输入框获取验证码</div></TD>
</TR>
              <TR>
                <TD style="HEIGHT: 18px"></TD>
                <TD style="HEIGHT: 18px"></TD>
                <TD style="HEIGHT: 18px"></TD></TR>
              <TR>
                <TD></TD>
                <TD><a href="#" target="_self" onclick="javascript:validate();">
<img src=login_files/login_button.gif border="0" /></a>
              </TD></TR>
              </TBODY></TABLE></FORM>

</TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD><IMG src="login_files/login_3.jpg" 
border=0></TD></TR></TBODY></TABLE>


</DIV></DIV>
<script type="text/javascript">
function validate()
{
	var user=document.all.txtName.value;
	var pwd=document.all.txtPwd.value;
	var code=document.all.txtCode.value;
	if(user!=""&&pwd!=""&&code!="")
	{
		document.all.form1.submit();
	}
	if(user=="")
	{
		document.all.nameValid.innerHTML="用户名不能为空 ";
		document.all.nameValid.style.display="block";
	}
	if(pwd=="")
	{
		document.all.pwdValid.innerHTML="用户密码不能为空 ";
		document.all.pwdValid.style.display="block";
	}
	if(code=="")
	{
		document.all.valid.innerHTML="<b><font color=white>验证码不能为空</font></b>";
	}
}
</script>
<%
	//注销用户
	if(request.getParameter("logout")!=null)
	{
		session.removeAttribute("user");
		session.invalidate();
	}
	//登录用户
	String name="";
	if(request.getAttribute("userName")!=null)
		name=request.getAttribute("userName").toString().trim();
	int errorCode=-1;
	if(request.getAttribute("error")!=null)
	{
		errorCode=Integer.parseInt(request.getAttribute("error").toString());
	}
%>
	<script type="text/javascript">
		document.all.txtName.value="<%=name %>";
		var err=<%=errorCode %>;
		switch(err)
		{
			case 0:
				document.all.nameValid.innerHTML="用户名不存在";
				document.all.nameValid.style.display="block";
				break;
			case 1:
				document.all.pwdValid.innerHTML="用户密码错误";
				document.all.pwdValid.style.display="block";
				break;
			case 2:
				document.all.valid.innerHTML="<b><font color=white>验证码错误</font></b>";
				document.all.valid.style.display="block";
				break;
		}
		
	</script>

</BODY></HTML>
