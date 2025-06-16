<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Error Page</title>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
    <jsp:include page="header.jsp" />

    <c:if test="${not empty result}">
        <h3>${result}</h3>
    </c:if>

    <%-- session.invalidate() must remain as scriptlet --%>
    <%
        session.invalidate();
    %>

    <jsp:include page="footer.jsp" />
</body>
</html>

<%--
Original code:

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

--%>
