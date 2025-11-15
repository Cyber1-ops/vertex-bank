<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database Test</title>
</head>
<body>
    <h1>Database Connection Test</h1>
    
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_db", "root", "root");
            
            out.println("<h2>✅ Database Connection Successful!</h2>");
            
            // Test USER table
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM user");
            rs.next();
            out.println("<p>Users in DB: " + rs.getInt("count") + "</p>");
            
            // Test ACCOUNT table
            rs = stmt.executeQuery("SELECT COUNT(*) as count FROM account");
            rs.next();
            out.println("<p>Accounts in DB: " + rs.getInt("count") + "</p>");
            
            // Show table structure for ACCOUNT
            out.println("<h3>ACCOUNT Table Structure:</h3>");
            out.println("<pre>");
            rs = stmt.executeQuery("DESCRIBE account");
            while(rs.next()) {
                out.println(rs.getString("Field") + " - " + rs.getString("Type") + " - " + rs.getString("Null"));
            }
            out.println("</pre>");
            
            conn.close();
            
        } catch (Exception e) {
            out.println("<h2>❌ Error:</h2>");
            out.println("<pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</pre>");
        }
    %>
</body>
</html>
