<%!private int tryCounter = 0; 
private long failTime = 0;%>

<%@page import="java.util.Date"%>
<%@page import="ua.itea.Auth" %>

<%
	String login = request.getParameter("login");
	String password = request.getParameter("password");
	boolean showForm = true;
	String message = "<h1 style = 'color:red;'>ACCESS DENIED</h1>";
		
	if(login != null && password != null){
		// if(login.equals("admin") && password.equals("123")){
		if(new Auth().getLogin(login,password)){
			message = "<h1 style = 'color:green;'>ACCESS GRANTED</h1>";
			showForm = false;
		} else {
			tryCounter++;
		}

		if (tryCounter >= 3){
			showForm = false;
			if(failTime == 0){
				failTime = new Date().getTime();
			}
		} 
		
	out.write(message);
	if (tryCounter < 3){
	out.write("<br>Try# " + tryCounter);
	}

		if(failTime!=0){
			long curTime = ((failTime+60000) - new Date().getTime()) / 1000;
				if(curTime < 0){
					tryCounter = 0;
					failTime = 0;
					showForm = true;
				}
		out.write("<br/> Time Left:  00:" + curTime);
		}
	}	
	
	if (showForm){
%>
	<form action="auth2.jsp">
		<center>
		<table>
			<tr>
				<td width = "100px" align = "left">Login</td>
				<td width = "100px" align = "center"><input type="text" name="login"/></td>
			</tr>
			<tr>
				<td width = "100px" align = "left">Password</td>
				<td width = "100px" align = "center"><input type="text" name="password"/>
				</td>
			</tr>
			<tr>
				<td width = "100px" align = "center"></td>
				<td width = "100px" align = "right"><input type="submit" value="OK"/>
			</tr>
		</table>
	</form>

<%}%>
