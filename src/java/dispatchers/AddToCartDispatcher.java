package dispatchers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Book;
import model.CartItem;
import utility.AdmitBookStoreDAO;

/**
 * Dispatcher for handling the addition of items to the shopping cart.
 */
public class AddToCartDispatcher implements Dispatcher {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String nextPage = "/jsp/titles.jsp";
        HttpSession session = request.getSession();
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        String[] selectedBooks = request.getParameterValues("add");

        // Check if selectedBooks is null or empty
        if (selectedBooks == null || selectedBooks.length == 0) {
            return nextPage;
        }

        // If the cart is null, create a new cart and add selected books
        if (cart == null) {
            cart = new HashMap();
        
            // Process each selected book
            for (String isbn : selectedBooks) {
                int quantity = Integer.parseInt(request.getParameter(isbn));
                Book book = this.getBookFromList(isbn, session);
                CartItem item = new CartItem(book);
                item.setQuantity(quantity);
                cart.put(isbn, item);
            }

            session.setAttribute("cart", cart);

            } else {
                // If the cart already exists, update the quantities of selected books
                for (String isbn : selectedBooks) {
                    int quantity = Integer.parseInt(request.getParameter(isbn));
                    if (cart.containsKey(isbn)) {
                        CartItem item = cart.get(isbn);
                        item.setQuantity(quantity);
                    } else {
                        Book book = this.getBookFromList(isbn, session);
                        CartItem item = new CartItem(book);
                        item.setQuantity(quantity);
                        cart.put(isbn, item);
                    }
                }
            }

        return nextPage;
    }

    /** Retrieve a book from the list of books stored in the session.
     * @param isbn ISBN of the book
     * @param session HttpSession object
     * @return Book object
     */
    private Book getBookFromList(String isbn, HttpSession session) {
    List<Book> list = (List<Book>) session.getAttribute("Books");
    Book aBook = null;
        for (Book book : list) {
            if (isbn.equals(book.getIsbn())) {
                aBook = book;
                break;
            }
        }
        return aBook;
}
}