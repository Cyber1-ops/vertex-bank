import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

import com.bank.models.Account;
import com.bank.models.Card;
import com.bank.models.CardApplication;
import com.bank.models.User;
import com.bank.utils.CardDBUtil;
import com.bank.utils.DatabaseUtil;
import com.bank.utils.AdminDao;

@WebServlet("/CardServlet")
public class CardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Load user accounts
        ArrayList<Account> accounts = DatabaseUtil.getActiveUserAccounts(user.getUserId());
        
        // Load user cards
        ArrayList<Card> cards = CardDBUtil.getUserCards(user.getUserId());
        
        // Load card applications
        ArrayList<CardApplication> applications = CardDBUtil.getUserCardApplications(user.getUserId());

        request.setAttribute("accounts", accounts);
        request.setAttribute("cards", cards);
        request.setAttribute("applications", applications);

        // Get messages from session (PRG pattern)
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");
        session.removeAttribute("success");
        session.removeAttribute("error");

        request.setAttribute("success", success);
        request.setAttribute("error", error);

        request.getRequestDispatcher("cards.jsp").forward(request, response);
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
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        String ip = request.getRemoteAddr();

        try {
            if ("apply".equals(action)) {
                // Handle card application
                String accountIdStr = request.getParameter("account_id");
                String cardType = request.getParameter("card_type");

                if (accountIdStr == null || accountIdStr.isEmpty() || cardType == null) {
                    session.setAttribute("error", "Please select an account and card type");
                    response.sendRedirect(request.getContextPath() + "/CardServlet");
                    return;
                }

                long accountId = Long.parseLong(accountIdStr);
                
                // Verify account belongs to user
                Account account = CardDBUtil.getAccountById(accountId);
                if (account == null || account.getUserId() != user.getUserId()) {
                    session.setAttribute("error", "Invalid account selected");
                    response.sendRedirect(request.getContextPath() + "/CardServlet");
                    return;
                }

                boolean success = CardDBUtil.createCardApplication(user.getUserId(), accountId, cardType);
                
                if (success) {
                    session.setAttribute("success", "Card application submitted successfully!");
                    AdminDao.log(user.getUserId(), "CARD_APPLICATION_SUBMITTED", ip, "Card type: " + cardType);
                } else {
                    session.setAttribute("error", "Failed to submit card application. Please try again.");
                }

            } else if ("block".equals(action)) {
                // Handle card blocking
                String cardIdStr = request.getParameter("card_id");
                
                if (cardIdStr == null || cardIdStr.isEmpty()) {
                    session.setAttribute("error", "Invalid card selected");
                    response.sendRedirect(request.getContextPath() + "/CardServlet");
                    return;
                }

                long cardId = Long.parseLong(cardIdStr);
                
                // Verify card belongs to user
                ArrayList<Card> userCards = CardDBUtil.getUserCards(user.getUserId());
                boolean cardBelongsToUser = false;
                for (Card card : userCards) {
                    if (card.getCardId() == cardId) {
                        cardBelongsToUser = true;
                        break;
                    }
                }
                
                if (!cardBelongsToUser) {
                    session.setAttribute("error", "Invalid card selected");
                    response.sendRedirect(request.getContextPath() + "/CardServlet");
                    return;
                }

                boolean success = CardDBUtil.blockCard(cardId);
                
                if (success) {
                    session.setAttribute("success", "Card blocked successfully!");
                    AdminDao.log(user.getUserId(), "CARD_BLOCKED", ip, "Card ID: " + cardId);
                } else {
                    session.setAttribute("error", "Failed to block card. Please try again.");
                }

            } else if ("activate".equals(action)) {
                // Handle card activation
                String cardIdStr = request.getParameter("card_id");
                
                if (cardIdStr == null || cardIdStr.isEmpty()) {
                    session.setAttribute("error", "Invalid card selected");
                    response.sendRedirect(request.getContextPath() + "/CardServlet");
                    return;
                }

                long cardId = Long.parseLong(cardIdStr);
                
                // Verify card belongs to user
                ArrayList<Card> userCards = CardDBUtil.getUserCards(user.getUserId());
                boolean cardBelongsToUser = false;
                for (Card card : userCards) {
                    if (card.getCardId() == cardId) {
                        cardBelongsToUser = true;
                        break;
                    }
                }
                
                if (!cardBelongsToUser) {
                    session.setAttribute("error", "Invalid card selected");
                    response.sendRedirect(request.getContextPath() + "/CardServlet");
                    return;
                }

                boolean success = CardDBUtil.activateCard(cardId);
                
                if (success) {
                    session.setAttribute("success", "Card activated successfully!");
                    AdminDao.log(user.getUserId(), "CARD_ACTIVATED", ip, "Card ID: " + cardId);
                } else {
                    session.setAttribute("error", "Failed to activate card. Please try again.");
                }
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid input format. Please check all fields.");
        } catch (Exception e) {
            session.setAttribute("error", "An unexpected error occurred.");
            e.printStackTrace();
        }

        // Redirect to GET (PRG)
        response.sendRedirect(request.getContextPath() + "/CardServlet");
    }
}

