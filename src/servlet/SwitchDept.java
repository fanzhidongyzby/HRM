package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.department;
import dao.deptDao;

public class SwitchDept extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public SwitchDept() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost( request,  response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD'>");
		HttpSession session =request.getSession();
		//��ʼ�����Ų˵�			
		if(request.getParameter("curDeptId")!=null)//����ˢ��
		{
			int curDeptId=1;//��¼��ǰ�����Ĳ���
			curDeptId=Integer.parseInt(request.getParameter("curDeptId"));
			//�����Ƿ������һ���Բ���
			deptDao dd=new deptDao();
			department dept=dd.findByID(curDeptId);//��ǰ
			String affi=dept.getDeptAffi();				
			if(affi.endsWith("0"))//���һ��ڵ�
			{
				StringTokenizer token=new StringTokenizer(affi,"-");//��ȡ���Ӳ���ID
				int parentDeptId=1;//������ID
				if(token.hasMoreTokens())
				{
					parentDeptId=Integer.parseInt(token.nextToken());
				}
				session.setAttribute("curDeptId",parentDeptId);//��Բ˵������仯
				session.setAttribute("realCurDeptId",curDeptId);//֪ͨdmMain��ʾ��ȷ��Ŀ¼
			}	
			else
			{
				session.setAttribute("curDeptId",curDeptId);//����չ��
				session.removeAttribute("realCurDeptId");//����չ����ɾ��֪ͨ
			}	
		}		
		out.println(" </HEAD>");
		out.println("  <BODY background='./images/bg.png'>");
		out.println("<script>" +
				"window.parent.frames[\"dmMain\"].location.href(\"./home/index/YHChannelApply.jsp\");" +
				"window.parent.frames[\"menu\"].location.href(\"./home/index/YHMenu.jsp\");"+
			"</script>");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
