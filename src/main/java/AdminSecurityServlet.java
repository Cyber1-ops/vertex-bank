import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.bank.models.User;
import com.bank.utils.AdminDao;
import java.util.ArrayList;

@WebServlet("/AdminSecurity")
public class AdminSecurityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            resp.sendRedirect("index.jsp");
            return;
        }

        ArrayList<com.bank.models.AuditLog> securityLogs = AdminDao.getlog();
        ArrayList<com.bank.models.AuditLog> filteredLogs = new ArrayList<>();
        for (com.bank.models.AuditLog log : securityLogs) {
            if (log.getAction() != null && (
                log.getAction().contains("LOGIN") || 
                log.getAction().contains("SECURITY") ||
                log.getAction().contains("FAILED") ||
                log.getAction().contains("PASSWORD")
            )) {
                filteredLogs.add(log);
            }
        }
        
        req.setAttribute("securityLogs", filteredLogs);
        req.getRequestDispatcher("adminSecurity.jsp").forward(req, resp);
    }
}

