<%@ page language="java" import="java.util.*" import="model.*" import="dao.*" import="util.*"  pageEncoding="GBK"%>

<%
 int staffId = 0;
if(request.getParameter("staffId")!=null){
    staffId = Integer.parseInt(request.getParameter("staffId"));
 }
staffDao stfDao = new staffDao();
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>ģ��</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK"><LINK 
href="images/Style.css" type=text/css rel=stylesheet><LINK 
href="images/Manage.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="images/FrameDiv.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="images/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=javascript src="images/Common.js"></SCRIPT>

<SCRIPT language=javascript>
function empty(){
document.all.staffNum.value="";
}

  ����var xmlHttp;//����Ǵ�˵�е�Ajax 
����function createXMLHttpRequest() {
����if (window.ActiveXObject) {
����xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
����}
����else if (window.XMLHttpRequest) {
����xmlHttp = new XMLHttpRequest();
����}
����}
����function retrieve(staffNum) {
����createXMLHttpRequest();
����var url = "../ActionServlet?actionPath=seperation&command=retrieve&staffNum=" + staffNum;
����xmlHttp.open("post", url, true);
����xmlHttp.onreadystatechange = callback;
����xmlHttp.send(null);
����}
	function callback() 
	{
	����if (xmlHttp.readyState == 4) 
		{
	����		if (xmlHttp.status == 200) 
			{
			����var staffName =xmlHttp.responseXML.getElementsByTagName("staffName")[0].firstChild.data;
			    var position =xmlHttp.responseXML.getElementsByTagName("position")[0].firstChild.data;
				//��Ajax��Ϣ�Ĵ���

				if(staffName!="@"){
				    document.all.staffName.value = staffName;
				    document.all.position.value = position;
				    }else{
				       document.all.staffName.value = "";
				    document.all.position.value = "";
				    document.all.staffNum.value = "�����������";
				    }
		����}
		}
	}
	
	function newSep(){
        var time = document.all.sepDate.value;
        var type = document.all.sepType.value;
        var reason = document.all.sepReason.value;
        if(time==""){
        alert("��������ְʱ�䣡");
        document.all.sepDate.focus();
        }else if(type==0){
        alert("��ѡ����ְ���ͣ�");
        document.all.sepType.focus();
        }else if(reason==""){
        alert("��������ְԭ��");
        document.all.sepReason.focus();
        }else{
        
	    var selectFlags = document.getElementsByName("sepType");
	for (var i=0; i<selectFlags.length; i++) {
		if (selectFlags[i].checked) {
			var type=selectFlags[i].value;
			break;
		}
	}
	document.forms[0].action="/HRM/ActionServlet?command=newSep";
		document.forms[0].method="post";
		document.forms[0].submit();
		}
	}
    </SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>
<form id="form1" name="form1" method="post" action="/HRM/ActionServlet">
     <input type="hidden" id="actionPath" name="actionPath" value="seperation"/>


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
          <TD width="75%" ><a href="deploy.jsp">��Ա����</a>&nbsp;&gt;&nbsp;��ְ��Ա</TD>
		  <td width="14%" align="right"><a href='retire.jsp'>������ԱԤ��</a></td>
		  <td width="11%" align="right"><a href='sepDoc.jsp'>��ְ��Ա����</a></td>
        </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!-- ���� -->
					<table width="362" border="0" align="center" bgcolor="eeeeee">
            <tr>
              <td width="52" align="center" valign="bottom">&nbsp;</td>
              <td width="74" align="center" valign="bottom">&nbsp;</td>
              <td width="180" align="center" valign="bottom">&nbsp;</td>
              <td width="38" align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td width="74" align="center" valign="middle"> ���</td>
              <td width="180" align="left" valign="middle">
              <%if(staffId!=0){ %>
              <input name="staffNum" id="staffNum" type="text" value="<%=stfDao.findByID(staffId).getStaffNum() %>" size="30"  >
              <%}else{ %>
              <input name="staffNum" id="staffNum" type="text" value="�ɱ���Զ�����Ա��" size="30" onFocus="empty();" onBlur="retrieve(this.value);" >
              <%} %>
              </td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="middle">����</td>
              <td align="left" valign="middle"><input type="text" name="staffName" id="staffName" disabled="disabled"/></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="middle">ְ��</td>
              <td align="left" valign="middle"><input type="text" name="position" id="position" disabled="disabled"/></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="middle">��ְʱ��</td>
              <td align="left" valign="middle"><input name="sepDate" type="text" class="Wdate" id="sepDate" onClick="WdatePicker()" size="30"></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="middle">��ְ����</td>
              <td align="left" valign="middle">
              <select name="sepType" id="sepType">
                <option value="0">ѡ��</option>
                <option value="1">����</option>
                <option value="2">��ְ</option>
                <option value="3">���</option>
                <option value="4">����</option>
                            </select></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="center" valign="middle">��ְԭ��</td>
              <td rowspan="3" align="left" valign="top"><textarea name="sepReason" id="sepReason" cols="30" rows="4"></textarea></td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="right" valign="middle">&nbsp;</td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="right" valign="middle">&nbsp;</td>
              <td align="center" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" valign="bottom">&nbsp;</td>
              <td align="right" valign="middle"><input name="ok" type="button" id="ok" value="ȷ��" onClick="javascript:newSep();"></td>
              <td align="center" valign="middle"><input name="cancel" type="button" id="cancel" value="ȡ��" onClick="javascript:location.href='deploy.jsp';"></td>
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
