package controller.roles;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Transaction;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.UserServiceFactory;

import model.entity.*;

@SuppressWarnings("serial")
public class RolesControllerDelete extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		PersistenceManager pm = PMF.get().getPersistenceManager();String query;
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
						Key k=KeyFactory.createKey("Role",new Long(request.getParameter("roleId")));
						Role r = pm.getObjectById(Role.class, k);
						query= "select from " + User.class.getName()+" where idRole=="+r.getId();
						List<User> users = (List<User>)pm.newQuery(query).execute();
						if(users.size()>0){
							request.setAttribute("mensaje","Profavor, borre todos los usuarios con este rol antes de eliminarlo.");
							RequestDispatcher rd= getServletContext().getRequestDispatcher("/roles/view");
							rd.forward(request,response);
						}else{
							query= "select from " + Access.class.getName()+" where idRole=="+r.getId();
							List<Access> access = (List<Access>)pm.newQuery(query).execute();
							if(access.size()>0){
								request.setAttribute("mensaje","Profavor, borre todos los accesos con este rol antes de eliminarlo.");
								RequestDispatcher rd= getServletContext().getRequestDispatcher("/roles/view");
								rd.forward(request,response);
							}else{
								System.out.println("SECUMPLE3");
								Transaction tx=pm.currentTransaction();
								tx.begin();
								pm.deletePersistent(r);
								tx.commit();
								response.sendRedirect("/roles");
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

