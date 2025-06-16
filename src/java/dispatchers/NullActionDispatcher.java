/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dispatchers;

import controller.FrontController;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;
import model.Book;


public class NullActionDispatcher implements Dispatcher {

    @PersistenceContext(unitName = "BookShopPU")
    private EntityManager em;
    private EntityManagerFactory emf;
    @Resource
    private javax.transaction.UserTransaction utx;
    
        public NullActionDispatcher() {
        // Initialize emf in the constructor
        emf = Persistence.createEntityManagerFactory("BookShopPU");
    }
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        // Get the requested action from the request parameters
        HttpSession session = request.getSession();

        try {
            List<Book> books = this.getAllBooks();
 
            // Check for null to avoid exceptions
            if (books == null) {
                throw new IllegalStateException("No books fetched from the database.");
            }

            // Set books in session and return titles page
            session.setAttribute("Books", books);
            return "/jsp/titles.jsp";
        } catch (Exception ex) {
            // Log exception or set error message
            request.setAttribute("result", ex.getMessage());
            return "/jsp/error.jsp";
        }
    }

  
        /**
     * Fetch all books from the database.
     *
     * @return List of Book objects
     */
    
    public List<Book> getAllBooks() {
    try {
        EntityManager em = emf.createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM USER1.TBOOKS", Book.class);
        return query.getResultList();
    } catch (Exception ex) {
        throw new RuntimeException("Failed to fetch books with native query.", ex);
    }
}
}

/**

 public class NullActionDispatcher implements Dispatcher {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // Get the requested action from the request parameters
        AdmitBookStoreDAO dao = new AdmitBookStoreDAO();
        HttpSession session = request.getSession();

        try {
            // Fetch all books from the DAO
            List<Book> books = dao.getAllBooks();

            // Check for null to avoid exceptions
            if (books == null) {
                throw new IllegalStateException("No books fetched from the DAO.");
            }

            // Set books in session and return titles page
            session.setAttribute("Books", books);
            return "/jsp/titles.jsp";
        } catch (Exception ex) {
            // Log exception or set error message
            request.setAttribute("result", ex.getMessage());
            return "/jsp/error.jsp";
        }
    }
 }
**/
