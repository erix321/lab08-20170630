package controller.products;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.UserServiceFactory;

import model.entity.Access;
import model.entity.PMF;
import model.entity.Product;
import model.entity.Resource;
import model.entity.User;

@SuppressWarnings("serial")
public class ProductsControllerEdit extends HttpServlet {
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
						if(request.getParameter("action").equals("productEditDo")) {
							Key k=KeyFactory.createKey("Product",new Long(request.getParameter("productId")));
							Product p = pm.getObjectById(Product.class, k);
							int n=0;
							if(p.getName().equals(request.getParameter("name"))){
								n=1;
							}
							query = "select from " + Product.class.getName()
									+ " where name == '"+request.getParameter("name")+"'";
							List<Product> products = (List<Product>)pm.newQuery(query).execute();
							if(!(products.size()==n)){
								request.setAttribute("mensaje", "Producto ya Existente");
								request.setAttribute("product", p);
								RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/products/view");
								dispatcher.forward(request, response);
							}else{
							boolean status=false;
							if(request.getParameter("availability").equals("Disponible")){
								status=true;
							}
							SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
							p.setName(request.getParameter("name"));
							p.setDescription(request.getParameter("description"));
							p.setPrice(Double.parseDouble(request.getParameter("price")));
							p.setStatus(status);
							p.setStock(Integer.parseInt(request.getParameter("stock")));
							try {
								p.setExpiration(date.parse(request.getParameter("expiration")));
							} catch (ParseException e) {
								e.printStackTrace();
							}
							request.setAttribute("product", p);
							request.setAttribute("mensaje","");
							RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/Views/Products/view.jsp");
							dispatcher.forward(request, response);
							}
						}else{
							Key k=KeyFactory.createKey("Product",new Long(request.getParameter("productId")));
							Product p = pm.getObjectById(Product.class, k);
							request.setAttribute("product", p);
							RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/WEB-INF/Views/Products/edit.jsp");
							dispatcher.forward(request, response);
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

