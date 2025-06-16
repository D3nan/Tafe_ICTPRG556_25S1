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

    <h1>Items in your Shopping Cart</h1>
    <table>
        <thead>
            <tr><th>Item</th></tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty sessionScope.cart}">
                    <c:set var="totalCostOfOrder" value="0" />
                    <c:forEach var="item" items="${sessionScope.cart.values()}">
                        <tr>
                            <td>${item}</td>
                        </tr>
                        <c:set var="totalCostOfOrder" value="${totalCostOfOrder + item.orderCost}" />
                    </c:forEach>
                    
                    <!-- Ensure the total cost is formatted to two decimal places -->
                    <c:set var="integerPart" value="${fn:substringBefore(totalCostOfOrder, '.')}" />
                    <c:set var="decimalPart" value="${fn:substringAfter(totalCostOfOrder, '.')}" />
                    <c:if test="${fn:length(decimalPart) < 2}">
                        <c:set var="decimalPart" value="${decimalPart}0" />
                    </c:if>
                    <c:if test="${fn:length(decimalPart) > 2}">
                        <c:set var="decimalPart" value="${fn:substring(decimalPart, 0, 2)}" />
                    </c:if>
                    <c:set var="formattedTotalCost" value="${integerPart}.${decimalPart}" />
                    
                    <tr>
                        <td>
                            Order Total: $<c:out value="${formattedTotalCost}" />
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr><td>No Items in Cart</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    <hr />

    <h2>Welcome to the Online Book Store</h2>

    <form name="form1" method="post" action="./books">
        <input type="hidden" name="action" value="add_to_cart" />
        <table>
            <thead>
                <tr>
                    <th>ISBN</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Add</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty sessionScope.Books}">
                        <tr><td colspan="6">Books not found in the session. Please reload the page.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="book" items="${sessionScope.Books}">
                            <tr>
                                <td>${book.isbn}</td>
                                <td>${book.title}</td>
                                <td>${book.author}</td>
                                <td>${book.dollarPrice}</td>
                                <td>
                                    <select name="${book.isbn}" size="1">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                    </select>
                                </td>
                                <td align="center">
                                    <input type="checkbox" name="add" value="${book.isbn}" />
                                </td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="6">
                                <input type="submit" name="Details" value="Add to cart" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="hidden" name="Action" value="add_to_cart" />
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </form>

    <div class="link-container">
        <p><a href="./books?Action=view_cart">View Shopping Cart</a></p>
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
        
        <h1>Items in your Shopping Cart</h1>
        <table>
            <thead>
                <tr>
                    <th>Item</th>
                </tr>
            </thead>
            <tbody>
                <%@ page import="model.*" %>
                <%@ page import="java.util.*" %>
                <%@ page import="java.text.*" %>
                <%
                    Map items = (Map) session.getAttribute("cart");
                    if (items != null) {
                            Set entries = items.entrySet();
                            Iterator iter = entries.iterator();
                            double totalCostOfOrder = 0.00;
                            Book book = null;
                            CartItem item = null;

                            while (iter.hasNext()) {
                                Map.Entry entry = (Map.Entry) iter.next();
                                item = (CartItem) entry.getValue();
                                double cost = item.getOrderCost();
                                totalCostOfOrder += cost;
                %>
                <tr>
                    <td><%= item%></td>
                </tr>
                <%
                    } // end while
                    DecimalFormat dollars = new DecimalFormat("0.00");
                    String totalOrderInDollars = (dollars.format(totalCostOfOrder));

                %>
                <tr>
                    <td>Order Total: $<%= totalOrderInDollars%></td>
                </tr>
                <%
                } else {
                %>
                <tr>
                    <td>No Items in Cart</td>
                </tr>
                <%
                    } // end else
                %>
            </tbody>
        </table>
        <hr>
        <h2>Welcome to the Online Book Store</h2>
        <form name="form1" method="post" action="./books">
            <input type="hidden" name="action" value="add_to_cart">
            <table>
                <thead>
                    <tr>
                        <th>ISBN</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Add</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List books = (List) session.getAttribute("Books");

                        if (books == null) {
                            out.println("<p>Books not found in the session. Please reload the page.</p>");
                        } else {
                            Iterator iter = books.iterator();
                            while (iter.hasNext()) {
                                Book book = (Book) iter.next();
                                String isbn = book.getIsbn();
                                String title = book.getTitle();
                                String author = book.getAuthor();
                                String price = book.getDollarPrice();
                    %>
                    <tr>
                        <td><%= isbn%></td>
                        <td><%= title%></td>
                        <td><%= author%></td>
                        <td><%= price%></td>
                        <td>
                            <select name="<%= isbn%>" size="1">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </td>
                        <td>
                            <div align="center">
                                <input type="checkbox" name="add" value="<%= isbn%>">
                            </div>
                        </td>
                    </tr>
                    <% } // end while %>
                    <tr>
                        <td colspan="6">
                            <input type="submit" name="Details" value="Add to cart">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input name="Action" type="hidden" value="add_to_cart">
                        </td>
                    </tr>
                    <% } // end else %>
                </tbody>
            </table>
        </form>
        <div class="link-container">
            <p><a href="./books?Action=view_cart">View Shopping Cart</a></p>
        </div>
        <%@ include file="footer.jsp" %> <!-- Added footer -->
    </body>
</html>

--%>
