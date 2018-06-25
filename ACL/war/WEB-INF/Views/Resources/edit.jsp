<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entity.Resource"%>
<%@ page import="java.text.SimpleDateFormat"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<% Resource r = (Resource)request.getAttribute("resource");String option="";%>
<%if(r.isStatus()==false){option="selected";}
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Actualizacion de Rol</title>
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
		<h1>Actualizar un Recurso</h1>
		<form method="post" action="/resources/edit">
			<input type="hidden" name="action" value="resourcesEditDo"/>
			<table align="center">
				<tr>
					<td class="dif">Url</td>
					<td><input type="text" name="url" value="<%=r.getUrl() %>" pattern="(([A-Za-z0-9]+(\/?))+"></td>
				</tr>
				<tr>
					<td class="dif">Estado</td>
					<td>
						<select name=estatus>
						  <option value="Activado">Activado</option>
						  <option value="Desactivado" <%=option%>>Desactivado</option>
						</select></td>
				</tr>
				<tr class="dif">
					<td colspan="2"><input type="submit" value="Subir"></td>
				</tr>
			</table>
			<input type="hidden" name="resourceId" value="<%=r.getId()%>"/>
		</form>
		<br><div><%=mensaje%></div>
	</body>
</html>