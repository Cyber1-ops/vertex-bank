import java.io.IOException;

import com.bank.models.User;
import com.bank.utils.DatabaseUtil;
import com.bank.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class UserProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        forwardWithLatestUser(req, resp, session, sessionUser);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        if ("contact".equals(action)) {
            handleContactUpdate(req, sessionUser);
        } else if ("password".equals(action)) {
            handlePasswordUpdate(req, sessionUser);
        } else {
            req.setAttribute("error", "Unknown action requested.");
        }

        forwardWithLatestUser(req, resp, session, sessionUser);
    }

    private void handleContactUpdate(HttpServletRequest req, User user) {
        String fullName = safeTrim(req.getParameter("fullName"));
        String email = safeTrim(req.getParameter("email"));
        String phone = safeTrim(req.getParameter("phone"));
        String address = safeTrim(req.getParameter("address"));

        if (fullName.isEmpty() || email.isEmpty() || phone.isEmpty()) {
            req.setAttribute("error", "Full name, email, and phone are required.");
            return;
        }

        boolean updated = DatabaseUtil.updateUserContactInfo(
                user.getUserId(),
                fullName,
                email,
                phone,
                address
        );

        if (updated) {
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            req.setAttribute("success", "Contact details updated successfully.");
        } else {
            req.setAttribute("error", "Unable to update contact details. Please try again.");
        }
    }

    private void handlePasswordUpdate(HttpServletRequest req, User user) {
        String currentPassword = req.getParameter("currentPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.isBlank() || newPassword.isBlank() || confirmPassword.isBlank()) {
            req.setAttribute("error", "All password fields are required.");
            return;
        }

        if (newPassword.length() < 8) {
            req.setAttribute("error", "New password must be at least 8 characters long.");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "New password and confirmation do not match.");
            return;
        }

        User latestUser = DatabaseUtil.getUserById(user.getUserId());
        if (latestUser == null) {
            req.setAttribute("error", "Unable to verify your account.");
            return;
        }

        boolean validCurrent = PasswordUtil.verifyPassword(currentPassword.toCharArray(), latestUser.getPasswordHash());
        if (!validCurrent) {
            req.setAttribute("error", "Current password is incorrect.");
            return;
        }

        String newHash = PasswordUtil.hashPassword(newPassword.toCharArray());
        boolean updated = DatabaseUtil.updateUserPassword(user.getUserId(), newHash);

        if (updated) {
            user.setPasswordHash(newHash);
            req.setAttribute("success", "Password updated successfully.");
        } else {
            req.setAttribute("error", "Unable to update password. Please try again.");
        }
    }

    private void forwardWithLatestUser(HttpServletRequest req, HttpServletResponse resp, HttpSession session, User fallback)
            throws ServletException, IOException {
        User latest = DatabaseUtil.getUserById(fallback.getUserId());
        if (latest != null) {
            session.setAttribute("user", latest);
            req.setAttribute("user", latest);
        } else {
            req.setAttribute("user", fallback);
        }
        req.getRequestDispatcher("userProfile.jsp").forward(req, resp);
    }

    private String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }
}

