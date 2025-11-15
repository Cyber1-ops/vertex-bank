import java.io.IOException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;

@WebServlet("/logout")
public class Logout extends HttpServlet {

	
	 protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                   
		 HttpSession s = req.getSession(false);
		 
		 if(s != null) {
			 s.invalidate();
		 }
		 resp.sendRedirect("index.jsp");
		 return;
    	
        
    }	
	

}
