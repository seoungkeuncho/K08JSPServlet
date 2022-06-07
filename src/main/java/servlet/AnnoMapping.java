package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
 web.xml에 매핑을 하는 대신 @WebServlet 어노테이션을 사용하여
 요청명에 대한 매핑을 한다. 편한방식이지만 차후 유지보수를 위해서는
 요청명과 서블릿 클래스의 관계를 명확히 해둔 상태에서 사용해야한다.
 */
@WebServlet("/13Servlet/AnnoMapping.do")
public class AnnoMapping extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//리퀘스트 영역에 속성값을 저장한다.,
		req.setAttribute("message", "@WebServlet으로 매핑");
		//View에 해당하는 JSP페이지로 포워드 한다.
		req.getRequestDispatcher("/13Servlet/AnnoMapping.jsp").forward(req, resp);
		/*
		 리퀘스트 영역은 포워드된 페이지까지 공유되므로 서블릿에서 저장한 속성값을
		 JSP에서 사용할수 있다.
		 */
	}
	

}