import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import com.bank.models.Account;
import com.bank.models.User;
import com.bank.utils.DatabaseUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/open-account")
public class OpenAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // 1. Authentication Check
            User user = (User) req.getSession().getAttribute("user");

            if (user == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            int userId = user.getUserId();

            // 2. Retrieve Form Parameters
            String fullName = req.getParameter("full_name");
            String phone = req.getParameter("phone");
            String dobStr = req.getParameter("dob");
            String ageStr = req.getParameter("age");
            String nationality = req.getParameter("nationality");
            String passportNumber = req.getParameter("passport_number");
            String idNumber = req.getParameter("id_number");
            String address = req.getParameter("address");
            String monthlyIncomeStr = req.getParameter("monthly_income");
            String accountType = req.getParameter("account_type");
            String currency = req.getParameter("currency");
            String initialDepositStr = req.getParameter("initial_deposit");

            // 3. Validation: Check for missing fields
            if (fullName == null || phone == null || dobStr == null || ageStr == null ||
                nationality == null || passportNumber == null || idNumber == null ||
                address == null || monthlyIncomeStr == null || accountType == null ||
                currency == null || initialDepositStr == null) {

                req.setAttribute("error", "All fields are required. Please fill in the complete form.");
                req.getRequestDispatcher("open-account.jsp").forward(req, resp);
                return;
            }

            int age;
            double monthlyIncome;
            double initialDeposit;
            LocalDate dob = null;

            try {
                age = Integer.parseInt(ageStr);
                monthlyIncome = Double.parseDouble(monthlyIncomeStr);
                initialDeposit = Double.parseDouble(initialDepositStr);

                if (dobStr != null && !dobStr.trim().isEmpty()) {
                    dob = LocalDate.parse(dobStr);
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Invalid number format provided.");
                req.getRequestDispatcher("open-account.jsp").forward(req, resp);
                return;
            } catch (DateTimeParseException e) {
                req.setAttribute("error", "Invalid date format for Date of Birth. Please use YYYY-MM-DD format.");
                req.getRequestDispatcher("open-account.jsp").forward(req, resp);
                return;
            }

            // 5. Normalize Account Type
            String normalizedAccountType = accountType.trim().toUpperCase();
            if (normalizedAccountType.contains("FIXED")) {
                normalizedAccountType = "FIXED_DEPOSIT";
            }

            if (!normalizedAccountType.equals("SAVINGS") &&
                !normalizedAccountType.equals("CURRENT") &&
                !normalizedAccountType.equals("FIXED_DEPOSIT")) {

                req.setAttribute("error", "Invalid account type selected.");
                req.getRequestDispatcher("open-account.jsp").forward(req, resp);
                return;
            }

            // 7. Update User object with collected details
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setDob(dob); 
            user.setAge(age);
            user.setNationality(nationality);
            user.setPassportNumber(passportNumber);
            user.setIdNumber(idNumber);
            user.setAddress(address);
            user.setMonthlyIncome(monthlyIncome);

            Account account = new Account();
            account.setUserId(userId);
            account.setAccountType(normalizedAccountType);
            account.setCurrency(currency);
            account.setBalance(initialDeposit);
            account.setStatus("ACTIVE");

            boolean opened = DatabaseUtil.openAccount(account, user);

            if (opened) {
                req.getSession().setAttribute("user", user);
                resp.sendRedirect("Dashboard");
            } else {
                req.setAttribute("error", "Failed to open account. Please try again.");
                req.getRequestDispatcher("open-account.jsp?message=Failed to create account").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", "A system error occurred. Please try again later.");
            req.getRequestDispatcher("open-account.jsp").forward(req, resp);
        }
    }
}