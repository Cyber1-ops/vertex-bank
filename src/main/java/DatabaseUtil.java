import java.sql.*;

public class DatabaseUtil {

	private static final String URL = "jdbc:mysql://localhost:3306/bank_db";
    private static final String USER = "root"; // your MySQL username
    private static final String PASS = "root"; // your MySQL password

    // Get connection
    public static Connection getConnection() throws SQLException {
        try {
            // Explicitly load MySQL driver
        	Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // Close resources safely
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }

    public static void close(Connection conn, Statement stmt) {
        close(conn, stmt, null);
    }
}
