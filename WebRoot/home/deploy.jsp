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
 function deploy()
 {
	 var type;
	 for(var i = 0; i<document.all.radiobutton.length; i++)
	 {
		 if (document.all.radiobutton[i].checked == true){ type=document.all.radiobutton[i].value;}
	 }
	 if(type == "employ"){window.location.href = "stfDtlEdit.jsp?staffId=0";}
	 if(type == "normal"){window.location.href = "transfer.jsp";}
	 if(type == "seperate"){window.location.href = "separate.jsp";}
 }
    </SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>
<form id="form1" name="form1" method="post" action="ActionServlet">
   <input type="hidden" id="actionPath" name="actionPath" value="deploy"/>

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
          <TD >人员调动</TD>
		  <td align="right">&nbsp;</td>
        </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!-- 代码 -->
					<table width="324" border="0" align="center" bgcolor="eeeeee">
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td width="109" align="center" valign="middle">&nbsp;</td>
              <td width="174" align="center">&nbsp;</td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td width="10" align="center" valign="middle">&nbsp;</td>
              <td colspan="2" align="center" valign="middle"><h2>选择人员调动的方式</h2></td>
              <td width="13" align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center">&nbsp;</td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle"><div align="right">
                <input type="radio" name="radiobutton" value="employ">
              </div></td>
              <td align="center" valign="middle"><div align="left">新进员工(聘任)</div></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle"><div align="right"></div></td>
              <td align="center"><div align="left"></div></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle"><div align="right">
                <input name="radiobutton" type="radio" value="normal" checked>
              </div></td>
              <td align="center"><div align="left">普通调动</div></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle"><div align="right"></div></td>
              <td align="center"><div align="left"></div></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle"><div align="right">
                <input type="radio" name="radiobutton" value="seperate">
              </div></td>
              <td align="center"><div align="left">离退处理</div></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center">&nbsp;</td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="left" valign="middle"><input name="button" type="button" id="Submit" value="确定" onClick="deploy()">
              
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center" valign="middle">&nbsp;</td>
              <td align="center">&nbsp;</td>
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
