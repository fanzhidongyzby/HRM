<%@ page language="java" import="java.util.*" import="model.*" import="dao.*" import="util.*"  pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  
  int pageNo = 1;
	int pageSize = 2;    //�ǵø�ÿҳ����
	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD id=Head1>
<base href="<%=basePath%>">
<TITLE>ģ��</TITLE>
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
		name.value="������������";
		name.bgcolor="red";
		name.disabled=true;
		sx.disabled=true;
		agPd.disabled=true;
		deg.disabled=true;
		pos.value="��������ְ��";
		pos.bgcolor="red";
		pos.disabled=true;
		tec.value="�������뼼��";
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
		alert("��ѡ��Ҫɾ���ĵ����");
		return;
	}
	
	if (window.confirm("ȷ��ɾ����")) {
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
          <TD >��ǰλ�ã�&nbsp;
<%
 	ArrayList<department> dir=new ArrayList<department>();
 	deptDao dd=new deptDao();
 	department dept;
	int curDeptId=Integer.parseInt(session.getAttribute("curDeptId").toString());	
	dept=dd.findByID(curDeptId);//��ǰ
	dir.add(dept);
	String affi=dept.getDeptAffi();
	StringTokenizer token=new StringTokenizer(affi,"-");//��ȡ���Ӳ���ID
	department parentDept=null;//������
	if(token.hasMoreTokens())
	{
		parentDept=dd.findByID(Integer.parseInt(token.nextToken()));
	}
	while(parentDept!=null)//�и����ż������
	{
		dir.add(parentDept);
		dept=dd.findByID(parentDept.getDeptID());
		affi=dept.getDeptAffi();
		token=new StringTokenizer(affi,"-");//��ȡ���Ӳ���ID
		if(token.hasMoreTokens())
		{
			parentDept=dd.findByID(Integer.parseInt(token.nextToken()));
		}
	}
	//����������������Ӳ��ŵ� ����
	for(int i=dir.size()-1;i>0;i--)
	{
		if(i!=dir.size()-1)//���ǵ�һ��λ��
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
	//��һ����ӵļ����һ�����ſ��Ƿ�����һ���ڴ���	
	//�ж�������һ���ڵ㲿��
	if(dir.size()!=1)//��������
	{
%>
		&gt;&nbsp;
<%	
	}
	if(session.getAttribute("realCurDeptId")!=null)//���һ�������Ӳ��ŵĲ���
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
if(session.getAttribute("realCurDeptId")!=null)//���һ�������Ӳ��ŵĲ���
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
			int oneDeptId=Integer.parseInt(testToken.nextToken());//����ID
			//����ID
			while(nowId!=0)
			{
				if(nowId==oneDeptId)
				{
					hasValid=true;
					break;
				}
				else
				{
					//������
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
          <TD  colspan="7" height=30 align="left">���:
		    <input name="staffNum" id="staffNum" type="text" size="15" onChange="mgrControlers();">
		    ����:
		    <input name="staffName" id="staffName" type="text" size="15">
		    �Ա�:
		    <select name="sex" id="sex">
		    <option value="-1">ѡ��</option>
		    <option value="1">��</option>
		    <option value="0">Ů</option>
		  </select>
		  ����:
		  <select name="agePeriod" id="agePeriod">
		    <option value="0">ѡ��</option>
		    <option value="1">16-18��</option>
		    <option value="2">18-25��</option>
		    <option value="3">26-30��</option>
		    <option value="4">31-40��</option>
		    <option value="5">41-50��</option>
		    <option value="6">51-60��</option>
		    </select>
		  �Ļ�:            <select name="degree" id="degree">
            <option value="0">ѡ��</option>
            <option value="1">��</option>
            <option value="2">��Сѧ(Сѧ/����/����)</option>
            <option value="3">ר��(��ר/��ר)</option>
            <option value="4">����(ѧʿ)</option>
            <option value="5">˶ʿ(�о���)</option>
            <option value="6">��ʿ</option>
                    </select>
		  ְ��:
		  <input name="position" id="position" type="text" size="15">
		  ����:
		  <input name="tech" id="tech" type="text" size="15">
		  <input type="button" name="search" value="ȫ�ֲ�ѯ" onClick="searchStf()"></TD>
		</TR>
        <TR>
          <TD>
            <TABLE  border="1" align="center"  bordercolor="cccccc" bgcolor="#FFFFFF" width="100%">
              <TBODY>
              <TR 
              style="FONT-WEIGHT: bold; FONT-STYLE: normal; BACKGROUND-COLOR: #eeeeee; TEXT-DECORATION: none">
                <TD width="20%">���</TD>
                <TD width="15%">����</TD>
                <TD width="11%">�Ա�</TD>
                <TD width="11%">����</TD>
                <TD width="11%">ְ��</TD>
                <TD width="20%">��ϸ</TD>
                <TD width="12%">ɾ��</TD>
              </TR>
              <%if(flag=="searchByNum"){
            	  if(oneStaff!=null){%>
             <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
                <TD><%=oneStaff.getStaffNum() %></TD>
                <TD><%=oneStaff.getStaffName() %></TD>
                <TD><%=(oneStaff.getSex()==0)?"Ů":"��" %></TD>
                <TD><%=dd.findByID(oneStaff.getDeptID()).getDeptName() %></TD>
                <TD><%=oneStaff.getPosition() %></TD>
                <TD><A 
                  href="home/staffDetail.jsp?staffId=<%=oneStaff.getStaffID() %>">�鿴</A></TD>
                <TD><input type="checkbox" name="staffid" id="staffid" value="<%=oneStaff.getStaffID() %>" /></TD></TR>
             <% }else{%> 
             <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">û�з�����������</TR>
              <%} %>
               <%}else if(pageModel.getList().size()!=0){ %>
              <%for(int k = 0;k < pageModel.getList().size();k++) {
                  oneStaff = (staff)pageModel.getList().get(k); %>
              <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
                <TD><%=oneStaff.getStaffNum() %></TD>
                <TD><%=oneStaff.getStaffName() %></TD>
                <TD><%=(oneStaff.getSex()==0)?"Ů":"��" %></TD>
                <TD><%=dd.findByID(oneStaff.getDeptID()).getDeptName() %></TD>
                <TD><%=oneStaff.getPosition() %></TD>
                <TD><A 
                  href="home/staffDetail.jsp?staffId=<%=oneStaff.getStaffID() %>">�鿴</A></TD>
                <TD><input
                 <%if(!hasValid){%>disabled<%}%>
                type="checkbox" name="staffid" id="staffid" value="<%=oneStaff.getStaffID() %>" /></TD></TR>
                <%} %>
                <%}else{ %>
                <TR 
              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">û�з�����������</TR>
              <%} %>
              </TBODY></TABLE></TD></TR>  
			  <tr><TD align=right height=25><INPUT onClick="selectAll(this.checked)"; type=checkbox <%if(!hasValid){%>disabled<%}%> name=checkAll>ȫѡ
			<input type="button" name="delete" value="����ɾ��" <%if(!hasValid){%>disabled<%}%> onClick="deleteStf()"/></TD></tr>  
		<%if(!"searchByNum".equals(flag)){ %>    
        <TR>
          <TD><SPAN id="pagelink">
            <DIV 
            style="LINE-HEIGHT: 20px; HEIGHT: 20px; TEXT-ALIGN: right">
           [<strong><%=totalNum %></strong>]����¼ 
            [<%=pageModel.getTotalPages() %>]ҳ ��ǰ��[<%=(pageNo-1)*pageSize+1 %>-<%=(pageNo*pageSize>totalNum)?totalNum:pageNo*pageSize %>]�� 
            
            [<a href="ActionServlet?actionPath=staff&pageNo=<%=pageModel.getPreviousPageNo()%>&pageSize=<%=pageSize %>&totalNum=<%=totalNum %>&flag=<%=flag %>&command=<%=flag %>&staffNum=<%=staffNum %>&staffName=<%=staffName %>&sex=<%=sex %>&agePeriod=<%=agePeriod %>&degree=<%=degree %>&position=<%=position %>">ǰһҳ</A>]
            [<a href="ActionServlet?actionPath=staff&pageNo=<%=pageModel.getNextPageNo()%>&pageSize=<%=pageSize %>&totalNum=<%=totalNum %>&flag=<%=flag %>&command=<%=flag %>&staffNum=<%=staffNum %>&staffName=<%=staffName %>&sex=<%=sex %>&agePeriod=<%=agePeriod %>&degree=<%=degree %>&position=<%=position %>">��һҳ</A>] 
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
