<%@ page language="java" import="java.util.*" import="model.*" import="dao.*" import="util.*"  pageEncoding="GBK"%>

<%
 int staffId = 0;
if(request.getParameter("staffId")!=null){
    staffId = Integer.parseInt(request.getParameter("staffId"));
 }
staffDao stfDao = new staffDao();
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>模板</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="images/Style.css" type=text/css rel=stylesheet><LINK 
href="images/Manage.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/FrameDiv.js"></SCRIPT>

<SCRIPT language=javascript src="images/Common.js"></SCRIPT>
<SCRIPT language=javascript>
 function empty(){

document.all.staffNum.value="";
}

　var xmlHttp;//这就是传说中的Ajax 
　　function createXMLHttpRequest() {
　　if (window.ActiveXObject) {
　　xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
　　}
　　else if (window.XMLHttpRequest) {
　　xmlHttp = new XMLHttpRequest();
　　}
　　}
　　function retrieve(param,opt) {
　　createXMLHttpRequest();
　　if(opt==1){
　　var url = "../ActionServlet?actionPath=deploy&command=retrieve&staffNum=" + param;
    }else {
    var url = "../ActionServlet?actionPath=staff&command=deptVerify&deptName=" + param;
    }
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
			　　var op = xmlHttp.responseXML.getElementsByTagName("option")[0].firstChild.data;
			    if(op=="a"){
			       var staffName = xmlHttp.responseXML.getElementsByTagName("staffName")[0].firstChild.data;
			       var oldDept = xmlHttp.responseXML.getElementsByTagName("oldDept")[0].firstChild.data;
			       var oldPos = xmlHttp.responseXML.getElementsByTagName("oldPos")[0].firstChild.data;
			       if(staffName!="@"){
			          document.all.staffName.value = staffName;
			          document.all.oldDept.value = oldDept;
			          document.all.oldPos.value = oldPos;
			       }else{
			          document.all.staffName.value = "";
			          document.all.oldDept.value = "";
			          document.all.oldPos.value = "";
			          document.all.staffNum.value = "编号输入有误！";
			       }
			    }else{
			         var msg =xmlHttp.responseXML.getElementsByTagName("verify")[0].firstChild.data;
			         if(msg=="illegal"){
			         alert("部门不存在，请重新输入！");
			         document.all.newDept.value="";
			         document.all.newDept.focus();
			         }
			    }
		　　}
		}
	}

function newDepl(){
       if(document.all.newDept.value==""){
       alert("请输入新部门！");
       document.all.newDept.focus();
       }else
       if(document.all.newPos.value==""){
       alert("请输入新职务！");
       document.all.newPos.focus();
       }else
       if(document.all.type.value==0){
       alert("请选择离职类型！");
       document.all.type.focus();
       }else{
	document.forms[0].action="/HRM/ActionServlet?command=newDepl";
		document.forms[0].method="post";
		document.forms[0].submit();
       }
	}
    </SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>
<form id="form1" name="form1" method="post" action="/HRM/ActionServlet">
     <input type="hidden" id="actionPath" name="actionPath" value="deploy"/>

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
          <TD ><a href="deploy.jsp">人员调动</a>&nbsp;&gt;&nbsp;普通调动</TD>
		  <td align="right">&nbsp;</td>
        </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!-- 代码 -->
					<table width="320" border="0" align="center" bgcolor="eeeeee">
            <tr>
              <td width="56" align="center" valign="bottom">&nbsp;</td>
              <td width="77" align="center" valign="bottom">&nbsp;</td>
              <td width="144" align="center" valign="bottom">&nbsp;</td>
              <td width="25" align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td width="77" align="center" valign="bottom"> 编号</td>
              <td width="144" align="left" valign="bottom">
              <%if(staffId!=0){ %>
              <input name="staffNum" id="staffNum" type="text" value="<%=stfDao.findByID(staffId).getStaffNum() %>" size="30"  >
              <%}else{ %>
              <input name="staffNum" id="staffNum" type="text" value="由编号自动检索员工" size="30" onFocus="empty();" onBlur="retrieve(this.value,1);" >
              <%} %>
              </td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            
            <!--
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="bottom">姓名</td>
              <td align="left" valign="bottom"><input type="text" name="staffName" id="staffName" disabled="disabled"/></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td height="17" align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="bottom">原部门</td>
              <td align="left" valign="bottom"><input type="text" name="oldDept" id="oldDept" disabled="disabled"/></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="bottom">原职务</td>
              <td align="left" valign="bottom"><input type="text" name="oldPos" id="oldPos" disabled="disabled"/></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>  -->
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="bottom">现部门</td>
              <td align="left" valign="bottom"><input type="text" name="newDept" onBlur="retrieve(this.value,2);"></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="bottom">现职务</td>
              <td align="left" valign="bottom"><input type="text" name="newPos"></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="bottom">调动类型</td>
              <td align="left" valign="bottom">
              <select name="type">
                <option value="0">选择</option>
                <option value="1">平级调动</option>
                <option value="2">降职</option>
                <option value="3">升职</option>
                            </select></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="right" valign="bottom">&nbsp;</td>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="right" valign="bottom"><input name="ok" type="button" id="ok" value="确定" onClick="newDepl()"></td>
              <td align="center" valign="bottom"><input name="cancel" type="button" id="cancel" value="取消" onClick="javascript:location.href='deploy.jsp';"></td>
              <td align="center" valign="bottom">&nbsp;</td>
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
