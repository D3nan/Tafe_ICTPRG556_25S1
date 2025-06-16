<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <!-- Include header -->
        <jsp:include page="header.jsp" />

        <h1>Shopping Cart Check Out</h1>

        <form method="post" action="jsp/final.jsp">
            <input type="hidden" name="action" value="validate_credit">
            <table>
                <thead>
                    <tr>
                        <th colspan="2">You have selected to purchase the following items</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- JSTL to iterate over the cart items -->
                    <c:if test="${not empty sessionScope.cart}">
                        <c:set var="totalCostOfOrder" value="0.0" scope="page" />
                        <c:forEach var="entry" items="${sessionScope.cart.entrySet()}">
                            <c:set var="item" value="${entry.value}" />
                            <c:set var="totalCostOfOrder" value="${totalCostOfOrder + item.orderCost}" scope="page" />
                            <tr>
                                <td>${item}</td>
                            </tr>
                        </c:forEach>
                        
                        <!-- Format totalCostOfOrder to 2 decimal places -->
                        <c:set var="totalOrderString" value="${totalCostOfOrder}" />
                        <c:set var="integerPart" value="${fn:substringBefore(totalOrderString, '.')}" />
                        <c:set var="decimalPart" value="${fn:substringAfter(totalOrderString, '.')}" />
                        <c:if test="${fn:length(decimalPart) < 2}">
                            <c:set var="decimalPart" value="${decimalPart}0" />
                        </c:if>
                        <c:if test="${fn:length(decimalPart) > 2}">
                            <c:set var="decimalPart" value="${fn:substring(decimalPart, 0, 2)}" />
                        </c:if>
                        <c:set var="totalOrderInDollars" value="${integerPart}.${decimalPart}" />
                    </c:if>
                </tbody>
            </table>

            <p>Please input the following information.</p>

            <table>
                <tr>
                    <td>Last name:</td>
                    <td><input type="text" name="lastname" size="25"></td>
                </tr>
                <tr>
                    <td>Street:</td>
                    <td><input type="text" name="street" size="25"></td>
                </tr>
                <tr>
                    <td>City:</td>
                    <td><input type="text" name="city" size="25"></td>
                </tr>
                <tr>
                    <td>State:</td>
                    <td><input type="text" name="state" size="2"></td>
                </tr>
                <tr>
                    <td>Zip code:</td>
                    <td><input type="text" name="zipcode" size="10"></td>
                </tr>
                <tr>
                    <td>Phone #:</td>
                    <td>
                        <input type="text" name="phone" size="12">
                    </td>
                </tr>
                <tr>
                    <td>Credit Card #:</td>
                    <td><input type="text" name="card_num" size="25"></td>
                </tr>
                <tr>
                    <td>Expiration (mm/yy):</td>
                    <td>
                        <input type="text" name="expires" size="2">/
                        <input type="text" name="expires2" size="2">
                    </td>
                </tr>
                <tr>
                    <td>Order Amount $</td>
                    <td><input type="text" name="amount" value="${totalOrderInDollars}" readonly></td>
                </tr>
            </table>

            <p><input type="submit" value="Submit"></p>
        </form>

        <!-- Include footer -->
        <jsp:include page="footer.jsp" />
    </body>
</html>
