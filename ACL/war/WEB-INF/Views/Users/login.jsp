<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.*"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<% User userG=(User)request.getAttribute("userG");%>
<!DOCTYPE html>
<html>
	<head>
		<title>Caracteristicas de Correo</title>
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
		<h1>Caracteristicas de Correo</h1>
			<p>Id del Correo: <%=userG.getUserId() %>
			<p>Correo: <%=userG.getEmail() %>
		<br><div><%=mensaje%></div>
	</body>
</html>