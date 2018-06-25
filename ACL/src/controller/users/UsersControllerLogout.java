package controller.users;

import java.io.IOException;

import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.google.appengine.api.users.*;
@SuppressWarnings("serial")
public class UsersControllerLogout extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		UserService us=UserServiceFactory.getUserService();
		User user = us.getCurrentUser();
		if(user==null){
			response.sendRedirect(us.createLoginURL("/users/login"));
		}else{
			response.sendRedirect(us.createLogoutURL("/users/login"));
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
			doGet(request, response);
		}	
}
