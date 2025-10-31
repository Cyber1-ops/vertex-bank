import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class Signup extends HttpServlet {

protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String username = req.getParameter("username");
    String email = req.getParameter("email");
    String fullName = req.getParameter("name");
    String password = req.getParameter("pass");

		Connection conn = null;
		PreparedStatement psCheck = null;
		PreparedStatement psInsert = null;
		ResultSet rs = null;

		try {
			conn = DatabaseUtil.getConnection();

        psCheck = conn.prepareStatement("SELECT 1 FROM `user` WHERE `username`=? OR `email`=?");
        psCheck.setString(1, username);
        psCheck.setString(2, email);
			rs = psCheck.executeQuery();
			if (rs.next()) {
				resp.sendRedirect(req.getContextPath() + "/signup?error=user_exists");
				return;
			}

        String passwordHash = PasswordUtil.hashPassword(password.toCharArray());

        psInsert = conn.prepareStatement(
            "INSERT INTO `user`(`username`, `password_hash`, `email`, `full_name`, `role`, `status`, `created_at`) " +
            "VALUES(?, ?, ?, ?, ?, ?, NOW())"
        );
        psInsert.setString(1, username);
        psInsert.setString(2, passwordHash);
        psInsert.setString(3, email);
        psInsert.setString(4, fullName);
        psInsert.setString(5, "USER");
        psInsert.setString(6, "ACTIVE");
			psInsert.executeUpdate();

			req.getRequestDispatcher("index.jsp").forward(req, resp);
			return;
		} catch (SQLException e) {
			throw new ServletException("DB Error", e);
		} finally {
			try { if (rs != null) rs.close(); } catch (Exception e) {}
			try { if (psCheck != null) psCheck.close(); } catch (Exception e) {}
			DatabaseUtil.close(conn, psInsert, null);
		}
	}
}


