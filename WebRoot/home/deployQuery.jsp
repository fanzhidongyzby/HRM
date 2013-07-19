<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="model.*" import="util.*" import="dao.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%

  List<deploy> deplList = null;
  deploy oneDeploy = new deploy();
  deployDao dplDao = new deployDao();
  
  staff oneStaff = new staff();
  staffDao stfDao = new staffDao();
  PageModel pageModel = new PageModel();
  int totalNum = 0;
  
  String staffNum = (String)request.getAttribute("staffNum");
  String staffName = (String)request.getAttribute("staffName");
  String position = (String)request.getAttribute("position");
  String startDate = (String)request.getAttribute("startDate");
  String endDate = (String)request.getAttribute("endDate");
  int type = 0;
  if(request.getAttribute("type")!=null){
  type = (Integer)request.getAttribute("type");
  }
  
  int pageNo = 1;
	int pageSize = 2;    //记得改每页条数
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
   
	String flag = "";
	if(request.getAttribute("flag")!=null){
		flag = (String)request.getAttribute("flag");
	}else{
		flag = "show";
	}
	
   if(flag=="show"){
	   pageModel = dplDao.findRct(pageNo, pageSize);
	   totalNum = dplDao.getTotalRecordsRct();
   }else{
	   pageModel = (PageModel)request.getAttribute("pageModel");
	   totalNum = (Integer)request.getAttribute("totalNum");
   }
	
   
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1>
<base href="<%=basePath%>">
<TITLE>模板</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK"><LINK 
href="home/images/Style.css" type=text/css rel=stylesheet><LINK 
href="home/images/Manage.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="home/images/FrameDiv.js"></SCRIPT>
<SCRIPT language=javascript src="home/images/calendar.js"></SCRIPT>
<SCRIPT language=javascript src="home/images/Common.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="home/images/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=javascript>
function mgrControlers()
{
	var num=document.all.staffNum.value;
	var name=document.all.staffName;
	var pos=document.all.position;
	if(num!="")
	{
		name.value="无需输入姓名";
		name.bgcolor="red";
		name.disabled=true;
		pos.value="无需输入职称";
		pos.bgcolor="red";
		pos.disabled=true;
	}
	else
	{
		name.disabled=false;
		name.value="";
		pos.disabled=false;
		pos.value="";		
	}
}

function  selectAll(flag) {
    var  arrObj  = document.all; 
    if(flag) {
       for(var  i  =  0;  i  <  arrObj.length;i++)  
       {  
           if(typeof  arrObj[i].type  !=  "undefined"  &&  arrObj[i].type=='checkbox')
		      arrObj[i].checked = true;  

	   }
    }  
    else {
       for(var  i  =  0;  i  <  arrObj.length;i++)  
       { 
           if(typeof  arrObj[i].type  !=  "undefined"  &&  arrObj[i].type=='checkbox')
		      arrObj[i].checked = false;  

	   }
    }
}  

function searchD(){
	
	var selectFlags = document.getElementsByName("type");
	for (var i=0; i<selectFlags.length; i++) {
		if (selectFlags[i].checked) {
			var type=selectFlags[i].value;
			break;
		}
	}
	var num=document.all.staffNum.value;
	if(num!=""){
		document.forms[0].action="/HRM/ActionServlet?command=searchByNum";
		document.forms[0].method="post";
		document.forms[0].submit();
	} else{
		document.forms[0].action="/HRM/ActionServlet?command=searchByOther";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
		
}



function deleteDpl(){
	var selectFlags = document.getElementsByName("deplid");
	var flag = false;
	for (var i=0; i<selectFlags.length; i++) {
		if (selectFlags[i].checked) {
			flag = true;
			break;
		}
	}
	if (!flag) {
		alert("请选择要删除的调动项！");
		return;
	}
	
	if (window.confirm("确定删除？")) {
			document.forms[0].action="/HRM/ActionServlet?command=delete";
			document.forms[0].method="post";
			document.forms[0].submit();
	}
}
    </SCRIPT>

<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<BODY>
<form id="form1" name="form1" method="post" action="ActionServlet">
        <input type="hidden" id="actionPath" name="actionPath" value="deploy"/>
         <input type="hidden" name="pageNo" value="<%=pageNo %>">
         <input type="hidden" name="pageSize" value="<%=pageSize %>">
<SCRIPT type=text/javascript>
//<![CDATA[

//]]>
</SCRIPT>

<TABLE  align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
  <TBODY>
  <TR>
    <TD width=15><IMG src="home/images/new_019.jpg" border=0></TD>
    <TD width="100%" background=home/images/new_020.jpg height=20></TD>
    <TD width=15><IMG src="home/images/new_021.jpg" 
  border=0></TD></TR></TBODY></TABLE>
<TABLE  align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
  <TBODY>
  <TR>
    <TD width=15 background=home/images/new_022.jpg><IMG 
      src="home/images/new_022.jpg" border=0> </TD>
    <TD vAlign=top width="100%" bgColor=#ffffff>
      <TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
        <TR class=manageHead height="35">
          <TD >人员变动查询</TD>
		  <td align="right">&nbsp;</td>
        </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
      <TABLE borderColor=#cccccc cellSpacing=0 cellPadding=0 width="100%" 
      align=center border=0>
        <TBODY>
        <TR>
          <TD  colspan="7" height=30 align="left">编号:
		    <input id="staffNum" name="staffNum" type="text" size="15" onChange="mgrControlers();">
姓名:
<input type="text" id="staffName" name="staffName" size="15"/>
		  职称:
		  <input type="text" id="position" name="position" size="15"/>
		  起始时间:
		  <input type="text" class="Wdate" id="startDate" name="startDate" onClick="WdatePicker()" size="20"/>
		 <%//request.setAttribute("startDate",startDate); %> 
		  结束时间:
		  <input type="text" class="Wdate" id="endDate" name="endDate" onClick="WdatePicker()" size="20"/>
		  <%//request.setAttribute("endDate",endDate); %>
		  变动类别:
		  <select name="type" id="type" />
		    <option value="0">选择</option>
		    <option value="1">新进(聘任)</option>
		    <option value="2">平级调动</option>
		    <option value="3">降职</option>
		    <option value="4">升职</option>
		    <option value="5">离退</option>
		    </select>
		  <input type="button" name="search" value="查询" onClick="searchD()"></TD>
		</TR>
        <TR>
          <TD>
            <TABLE  border="1" align="center"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
              <TBODY>
              <TR 
              style="FONT-WEIGHT: bold; FONT-STYLE: normal; BACKGROUND-COLOR: #eeeeee; TEXT-DECORATION: none">
                <TD width="18%">变动时间</TD>
                <TD width="11%">姓名</TD>
                <TD width="26%">变动前状态</TD>
                <TD width="24%">变动后状态</TD>
                <TD width="12%">变动类型</TD>
                <TD width="9%">操作</TD>
              </TR>
              <%if(pageModel.getList().size()!=0){ %>
              <%for(int k = 0;k < pageModel.getList().size();k++) {
                  oneDeploy = (deploy)pageModel.getList().get(k); %>
              <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
                <TD><%=oneDeploy.getDeplTime() %></TD>
                <TD><a href="home/staffDetail.jsp?staffId=<%=oneDeploy.getStaffID() %>"><%=stfDao.findByID(oneDeploy.getStaffID()).getStaffName() %></a></TD>
                <TD><%=oneDeploy.getDeplBefore() %></TD>
                <TD><%=oneDeploy.getDeplAfter() %></TD>
                <TD><%=oneDeploy.getDeplType() %></TD>
                <TD><input type="checkbox" name="deplid" id="deplid" value="<%=oneDeploy.getDeplID() %>" /></TD></TR>
                <%} %>
                <%}else{ %>
                <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">没有符合条件的项</TR>
              <%} %>
              </TBODY></TABLE></TD></TR>  
              
			  <tr><TD align=right height=25>全选<INPUT onclick="selectAll(this.checked)"; type=checkbox name=checkAll>
			<input type="button" name="delete" value="批量删除" onClick="deleteDpl()"/></TD></tr>   
		
        <TR>
          <TD><SPAN id=pagelink>
            <DIV 
            style="LINE-HEIGHT: 20px; HEIGHT: 20px; TEXT-ALIGN: right">

            [<strong><%=totalNum %></strong>]条记录 
            [<%=pageModel.getTotalPages() %>]页 当前是[<%=(pageNo-1)*pageSize+1 %>-<%=(pageNo*pageSize>totalNum)?totalNum:pageNo*pageSize %>]条 
            
            [<a href="ActionServlet?actionPath=deploy&pageNo=<%=pageModel.getPreviousPageNo()%>&pageSize=<%=pageSize %>&command=<%=flag %>&flag=<%=flag %>&totalNum=<%=totalNum %>&staffNum=<%=staffNum %>&staffName=<%=staffName %>&position=<%=position %>&startDate=<%=startDate %>&endDate=<%=endDate %>&type=<%=type %>">前一页</A>]
            [<a href="ActionServlet?actionPath=deploy&pageNo=<%=pageModel.getNextPageNo()%>&pageSize=<%=pageSize %>&command=<%=flag %>&flag=<%=flag %>&totalNum=<%=totalNum %>&staffNum=<%=staffNum %>&staffName=<%=staffName %>&position=<%=position %>&startDate=<%=startDate %>&endDate=<%=endDate %>&type=<%=type %>">后一页</A>] 
            <SELECT onChange="javascript:location.href=this.value;">
            <%for(int i=1; i<=pageModel.getTotalPages(); i++){ %>
            <OPTION value="ActionServlet?actionPath=deploy&pageNo=<%=i%>&pageSize=<%=pageSize %>&command=<%=flag %>&flag=<%=flag %>&totalNum=<%=totalNum %>&staffNum=<%=staffNum %>&staffName=<%=staffName %>&position=<%=position %>&startDate=<%=startDate %>&endDate=<%=endDate %>&type=<%=type %>"><%=i %></OPTION>
            <%} %>
            </SELECT></DIV></SPAN></TD>
		</TR>
			</TBODY></TABLE></TD>
    <TD width=15 background=home/images/new_023.jpg><IMG 
      src="home/images/new_023.jpg" border=0> </TD></TR></TBODY></TABLE>
<TABLE  align="center" cellSpacing=0 cellPadding=0 width="99%" border=0>
  <TBODY>
  <TR>
    <TD width=15><IMG src="home/images/new_024.jpg" border=0></TD>
    <TD align=middle width="100%" background=home/images/new_025.jpg 
    height=15></TD>
    <TD width=15><IMG src="home/images/new_026.jpg" 
  border=0></TD></TR></TBODY></TABLE>
</FORM></BODY></HTML>
