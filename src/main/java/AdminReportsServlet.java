import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.bank.models.User;
import com.bank.utils.AdminDao;
import com.bank.utils.TransferDBUtil;
import java.util.List;

@WebServlet("/AdminReports")
public class AdminReportsServlet extends HttpServlet {

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

        // Get statistics for reports
        int totalUsers = AdminDao.countUsers();
        double totalBalance = 0.0;
        java.util.ArrayList<com.bank.models.Account> accounts = AdminDao.getallAccount();
        for (com.bank.models.Account acc : accounts) {
            totalBalance += acc.getBalance();
        }
        List<com.bank.models.TransactionRecord> recentTransactions = TransferDBUtil.getAllTransactions(50);
        
        req.setAttribute("totalUsers", totalUsers);
        req.setAttribute("totalBalance", totalBalance);
        req.setAttribute("recentTransactions", recentTransactions);
        
        req.getRequestDispatcher("adminReports.jsp").forward(req, resp);
    }
}

