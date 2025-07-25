<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Error Page</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <%@ include file="header.jsp" %> <!-- Added header -->
        <%@ page isErrorPage="true" %>
        <%
            String msg = (String) request.getAttribute("result");
            out.print("<h3>" + msg + "</h3>");
            session.invalidate();
        %>
        <%@ include file="footer.jsp" %> <!-- Added footer -->
    </body>
</html>