<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entity.Role"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<% List<Role> roles=(List<Role>)request.getAttribute("roles");%>

<!DOCTYPE html>
<html>
	<head>
		<title>Creacion de Usuario</title>
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
		<span class="nav"><a href="/users">Regresar al Menú</a></span>
		<h1>Crear un nuevo usuario</h1>
		<form method="post" action="/users/add">
			<input type="hidden" name="action" value="userCreateDo"/>
			<table align=center>
				<tr>
					<td class="dif">Email</td>
					<td><input type="text" name="email" required pattern="([A-Za-z0-9]|_|\.|-|@)+"></td>
				</tr>
				<tr>
					<td class="dif">F. de Nacimiento</td>
					<td>
						<input type="date" name="birth" required>
					</td>
				</tr>
				<tr>
					<td class="dif">Estado</td>
					<td>
						<select name="estatus">
						  <option value="Activado">Activado</option>
						  <option value="Desactivado">Desactivado</option>
						</select></td>
				</tr>
				<tr>
					<td class="dif">Genero</td>
					<td>
						<select name="gender">
						  <option value="Masculino">Masculino</option>
						  <option value="Femenino">Femenino</option>
						</select></td>
				</tr>
				<tr>
					<td class="dif">Rol</td>
					<td>
						<select name="idRole" required>
						<%for(int i=0;i<roles.size();i++){
							Role r=roles.get(i);
							out.println("<option value=\""+r.getId()+"\">"+r.getName()+"</option>");
						}%>
						</select></td>
				</tr>
				<tr class="dif">
					<td colspan="2"><input type="submit" value="Subir"></td>
				</tr>
			</table>
		</form>
		<br><div><%=mensaje%></div>
	</body>
</html>