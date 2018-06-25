<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entity.Role"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%List<Role> roles=(List<Role>)request.getAttribute("roles");
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
	String estado="";%>
<!DOCTYPE html>
<html>
	<head>
		<title>Roles</title>
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
		<span class="nav"><a href="/roles/add">Crear Rol</a></span>
		<h1>Búsqueda de Roles</h1>
		<% if (roles.size() > 0) { %>
			<span class="heading"><% out.println(roles.size());%> roles obtenidos:</span><br>
			<table align="center">
				<tr>
					<td class="dif">Nombre</td>
					<td class="dif">Estado</td>
					<td class="dif">F. de Creacion</td>
				</tr>
			<% for (int i = 0;i<roles.size();i++) { %>
				<% Role p = (Role)roles.get(i); %>
				<% if(p.isStatus()){
					estado="Activado";
					}else{
					estado="Desactivado";
					}%>
				<tr>
					<td><a href="roles/view?roleId=<%=p.getId()%>">
					<%=p.getName() %></a></td>
					<td><%=estado %></td>
					<td><%=date.format(p.getCreated()) %></td>
				</tr>
			<% } %>
			</table>
		<% } else { %>
			<span class="heading">No se encontraron roles coincidentes.</span>
		<%} %>
	</body>
</html>