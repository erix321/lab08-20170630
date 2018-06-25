package controller.users;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
//import java.util.Date;

import com.google.appengine.api.users.UserServiceFactory;

import model.entity.Access;
import model.entity.PMF;
import model.entity.Resource;
import model.entity.Role;
import model.entity.User;

@SuppressWarnings("serial")
public class UsersControllerAdd extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String query;PersistenceManager pm = PMF.get().getPersistenceManager();
		com.google.appengine.api.users.User uGoogle=UserServiceFactory.getUserService().getCurrentUser();
		if(uGoogle==null){
			request.setAttribute("mensaje","Porfavor, Logueese primero.");
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/Views/Access/error.jsp");
			dispatcher.forward(request, response);
		}else{
			query="select from "+User.class.getName()+" where email=='"+uGoogle.getEmail()+
					"' && status==true";
			List<User> uSearch=(List<User>)pm.newQuery(query).execute();
			if(uSearch.isEmpty()){
				request.setAttribute("mensaje","Usted no tiene una cuenta en la pagina web.");
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/Views/Access/error.jsp");
				dispatcher.forward(request, response);
			}else{
				System.out.println(request.getServletPath());
				query="select from "+Resource.class.getName()+" where url=='"+request.getServletPath()+
						"' && status==true";
				List<Resource> rSearch=(List<Resource>)pm.newQuery(query).execute();
				if(rSearch.isEmpty()){
					request.setAttribute("mensaje","No existe el recurso requerido o no se encuentra activado.");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/Views/Access/error.jsp");
					dispatcher.forward(request, response);
				}else{
					query="select from "+Access.class.getName()+" where idRole=="+
					uSearch.get(0).getIdRole()+" && idUrl=="+rSearch.get(0).getId()+
					" && status==true";
					List<Access> aSearch=(List<Access>)pm.newQuery(query).execute();
					if(aSearch.isEmpty()){
						request.setAttribute("mensaje","Usted no tiene accesso.");
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/Views/Access/error.jsp");
						dispatcher.forward(request, response);
					}else{
						if(request.getParameter("action")==null||!request.getParameter("action").equals("userCreateDo")){
							query= "select from " + Role.class.getName();
							List<Role> roles = (List<Role>)pm.newQuery(query).execute();
							request.setAttribute("roles", roles);
							RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/add.jsp");
							dispatcher.forward(request, response);
						}else{
							System.out.println(request.getParameter("idRole"));
							query= "select from " + User.class.getName()
									+ " where email == '"+request.getParameter("email")+"'";
							List<User> usuarios = (List<User>)pm.newQuery(query).execute();
							if(usuarios.size()==0){
								boolean estatus=false;
								if(request.getParameter("estatus").equals("Activado")){
									estatus=true;
								}
								boolean gender=false;
								if(request.getParameter("gender").equals("Masculino")){
									gender=true;
								}
								SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
								User u = null;
								try {
									u = new User(
									(String)request.getParameter("email"),
									date.parse(request.getParameter("birth")),
									estatus,gender,
									new Long(request.getParameter("idRole")));
									pm.makePersistent(u);
								} catch (NumberFormatException | ParseException e) {
									e.printStackTrace();
								}finally {
									pm.close();
									if(u!=null){
										request.setAttribute("userId",u.getId());
										RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/users/view");
										dispatcher.forward(request, response);
									}else{
										request.setAttribute("mensaje", "Error Inesperado");
										RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/add.jsp");
										dispatcher.forward(request, response);
									}
								}
							}else{
								query= "select from " + Role.class.getName();
								List<Role> roles = (List<Role>)pm.newQuery(query).execute();
								request.setAttribute("roles", roles);
								request.setAttribute("mensaje", "Usuario ya Existente");
								RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/WEB-INF/Views/Users/add.jsp");
								dispatcher.forward(request, response);
							}
						}
					}
				}
			}
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
			doGet(request, response);
		}	
}
