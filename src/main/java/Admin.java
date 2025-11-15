import java.io.IOException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import com.bank.models.*;
import com.bank.utils.*;
import java.util.ArrayList;

@WebServlet("/Admin")
public class Admin extends HttpServlet {

	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       req.setAttribute("allbalance",getallbalance(AdminDao.getallAccount()));
       req.setAttribute("Ucount", AdminDao.countUsers());
       req.getRequestDispatcher("Admin.jsp").forward(req, resp);
       return;
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("pass");
       req.setAttribute("allbalance",getallbalance(AdminDao.getallAccount()));
       req.setAttribute("Ucount", AdminDao.countUsers());
       req.getRequestDispatcher("Admin.jsp").forward(req, resp);
       return;
                
	}
	
	public static double getallbalance(ArrayList<Account> list) {
		double sum = 0.0;
		for(Account AC : list) {
		sum +=	AC.getBalance();
		}
		return sum;
	}
	
}
