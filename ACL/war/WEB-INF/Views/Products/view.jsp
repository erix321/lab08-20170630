<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.entity.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<%
	Product product = (Product)request.getAttribute("product");
	String availability="Disponible";
	if(product.isStatus()==false){availability="No Disponible";}
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Caracteristicas de Producto</title>
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
		<span class="nav"><a href="/products">Regresar al Menú</a></span>
		<h1>Visualización de Producto</h1>
		<table align="center">
			<tr>
				<td class="dif">Nombre</td>
				<td><%= product.getName() %></td>
			</tr>
			<tr>
				<td class="dif">Descripcion</td>
				<td><textarea class="dif2" name="description" required readonly><%= product.getDescription() %></textarea></td>
			</tr>
			<tr>
				<td class="dif">Precio</td>
				<td><%= product.getPrice() %></td>
			</tr>
			<tr>
				<td class="dif">Stock</td>
				<td><%= product.getStock() %></td>
			</tr>
			<tr>
				<td class="dif">Disponibilidad</td>
				<td><%=availability %></td>
			</tr>
			<tr>
				<td class="dif">Expiracion</td>
				<td><%=date.format(product.getExpiration()) %></td>
			</tr>
			<tr>
				<td class="dif">Creación</td>
				<td><%=date.format(product.getCreated()) %></td>
			</tr>
		</table>
		<br><a href="/products/delete?action=productDelete&productId=<%=product.getId()%>">Eliminar Producto</a>
		<br><a href="/products/edit?action=productUpdate&productId=<%=product.getId()%>">Actualizar Producto</a>
		<br><div><%=mensaje%></div>
	</body>
</html>