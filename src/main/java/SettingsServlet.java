import java.io.IOException;

import com.bank.models.User;
import com.bank.models.UserSettings;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/settings")
public class SettingsServlet extends HttpServlet {

    private static final String SETTINGS_ATTR = "userSettings";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

        UserSettings settings = getOrCreateSettings(session);
        req.setAttribute("user", user);
        req.setAttribute("settings", settings);
        req.getRequestDispatcher("settings.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

        UserSettings settings = getOrCreateSettings(session);

        settings.setEmailAlerts(isOn(req.getParameter("emailAlerts")));
        settings.setSmsAlerts(isOn(req.getParameter("smsAlerts")));
        settings.setPushNotifications(isOn(req.getParameter("pushNotifications")));
        settings.setMarketingEmails(isOn(req.getParameter("marketingEmails")));
        settings.setLoginAlerts(isOn(req.getParameter("loginAlerts")));
        settings.setAutoLogout(isOn(req.getParameter("autoLogout")));
        settings.setBiometricLogin(isOn(req.getParameter("biometricLogin")));
        settings.setTheme(req.getParameter("theme"));

        session.setAttribute(SETTINGS_ATTR, settings);

        req.setAttribute("user", user);
        req.setAttribute("settings", settings);
        req.setAttribute("success", "Settings updated successfully.");
        req.getRequestDispatcher("settings.jsp").forward(req, resp);
    }

    private UserSettings getOrCreateSettings(HttpSession session) {
        UserSettings settings = (UserSettings) session.getAttribute(SETTINGS_ATTR);
        if (settings == null) {
            settings = new UserSettings();
            session.setAttribute(SETTINGS_ATTR, settings);
        }
        return settings;
    }

    private boolean isOn(String value) {
        return value != null && (value.equalsIgnoreCase("on") || value.equalsIgnoreCase("true"));
    }
}

