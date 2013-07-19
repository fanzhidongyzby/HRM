package action;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 注意：这个文件不要再改动了，这是个标准文件，就是这么写的
		
		String path = request.getParameter("actionPath");
		//System.out.println(path);
		String profile = this.getServletContext().getInitParameter("action");
		Properties pro = new Properties();
		InputStream in = this.getServletContext().getResourceAsStream(profile);
		pro.load(in);

		if (pro.getProperty(path) != null) {
			try {
				Action action = (Action) Class.forName(pro.getProperty(path))
						.newInstance();
				action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
}
