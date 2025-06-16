package utility;

import static com.sun.faces.facelets.util.Path.context;
import java.util.*;
import java.sql.*;
import model.Book;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletContext;
import java.sql.Connection;
import java.sql.DriverManager;


/**
 * The {@code AdmitBookStoreDAO} class provides data access methods for retrieving book information from a database.
 */
public class AdmitBookStoreDAO {

    private Connection con;

    /**
     * Constructs a new {@code AdmitBookStoreDAO} and establishes a connection to the database.
     */
    public AdmitBookStoreDAO() {
        
        // Retrieve initialization parameters
        /**
            String dbDriver = getServletConfig().getInitParameter("dbDriver");
            String dbURL = getServletConfig().getInitParameter("dbURL");
            String dbUser = getServletConfig().getInitParameter("dbUser");
            String dbPassword = getServletConfig().getInitParameter("dbPassword");

            // Establish the connection
            Class.forName(dbDriver);
            System.err.println("Getting Connection!");
            con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        **/
        
        
        
        try {
            // Load the Driver class file
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            System.err.println("Getting Connection!");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/BooksDB",
                    "user1", "password");

            if (con != null) {
                System.err.println("Got Connection!");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } 
    }

    /**
     * Retrieves all books from the database.
     *
     * @return a list of all books in the database
     * @throws SQLException if a database access error occurs
     */
    public List<Book> getAllBooks() throws SQLException {
        
        Statement statement = con.createStatement();
        ResultSet rs = null;
        List list = new ArrayList();

        rs = statement.executeQuery("SELECT * FROM USER1.TBooks");
        while (rs.next()) {
            System.out.println("rs has records");
            String isbn = rs.getString(1);
            String title = rs.getString(2);
            String author = rs.getString(3);
            double price = rs.getDouble(4);
            list.add(new Book(isbn, title, author, price));
        }
        return list;
    }
}