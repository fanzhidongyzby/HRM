<%@ page language="java" import="java.util.*" import="model.*" import="dao.*" import="util.*"  pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  
  int pageNo = 1;
	int pageSize = 2;    //记得改每页条数
	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1>
<base href="<%=basePath%>">
<TITLE>模板</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gbk"><LINK 
href="home/images/Style.css" type=text/css rel=stylesheet><LINK 
href="home/images/Manage.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="home/images/FrameDiv.js"></SCRIPT>

<SCRIPT language=javascript src="home/images/Common.js"></SCRIPT>



<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<SCRIPT language=javascript>
function mgrControlers()
{
	var num=document.all.staffNum.value;
	var name=document.all.staffName;
	var sx=document.all.sex;
	var agPd=document.all.agePeriod;
	var deg=document.all.degree;
	var pos=document.all.position;
	var tec=document.all.tech;
	if(num!="")
	{
		name.value="无需输入姓名";
		name.bgcolor="red";
		name.disabled=true;
		sx.disabled=true;
		agPd.disabled=true;
		deg.disabled=true;
		pos.value="无需输入职称";
		pos.bgcolor="red";
		pos.disabled=true;
		tec.value="无需输入技术";
		tec.bgcolor="red";
		tec.disabled=true;
	}
	else
	{
		name.disabled=false;
		name.value="";
		sx.disabled=false;
		agPd.disabled=false;
		deg.disabled=false;
		pos.disabled=false;
		pos.value="";
		tec.disabled=false;
		tec.value="";		
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

function searchStf(){
	var selectFlagsSex = document.getElementsByName("sex");
	for (var i=0; i<selectFlagsSex.length; i++) {
		if (selectFlagsSex[i].checked) {
			var type=selectFlagsSex[i].value;
			break;
		}
	}
	var selectFlagsAge = document.getElementsByName("agePeriod");
	for (var i=0; i<selectFlagsAge.length; i++) {
		if (selectFlagsAge[i].checked) {
			var type=selectFlagsAge[i].value;
			break;
		}
	}
	var selectFlagsDegree = document.getElementsByName("degree");
	for (var i=0; i<selectFlagsDegree.length; i++) {
		if (selectFlagsDegree[i].checked) {
			var type=selectFlagsDegree[i].value;
			break;
		}
	}
	var num=document.all.staffNum.value;
	if(num!=""){
		document.forms[0].action="/HRM/ActionServlet?actionPath=staff&command=searchByNum";
		document.forms[0].method="post";
		document.forms[0].submit();
	} else{
		document.forms[0].action="/HRM/ActionServlet?actionPath=staff&command=searchByOther";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
		
}



function deleteStf(){
	var selectFlags = document.getElementsByName("staffid");
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
			document.forms[0].action="/HRM/ActionServlet?actionPath=staff&command=delete";
			document.forms[0].method="post";
			document.forms[0].submit();
	}
}
    </SCRIPT>

<BODY>
<form id="form1" name="form1" method="post" action="/HRM/ActionServlet">
     <input type="hidden" id="actionPath" name="actionPath" value="staff"/>
         <input type="hidden" name="pageNo" value="<%=pageNo %>">
         <input type="hidden" name="pageSize" value="<%=pageSize %>">
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
          <TD >当前位置：&nbsp;
<%
 	ArrayList<department> dir=new ArrayList<department>();
 	deptDao dd=new deptDao();
 	department dept;
	int curDeptId=Integer.parseInt(session.getAttribute("curDeptId").toString());	
	dept=dd.findByID(curDeptId);//当前
	dir.add(dept);
	String affi=dept.getDeptAffi();
	StringTokenizer token=new StringTokenizer(affi,"-");//获取父子部门ID
	department parentDept=null;//父部门
	if(token.hasMoreTokens())
	{
		parentDept=dd.findByID(Integer.parseInt(token.nextToken()));
	}
	while(parentDept!=null)//有父部门继续添加
	{
		dir.add(parentDept);
		dept=dd.findByID(parentDept.getDeptID());
		affi=dept.getDeptAffi();
		token=new StringTokenizer(affi,"-");//获取父子部门ID
		if(token.hasMoreTokens())
		{
			parentDept=dd.findByID(Integer.parseInt(token.nextToken()));
		}
	}
	//逆序输出各个含有子部门的 部门
	for(int i=dir.size()-1;i>0;i--)
	{
		if(i!=dir.size()-1)//不是第一个位置
		{
%>
			&gt;&nbsp;
<%					
		}
%>

		<a 
		href="../../SwitchDept?curDeptId=<%=dir.get(i).getDeptID() %>" >
		<%=dir.get(i).getDeptName() %></a>&nbsp;
<%			
	}
	//第一个添加的即最后一个部门看是否有下一级在处理	
	//判断输出最后一个节点部门
	if(dir.size()!=1)//顶级部门
	{
%>
		&gt;&nbsp;
<%	
	}
	if(session.getAttribute("realCurDeptId")!=null)//最后一级含有子部门的部门
	{
		int realCurDeptId=Integer.parseInt(session.getAttribute("realCurDeptId").toString());
		dept=dd.findByID(realCurDeptId);
%>
		<a 
		href="../../SwitchDept?curDeptId=<%=dir.get(0).getDeptID() %>" >
		<%=dir.get(0).getDeptName() %></a>&nbsp;
		&gt;&nbsp;<%=dept.getDeptName() %>
<%	
	}	
	else
	{
%>
		<%=dir.get(0).getDeptName() %>&nbsp;
<%	
	}
%>

<%
staff oneStaff = new staff();
staffDao stfDao =new staffDao();
PageModel pageModel = new PageModel();
int totalNum = 0;
int showDeptId = 0;
if(session.getAttribute("realCurDeptId")!=null)//最后一级含有子部门的部门
	{
		showDeptId=Integer.parseInt(session.getAttribute("realCurDeptId").toString());
    }else {
    showDeptId=curDeptId;
    }

String staffNum = (String)request.getAttribute("staffNum");
String staffName = (String)request.getAttribute("staffName");
int sex = -1;
if(request.getAttribute("sex")!=null){
sex = (Integer)request.getAttribute("sex");
}
int agePeriod = 0;
if(request.getAttribute("agePeriod")!=null){
agePeriod = (Integer)request.getAttribute("agePeriod");
}
int degree = 0;
if(request.getAttribute("degree")!=null){
degree = (Integer)request.getAttribute("degree");
}
String position = (String)request.getAttribute("position");
String tech = (String)request.getAttribute("tech");

String pageNoStr = request.getParameter("pageNo");
if (pageNoStr != null && !"".equals(pageNoStr)) {
	pageNo = Integer.parseInt(pageNoStr);
}

String flag = "show";
if(request.getAttribute("flag")!=null){
	flag = (String)request.getAttribute("flag");
}

if(flag == "show"){
	pageModel = stfDao.findByDept(pageNo,pageSize,showDeptId);
	totalNum = stfDao.getTotalRecords(showDeptId);
}else if(flag == "searchByNum"){
	oneStaff = (staff)request.getAttribute("oneStaff");
	totalNum = 1;
}else if(flag == "searchByOther") {
	pageModel = (PageModel)request.getAttribute("pageModel");
	totalNum = (Integer)request.getAttribute("totalNum");
}
%>
<%
	boolean hasValid=false;
	int nowId=showDeptId;
	user u=(user)session.getAttribute("user");
	if(u.getUserRole()==1)//A,
	{
		String depts=u.getDeptIDs();
		StringTokenizer testToken=new StringTokenizer(depts,"-");
		while(testToken.hasMoreTokens())
		{
			int oneDeptId=Integer.parseInt(testToken.nextToken());//测试ID
			//迭代ID
			while(nowId!=0)
			{
				if(nowId==oneDeptId)
				{
					hasValid=true;
					break;
				}
				else
				{
					//向上找
					String t_affi=dd.findByID(nowId).getDeptAffi();
					t_affi=t_affi.substring(0,t_affi.indexOf('-'));
					nowId=Integer.parseInt(t_affi);
				}
			}
			if(hasValid)
				break;
		} 
	}
	else
	{
		hasValid=true;
	}
	
	
 %>
</TD>
		  <td align="right">&nbsp;</td>
        </TR>
        <TR>
          <TD height=2></TD></TR></TABLE>
      <TABLE borderColor=#cccccc cellSpacing=0 cellPadding=0 width="100%" 
      align=center border=0>
        <TBODY>
        <TR>
          <TD  colspan="7" height=30 align="left">编号:
		    <input name="staffNum" id="staffNum" type="text" size="15" onChange="mgrControlers();">
		    姓名:
		    <input name="staffName" id="staffName" type="text" size="15">
		    性别:
		    <select name="sex" id="sex">
		    <option value="-1">选择</option>
		    <option value="1">男</option>
		    <option value="0">女</option>
		  </select>
		  年龄:
		  <select name="agePeriod" id="agePeriod">
		    <option value="0">选择</option>
		    <option value="1">16-18岁</option>
		    <option value="2">18-25岁</option>
		    <option value="3">26-30岁</option>
		    <option value="4">31-40岁</option>
		    <option value="5">41-50岁</option>
		    <option value="6">51-60岁</option>
		    </select>
		  文化:            <select name="degree" id="degree">
            <option value="0">选择</option>
            <option value="1">无</option>
            <option value="2">中小学(小学/初中/高中)</option>
            <option value="3">专科(中专/大专)</option>
            <option value="4">本科(学士)</option>
            <option value="5">硕士(研究生)</option>
            <option value="6">博士</option>
                    </select>
		  职称:
		  <input name="position" id="position" type="text" size="15">
		  技术:
		  <input name="tech" id="tech" type="text" size="15">
		  <input type="button" name="search" value="全局查询" onClick="searchStf()"></TD>
		</TR>
        <TR>
          <TD>
            <TABLE  border="1" align="center"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
              <TBODY>
              <TR 
              style="FONT-WEIGHT: bold; FONT-STYLE: normal; BACKGROUND-COLOR: #eeeeee; TEXT-DECORATION: none">
                <TD width="20%">编号</TD>
                <TD width="15%">姓名</TD>
                <TD width="11%">性别</TD>
                <TD width="11%">部门</TD>
                <TD width="11%">职称</TD>
                <TD width="20%">详细</TD>
                <TD width="12%">删除</TD>
              </TR>
              <%if(flag=="searchByNum"){
            	  if(oneStaff!=null){%>
             <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
                <TD><%=oneStaff.getStaffNum() %></TD>
                <TD><%=oneStaff.getStaffName() %></TD>
                <TD><%=(oneStaff.getSex()==0)?"女":"男" %></TD>
                <TD><%=dd.findByID(oneStaff.getDeptID()).getDeptName() %></TD>
                <TD><%=oneStaff.getPosition() %></TD>
                <TD><A 
                  href="home/staffDetail.jsp?staffId=<%=oneStaff.getStaffID() %>">查看</A></TD>
                <TD><input type="checkbox" name="staffid" id="staffid" value="<%=oneStaff.getStaffID() %>" /></TD></TR>
             <% }else{%> 
             <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">没有符合条件的项</TR>
              <%} %>
               <%}else if(pageModel.getList().size()!=0){ %>
              <%for(int k = 0;k < pageModel.getList().size();k++) {
                  oneStaff = (staff)pageModel.getList().get(k); %>
              <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
                <TD><%=oneStaff.getStaffNum() %></TD>
                <TD><%=oneStaff.getStaffName() %></TD>
                <TD><%=(oneStaff.getSex()==0)?"女":"男" %></TD>
                <TD><%=dd.findByID(oneStaff.getDeptID()).getDeptName() %></TD>
                <TD><%=oneStaff.getPosition() %></TD>
                <TD><A 
                  href="home/staffDetail.jsp?staffId=<%=oneStaff.getStaffID() %>">查看</A></TD>
                <TD><input
                 <%if(!hasValid){%>disabled<%}%>
                type="checkbox" name="staffid" id="staffid" value="<%=oneStaff.getStaffID() %>" /></TD></TR>
                <%} %>
                <%}else{ %>
                <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">没有符合条件的项</TR>
              <%} %>
              </TBODY></TABLE></TD></TR>  
			  <tr><TD align=right height=25><INPUT onClick="selectAll(this.checked)"; type=checkbox <%if(!hasValid){%>disabled<%}%> name=checkAll>全选
			<input type="button" name="delete" value="批量删除" <%if(!hasValid){%>disabled<%}%> onClick="deleteStf()"/></TD></tr>  
		<%if(!"searchByNum".equals(flag)){ %>    
        <TR>
          <TD><SPAN id="pagelink">
            <DIV 
            style="LINE-HEIGHT: 20px; HEIGHT: 20px; TEXT-ALIGN: right">
           [<strong><%=totalNum %></strong>]条记录 
            [<%=pageModel.getTotalPages() %>]页 当前是[<%=(pageNo-1)*pageSize+1 %>-<%=(pageNo*pageSize>totalNum)?totalNum:pageNo*pageSize %>]条 
            
            [<a href="ActionServlet?actionPath=staff&pageNo=<%=pageModel.getPreviousPageNo()%>&pageSize=<%=pageSize %>&totalNum=<%=totalNum %>&flag=<%=flag %>&command=<%=flag %>&staffNum=<%=staffNum %>&staffName=<%=staffName %>&sex=<%=sex %>&agePeriod=<%=agePeriod %>&degree=<%=degree %>&position=<%=position %>">前一页</A>]
            [<a href="ActionServlet?actionPath=staff&pageNo=<%=pageModel.getNextPageNo()%>&pageSize=<%=pageSize %>&totalNum=<%=totalNum %>&flag=<%=flag %>&command=<%=flag %>&staffNum=<%=staffNum %>&staffName=<%=staffName %>&sex=<%=sex %>&agePeriod=<%=agePeriod %>&degree=<%=degree %>&position=<%=position %>">后一页</A>] 
            <SELECT onChange="javascript:location.href=this.value;">
            <%for(int i=1; i<=pageModel.getTotalPages(); i++){ %>
            <OPTION value="ActionServlet?actionPath=staff&pageNo=<%=i%>&pageSize=<%=pageSize %>&totalNum=<%=totalNum %>&flag=<%=flag %>&command=<%=flag %>&staffNum=<%=staffNum %>&staffName=<%=staffName %>&sex=<%=sex %>&agePeriod=<%=agePeriod %>&degree=<%=degree %>&position=<%=position %>"><%=i %></OPTION>
            <%} %>
            </SELECT></DIV></SPAN></TD>
		</TR>
		<%} %>
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
