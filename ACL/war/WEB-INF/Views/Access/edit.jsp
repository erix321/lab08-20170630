<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entity.Role"%>
<%@ page import="model.entity.Resource"%>
<%@ page import="model.entity.Access"%>
<%@ page import="java.text.SimpleDateFormat"%>
<% String mensaje=(String)request.getAttribute("mensaje");if(mensaje==null){mensaje="";}%>
<% List<Role> roles=(List<Role>)request.getAttribute("roles");
	List<Resource> recursos=(List<Resource>)request.getAttribute("recursos");String option="";%>
<% Access a = (Access)request.getAttribute("access");%>
<%if(a.isStatus()==false){option="selected";}
	SimpleDateFormat date=new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Actualizacion de Acceso</title>
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
		<h1>Actualizar un Acceso</h1>
		<form method="post" action="/access/edit">
			<input type="hidden" name="action" value="accessEditDo"/>
			<table align="center">
				<tr>
					<td class="dif">Rol</td>
					<td>
						<select name="idRole">
						<%for(int i=0;i<roles.size();i++){
							Role r=roles.get(i);
							String act="";
							if(r.getId().equals(a.getIdRole())){
								act=" selected";
							}
							out.println("<option value=\""+r.getId()+"\""+act+">"+r.getName()+"</option>");
						}%>
						</select></td>
				</tr>
				<tr>
					<td class="dif">Recurso</td>
					<td>
						<select name="idUrl">
						<%for(int i=0;i<recursos.size();i++){
							Resource r=recursos.get(i);
							String act="";
							if(r.getId().equals(a.getIdUrl())){
								act=" selected";
							}
							out.println("<option value=\""+r.getId()+"\""+act+">"+r.getUrl()+"</option>");
						}%>
						</select></td>
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
			<input type="hidden" name="accessId" value="<%=a.getId()%>"/>
		</form>
		<br><div><%=mensaje%></div>
	</body>
</html>