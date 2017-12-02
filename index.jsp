<%@ page language="java" errorPage="errorPage.jsp" %>

<html>

<head>
    <title>Class Registration Login</title>
</head>

<BODY BGCOLOR="#FDF5E6">
<h2>Notes for Ted:</h2>
<li>There are extra Java, JSP files in my submission because I started the midterm on July 11 using a sample application that I had built.  It was a combination of several sample WAR files that you had given us.  I did not have enough time to delete the extra files. 
<li>I was hoping to use Log4j to do my debugging logging but I could not get it to work for the midterm application (that is why there are java classes in the log package and Log4j Jars and config file)
<br>
<hr>
<br>

<center>
<H1> CyTech Computer School </H1>
<H1> Class Registration System (by John Knight)</H1>



<form action="/JKnightGenericView-DB/LoginServletNew2" method="POST">

<%
	String rejectReason = (String)request.getAttribute("rejectReason");
	if(rejectReason!=null)
	{
%>
<p align="center"><font size="5" color=red><%=rejectReason%></font></p>
<%
	}
	
	
	String userName = request.getParameter("userName");
	if(userName==null || userName.equals(""))
	{
		Cookie[] cookies = request.getCookies();
		userName = getCookieValue(cookies,
				"userName", "");
	}
	String password = request.getParameter("password");
		if(password==null)
			password="";
%>

<Br>

<Table>
	<tr>
		<td>User Name:
		<td><INPUT type="text" name="userName" value="<%=userName%>">
		
		
	<tr>
		<td>Password:
		<td><INPUT type="password" name="password" value="<%=password%>">
</Table>


<P>

<INPUT TYPE="submit" value="Login!">

</form>
</center>
</body>
</html>
<%!
	static String getCookieValue(Cookie[] cookies, String cookieName,
			String defaultValue) {
		for (int i = 0; cookies!=null && i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookieName.equals(cookie.getName()))
				return (cookie.getValue());
		}
		return (defaultValue);
	}
	%>