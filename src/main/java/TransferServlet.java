
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

import com.bank.models.Account;
import com.bank.models.Beneficiary;
import com.bank.models.User;
import com.bank.utils.AdminDao;
import com.bank.utils.DatabaseUtil;
import com.bank.utils.TransferDBUtil;

@WebServlet("/TransferServlet")
public class TransferServlet extends HttpServlet {

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

        // Load user accounts and beneficiaries
        ArrayList<Account> accounts = DatabaseUtil.getActiveUserAccounts(user.getUserId());
        ArrayList<Beneficiary> beneficiaries =( ArrayList<Beneficiary>) TransferDBUtil.getAllBeneficiary(user.getUserId());

        request.setAttribute("accounts", accounts);
        request.setAttribute("beneficiaries", beneficiaries);

        // Get messages from session (PRG pattern)
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");
        
        // Get transfer details from session for success modal
        String transferAmount = (String) session.getAttribute("transferAmount");
        String transferFrom = (String) session.getAttribute("transferFrom");
        String transferTo = (String) session.getAttribute("transferTo");
        
        // Remove from session after reading
        session.removeAttribute("success");
        session.removeAttribute("error");
        session.removeAttribute("transferAmount");
        session.removeAttribute("transferFrom");
        session.removeAttribute("transferTo");

        // Set as request attributes
        request.setAttribute("success", success);
        request.setAttribute("error", error);
        request.setAttribute("transferAmount", transferAmount);
        request.setAttribute("transferFrom", transferFrom);
        request.setAttribute("transferTo", transferTo);

        request.getRequestDispatcher("transfer.jsp").forward(request, response);
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

        String transferType = request.getParameter("transfer_type");
        String fromAccountStr = request.getParameter("from_account_id");
        String amountStr = request.getParameter("amount");
        String description = request.getParameter("description");
        String ip = request.getRemoteAddr();

        try {
            System.out.println("TransferServlet: doPost started.");
            System.out.println("TransferServlet: transferType = " + transferType);
            System.out.println("TransferServlet: fromAccountStr = " + fromAccountStr);
            System.out.println("TransferServlet: amountStr = " + amountStr);

            // Validate required fields
            if (transferType == null || fromAccountStr == null || fromAccountStr.isEmpty()
                    || amountStr == null || amountStr.isEmpty()) {
                System.out.println("TransferServlet: Validation failed - missing required fields.");
                session.setAttribute("error", "Please fill all required fields");
                response.sendRedirect(request.getContextPath() + "/TransferServlet");
                return;
            }

            int fromAccountId = Integer.parseInt(fromAccountStr);
            double amount = Double.parseDouble(amountStr);
            System.out.println("TransferServlet: Parsed fromAccountId = " + fromAccountId + ", amount = " + amount);

            if (amount <= 0) {
                System.out.println("TransferServlet: Validation failed - amount <= 0.");
                session.setAttribute("error", "Amount must be greater than zero");
                response.sendRedirect(request.getContextPath() + "/TransferServlet");
                return;
            }

            boolean transferSuccess = false;

            switch (transferType) {
                case "OWN_ACCOUNT": {
                    String toAccountStr = request.getParameter("to_own_account_id");
                    System.out.println("TransferServlet: OWN_ACCOUNT - toAccountStr = " + toAccountStr);
                    if (toAccountStr == null || toAccountStr.isEmpty()) {
                        System.out.println("TransferServlet: OWN_ACCOUNT Validation failed - missing destination account.");
                        session.setAttribute("error", "Please select a destination account");
                        response.sendRedirect(request.getContextPath() + "/TransferServlet");
                        return;
                    }
                    int toAccountId = Integer.parseInt(toAccountStr);
                    System.out.println("TransferServlet: OWN_ACCOUNT - toAccountId = " + toAccountId);
                    transferSuccess = TransferDBUtil.transfer(amount, fromAccountId, toAccountId, description);
                    System.out.println("TransferServlet: OWN_ACCOUNT - transferSuccess = " + transferSuccess);
                    break;
                }
                case "BENEFICIARY": {
                    String benStr = request.getParameter("beneficiary_id");
                    System.out.println("TransferServlet: BENEFICIARY - benStr = " + benStr);
                    if (benStr == null || benStr.isEmpty()) {
                        System.out.println("TransferServlet: BENEFICIARY Validation failed - missing beneficiary selection.");
                        session.setAttribute("error", "Please select a beneficiary");
                        response.sendRedirect(request.getContextPath() + "/TransferServlet");
                        return;
                    }
                    int beneficiaryId = Integer.parseInt(benStr);
                    String recipientAccNum = TransferDBUtil.getBeneficiaryAccountNumber(beneficiaryId);
                    System.out.println("TransferServlet: BENEFICIARY - recipientAccNum = " + recipientAccNum);

                    if (recipientAccNum != null && TransferDBUtil.verifyAccount(recipientAccNum)) {
                        int toAccountId = TransferDBUtil.getAccountIdByNumber(recipientAccNum);
                        System.out.println("TransferServlet: BENEFICIARY - toAccountId = " + toAccountId);
                        if (toAccountId > 0) {
                            transferSuccess = TransferDBUtil.transfer(amount, fromAccountId, toAccountId, description);
                            System.out.println("TransferServlet: BENEFICIARY - transferSuccess = " + transferSuccess);
                        } else {
                            System.out.println("TransferServlet: BENEFICIARY - toAccountId <= 0.");
                        }
                    } else {
                        System.out.println("TransferServlet: BENEFICIARY - recipientAccNum is null or verifyAccount failed.");
                    }
                    break;
                }
                case "OTHER_BANK": {
                    String recipientAcc = request.getParameter("recipient_account_number");
                    String recipientName = request.getParameter("recipient_name");
                    System.out.println("TransferServlet: OTHER_BANK - recipientAcc = " + recipientAcc + ", recipientName = " + recipientName);

                    if (recipientAcc == null || recipientAcc.isEmpty() || recipientName == null || recipientName.isEmpty()) {
                        System.out.println("TransferServlet: OTHER_BANK Validation failed - missing recipient account or name.");
                        session.setAttribute("error", "Recipient account and name are required");
                        response.sendRedirect(request.getContextPath() + "/TransferServlet");
                        return;
                    }

                    if (TransferDBUtil.verifyAccount(recipientAcc)) {
                        int toAccountId = TransferDBUtil.getAccountIdByNumber(recipientAcc);
                        System.out.println("TransferServlet: OTHER_BANK - toAccountId = " + toAccountId);
                        if (toAccountId > 0) {
                            transferSuccess = TransferDBUtil.transfer(amount, fromAccountId, toAccountId,
                                    description + " - To: " + recipientName);
                            System.out.println("TransferServlet: OTHER_BANK - transferSuccess = " + transferSuccess);
                        } else {
                            System.out.println("TransferServlet: OTHER_BANK - toAccountId <= 0.");
                        }
                    } else {
                        System.out.println("TransferServlet: OTHER_BANK - verifyAccount failed.");
                    }
                    break;
                }
                default:
                    System.out.println("TransferServlet: Invalid transfer type: " + transferType);
                    session.setAttribute("error", "Invalid transfer type");
                    response.sendRedirect(request.getContextPath() + "/TransferServlet");
                    return;
            }

            // Set messages and log
            if (transferSuccess) {
                System.out.println("TransferServlet: Transfer successful.");
                session.setAttribute("success", "Transfer completed successfully!");
                
                // Store transfer details for success modal
                String fromAccountText = "";
                String toAccountText = "";
                String currency = "AED";
                
                // Get from account details
                Account fromAccount = com.bank.utils.CardDBUtil.getAccountById(fromAccountId);
                if (fromAccount != null) {
                    fromAccountText = fromAccount.getAccountNumber() + " - " + fromAccount.getAccountType();
                    currency = fromAccount.getCurrency();
                }
                
                // Get to account details based on transfer type
                if ("OWN_ACCOUNT".equals(transferType)) {
                    String toAccountStr = request.getParameter("to_own_account_id");
                    if (toAccountStr != null && !toAccountStr.isEmpty()) {
                        int toAccountId = Integer.parseInt(toAccountStr);
                        Account toAccount = com.bank.utils.CardDBUtil.getAccountById(toAccountId);
                        if (toAccount != null) {
                            toAccountText = toAccount.getAccountNumber() + " - " + toAccount.getAccountType();
                        }
                    }
                } else if ("BENEFICIARY".equals(transferType)) {
                    String benStr = request.getParameter("beneficiary_id");
                    if (benStr != null && !benStr.isEmpty()) {
                        int beneficiaryId = Integer.parseInt(benStr);
                        String beneficiaryName = TransferDBUtil.getBeneficiaryName(beneficiaryId);
                        String recipientAccNum = TransferDBUtil.getBeneficiaryAccountNumber(beneficiaryId);
                        if (beneficiaryName != null && recipientAccNum != null) {
                            toAccountText = beneficiaryName + " - " + recipientAccNum;
                        }
                    }
                } else if ("OTHER_BANK".equals(transferType)) {
                    String recipientName = request.getParameter("recipient_name");
                    String recipientAcc = request.getParameter("recipient_account_number");
                    if (recipientName != null && recipientAcc != null) {
                        toAccountText = recipientName + " - " + recipientAcc;
                    }
                }
                
                session.setAttribute("transferAmount", currency + " " + String.format("%.2f", amount));
                session.setAttribute("transferFrom", fromAccountText);
                session.setAttribute("transferTo", toAccountText);
                
                AdminDao.log(user.getUserId(), "TRANSFER_COMPLETED", ip, "Transfer of " + amount);
            } else {
                System.out.println("TransferServlet: Transfer failed.");
                session.setAttribute("error", "Transfer failed. Check account details and balance.");
                AdminDao.log(user.getUserId(), "TRANSFER_FAILED", ip, "Attempted transfer of " + amount);
            }

        } catch (NumberFormatException e) {
            System.err.println("TransferServlet: NumberFormatException - " + e.getMessage());
            session.setAttribute("error", "Invalid input format. Please check all fields.");
        } catch (Exception e) {
            System.err.println("TransferServlet: Unexpected error - " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "An unexpected error occurred during transfer.");
        }

        // Redirect to GET (PRG)
        System.out.println("TransferServlet: Redirecting to /TransferServlet (GET).");
        response.sendRedirect(request.getContextPath() + "/TransferServlet");
    }
}
