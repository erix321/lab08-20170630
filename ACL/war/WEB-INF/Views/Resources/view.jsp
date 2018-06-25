<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.entity.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<%
	Resource resource = (Resource)request.getAttribute("resource");
	String estado="Activado";
	if(resource.isStatus()==false){estado="Desactivado";}
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Caracteristicas del Recurso</title>
		<link rel="stylesheet" type="text/css" href="/stylesheets/styles.css"/>
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
		<span class="nav"><a href="/resources">Regresar al Menú</a></span>
		<h1>Visualización del Recurso</h1>
		<table align="center">
			<tr>
				<td class="dif">Nombre</td>
				<td><%=resource.getUrl() %></td>
			</tr>
			<tr>
				<td class="dif">Estado</td>
				<td><%=estado %></td>
			</tr>
		</table>
		<br><a href="/resources/delete?action=resourceDelete&resourceId=<%=resource.getId()%>">Eliminar Recurso</a>
		<br><a href="/resources/edit?action=resourceUpdate&resourceId=<%=resource.getId()%>">Actualizar Recurso</a>
		<br><div><%=mensaje%></div>
	</body>
</html>