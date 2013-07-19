<%@ page language="java" import="java.util.*" import="model.*" import="dao.*" import="util.*"  pageEncoding="GBK"%>

<%
  
  int pageNo = 1;
	int pageSize = 2;    //记得改每页条数
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	%>
	<%
	seperation oneSep = new seperation();
	sepDao spDao = new sepDao();
	staffDao stfDao = new staffDao();
	PageModel pageModel = new PageModel();
	int totalNum = 0;
	pageModel = spDao.findAll(pageNo, pageSize);
	totalNum = spDao.getTotalRecords();
	String args = spDao.countType();
	
	 %>
	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1><TITLE>模板</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
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
          <TD width="83%" ><a href="deploy.jsp">人员调动</a>&nbsp;&gt;&nbsp;<a href="separate.jsp">离职人员</a>&nbsp;&gt;&nbsp;离职人员档案</TD>
        </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
		  <!-- 代码 -->
		  <table width="100%">
		  <tr>
		  <td width="90%" valign="top">
		 <TABLE  border="1" align="left"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
              <TBODY>
              <TR 
              style="FONT-WEIGHT: bold; FONT-STYLE: normal; BACKGROUND-COLOR: #eeeeee; TEXT-DECORATION: none">
                <TD width="19%">编号</TD>
                <TD width="12%">姓名</TD>
                <TD width="8%">性别</TD>
                <TD width="8%">离职时间</TD>
                <TD width="7%">离职类型</TD>
                <TD width="46%">离职原因</TD>
                </TR>
                 <%if(pageModel.getList().size()!=0){ %>
              <%for(int k = 0;k < pageModel.getList().size();k++) {
                  oneSep = (seperation)pageModel.getList().get(k); %>
              <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
                <TD height="16"><%=stfDao.findByID(oneSep.getStaffID()).getStaffNum() %></TD>
                <TD><a href="staffDetail.jsp"><%=stfDao.findByID(oneSep.getStaffID()).getStaffName() %></a></TD>
                <TD><%=(stfDao.findByID(oneSep.getStaffID()).getSex()==0)?"女":"男" %></TD>
                <TD><%=oneSep.getSepTime() %></TD>
                <TD><%=oneSep.getSepType() %></TD>
                <TD><%=oneSep.getSepReason() %></TD>
                </TR>
                <%} %>
                </TBODY></TABLE>
         <table align="right"><tbody>
              <TR>
          <TD><SPAN id="pagelink">
            <DIV 
            style="LINE-HEIGHT: 20px; HEIGHT: 20px; TEXT-ALIGN: right">
           [<strong><%=totalNum %></strong>]条记录 
            [<%=pageModel.getTotalPages() %>]页 当前是[<%=(pageNo-1)*pageSize+1 %>-<%=(pageNo*pageSize>totalNum)?totalNum:pageNo*pageSize %>]条 
            
            [<a href="sepDoc.jsp?pageNo=<%=pageModel.getPreviousPageNo()%>">前一页</A>]
            [<a href="sepDoc.jsp?pageNo=<%=pageModel.getNextPageNo()%>">后一页</A>] 
            <SELECT onChange="javascript:location.href=this.value;">
            <%for(int i=1; i<=pageModel.getTotalPages(); i++){ %>
            <OPTION value="sepDoc.jsp?pageNo=<%=i%>"><%=i %></OPTION>
            <%} %>
            </SELECT></DIV></SPAN></TD>
		</TR>
              <%}else{ %>
               <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">没有符合条件的项</TR>
              <%} %>
              </TBODY></TABLE>
			  </td><td align="center" valign="middle"><img src="pie.jsp?args=<%=args %>" height="200" width="200"></td>
		  </tr></table>
			  
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
