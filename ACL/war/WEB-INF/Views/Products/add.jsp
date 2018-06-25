<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<!DOCTYPE html>
<html>
	<head>
		<title>Creacion de Producto</title>
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
		<span class="nav"><a href="/products">Regresar al Menú</a></span>
		<h1>Crear un nuevo producto</h1>
		<form method="post" action="/products/add">
			<input type="hidden" name="action" value="productCreateDo"/>
			<table align=center>
				<tr>
					<td class="dif">Nombre</td>
					<td><input type="text" name="name" required pattern="([A-Za-z0-9])+"></td>
				</tr>
				<tr>
					<td class="dif">Descripción</td>
					<td><textarea name="description" required maxlength="1500" pattern="([A-Za-z0-9])+"></textarea></td>
				</tr>
				<tr>
					<td class="dif">Precio PE:1.25</td>
					<td><input type="text" name="price" maxlength="9" required pattern="[0-9]*(\.[0-9]{1,2})?"></td>
				</tr>
				<tr>
					<td class="dif">Stock PE:30</td>
					<td><input type="text" name="stock" maxlength="9" required pattern="[0-9]*"></td>
				</tr>
				<tr>
					<td class="dif">Disponibilidad</td>
					<td>
						<select name=availability>
						  <option value="Disponible">Disponible</option>
						  <option value="No Disponible">No Disponible</option>
						</select></td>
				</tr>
				<tr>
					<td class="dif">Expiracion</td>
					<td>
						<input type="date" name="expiration" required>
					</td>
				</tr>
				<tr class="dif">
					<td colspan="2"><input type="submit" value="Subir"></td>
				</tr>
			</table>
		</form>
		<br><div><%=mensaje%></div>
	</body>
</html>