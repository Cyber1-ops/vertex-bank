import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

import com.bank.models.CardApplication;
import com.bank.models.User;
import com.bank.utils.CardDBUtil;
import com.bank.utils.AdminDao;

@WebServlet("/AdminCardServlet")
public class AdminCardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Load all card applications
        ArrayList<CardApplication> applications = CardDBUtil.getAllCardApplications();
        
        // Load pending applications count
        int pendingCount = CardDBUtil.countPendingApplications();
        
        // Load total cards count
        int totalCards = CardDBUtil.countTotalCards();

        request.setAttribute("applications", applications);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("totalCards", totalCards);

        // Get messages from session (PRG pattern)
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");
        session.removeAttribute("success");
        session.removeAttribute("error");

        request.setAttribute("success", success);
        request.setAttribute("error", error);

        request.getRequestDispatcher("adminCards.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        String ip = request.getRemoteAddr();

        try {
            if ("approve".equals(action)) {
                // Handle card application approval
                String applicationIdStr = request.getParameter("application_id");
                
                if (applicationIdStr == null || applicationIdStr.isEmpty()) {
                    session.setAttribute("error", "Invalid application selected");
                    response.sendRedirect(request.getContextPath() + "/AdminCardServlet");
                    return;
                }

                long applicationId = Long.parseLong(applicationIdStr);
                
                // Get application details
                CardApplication app = CardDBUtil.getCardApplicationWithDetails(applicationId);
                if (app == null) {
                    session.setAttribute("error", "Application not found");
                    response.sendRedirect(request.getContextPath() + "/AdminCardServlet");
                    return;
                }
                
                // Issue the card
                boolean success = CardDBUtil.issueCard(applicationId);
                
                if (success) {
                    session.setAttribute("success", "Card application approved and card issued successfully!");
                    AdminDao.log(user.getUserId(), "CARD_APPLICATION_APPROVED", ip, "Application ID: " + applicationId);
                } else {
                    session.setAttribute("error", "Failed to approve card application. Please try again.");
                }

            } else if ("reject".equals(action)) {
                // Handle card application rejection
                String applicationIdStr = request.getParameter("application_id");
                
                if (applicationIdStr == null || applicationIdStr.isEmpty()) {
                    session.setAttribute("error", "Invalid application selected");
                    response.sendRedirect(request.getContextPath() + "/AdminCardServlet");
                    return;
                }

                long applicationId = Long.parseLong(applicationIdStr);
                
                boolean success = CardDBUtil.rejectCardApplication(applicationId);
                
                if (success) {
                    session.setAttribute("success", "Card application rejected successfully!");
                    AdminDao.log(user.getUserId(), "CARD_APPLICATION_REJECTED", ip, "Application ID: " + applicationId);
                } else {
                    session.setAttribute("error", "Failed to reject card application. Please try again.");
                }
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid input format. Please check all fields.");
        } catch (Exception e) {
            session.setAttribute("error", "An unexpected error occurred.");
            e.printStackTrace();
        }

        // Redirect to GET (PRG)
        response.sendRedirect(request.getContextPath() + "/AdminCardServlet");
    }
}

