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
	
	

protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String username = req.getParameter("username");
    String email = req.getParameter("email");
    String fullName = req.getParameter("name");
    String password = req.getParameter("pass");
    String phone = req.getParameter("tel");
    
    if(validateUserInput(email,username,password,fullName,phone)) {
    	String passwordHash = PasswordUtil.hashPassword(password.toCharArray());
          User user = new User();
          user.setUsername(username);
          user.setEmail(email);
          user.setFullName(fullName);
          user.setPasswordHash(passwordHash);
          user.setPhone(phone);
          if(DatabaseUtil.Signup(user)) {
        	  req.getSession().setAttribute("user", user);
        	  req.getRequestDispatcher("login.jsp").forward(req, resp);
        	  return;
        	  } 
          else {
        	  String message = "account creation faild! , Please try again";
        	  req.getSession().setAttribute("message", message);
        	  resp.sendRedirect("signup.jsp");
        	  return;
          }
          
    
    }
          else {
        	  String error = "Wrong Information Enter a valid Values";
        	  req.getSession().setAttribute("error", error);
        	  resp.sendRedirect("signup.jsp");
        	  return;
          }
                             
	}

public static boolean validateUserInput(String email, String username, String password, String fullName, String phone) {
    if (email == null || username == null || password == null || fullName == null || phone == null) {
        return false;
    }

    // 1. Email: standard format (e.g., user@vertex.bank)
    Pattern emailPattern = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    if (!emailPattern.matcher(email).matches()) {
        return false;
    }

    // 2. Username: 3-20 chars, letters, numbers, underscore only
    Pattern usernamePattern = Pattern.compile("^[A-Za-z0-9_]{3,20}$");
    if (!usernamePattern.matcher(username).matches()) {
        return false;
    }

    // 3. Password: min 8 chars, at least 1 letter + 1 number
    Pattern passwordPattern = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$");
    if (!passwordPattern.matcher(password).matches()) {
        return false;
    }

    // 4. Full Name: letters and spaces only, 2-50 chars
    Pattern fullNamePattern = Pattern.compile("^[A-Za-z ]{2,50}$");
    if (!fullNamePattern.matcher(fullName).matches()) {
        return false;
    }

    // 5. Phone Number: UAE mobile format
    // - Must start with 05
    // - Exactly 10 digits: 05X XXXXXXX
    // - X can be 0-9
    Pattern phonePattern = Pattern.compile("^05[0-9]{8}$");
    if (!phonePattern.matcher(phone).matches()) {
        return false;
    }

    return true; // All validations passed
}

}


