<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entity.User"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="model.entity.Role"%>
<% List<Role> roles=(List<Role>)request.getAttribute("roles");%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<% User u = (User)request.getAttribute("user");String option1="",option2="";%>
<%if(u.isStatus()==false){option1="selected";}
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
%>
<%if(u.isGender()==false){option2="selected";}%>
<!DOCTYPE html>
<html>
	<head>
		<title>Actualizacion de Usuario</title>
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
		<h1>Actualizar un Usuario</h1>
		<form method="post" action="/users/edit">
			<input type="hidden" name="action" value="userEditDo"/>
			<table align="center">
				<tr>
					<td class="dif">Email</td>
					<td><input type="text" name="email" value="<%=u.getEmail() %>" pattern="([A-Za-z0-9]|_|\.|-|@)+"></td>
				</tr>
				<tr>
					<td class="dif">F. de Nacimiento</td>
					<td>
						<input type="date" name="birth" value="<%=date.format(u.getBirth()) %>"required>
					</td>
				</tr>
				<tr>
					<td class="dif">Estado</td>
					<td>
						<select name="estatus">
						  <option value="Activado">Activado</option>
						  <option value="Desactivado" <%=option1%>>Desactivado</option>
						</select></td>
				</tr>
				<tr>
					<td class="dif">Genero</td>
					<td>
						<select name="gender">
						  <option value="Masculino">Masculino</option>
						  <option value="Femenino" <%=option2%>>Femenino</option>
						</select></td>
				</tr>
				<tr>
					<td class="dif">Rol</td>
					<td>
						<select name="idRole">
						<%for(int i=0;i<roles.size();i++){
							Role r=roles.get(i);
							String act="";
							if(r.getId().equals(u.getIdRole())){
								act=" selected";
							}
							out.print("<option value=\""+r.getId()+"\""+act+">"+r.getName()+"</option>");
						}%>
						</select></td>
				</tr>
				<tr class="dif">
					<td colspan="2"><input type="submit" value="Subir"></td>
				</tr>
			</table>
			<input type="hidden" name="userId" value="<%=u.getId()%>"/>
		</form>
		<br><div><%=mensaje%></div>
	</body>
</html>