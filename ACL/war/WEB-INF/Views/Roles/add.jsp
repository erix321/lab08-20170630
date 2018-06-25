<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<!DOCTYPE html>
<html>
	<head>
		<title>Creacion de Rol</title>
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
		<span class="nav"><a href="/roles">Regresar al Menú</a></span>
		<h1>Crear un nuevo Rol</h1>
		<form method="post" action="/roles/add">
			<input type="hidden" name="action" value="roleCreateDo"/>
			<table align=center>
				<tr>
					<td class="dif">Nombre</td>
					<td><input type="text" name="name" required pattern="([A-Za-z0-9])+"></td>
				</tr>
				<tr>
					<td class="dif">Estado</td>
					<td>
						<select name=estatus>
						  <option value="Activado">Activado</option>
						  <option value="Desactivado">Desactivado</option>
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