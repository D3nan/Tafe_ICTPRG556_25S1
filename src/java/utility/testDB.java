/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;

/**
 *
 * @author denan
 */

public class testDB extends HttpServlet {

    @PersistenceContext(unitName = "BookShopPU")
    private EntityManager em;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        /**
        try {
            List<Book> books = em.createQuery("SELECT b FROM Book b", Book.class).getResultList();
            response.getWriter().write("Books fetched successfully: " + books.size());
        } catch (Exception ex) {
            response.getWriter().write("Error fetching books: " + ex.getMessage());
        } **/
        
        try {
        Query query = em.createQuery("SELECT b FROM Book b");
        List<Book> books = query.getResultList();
        response.getWriter().write("Books fetched successfully v2: " + books.size());
    } catch (Exception ex) {
        response.getWriter().write("Error fetching books with native query: " + ex.getMessage());
    }
        
        
    }

} 


