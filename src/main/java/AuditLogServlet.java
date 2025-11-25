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
	     
	     String searchQuery = request.getParameter("search");
	     List<AuditLog> filteredList = list;
	     
	     if (searchQuery != null && !searchQuery.trim().isEmpty()) {
	         String searchLower = searchQuery.toLowerCase().trim();
	         filteredList = list.stream()
	             .filter(log -> 
	                 String.valueOf(log.getLogId()).contains(searchLower) ||
	                 String.valueOf(log.getUserId()).contains(searchLower) ||
	                 (log.getAction() != null && log.getAction().toLowerCase().contains(searchLower)) ||
	                 (log.getIpAddress() != null && log.getIpAddress().toLowerCase().contains(searchLower)) ||
	                 (log.getDetails() != null && log.getDetails().toLowerCase().contains(searchLower))
	             )
	             .collect(Collectors.toList());
	         request.setAttribute("searchQuery", searchQuery);
	     }
	     
	     int page = 1;
	     int pageSize = 20;
	     try {
	         String pageParam = request.getParameter("page");
	         if (pageParam != null && !pageParam.isEmpty()) {
	             page = Integer.parseInt(pageParam);
	         }
	     } catch (NumberFormatException e) {
	         page = 1;
	     }
	     
	     int totalItems = filteredList.size();
	     int totalPages = (int) Math.ceil((double) totalItems / pageSize);
	     int startIndex = (page - 1) * pageSize;
	     int endIndex = Math.min(startIndex + pageSize, totalItems);
	     
	     List<AuditLog> paginatedList = filteredList.subList(startIndex, endIndex);
	     
	     request.setAttribute("logs", paginatedList);
	     request.setAttribute("currentPage", page);
	     request.setAttribute("totalPages", totalPages);
	     request.setAttribute("totalItems", totalItems);
	     
	     request.getRequestDispatcher("AUDIT_LOG.jsp").forward(request, response);
		 return;
	
	}

	

}
