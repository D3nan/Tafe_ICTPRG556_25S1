<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thank You</title>
        <link rel="stylesheet" type="text/css" href="../css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <h2>Online Bookstore</h2>
        <hr>
        <h3>Thank you for shopping with us.</h3>

        <!-- JSTL for processing the message -->
        <c:if test="${not empty result}">
            <table>
                <tr>
                    <td>${result}</td>
                </tr>
            </table>
        </c:if>

        <jsp:include page="footer.jsp" />
    </body>
</html>
