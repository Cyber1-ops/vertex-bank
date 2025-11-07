

import java.io.IOException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import com.bank.models.*;
import com.bank.utils.*;

@WebServlet("/login")
public class Login extends HttpServlet {

	
	
   
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
   
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("pass");
        User user = DatabaseUtil.getUser(email);
       String storedHash = user.getPasswordHash();
                boolean ok = PasswordUtil.verifyPassword(password.toCharArray(), storedHash);
                if (ok && user.getRole().equals("USER")) {
                    HttpSession session = req.getSession();
                    session.setAttribute("user",user);
                    req.getRequestDispatcher("Dashboard.jsp").forward(req, resp);
                    return;}
                    
                  else if(ok && user.getRole().equals("ADMIN")) {
                      HttpSession session = req.getSession();
                      session.setAttribute("user",user);
                      req.getRequestDispatcher("Admin.jsp").forward(req, resp);
                      return;
                    	
                    }

                 else {
                    resp.sendRedirect("index.jsp");
                    return;
                }
       
      
    
		
	
		
		
	}

}
