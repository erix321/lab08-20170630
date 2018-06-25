package test;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import model.entity.*;

@SuppressWarnings("serial")
public class Test extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String query;PersistenceManager pm = PMF.get().getPersistenceManager();
		query= "select from " + User.class.getName();
		List<User> accesos = (List<User>)pm.newQuery(query).execute();
		for(int i=0;i<accesos.size();i++)
		System.out.println(accesos.get(i).getId());
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
				doGet(request, response);
			}	
	}
