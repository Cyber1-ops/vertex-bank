import java.io.IOException;
import java.util.ArrayList;

import com.bank.models.Account;
import com.bank.models.User;
import com.bank.utils.DatabaseUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/accounts")
public class AccountManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<Account> accounts = DatabaseUtil.getActiveUserAccounts(user.getUserId());
        request.setAttribute("accounts", accounts);
        request.getRequestDispatcher("/accounts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("update".equals(action)) {
            String accountIdStr = request.getParameter("accountId");
            String accountType = request.getParameter("accountType");
            String currency = request.getParameter("currency");
            try {
                int accountId = Integer.parseInt(accountIdStr);
                boolean ok = DatabaseUtil.updateAccountSettings(accountId, accountType, currency);
                request.getSession().setAttribute("accountsMessage", ok ? "Account updated" : "Failed to update account");
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("accountsMessage", "Invalid account id");
            }
        }

        response.sendRedirect(request.getContextPath() + "/accounts");
    }
}
