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

@WebServlet("/AdminUsers")
public class AdminUsersServlet extends HttpServlet {

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

        ArrayList<User> users = AdminDao.getAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("adminUsers.jsp").forward(req, resp);
    }
}

