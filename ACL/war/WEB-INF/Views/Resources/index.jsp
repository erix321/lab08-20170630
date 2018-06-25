<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entity.Resource"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%List<Resource> recursos=(List<Resource>)request.getAttribute("recursos");
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
	String estado="";%>
<!DOCTYPE html>
<html>
	<head>
		<title>Recursos</title>
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
		<span class="nav"><a href="/resources/add">Crear Recurso</a></span>
		<h1>Búsqueda de Recursos</h1>
		<% if (recursos.size() > 0) { %>
			<span class="heading"><% out.println(recursos.size());%> recursos obtenidos:</span><br>
			<table align="center">
				<tr>
					<td class="dif">Nombre</td>
					<td class="dif">Estado</td>
				</tr>
			<% for (int i = 0;i<recursos.size();i++) { %>
				<% Resource p = (Resource)recursos.get(i); %>
				<% if(p.isStatus()){
					estado="Activado";
					}else{
					estado="Desactivado";
					}%>
				<tr>
					<td><a href="resources/view?resourceId=<%=p.getId()%>">
					<%=p.getUrl() %></a></td>
					<td><%=estado %></td>
				</tr>
			<% } %>
			</table>
		<% } else { %>
			<span class="heading">No se encontraron recursos coincidentes.</span>
		<%} %>
	</body>
</html>