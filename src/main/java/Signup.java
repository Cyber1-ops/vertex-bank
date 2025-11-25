import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.regex.Pattern;
import com.bank.models.*;
import com.bank.utils.*;

@WebServlet("/signup")
public class Signup extends HttpServlet {
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
	            throws ServletException, IOException {

	        String username = req.getParameter("username");
	        String email = req.getParameter("email");
	        String fullName = req.getParameter("name");
	        String password = req.getParameter("pass");
	        String phone = req.getParameter("tel");

	        
	        if (!validateUserInput(email, username, password, fullName, phone)) {
	            req.setAttribute("error", "❌ Wrong information. Enter valid values.");
	            req.getRequestDispatcher("signup.jsp").forward(req, resp);
	            return;
	        }

	       
	        String passwordHash = PasswordUtil.hashPassword(password.toCharArray());

	      
	        User user = new User();
	        user.setUsername(username);
	        user.setEmail(email);
	        user.setFullName(fullName);
	        user.setPasswordHash(passwordHash);
	        user.setPhone(phone);

	      
	        if (DatabaseUtil.Signup(user)) {
	            req.setAttribute("msg", "🎉 Account created successfully! <a href='login.jsp'>Login now</a>");
	            req.getRequestDispatcher("signup.jsp").forward(req, resp);
	        } else {
	            req.setAttribute("error", "❌ Account creation failed. Please try again.");
	            req.getRequestDispatcher("signup.jsp").forward(req, resp);
	        }
	   
	}


public static boolean validateUserInput(String email, String username, String password, String fullName, String phone) {
    if (email == null || username == null || password == null || fullName == null || phone == null) {
        return false;
    }

    
    Pattern emailPattern = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    if (!emailPattern.matcher(email).matches()) {
        return false;
    }

    
    Pattern usernamePattern = Pattern.compile("^[A-Za-z0-9_]{3,20}$");
    if (!usernamePattern.matcher(username).matches()) {
        return false;
    }

   
    Pattern passwordPattern = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$");
    if (!passwordPattern.matcher(password).matches()) {
        return false;
    }

   
    Pattern fullNamePattern = Pattern.compile("^[A-Za-z ]{2,50}$");
    if (!fullNamePattern.matcher(fullName).matches()) {
        return false;
    }

  
    Pattern phonePattern = Pattern.compile("^05[0-9]{8}$");
    if (!phonePattern.matcher(phone).matches()) {
        return false;
    }

    return true;
}

}


