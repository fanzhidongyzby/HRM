<%@ page language="java" import="java.util.*" import="model.*" import="dao.*" import="util.*"  pageEncoding="GBK"%>

<%
  
  int pageNo = 1;
	int pageSize = 2;    //�ǵø�ÿҳ����
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	%>
	
	<%
staff oneStaff = new staff();
staffDao stfDao =new staffDao();
deptDao dptDao = new deptDao();
PageModel pageModel = new PageModel();
int totalNum = 0;
pageModel = stfDao.retire(pageNo, pageSize);
totalNum = stfDao.getTotalRecordsRtr();
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

    </SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>
<form id="form1" name="form1" method="post" action="/HRM/ActionServlet">
     <input type="hidden" id="actionPath" name="actionPath" value=""/>
         <input type="hidden" name="pageNo" value="<%=pageNo %>">
         <input type="hidden" name="pageSize" value="<%=pageSize %>">

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
          <TD width="83%" ><a href="deploy.jsp">��Ա����</a>&nbsp;&gt;&nbsp;<a href="separate.jsp">��ְ��Ա</a>&nbsp;&gt;&nbsp;������ԱԤ��</TD>
        </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!-- ����-->

		  <table  border="1" align="center"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
            <tbody>
              <tr 
              style="FONT-WEIGHT: bold; FONT-STYLE: normal; BACKGROUND-COLOR: #eeeeee; TEXT-DECORATION: none">
                <TD width="15%">���</TD>
                <TD width="8%">����</TD>
                <TD width="4%">�Ա�</TD>
                <TD width="19%">����</TD>
                <TD width="17%">ְ��</TD>
                <TD width="15%">����</TD>
                <TD width="22%">����</TD>
              </tr>
              <%if(pageModel.getList().size()!=0){ %>
              <%for(int k = 0;k < pageModel.getList().size();k++) {
                  oneStaff = (staff)pageModel.getList().get(k); %>
              <tr 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
                <td height="27"><%=oneStaff.getStaffNum() %></td>
                <td><a href="staffDetail.jsp?staffId=<%=oneStaff.getStaffID() %>"><%=oneStaff.getStaffName() %></a></td>
                <td><%=(oneStaff.getSex()==0)?"Ů":"��" %></td>
                <td><%=dptDao.findByID(oneStaff.getDeptID()).getDeptName() %></td>
                <td><%=oneStaff.getPosition() %></td>
                <td><%=oneStaff.getAge() %></td>
                <td><input type="button" name="seperate" value="����" onClick="javascript:location.href='separate.jsp?staffId=<%=oneStaff.getStaffID() %>'"></td>
              </tr>
              <%} %>
</TBODY></TABLE>
<table align="right"><tbody>
              <tr>
                <td><span id="pagelink">
                  <div 
            style="LINE-HEIGHT: 20px; HEIGHT: 20px; TEXT-ALIGN: right"> [<strong><%=totalNum %></strong>]����¼  
                    [<%=pageModel.getTotalPages() %>]ҳ ��ǰ��[<%=(pageNo-1)*pageSize+1 %>-<%=(pageNo*pageSize>totalNum)?totalNum:pageNo*pageSize %>]��
                    
                    [<a href="retire.jsp?pageNo=<%=pageModel.getPreviousPageNo()%>">ǰһҳ</a>]
                    [<a href="retire.jsp?pageNo=<%=pageModel.getNextPageNo()%>">��һҳ</a>]
                    <select name="select" onChange="javascript:location.href=this.value;">
                        <%for(int i=1; i<=pageModel.getTotalPages(); i++){ %>
                        <option value="retire.jsp?pageNo=<%=i%>"><%=i %></option>
                        <%} %>
                      </select>
                  </div>
                </span></td>
              </tr>
              <%}else{ %>
              <tr 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">û�з�����������</tr>
              <%} %>
            </tbody>
	      </table></TD>
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
