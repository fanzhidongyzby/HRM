package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class upLoad extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public upLoad() {
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
			
		doPost(request, response);
		
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

		
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", -1);
		
		
		response.setContentType("text/html");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		
		

		HttpSession session=request.getSession();
		int iTotalByte, iTotalRead, iReadByte;
		iTotalByte = request.getContentLength();
		iTotalRead = 0;
		iReadByte = 0;
		byte[] Buffer = new byte[iTotalByte];
		if (iTotalByte > 0) {
			for (; iTotalRead < iTotalByte; iTotalRead += iReadByte) {
				try {
					iReadByte = request.getInputStream().read(Buffer,
							iTotalRead, iTotalByte - iTotalRead);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			String strContentType = request.getContentType();
			//数据处理开始
			String strBuffer = new String(Buffer);

		String strBoundary = "--"
					+ strContentType.substring(strContentType
							.lastIndexOf("=") + 1, strContentType.length());
			String strArray[] = strBuffer.split(strBoundary);

			String strSubString;
			int iBegin, iEnd;
			iBegin = 0;
			iEnd = 0;
			String strFieldName = "";
			String strFieldValue = "";
			String strFilePath = "";
			String strFileName = "";
			String strFileType = "";
			boolean bTrue;
			bTrue = false;
			int iLocation = 0;
			for (int iIndex = 1; iIndex < strArray.length - 1; iIndex++) {
				strSubString = strArray[iIndex];
				iBegin = strSubString.indexOf("name=\"", 0);
				if (iBegin != -1) {
					strFieldName = "";
					strFieldValue = "";
					strFilePath = "";
					strFileName = "";
					strFileType = "";
					iEnd = strSubString.indexOf("\"", iBegin + 6);
					strFieldName = strSubString.substring(iBegin + 6, iEnd);
					iBegin = strSubString.indexOf("filename=\"", 0);
					if (iBegin != -1) {
						bTrue = true;
					}
					iEnd = strSubString.indexOf("\r\n\r\n", 0);
					if (bTrue == true) {
						//文件路径
						strFilePath = strSubString.substring(iBegin + 10,
								strSubString.indexOf("\"", iBegin + 10));
						strFileName = strFilePath.substring(strFilePath
								.lastIndexOf("\\") + 1);
						strFileType = strSubString.substring(strSubString
								.indexOf("Content-Type: ") + 14,
								strSubString.indexOf("\r\n\r\n"));

		//文件数据
						iBegin = strSubString.indexOf("\r\n\r\n", iBegin);
						strFieldValue = strSubString.substring(iBegin + 4);
						strFieldValue = strFieldValue.substring(0,
								strFieldValue.lastIndexOf("\n") - 1);


		byte[] pFile = strFieldValue.getBytes();
						byte[] pFileExtend = new byte[pFile.length];
						iLocation = strBuffer.indexOf("filename=\"",
								iLocation);
						for (int kIndex = iLocation; kIndex < iTotalByte - 2; kIndex++) {
							if (Buffer[kIndex] == 13
									&& Buffer[kIndex + 2] == 13) {
								iLocation = kIndex + 4;
								break;
							}
						}
						for (int nIndex = 0; nIndex < pFile.length; nIndex++) {
							pFileExtend[nIndex] = Buffer[iLocation + nIndex];
						}
						
						ServletContext application=this.getServletContext();
						//保存到Local Disk;
						String type="";
						if(session.getAttribute("type")!=null)
							type=session.getAttribute("type").toString();
						int staffId=Integer.parseInt(session.getAttribute("staffId").toString());
						if(strFileName!=null&&!strFileName.equals(""))
						{
						if("head".equals(type))//头像
						{
							File testFile=new File(application.getRealPath("/")+"home/userPhoto/"+staffId+"/photo_head.jpg");
							if(testFile.exists())
							{
									testFile.delete();
									strFileName="t_photo_head.jpg";
							}
							else 
							{		testFile=new File(application.getRealPath("/")+"home/userPhoto/"+staffId+"/t_photo_head.jpg");
									if(testFile.exists())
									{
										testFile.delete();
										strFileName="photo_head.jpg";
									}
									else
										strFileName="photo_head.jpg";
							}
							
						}
						else
						{
							File dir=new File(application.getRealPath("/")+"home/userPhoto/"+staffId+"/");
							String[] files=dir.list();
							strFileName="cert"+files.length+".jpg";
						}
						File f=new File(application.getRealPath("/")+"home/userPhoto/"+staffId+"/");
						if(!f.exists())
							f.mkdir();
						FileOutputStream pFileOutputStream = new FileOutputStream(application.getRealPath("/")+"home/userPhoto/"+staffId+"/"+strFileName);
						pFileOutputStream.write(pFileExtend);
						pFileOutputStream.close();
						}else
						{
						
							out.println("<script>" +
									"alert('文件目录有误，上传失败。');" +
								"</script>");
						}
						out.println("<script>" +
								"opener.location.href('staffDetail.jsp?staffId="+staffId+"');" +
								"window.close();" +
							"</script>");
						//response.sendRedirect("staffDetail.jsp?staffId="+staffId);
						//response.getWriter().print("<script>"+
							//"self.location.replace('staffDetail.jsp?staffId="+staffId+"');"+
						//"</script>");
						
						//session.setAttribute(strFieldName+"_FileType",strFileType);
						//session.setAttribute(strFieldName+"_FilePath",strFilePath);
						// session.setAttribute(strFieldName+"_FileName",strFileName);
						// session.setAttribute(strFieldName,pFileExtend);
					} else {
						//strFieldValue = strSubString.substring(iEnd + 4);
						//strFieldValue = strFieldValue.substring(0,
								//strFieldValue.lastIndexOf("\n") - 1);
						//session.setAttribute(strFieldName,strFieldValue);
					}
					bTrue = false;
				}
	
		}
			//数据处理结束
		}
		
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
