import java.io.IOException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import com.bank.models.AuditLog;
import com.bank.utils.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


@WebServlet("/AuditLogServlet")
public class AuditLogServlet extends HttpServlet {

  


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	     ArrayList<AuditLog> list =  AdminDao.getlog();
	     
	     // Handle search functionality
	     String searchQuery = request.getParameter("search");
	     if (searchQuery != null && !searchQuery.trim().isEmpty()) {
	         String searchLower = searchQuery.toLowerCase().trim();
	         List<AuditLog> filteredList = list.stream()
	             .filter(log -> 
	                 String.valueOf(log.getLogId()).contains(searchLower) ||
	                 String.valueOf(log.getUserId()).contains(searchLower) ||
	                 (log.getAction() != null && log.getAction().toLowerCase().contains(searchLower)) ||
	                 (log.getIpAddress() != null && log.getIpAddress().toLowerCase().contains(searchLower)) ||
	                 (log.getDetails() != null && log.getDetails().toLowerCase().contains(searchLower))
	             )
	             .collect(Collectors.toList());
	         request.setAttribute("logs", filteredList);
	         request.setAttribute("searchQuery", searchQuery);
	     } else {
	         request.setAttribute("logs", list);
	     }
	     
	     // Forward the request to the JSP page
	     request.getRequestDispatcher("AUDIT_LOG.jsp").forward(request, response);
		 return;
	
	}

	

}
