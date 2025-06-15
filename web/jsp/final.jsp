<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thank You</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <%@ include file="header.jsp" %> <!-- Added header -->
        
        <h2>Online Bookstore</h2>
        <hr>
        <h3>Thank you for shopping with us.</h3>
        <%
            String message = (String) request.getAttribute("result");
            session.invalidate();
        %>
        <table>
            <tr>
                <td><%= message%></td>
            </tr>
        </table>
        
        <%@ include file="footer.jsp" %> <!-- Added footer -->
    </body>
</html>