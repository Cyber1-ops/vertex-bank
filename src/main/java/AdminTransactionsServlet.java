import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.bank.models.User;
import com.bank.utils.TransferDBUtil;
import java.util.List;

@WebServlet("/AdminTransactions")
public class AdminTransactionsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            resp.sendRedirect("index.jsp");
            return;
        }

        List<com.bank.models.TransactionRecord> transactions = TransferDBUtil.getAllTransactions(100);
        req.setAttribute("transactions", transactions);
        req.getRequestDispatcher("adminTransactions.jsp").forward(req, resp);
    }
}

