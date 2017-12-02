<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c" %>
          
<%-- 
Example from
http://www.jsptutorial.net/introducing-to-jstl.aspx
 --%>          
          
<html>
    <head>
        <title>JSTL page</title>
        <style type="text/css">
            .odd{background-color:white}
            .even{background-color:gray}
        </style>
    </head>
    <body>
        <table border="1" width="100px">
            <c:forEach begin="1" end="10" step="1" var="c">
                <c:choose>
                    <c:when test = "${c%2 ==0}">
                        <tr class="even">
                            <td><c:out value="${c}" /></td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <tr class="odd">
                            <td><c:out value="${c}" /></td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </table>
    </body>
</html>