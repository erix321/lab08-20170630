<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entity.Product"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%List<Product> products=(List<Product>)request.getAttribute("products");
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
	String availability="";%>
<!DOCTYPE html>
<html>
	<head>
		<title>Productos</title>
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
		<span class="nav"><a href="/products/add">Crear Producto</a></span>
		<h1>Productos</h1>
		<% if (products.size() > 0) { %>
			<span class="heading"><% out.println(products.size());%> productos obtenidos:</span><br>
			<table align="center">
				<tr>
					<td class="dif">Nombre</td>
					<td class="dif">Descripción</td>
					<td class="dif">Precio</td>
					<td class="dif">Stock</td>
					<td class="dif">Disponibilidad</td>
					<td class="dif">F. de Creacion</td>
					<td class="dif">Vencimiento</td>					
				</tr>
			<% for (int i = 0;i<products.size();i++) { %>
				<% Product p = (Product)products.get(i); %>
				<% if(p.isStatus()){
					availability="Disponible";
					}else{
					availability="No Disponible";
					}%>
				<tr>
					<td><a href="products/view?productId=<%=p.getId()%>">
					<%=p.getName() %></a></td>
					<td><textarea class="dif2" name="description" required readonly><%=p.getDescription() %></textarea></td>
					<td><%=p.getPrice() %></td>
					<td><%=p.getStock() %></td>
					<td><%=availability %></td>
					<td><%=date.format(p.getCreated()) %></td>
					<td><%=date.format(p.getExpiration()) %></td>					
				</tr>
			<% } %>
			</table>
		<% } else { %>
			<span class="heading">No se encontraron productos coincidentes.</span>
		<%} %>
	</body>
</html>