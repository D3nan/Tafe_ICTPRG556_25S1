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
public class ViewCartDispatcher implements Dispatcher {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
    HttpSession session = request.getSession();
    String nextPage = "/jsp/cart.jsp";
    Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
    if (cart == null) {
        nextPage = "/jsp/titles.jsp";
    }
    return nextPage;
}
}