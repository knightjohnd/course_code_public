<%@ page language="java" errorPage="errorPage.jsp" import="java.util.*, mvc.model.*, mvc.view.*" %>
<%@ page session="true" %>

<HTML>
<HEAD><TITLE>View the List of your Registered Courses</TITLE></HEAD>

<%@ include file="header.jsp" %>


<H1 ALIGN="CENTER">View the List of your Registered Courses</H1>
<center>

<%
//String userNameString = (String)session.getAttribute("theName");
	LoginUser user =(LoginUser)session.getAttribute("LoginUser");
	
	//TODO - Remove hardcoding of userID
	//String userID = "01";
	String studentID = (String)session.getAttribute("StudentID");


%>
<%--  Username: <%= userNameString %>  --%>

	Username: <%=user.getFirstName()%> <%=user.getLastName()%><br>
	You are currently logged in as <%=user.getUserNameShort()%>
</center>
<br>
<hr>
<br><a href="/JKnightGenericView-DB/main.jsp">Return to Main page</a>
<br>

<Table border=0>
<tr>
<td>
<%
	//This view takes 3 key variables:
	//1. records is a Vector of String arrays
	//2. headers is an array of Headers (which contains a header and a type)
	//3. links is an optional array of Links (which contain a text, a URL,
	//	and a column index)

	//Two optional parameters:
	//1. StartPosition
	//2. NumPerPage


	// BEGIN - Throw ServletException if different objects are not found
	DataModel dm =(DataModel)request.getAttribute("Model");
	if(dm==null) {
		application.log("No DataModel is found");
		throw new ServletException("can't find the object named \"DataModel\"");
	}


	
//	List<Object[]> records =dm.getAllRegisteredClasses(studentID);
	List<Object[]> records = (List<Object[]>)session.getAttribute("RegisteredClassesList");	
	if(records==null) {
		application.log("No records object is found");
		throw new ServletException("can't find the object named \"Records\"");
	}

	String[] headers = dm.getColumnNames();
	if(headers==null) {
		application.log("No headers object is found");
		throw new ServletException("can't find the object named \"Headers\"");
	}

	int[] columnTypes = dm.getColumnTypes();
	if(columnTypes==null) {
		application.log("No columnTypes object is found");
		throw new ServletException("can't find the object named \"columnTypes\"");
	}
	// END - Throw ServletException if different objects are not found


    // BEGIN - Determine Start Position, Number per Page and Next Position
	String startPositionStr=request.getParameter("StartPosition");
	int startPos=0;
	if(startPositionStr!=null)
	{
		try{ startPos=Integer.parseInt(startPositionStr); }
		catch(Exception ignor){}
	}

	String numPerPageStr=request.getParameter("NumPerPage");
	int numPerPage=NUMBER_PER_PAGE;
	if(numPerPageStr!=null)
	{
		try{ numPerPage=Integer.parseInt(numPerPageStr); }
		catch(Exception ignor){}
	}

    int nextPos=startPos+numPerPage;
    // END - Determine Start Position, Number per Page and Next Position


	// BEGIN - Print out the Previous and Next Links above the main table
    if(startPos>0 ||  nextPos<records.size()){
    	out.println("<div align=right>");
        out.println("<Table border=0>");
        out.println("<tr>");
        if(startPos>0){
			int prevPos=startPos-numPerPage;
			if(prevPos<0){
				prevPos=0;
			}
			//to print out this
			//	<td><a href="ShowRecords.jsp?StartPosition=1">&lt;&lt;Prev</a></td>
			out.println("<td><a href=\"/JKnightGenericView-DB/ViewRegisteredClasses?StartPosition="+
				prevPos+"\">&lt;&lt;Prev</a></td>");
        }
	    if(nextPos<records.size()) {
			out.println("<td><a href=\"/JKnightGenericView-DB/ViewRegisteredClasses?StartPosition="+
				nextPos+"\">Next&gt;&gt;</a></td>");
		}
		out.println("</tr>");
		out.println("</Table>");
		out.println("</div>");
    }//end outer if
	// END - Print out the Previous and Next Links above the main table

%>
</td>
</tr>
<tr>
<td>

<Table border="1">
<tr>

<%
	// BEGIN - Display table headers

	String builtURL="";
	Object [] record=null;
	Link link=null;
	for(int i=0; i<headers.length; i++)	{
%>

	<th><%=headers[i]%>

<%	}

	if(hasAppendedLinks(links)) {
%>
	<th>&nbsp;

<%	}
	// END - Display table headers


	// BEGIN - Display table rows
	for(int i=startPos; i<startPos+numPerPage && i<records.size(); i++) {
		//vector elements must be String arrays, otherwise this will throw an exception
		record= records.get(i);
%>

	<tr>

<%
		for(int j=0; j<headers.length; j++) {
            //in case headers array is longer than record array
			if(j<record.length) {
				switch(columnTypes[j]) {
				case DataModel.DATA_TYPE_MONEY:
%>

		<td><%=DataFormatter.formatMoney(record[j])%></td>

<%					break;
				case DataModel.DATA_TYPE_DATE:
%>

		<td><%=DataFormatter.formatDate(record[j])%></td>

<%					break;			
						
				default:
					link=null;

				if((link=getLink(j, links))!=null){
					builtURL=link.getURL()+
					headers[0]+ "=" +record[0];
%>
		<td><a href="<%=builtURL%>"><%=record[j]%> </a> </td>

<%				} else {
%>
		<td><%=record[j]%></td>

<%				}
			}//end switch
		}//end if

			else {  //record String array is shorter than headers array

%>
		<td>&nbsp;</td>

<%			}//end else
		}//end inner for
		
		if(hasAppendedLinks(links)) {
%>

		<td>

<%			for(int k=0; links!=null && k<links.length; k++) {
				if(links[k].getText()!=null) {
					builtURL=links[k].getURL()+
					headers[0]+ "=" +record[0];
%>

			<a href="<%=builtURL%>"><%=links[k].getText()%> </a> <br>

<%				}//end if
			}//end for
%>
	 	</td>
<%
		}//end if
%>
	</tr>
<%
	}//end outer for
	
	// END - Display table rows	
	
%>

</Table>
</td>
</tr>
<tr>
<td>

<%
		// BEGIN - Print out the Previous and Next Links at the bottom of the table
        if(startPos>0 ||  nextPos<records.size()) {
        	out.println("<div align=right>");
          	out.println("<Table border=0>");
          	out.println("<tr>");
          	if(startPos>0){
	      		int prevPos=startPos-numPerPage;
	      		if(prevPos<0) {
                      prevPos=0;
                }
					//to print out this
					//	<td><a href="ShowRecords.jsp?StartPosition=1">&lt;&lt;Prev</a></td>
				out.println("<td><a href=\"/JKnightGenericView-DB/ViewRegisteredClasses?StartPosition="+
				prevPos+"\">&lt;&lt;Prev</a></td>");
          	}
        	if(nextPos<records.size()) {
				out.println("<td><a href=\"/JKnightGenericView-DB/ViewRegisteredClasses?StartPosition="+
				nextPos+"\">Next&gt;&gt;</a></td>");
          	}
        	out.println("</tr>");
        	out.println("</Table>");
        	out.println("</div>");
      	}//end outer if
      
		// END - Print out the Previous and Next Links at the bottom of the table      
%>



</td>
</tr>
</Table>
</center>

<%@ include file="footer.jsp" %>


<%!
// BEGIN - JSP Declarations section

// 5 Courses should be displayed per page
final static int NUMBER_PER_PAGE = 5;

//final static Link[] links = new Link[] { new Link(null, "/JKnightGenericView-DB/Review?", 1),
//				new Link("Details", "/JKnightGenericView-DB/RegisterForThisCourse?", -1),
//				new Link("Order", "/JKnightGenericView-DB/Order?", -1) };

final static Link[] links = new Link[] { new Link(null, "/JKnightGenericView-DB/Review?", 1),
				new Link("Drop", "/JKnightGenericView-DB/DropThisCourse?", -1) };


//Method hasAppendedLinks
boolean hasAppendedLinks(Link[] links) {
  for(int i=0; links!=null && i<links.length; i++) {
    if(links[i].getIndex()==-1)
      return true;
  }
  return false;
}

//Method to Check if the jth column is a link
Link getLink(int j,  Link[] links) {
  for(int i=0; links!=null && i<links.length; i++) {
    if(links[i].getIndex()!=-1 && links[i].getIndex()==j)
      return links[i];
  }
  return null;
}

// END - JSP Declarations section
%>