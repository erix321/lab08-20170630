<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.entity.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<%
	Role role = (Role)request.getAttribute("role");
	String estado="Activado";
	if(role.isStatus()==false){estado="Desactivado";}
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Caracteristicas del Rol</title>
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
		<span class="nav"><a href="/roles">Regresar al Menú</a></span>
		<h1>Visualización del Rol</h1>
		<table align="center">
			<tr>
				<td class="dif">Nombre</td>
				<td><%= role.getName() %></td>
			</tr>
			<tr>
				<td class="dif">Estado</td>
				<td><%=estado %></td>
			</tr>
			<tr>
				<td class="dif">Creación</td>
				<td><%=date.format(role.getCreated()) %></td>
			</tr>
		</table>
		<br><a href="/roles/delete?action=roleDelete&roleId=<%=role.getId()%>">Eliminar Rol</a>
		<br><a href="/roles/edit?action=roleUpdate&roleId=<%=role.getId()%>">Actualizar Rol</a>
		<br><div><%=mensaje%></div>
	</body>
</html>