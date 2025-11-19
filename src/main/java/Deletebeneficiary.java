

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.bank.models.User;
import com.bank.utils.TransferDBUtil;


@WebServlet("/Deletebeneficiary")
public class Deletebeneficiary extends HttpServlet {
	
	


	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		 HttpSession session = request.getSession(false);
	        if(session == null) {
	            response.sendRedirect("index.jsp");
	            return;
	        }
	        
	        User user = (User) session.getAttribute("user");
	        if(user == null) {
	            response.sendRedirect("index.jsp");
	            return;
	        }
	        int id = Integer.parseInt(request.getParameter("beneficiary_id"));
	      
	      if(  TransferDBUtil.deleteBeneficiary(id) ) {
	    	  request.setAttribute("message", "Beneficiary Deleted Succussfuly");
	    	
	      }
	      else
	    	  request.setAttribute("message", "Beneficiary Deletion Faild  ");
 
	    	
	   request.getRequestDispatcher("beneficiaryServlet").forward(request, response);
    	  return;
		
		
	}

}
