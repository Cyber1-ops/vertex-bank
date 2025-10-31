

import java.io.IOException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.*;

@WebServlet("/login")
public class Login extends HttpServlet {

	
	
   
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Serve the app entry for GET; the form will POST to this same path
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
   
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
        String email = req.getParameter("email");
        String password = req.getParameter("pass");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();  // REUSABLE!
            ps = conn.prepareStatement("SELECT `user_id`, `password_hash`, `role`, `status`, `username`, `email` FROM `user` WHERE `email`=?");
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password_hash");
                boolean ok = PasswordUtil.verifyPassword(password.toCharArray(), storedHash);
                if (ok) {
                    HttpSession session = req.getSession();
                    session.setAttribute("user", rs.getString("username"));
                    session.setAttribute("userId", rs.getLong("user_id"));
                    session.setAttribute("role", rs.getString("role"));
                    session.setAttribute("email", rs.getString("email"));
                    req.getRequestDispatcher("Dashboard.jsp").forward(req, resp);
                    return;

                } else {
                    resp.sendRedirect("index.jsp");
                    return;
                }
            } else {
                resp.sendRedirect("index.jsp");
                return;
            }

        } catch (SQLException e) {
            throw new ServletException("DB Error", e);
        } finally {
            DatabaseUtil.close(conn, ps, rs);  
        }
    
		
	
		
		
	}

}
