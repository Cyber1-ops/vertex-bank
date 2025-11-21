import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.bank.models.User;
import com.bank.models.Account;
import com.bank.utils.DatabaseUtil;
import com.bank.utils.AdminDao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/deposit")
public class DepositServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Account account = DatabaseUtil.getAccount(user.getUserId());
        if (account == null) {
            resp.sendRedirect("OpenAccount.jsp");
            return;
        }

        req.setAttribute("account", account);
        req.getRequestDispatcher("deposit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Account account = DatabaseUtil.getAccount(user.getUserId());
        if (account == null) {
            req.setAttribute("error", "Account not found");
            req.getRequestDispatcher("deposit.jsp").forward(req, resp);
            return;
        }

        String depositMethod = req.getParameter("deposit_method");
        String amountStr = req.getParameter("amount");
        String ip = req.getRemoteAddr();

        try {
            double amount = Double.parseDouble(amountStr);
            
            if (amount <= 0) {
                req.setAttribute("error", "Amount must be greater than zero");
                req.setAttribute("account", account);
                req.getRequestDispatcher("deposit.jsp").forward(req, resp);
                return;
            }

            boolean success = false;
            String description = "";

            switch (depositMethod) {
                case "card":
                    description = "Deposit via Card Payment";
                    success = processDeposit(account.getAccountId(), amount, description);
                    break;
                case "atm":
                    String atmLocation = req.getParameter("atm_location");
                    description = "Deposit via ATM at " + (atmLocation != null ? atmLocation : "ATM Location");
                    success = processDeposit(account.getAccountId(), amount, description);
                    break;
                case "paypal":
                    String paypalEmail = req.getParameter("paypal_email");
                    description = "Deposit via PayPal from " + (paypalEmail != null ? paypalEmail : "PayPal Account");
                    success = processDeposit(account.getAccountId(), amount, description);
                    break;
                default:
                    req.setAttribute("error", "Invalid deposit method");
                    req.setAttribute("account", account);
                    req.getRequestDispatcher("deposit.jsp").forward(req, resp);
                    return;
            }

            if (success) {
                AdminDao.log(user.getUserId(), "DEPOSIT_SUCCESS", ip, 
                    "Deposited " + amount + " via " + depositMethod);
                req.setAttribute("success", "Deposit of " + amount + " completed successfully!");
            } else {
                AdminDao.log(user.getUserId(), "DEPOSIT_FAILED", ip, 
                    "Failed to deposit " + amount + " via " + depositMethod);
                req.setAttribute("error", "Deposit failed. Please try again.");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid amount format");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred during deposit");
        }

        account = DatabaseUtil.getAccount(user.getUserId());
        req.setAttribute("account", account);
        req.getRequestDispatcher("deposit.jsp").forward(req, resp);
    }

    private boolean processDeposit(long accountId, double amount, String description) {
        String sql = "UPDATE account SET balance = balance + ? WHERE account_id = ?";
        String transactionSQL = "INSERT INTO transaction (to_account_id, amount, transaction_type, description, timestamp) VALUES (?, ?, 'DEPOSIT', ?, NOW())";
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);
            
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 PreparedStatement txnPs = conn.prepareStatement(transactionSQL)) {
                
                ps.setDouble(1, amount);
                ps.setLong(2, accountId);
                int rows = ps.executeUpdate();
                
                if (rows > 0) {
                    txnPs.setLong(1, accountId);
                    txnPs.setDouble(2, amount);
                    txnPs.setString(3, description);
                    txnPs.executeUpdate();
                    
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

