<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entity.User"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%List<User> users=(List<User>)request.getAttribute("users");
	String[]rolesName=(String[])request.getAttribute("rolesName");
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
	String estatus="",gender="";%>
<!DOCTYPE html>
<html>
	<head>
		<title>Usuarios</title>
		<link rel="stylesheet" type="text/css" href="/stylesheets/styles.css">
	</head>
	<body>
		<div class="bar">
			<a href="/roles">Roles</a>
			<a href="/users">Users</a>
			<a href="/resources">Resource</a>
			<a href="/access">Access</a>
			<a href="/products">Products</a>
			<a href="/users/login">Login</a>
			<a href="/users/logout">Logout</a>
		</div>
		<span class="nav"><a href="/users/add">Crear Usuario</a></span>
		<h1>Usuarios</h1>
		<% if (users.size() > 0) { %>
			<span class="heading"><% out.println(users.size());%> usuarios obtenidos:</span><br>
			<table align="center">
				<tr>
					<td class="dif">Email</td>
					<td class="dif">F. de Nacimiento</td>
					<td class="dif">Estatus</td>
					<td class="dif">Genero</td>
					<td class="dif">Rol</td>
					<td class="dif">F. de Creacion</td>
				</tr>
			<% for (int i = 0;i<users.size();i++) { %>
				<% User u = (User)users.get(i); %>
				<% if(u.isStatus()){
					estatus="Activado";
					}else{
					estatus="Desactivado";
					}
					if(u.isGender()){
					gender="Masculino";
					}else{
					gender="Femenino";
					}%>
				<tr>
					<td><a href="users/view?userId=<%=u.getId()%>">
					<%=u.getEmail() %></a></td>
					<td><%=date.format(u.getBirth()) %></td>
					<td><%=estatus%></td>
					<td><%=gender%></td>
					<td><%=rolesName[i] %></td>
					<td><%=date.format(u.getCreated()) %></td>
				</tr>
			<% } %>
			</table>
		<% } else { %>
			<span class="heading">No se encontraron usuarios coincidentes.</span>
		<%} %>
	</body>
</html>