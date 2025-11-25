import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.bank.models.Account;
import com.bank.models.TransactionRecord;
import com.bank.models.User;
import com.bank.utils.DatabaseUtil;
import com.bank.utils.TransferDBUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/statement")
public class StatementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/statement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String period = request.getParameter("period"); 
        String monthStr = request.getParameter("month");
        String yearStr = request.getParameter("year");
        String download = request.getParameter("download");

        int year = -1;
        int month = -1;
        try {
            if (yearStr != null && !yearStr.isEmpty()) year = Integer.parseInt(yearStr);
            if (monthStr != null && !monthStr.isEmpty()) month = Integer.parseInt(monthStr);
        } catch (NumberFormatException e) {
           
        }

        List<TransactionRecord> txns = new ArrayList<>();
        
        try {
            txns = TransferDBUtil.getUserTransactions(user.getUserId(), 10000);
        } catch (Exception e) {
            e.printStackTrace();
        }

       
        List<Account> accounts = DatabaseUtil.getActiveUserAccounts(user.getUserId());
        final List<Long> accountIds = accounts.stream().map(Account::getAccountId).collect(Collectors.toList());
        final String periodF = period;
        final int yearF = year;
        final int monthF = month;

        List<TransactionRecord> filtered = txns.stream().filter(t -> {
            LocalDateTime ts = t.getTimestamp();
            if (ts == null) return false;
            boolean belongs = accountIds.contains(t.getFromAccountId()) || accountIds.contains(t.getToAccountId());
            if (!belongs) return false;
            if ("monthly".equals(periodF)) {
                if (yearF > 0 && monthF > 0) {
                    return ts.getYear() == yearF && ts.getMonthValue() == monthF;
                }
                return true;
            } else if ("yearly".equals(periodF)) {
                if (yearF > 0) {
                    return ts.getYear() == yearF;
                }
                return true;
            }
            return true;
        }).collect(Collectors.toList());

       
        double totalIn = 0.0, totalOut = 0.0;
        for (TransactionRecord t : filtered) {
            if (accountIds.contains(t.getToAccountId()) && !accountIds.contains(t.getFromAccountId())) {
                totalIn += t.getAmount();
            } else if (accountIds.contains(t.getFromAccountId()) && !accountIds.contains(t.getToAccountId())) {
                totalOut += t.getAmount();
            } else {
               
            }
        }

        if ("csv".equalsIgnoreCase(download)) {
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=statement.csv");
            try (PrintWriter pw = response.getWriter()) {
                pw.println("transactionId,timestamp,fromAccountId,toAccountId,amount,type,description");
                for (TransactionRecord t : filtered) {
                    pw.printf("%d,%s,%d,%d,%.2f,%s,%s\n",
                            t.getTransactionId(), t.getTimestamp().toString(), t.getFromAccountId(), t.getToAccountId(), t.getAmount(), t.getTransactionType(), t.getDescription().replaceAll("[\r\n,]"," "));
                }
            }
            return;
        }

        request.setAttribute("transactions", filtered);
        request.setAttribute("totalIn", totalIn);
        request.setAttribute("totalOut", totalOut);
        request.setAttribute("period", period);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);
        request.getRequestDispatcher("/statement.jsp").forward(request, response);
    }
}
