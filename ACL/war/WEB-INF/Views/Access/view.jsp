<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.entity.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<%
	Access a = (Access)request.getAttribute("access");
	Role role = (Role)request.getAttribute("role");
	Resource resource = (Resource)request.getAttribute("resource");
	String estado="Activado";
	if(a.isStatus()==false){estado="Desactivado";}
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Caracteristicas del Acceso</title>
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
		<span class="nav"><a href="/access">Regresar al Menú</a></span>
		<h1>Visualización del Acceso</h1>
		<table align="center">
			<tr>
				<td class="dif">Rol</td>
				<td><%=role.getName() %></td>
			</tr>
			<tr>
				<td class="dif">Recurso</td>
				<td><%=resource.getUrl() %></td>
			</tr>
			<tr>
				<td class="dif">Estado</td>
				<td><%=estado %></td>
			</tr>
		</table>
		<br><a href="/access/delete?action=accessDelete&accessId=<%=a.getId()%>">Eliminar Acceso</a>
		<br><a href="/access/edit?action=accessUpdate&accessId=<%=a.getId()%>">Actualizar Acceso</a>
		<br><div><%=mensaje%></div>
	</body>
</html>