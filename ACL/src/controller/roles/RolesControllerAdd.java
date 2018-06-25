package controller.roles;

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

import model.entity.PMF;
import model.entity.*;

@SuppressWarnings("serial")
public class RolesControllerAdd extends HttpServlet {
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
						if(request.getParameter("action")==null||!request.getParameter("action").equals("roleCreateDo")){
							RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/Views/Roles/add.jsp");
							dispatcher.forward(request, response);
						}else{
							pm = PMF.get().getPersistenceManager();
							query= "select from " + Role.class.getName()
									+ " where name == '"+request.getParameter("name")+"'";
							List<Role> roles = (List<Role>)pm.newQuery(query).execute();
							if(roles.size()==0){
								boolean estatus=false;
								if(request.getParameter("estatus").equals("Activado")){
									estatus=true;
								}
								SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
								Role r = null;
								try {
									r = new Role(
									(String)request.getParameter("name"),
									estatus);
									pm.makePersistent(r);
								} catch (Exception e) {
									e.printStackTrace();
								}finally {
									pm.close();
									if(r!=null){
										request.setAttribute("roleId",r.getId());
										RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/roles/view");
										dispatcher.forward(request, response);
									}else{
										request.setAttribute("mensaje", "Error Inesperado");
										RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/WEB-INF/Views/Roles/add.jsp");
										dispatcher.forward(request, response);
									}
								}
							}else{
								request.setAttribute("mensaje", "Rol ya Existente");
								RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/WEB-INF/Views/Roles/add.jsp");
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
