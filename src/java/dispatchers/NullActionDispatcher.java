/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dispatchers;

import java.sql.*;
import java.util.*;
import javax.servlet.http.*;
import model.Book;
import tafe.java.web.TableFormatter;
import utility.AdmitBookStoreDAO;

/**
 *
 * @author denan
 */
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
    
