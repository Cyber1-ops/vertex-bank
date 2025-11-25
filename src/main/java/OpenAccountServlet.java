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
import jakarta.servlet.http.HttpSession;

@WebServlet("/open-account")
public class OpenAccountServlet extends HttpServlet {

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

        try {
            int userId = user.getUserId();

          
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

         
            if (fullName == null || fullName.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                dobStr == null || dobStr.trim().isEmpty() ||
                ageStr == null || ageStr.trim().isEmpty() ||
                nationality == null || nationality.trim().isEmpty() ||
                passportNumber == null || passportNumber.trim().isEmpty() ||
                idNumber == null || idNumber.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                monthlyIncomeStr == null || monthlyIncomeStr.trim().isEmpty() ||
                accountType == null || accountType.trim().isEmpty() ||
                currency == null || currency.trim().isEmpty() ||
                initialDepositStr == null || initialDepositStr.trim().isEmpty()) {

                req.setAttribute("error", "All fields are required. Please fill in the complete form.");
                req.getRequestDispatcher("OpenAccount.jsp").forward(req, resp);
                return;
            }

          
            int age;
            double monthlyIncome;
            double initialDeposit;
            LocalDate dob;

            try {
                age = Integer.parseInt(ageStr.trim());
                monthlyIncome = Double.parseDouble(monthlyIncomeStr.trim());
                initialDeposit = Double.parseDouble(initialDepositStr.trim());
                dob = LocalDate.parse(dobStr.trim());

              
                if (age < 18) {
                    req.setAttribute("error", "You must be at least 18 years old to open an account.");
                    req.getRequestDispatcher("OpenAccount.jsp").forward(req, resp);
                    return;
                }

                if (monthlyIncome < 0 || initialDeposit < 0) {
                    req.setAttribute("error", "Income and deposit amounts cannot be negative.");
                    req.getRequestDispatcher("OpenAccount.jsp").forward(req, resp);
                    return;
                }

            } catch (NumberFormatException e) {
                req.setAttribute("error", "Invalid number format provided.");
                req.getRequestDispatcher("OpenAccount.jsp").forward(req, resp);
                return;
            } catch (DateTimeParseException e) {
                req.setAttribute("error", "Invalid date format for Date of Birth. Please use YYYY-MM-DD format.");
                req.getRequestDispatcher("OpenAccount.jsp").forward(req, resp);
                return;
            }

         
            String normalizedAccountType = accountType.trim().toUpperCase();
            if (normalizedAccountType.contains("FIXED")) {
                normalizedAccountType = "FIXED_DEPOSIT";
            }

            if (!normalizedAccountType.equals("SAVINGS") &&
                !normalizedAccountType.equals("CURRENT") &&
                !normalizedAccountType.equals("FIXED_DEPOSIT")) {

                req.setAttribute("error", "Invalid account type selected.");
                req.getRequestDispatcher("OpenAccount.jsp").forward(req, resp);
                return;
            }

            user.setFullName(fullName.trim());
            user.setPhone(phone.trim());
            user.setDob(dob);
            user.setAge(age);
            user.setNationality(nationality.trim());
            user.setPassportNumber(passportNumber.trim());
            user.setIdNumber(idNumber.trim());
            user.setAddress(address.trim());
            user.setMonthlyIncome(monthlyIncome);

           
            Account account = new Account();
            account.setUserId(userId);
            account.setAccountType(normalizedAccountType);
            account.setCurrency(currency.trim());
            account.setBalance(initialDeposit);
            account.setStatus("ACTIVE");

            
            boolean opened = DatabaseUtil.openAccount(account, user);

            if (opened) {
               
                session.setAttribute("user", user);
                resp.sendRedirect(req.getContextPath() + "/Dashboard"); 
            } else {
                req.setAttribute("error", "Failed to open account. Please try again.");
                req.getRequestDispatcher("OpenAccount.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "A system error occurred. Please try again later.");
            req.getRequestDispatcher("OpenAccount.jsp").forward(req, resp);
        }
    }
}