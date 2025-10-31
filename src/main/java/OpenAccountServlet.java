import java.io.IOException;
import java.sql.*;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/open-account")
public class OpenAccountServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        long userId = (Long) session.getAttribute("userId");

        String fullName = req.getParameter("full_name");
        String phone = req.getParameter("phone");
        String dob = req.getParameter("dob");
        String age = req.getParameter("age");
        String nationality = req.getParameter("nationality");
        String passportNumber = req.getParameter("passport_number");
        String idNumber = req.getParameter("id_number");
        String address = req.getParameter("address");
        String monthlyIncome = req.getParameter("monthly_income");

        String accountType = req.getParameter("account_type");
        String currency = req.getParameter("currency");
        String initialDepositStr = req.getParameter("initial_deposit");
        double initialDeposit = 0.0;
        try { if (initialDepositStr != null) initialDeposit = Double.parseDouble(initialDepositStr); } catch (NumberFormatException ignored) {}

        Connection conn = null;
        PreparedStatement psUpdateUser = null;
        PreparedStatement psInsertAccount = null;

        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false);

            psUpdateUser = conn.prepareStatement(
                "UPDATE `user` SET full_name=?, phone=?, dob=?, age=?, nationality=?, passport_number=?, id_number=?, address=?, monthly_income=? WHERE user_id=?"
            );
            psUpdateUser.setString(1, fullName);
            psUpdateUser.setString(2, phone);
            psUpdateUser.setString(3, dob);
            psUpdateUser.setString(4, age);
            psUpdateUser.setString(5, nationality);
            psUpdateUser.setString(6, passportNumber);
            psUpdateUser.setString(7, idNumber);
            psUpdateUser.setString(8, address);
            psUpdateUser.setString(9, monthlyIncome);
            psUpdateUser.setLong(10, userId);
            psUpdateUser.executeUpdate();

            String accountNumber = generateAccountNumber();
            psInsertAccount = conn.prepareStatement(
                "INSERT INTO `account`(account_number, user_id, account_type, balance, currency, status, created_at) VALUES(?, ?, ?, ?, ?, 'ACTIVE', NOW())"
            );
            psInsertAccount.setString(1, accountNumber);
            psInsertAccount.setLong(2, userId);
            psInsertAccount.setString(3, accountType);
            psInsertAccount.setDouble(4, initialDeposit);
            psInsertAccount.setString(5, currency);
            psInsertAccount.executeUpdate();

            conn.commit();
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } catch (SQLException e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ignored) {}
            throw new ServletException("DB Error", e);
        } finally {
            try { if (psUpdateUser != null) psUpdateUser.close(); } catch (Exception ignored) {}
            DatabaseUtil.close(conn, psInsertAccount, null);
        }
    }

    private String generateAccountNumber() {
        Random r = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 12; i++) sb.append(r.nextInt(10));
        return sb.toString();
    }
}


