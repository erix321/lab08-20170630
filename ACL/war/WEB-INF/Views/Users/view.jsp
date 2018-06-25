<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.entity.User"%>
<%@ page import="model.entity.Role"%>
<%@ page import="java.text.SimpleDateFormat"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<%
	User user = (User)request.getAttribute("user");
	Role role = (Role)request.getAttribute("role");
	String estatus="Activado",gender="Masculino";
	if(user.isStatus()==false){estatus="Desactivado";}
	if(user.isGender()==false){gender="Femenino";}
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Caracteristicas de Usuario</title>
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
		<span class="nav"><a href="/users">Regresar al Menú</a></span>
		<h1>Visualización de Usuario</h1>
		<table align="center">
			<tr>
				<td class="dif">Email</td>
				<td><%=user.getEmail() %></td>
			</tr>
			<tr>
				<td class="dif">F. de Nacimiento</td>
				<td><%=date.format(user.getBirth()) %></td>
			</tr>
			<tr>
				<td class="dif">Estatus</td>
				<td><%=estatus %></td>
			</tr>
			<tr>
				<td class="dif">Genero</td>
				<td><%=gender %></td>
			</tr>
			<tr>
				<td class="dif">Rol</td>
				<td><%=role.getName() %></td>
			</tr>
			<tr>
				<td class="dif">Creación</td>
				<td><%=date.format(user.getCreated()) %></td>
			</tr>
		</table>
		<br><a href="/users/delete?action=userDelete&userId=<%=user.getId()%>">Eliminar Usuario</a>
		<br><a href="/users/edit?action=userUpdate&userId=<%=user.getId()%>">Actualizar Usuario</a>
		<br><div><%=mensaje%></div>
	</body>
</html>