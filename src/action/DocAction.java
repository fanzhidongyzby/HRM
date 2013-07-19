package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.document;
import model.resume;
import dao.docDao;

public class DocAction implements Action {

	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<body background='home/images/bg.png'>");
		
		String opp="";
		String args="";
		
		if(request.getParameter("opp")!=null)
			opp=request.getParameter("opp");
		if(request.getParameter("args")!=null)
			args=request.getParameter("args");
		
		int docId=0;
		int staffId=0;
		String docNum="";
		String docName="";
		String docAbs="";
		String docCom="";
		int type=0;
		
		if(request.getParameter("docId")!=null)
			docId=Integer.parseInt(request.getParameter("docId"));
		if(request.getParameter("staffId")!=null)
			staffId=Integer.parseInt(request.getParameter("staffId"));
		if(request.getParameter("docNum")!=null)
			docNum=request.getParameter("docNum");
		if(request.getParameter("docName")!=null)
			docName=request.getParameter("docName");
		if(request.getParameter("docAbs")!=null)
			docAbs=request.getParameter("docAbs");
		if(request.getParameter("docCom")!=null)
			docCom=request.getParameter("docCom");
		if(request.getParameter("docType")!=null)
			type=Integer.parseInt(request.getParameter("docType"));
		
		String docType="";
		switch(type)
		{
		case 1:docType="����";break;
		case 2:docType="����";break;
		case 3:docType="����";break;
		case 4:docType="����";break;
		}
	
		docDao docd=new docDao();
		document doc=null;
		if("delete".equals(opp))
		{
			StringTokenizer token =new StringTokenizer(args,"-");
			while(token.hasMoreTokens())
			{
				int dId=Integer.parseInt(token.nextToken());
				docd.delete(dId);
			}
			out.println("<script language='javascript'>" +
					"location.href='home/doc.jsp?staffId=" +staffId+
					"';</script>");
		}
		else if("add".equals(opp))
		{
			//��֤
			String warning="";
			if(warning.equals(""))
			{
				doc=new document();
				doc.setDocID(docd.nextID());
				doc.setStaffID(staffId);
				doc.setDocNum(docNum);
				doc.setDocName(docName);
				doc.setDocAbs(docAbs);
				doc.setDocCom(docCom);
				doc.setDocType(docType);
				docd.newDoc(doc);
				warning="������Ϣ��ӳɹ���";
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"location.href='home/doc.jsp?staffId=" +staffId+
						"';</script>");
			}
			else
			{
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"history.go(-1);</script>");
			}
		}
		else if("edit".equals(opp))
		{
			//��֤
			String warning="";
			if(warning.equals(""))
			{
				doc=docd.findByID(docId);
				doc.setDocNum(docNum);
				doc.setDocName(docName);
				doc.setDocAbs(docAbs);
				doc.setDocCom(docCom);
				doc.setDocType(docType);
				docd.edit(doc);
				warning="������Ϣ���³ɹ���";
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"location.href='home/doc.jsp?staffId=" +staffId+
						"';</script>");
			}
			else
			{
				out.println("<script language='javascript'>" +
						"alert('"+warning+"');" +
						"history.go(-1);</script>");
			}
		}		
		out.print("</body>");
		out.close();
	}

}
