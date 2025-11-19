package com.bank.filters;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.bank.models.User;

@WebFilter("*.jsp") // intercept all JSPs
public class LoginFilter extends HttpFilter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        String uri = req.getRequestURI();
        String ctx = req.getContextPath();

        // PUBLIC JSPs that do not require login
        boolean isPublic = uri.endsWith("index.jsp") || 
                           uri.endsWith("login.jsp") ||
                           uri.endsWith("signup.jsp") || 
                           uri.endsWith("Support.jsp");

        if (isPublic) {
            // Let public JSPs pass
            chain.doFilter(request, response);
            return;
        }

        // PRIVATE JSPs: user must be logged in
        if (user == null) {
            res.sendRedirect(ctx + "/index.jsp"); // redirect to login
            return;
        }

        // User logged in, allow access
        chain.doFilter(request, response);
    }
}
