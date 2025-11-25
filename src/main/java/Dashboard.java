import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession; // ✅ ADDED

import com.bank.models.User;
import com.bank.models.Account;
import com.bank.models.Card;
import com.bank.models.TransactionRecord;
import com.bank.utils.DatabaseUtil;
import com.bank.utils.CardDBUtil;
import com.bank.utils.TransferDBUtil;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;

@WebServlet("/Dashboard")
public class Dashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false); 
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        loadDashboard(req, resp, user);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false); 
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        loadDashboard(req, resp, user);
    }

    private void loadDashboard(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        Account AC = DatabaseUtil.getAccount(user.getUserId());

       
        if (AC == null || AC.getAccountNumber() == null || AC.getAccountNumber().isEmpty()) {
        	resp.sendRedirect(req.getContextPath() + "/OpenAccount.jsp");
            return;
        }

        
        req.setAttribute("ACnumber", AC.getAccountNumber());
        req.setAttribute("ACtype", AC.getAccountType());
        req.setAttribute("ACcurrency", AC.getCurrency());
        req.setAttribute("ACstatus", AC.getStatus());
        req.setAttribute("ACbalance", AC.getBalance());
        req.setAttribute("userAccountId", AC.getAccountId());

       
        ArrayList<Card> cards = CardDBUtil.getUserCards(user.getUserId());
        req.setAttribute("cards", cards);

       
        List<TransactionRecord> transactions = TransferDBUtil.getUserTransactions(user.getUserId(), 5);
        req.setAttribute("transactions", transactions);

        
        LocalDate now = LocalDate.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();
        
        double monthlyIncome = TransferDBUtil.getMonthlyIncome(user.getUserId(), currentMonth, currentYear);
        double monthlyExpenses = TransferDBUtil.getMonthlyExpenses(user.getUserId(), currentMonth, currentYear);
        double totalSavings = AC.getBalance();

        req.setAttribute("monthlyIncome", monthlyIncome);
        req.setAttribute("monthlyExpenses", monthlyExpenses);
        req.setAttribute("totalSavings", totalSavings);

        req.getRequestDispatcher("Dashboard.jsp").forward(req, resp);
    }
}