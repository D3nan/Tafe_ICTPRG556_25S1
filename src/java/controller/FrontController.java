package controller;


import dispatchers.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import model.Book;
import model.CartItem;
import utility.AdmitBookStoreDAO;

/**
 * FrontController class to handle HTTP requests and responses.
 */

public class FrontController extends HttpServlet {

    private final HashMap dispatchers = new HashMap();  
    private final HashMap actions = new HashMap();
    /**
     * Initialize global variables.
     * @param config ServletConfig object
     * @throws ServletException if an error occurs during initialization
     */

    
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        // Additional initialization code can be added here
        dispatchers.put("Checkout", new CheckoutDispatcher());
        dispatchers.put("Continue", new ContinueDispatcher());
        dispatchers.put(null, new NullActionDispatcher());
        dispatchers.put("add_to_cart", new AddToCartDispatcher());
        dispatchers.put("update_cart", new UpdateCartDispatcher());
        dispatchers.put("view_cart", new ViewCartDispatcher());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the requested action from the request parameters
        String requestedAction = request.getParameter("Action");
        HttpSession session = request.getSession();
        /** AdmitBookStoreDAO dao = new AdmitBookStoreDAO(); **/ /**removing DAO**/
        String nextPage = "";

        // If no action is specified, fetch all books and display them
        if (requestedAction == null) {
            Dispatcher dispatcher = (Dispatcher) dispatchers.get(requestedAction);
            this.dispatch(request, response, dispatcher.execute(request, response));
            
        } else if (requestedAction.equals("add_to_cart")) {
            Dispatcher dispatcher = (Dispatcher) dispatchers.get(requestedAction);
            this.dispatch(request, response, dispatcher.execute(request, response));
     
        } else if (requestedAction.equals("Checkout")) {
            // Redirect to the checkout page
            Dispatcher dispatcher = (Dispatcher) dispatchers.get(requestedAction);
            this.dispatch(request, response, dispatcher.execute(request, response));
            
        } else if (requestedAction.equals("Continue")) {
            // Redirect to the titles page
            Dispatcher dispatcher = (Dispatcher) dispatchers.get(requestedAction);
            this.dispatch(request, response, dispatcher.execute(request, response)); /** Continue to use this instead of sendRedirect as dispatch preserves servlet context/format) **/
            
        } else if (requestedAction.equals("update_cart")) {
            Dispatcher dispatcher = (Dispatcher) dispatchers.get(requestedAction);
            this.dispatch(request, response, dispatcher.execute(request, response));
            
        } else if (requestedAction.equals("view_cart")) {
            Dispatcher dispatcher = (Dispatcher) dispatchers.get(requestedAction);
            this.dispatch(request, response, dispatcher.execute(request, response));
        }
    }

    /**
     * Forward the request to the specified page.
     * @param request HttpServletRequest object
     * @param response HttpServletResponse object
     * @param page Page to forward to
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void dispatch(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    /**
     * Get Servlet information.
     * @return Servlet information
     */
    public String getServletInfo() {
        return "controller.FrontController Information";
    }
}
