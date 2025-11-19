import java.io.IOException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import com.bank.models.*;
import com.bank.utils.*;

@WebServlet("/login")
public class Login extends HttpServlet {
    
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
   
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("pass");
        String ip = req.getRemoteAddr();
        
        // Input validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("message", "Email and password are required");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        
        // Email format validation
        if (!isValidEmail(email)) {
            req.setAttribute("message", "Invalid email format");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        
        User user = DatabaseUtil.getUser(email);
        
        if (user == null) {
            AdminDao.log(null, "LOGIN_FAILED", ip, "Attempted email: " + email);
            req.setAttribute("message", "Wrong Email or Password");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        
        // Check account status
        if ("INACTIVE".equals(user.getStatus()) || "SUSPENDED".equals(user.getStatus())) {
            AdminDao.log(user.getUserId(), "LOGIN_FAILED", ip, "Attempted login with " + user.getStatus() + " account");
            req.setAttribute("message", "Account is " + user.getStatus().toLowerCase());
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        
        String storedHash = user.getPasswordHash();
        boolean ok = PasswordUtil.verifyPassword(password.toCharArray(), storedHash);
        
        if (ok) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            AdminDao.log(user.getUserId(), "LOGIN_SUCCESS", ip, "User logged in");
            
            if ("ADMIN".equals(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/Admin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/Dashboard");
            }
            return;
        } else {
            AdminDao.log(user.getUserId(), "LOGIN_FAILED", ip, "Invalid password attempt");
            req.setAttribute("message", "Wrong Email or Password");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
    
    private static boolean isValidEmail(String email) {
        if (email == null) return false;
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return email.matches(emailRegex);
    }
}