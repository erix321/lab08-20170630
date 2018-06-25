<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entity.Access"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%List<Access> accesos=(List<Access>)request.getAttribute("accesos");
	String[]rolesName=(String[])request.getAttribute("rolesName");
	String[]resourcesName=(String[])request.getAttribute("resourcesName");
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
	String estado="";%>
<!DOCTYPE html>
<html>
	<head>
		<title>Accesos</title>
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
		<span class="nav"><a href="/access/add">Crear Acceso</a></span>
		<h1>Búsqueda de Accesos</h1>
		<% if (accesos.size() > 0) { %>
			<span class="heading"><% out.println(accesos.size());%> accesos obtenidos:</span><br>
			<table align="center">
				<tr>
					<td class="dif">Rol</td>
					<td class="dif">Recurso</td>
					<td class="dif">Estado</td>
				</tr>
			<% for (int i = 0;i<accesos.size();i++) { %>
			<% Access a = (Access)accesos.get(i); %>
				<% if(a.isStatus()){
					estado="Activado";
					}else{
					estado="Desactivado";
					}%>
				<tr>
					<td><a href="access/view?accessId=<%=a.getId()%>">
					<%=rolesName[i] %></a></td>
					<td><%=resourcesName[i] %></td>
					<td><%=estado%></td>
				</tr>
			<% } %>
			</table>
		<% } else { %>
			<span class="heading">No se encontraron accesos coincidentes.</span>
		<%} %>
	</body>
</html>