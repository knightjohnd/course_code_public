<%@ page language="java" errorPage="errorPage.jsp"  import="mvc.model.*"%>
<html>
<head>
<title>Welcome Page</title>
</head>

<BODY BGCOLOR="#FDF5E6">
<center>
<h2>Course Registration Web Application (by John Knight)</h2>

<%

	LoginUser user =(LoginUser)session.getAttribute("LoginUser");
	String studentID = (String)session.getAttribute("StudentID");
// TODO - uncomment below so that page will verify whether user is able to view the page
// 	 	if(user==null) {
	if(user==null || studentID==null) {
		throw new Exception("You're not authorized to view this page.");
	}

	
// TODO - Change studentID so that it is no longer hard coded	
	String registerClassUrl=response.encodeURL("/JKnightGenericView-DB/RegisterClassServlet?StudentID="+studentID );
	String viewRegisteredClassesUrl=response.encodeURL("/JKnightGenericView-DB/ViewRegisteredClasses?StudentID="+studentID );
//	String registerClassUrl=response.encodeURL("/JKnightGenericView-DB/RegisterClassServlet?StudentID=01");	
//	String viewRegisteredClassesUrl=response.encodeURL("/JKnightGenericView-DB/ViewRegisteredClasses?StudentID=01" );
%>


	<H2>Hello, <%=user.getFirstName()%> <%=user.getLastName()%>!</H2>
	You are currently logged in as <%=user.getUserNameShort()%>.


<p>
Please select an option:
<ul>
	<li><a href="<%=registerClassUrl%>">
		Register a Class</a>
	<li><a href="<%=viewRegisteredClassesUrl%>">
		View All Your Registered Classes</a>

</ul>
</center>
</body>
</html>
