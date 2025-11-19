import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.bank.utils.AdminDao;
import com.bank.utils.TransferDBUtil;
import com.bank.models.User;
import com.bank.models.Beneficiary;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

@WebServlet("/beneficiaryServlet")
public class beneficiaryServlet extends HttpServlet {
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        
        ArrayList<Beneficiary> list = (ArrayList<Beneficiary>) TransferDBUtil.getAllBeneficiary(user.getUserId());
        request.setAttribute("beneficiaries", list);
        request.getRequestDispatcher("beneficiaries.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        
        String beneficiary_name = request.getParameter("beneficiary_name");
        String account_number = request.getParameter("account_number");
        String bank_name = request.getParameter("bank_name");
        String ip = request.getRemoteAddr();

        
       if( TransferDBUtil.verifyAccount(account_number)) {
        
        Beneficiary B = new Beneficiary();
        B.setBeneficiaryName(beneficiary_name);
        B.setAccountNumber(account_number);
        B.setBankName(bank_name);
        B.setUserId(user.getUserId());
        
        boolean added = TransferDBUtil.addBeneficiary(B);
        if(added) {
            request.setAttribute("message", "Beneficiary added successfully!");
            AdminDao.log(user.getUserId(), "Beneficiary added", ip, "Attempted to  Transfer money");
        } else {
            request.setAttribute("message", "Error: Beneficiary could not be added");
            AdminDao.log(user.getUserId(), " FAILD_TO_added_Beneficiary ", ip, "Attempted to  add Beneficiary");

        } }
       else 
           request.setAttribute("message", "Wrong Account number,or does not Exist");

        doGet(request, response);
    }
}