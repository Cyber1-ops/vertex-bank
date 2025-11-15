
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;

import com.bank.models.User;
import com.bank.models.Account;
import com.bank.utils.DatabaseUtil;

@WebServlet("/Dashboard")
public class Dashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");

        // User not logged in
        if (user == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        loadDashboard(req, resp, user);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        loadDashboard(req, resp, user);
    }

    private void loadDashboard(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        Account AC = DatabaseUtil.getAccount(user.getUserId());

        // User has no account → go to create/welcome page
        if (AC == null || AC.getAccountNumber() == null || AC.getAccountNumber().isEmpty()) {
            req.getRequestDispatcher("welcome-no-account.jsp").forward(req, resp);
            return;
        }

        // Set account details
        req.setAttribute("ACnumber", AC.getAccountNumber());
        req.setAttribute("ACtype", AC.getAccountType());
        req.setAttribute("ACcurrency", AC.getCurrency());
        req.setAttribute("ACstatus", AC.getStatus());
        req.setAttribute("ACbalance", AC.getBalance());

        req.getRequestDispatcher("Dashboard.jsp").forward(req, resp);
        return;
    }
}
