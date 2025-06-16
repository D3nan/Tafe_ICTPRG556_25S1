<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="model.Book, model.CartItem" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Online Bookshop</title>
        <link rel="stylesheet" type="text/css" href="css/style.css" />
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <h1>The following items are in your shopping cart</h1>
        <form name="form1" method="post" action="./books">
            <input type="hidden" name="Action" value="update_cart" />
            <table>
                <thead>
                    <tr>
                        <th>ISBN</th>
                        <th>Title</th>
                        <th>Price/unit</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty sessionScope.cart}">
                            <c:set var="totalCostOfOrder" value="0" scope="page" />
                            <c:forEach var="entry" items="${sessionScope.cart.entrySet()}">
                                <c:set var="isbn" value="${entry.key}" />
                                <c:set var="item" value="${entry.value}" />
                                <c:set var="book" value="${item.book}" />
                                <c:set var="quantity" value="${item.quantity}" />
                                <c:set var="price" value="${book.dollarPrice}" />
                                <c:set var="dollarCost" value="${item.dollarOrderCost}" />
                                <c:set var="cost" value="${item.orderCost}" />
                                <c:set var="totalCostOfOrder" value="${totalCostOfOrder + cost}" scope="page" />

                                <!-- Format item subtotal -->
                                <c:set var="subtotalString" value="${dollarCost}" />
                                <c:set var="subtotalIntegerPart" value="${fn:substringBefore(subtotalString, '.')}" />
                                <c:set var="subtotalDecimalPart" value="${fn:substringAfter(subtotalString, '.')}" />
                                <c:if test="${fn:length(subtotalDecimalPart) < 2}">
                                    <c:set var="subtotalDecimalPart" value="${subtotalDecimalPart}0" />
                                </c:if>
                                <c:if test="${fn:length(subtotalDecimalPart) > 2}">
                                    <c:set var="subtotalDecimalPart" value="${fn:substring(subtotalDecimalPart, 0, 2)}" />
                                </c:if>

                                <tr>
                                    <td>${isbn}</td>
                                    <td>${book.title}</td>
                                    <td>${price}</td>
                                    <td>
                                        <input type="text" name="${isbn}" size="2" value="${quantity}" maxlength="4" />
                                    </td>
                                    <td>${subtotalIntegerPart}.${subtotalDecimalPart}</td>
                                    <td align="center">
                                        <input type="checkbox" name="remove" value="${isbn}" />
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="4">
                                    <input type="submit" name="Submit" value="Update Cart" />
                                </td>
                                <td colspan="2" align="right">
                                    <!-- Format total cost -->
                                    <c:set var="orderTotal" value="${totalCostOfOrder}" />
                                    <c:set var="orderTotalString" value="${orderTotal}" />
                                    <c:set var="integerPart" value="${fn:substringBefore(orderTotalString, '.')}" />
                                    <c:set var="decimalPart" value="${fn:substringAfter(orderTotalString, '.')}" />
                                    <c:if test="${fn:length(decimalPart) < 2}">
                                        <c:set var="decimalPart" value="${decimalPart}0" />
                                    </c:if>
                                    <c:if test="${fn:length(decimalPart) > 2}">
                                        <c:set var="decimalPart" value="${fn:substring(decimalPart, 0, 2)}" />
                                    </c:if>
                                    <b>ORDER TOTAL $${integerPart}.${decimalPart}</b>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6">Your cart is empty.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </form>

        <div class="link-container">
            <p><a href="./books?action=continue">Continue Shopping</a></p>
            <p><a href="./books?Action=Checkout">Check Out</a></p>
        </div>

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
        <title>Online Bookshop</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <%@ include file="header.jsp" %> <!-- Added header -->
        
        <%@ page import="model.*" %>
        <%@ page import="java.util.*" %>
        <%@ page import="java.text.*" %>

        <h1>The following items are in your shopping cart</h1>
        <form name="form1" method="post" action="./books">
            <input type="hidden" name="Action" value="update_cart">
            <table>
                <thead>
                    <tr>
                        <th>ISBN</th>
                        <th>Title</th>
                        <th>Price/unit</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Map items = (Map) session.getAttribute("cart");
                        Set entries = items.entrySet();
                        Iterator iter = entries.iterator();
                        double totalCostOfOrder = 0.00;
                        Book book = null;
                        CartItem item = null;
                        while (iter.hasNext()) {
                            Map.Entry entry = (Map.Entry) iter.next();
                            String isbn = (String) entry.getKey();
                            item = (CartItem) entry.getValue();
                            book = item.getBook();
                            String title = book.getTitle();
                            String price = book.getDollarPrice();
                            int quantity = item.getQuantity();
                            double cost = item.getOrderCost();
                            String dollarCost = item.getDollarOrderCost();
                            totalCostOfOrder += cost;
                    %>
                    <tr>
                        <td><%= isbn%></td>
                        <td><%= title%></td>
                        <td><%= price%></td>
                        <td>
                            <input type="text" name="<%= isbn%>" size="2" value="<%= quantity%>" maxlength="4">
                        </td>
                        <td><%= dollarCost%></td>
                        <td>
                            <div align="center">
                                <input type="checkbox" name="remove" value="<%= isbn%>">
                            </div>
                        </td>
                    </tr>
                    <%
                        } // end while
                        DecimalFormat dollars = new DecimalFormat("0.00");
                        String totalOrderInDollars = "ORDER TOTAL $" + dollars.format(totalCostOfOrder);
                    %>
                    <tr>
                        <td colspan="4">
                            <input type="submit" name="Submit" value="Update Cart">
                        </td>
                        <td colspan="2">
                            <div align="right"><b><%= totalOrderInDollars%></b></div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <div class="link-container">
            <p><a href="./books?action=continue">Continue Shopping</a></p>
            <p><a href="./books?Action=Checkout">Check Out</a></p>
        </div>
                        
        <%@ include file="footer.jsp" %> <!-- Added footer -->
    </body>
</html>

--%>
