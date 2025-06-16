/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dispatchers;

import java.util.*;
import javax.servlet.http.*;
import model.*;

/**
 *
 * @author denan
 */
public class UpdateCartDispatcher implements Dispatcher {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String nextPage = "/jsp/titles.jsp";
        HttpSession session = request.getSession();
        Map<String, CartItem> cart = null;
        CartItem item = null;
        String isbn = null;
        nextPage = "/jsp/cart.jsp";
        cart = (Map<String, CartItem>) session.getAttribute("cart");
        String[] booksToRemove = request.getParameterValues("remove");
        if (booksToRemove != null) {
            for (String bookToRemove : booksToRemove) {
                cart.remove(bookToRemove);
            }
        }
        Set<Map.Entry<String, CartItem>> entries = cart.entrySet();
        Iterator<Map.Entry<String, CartItem>> iter = entries.iterator();
        while (iter.hasNext()) {
            Map.Entry<String, CartItem> entry = iter.next();
            isbn = entry.getKey();
            item = entry.getValue();
            int quantity = Integer.parseInt(request.getParameter(isbn));
            item.updateQuantity(quantity);
        }
        return nextPage;
        
    }
}