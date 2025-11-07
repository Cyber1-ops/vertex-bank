package com.bank.utils;
import java.sql.*;
import com.bank.models.*;

public class DatabaseUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/bank_db";
    private static final String USER = "root";
    private static final String PASS = "root";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public static User getUser(String email) {
        User user = null;
        String sql = "SELECT * FROM `user` WHERE `email` = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
    
    public static boolean insertUser(User user) {
        String sql = "INSERT INTO `user` (" +
                " username, password_hash, full_name, email, phone, age, " +
                "nationality, passport_number, address, monthly_income, role, status" +
                ") VALUES ( ?, ?, ?, ?, ?, NOW(), ?, ?, ?, ?, ?, ?,?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setInt(6, user.getAge());
            ps.setString(7, user.getNationality());
            ps.setString(8, user.getPassportNumber());
            ps.setString(9, user.getAddress());
            ps.setDouble(10, user.getMonthlyIncome());
            ps.setString(11, user.getRole());
            ps.setString(12, user.getStatus());

            int rows = ps.executeUpdate();
            return rows > 0; // true if insert was successful

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    	
    
    

    public static Account getAccount(long userId) {
        Account account = null;
        String sql = "SELECT * FROM account WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    account = new Account(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return account;
    }
    
    public static boolean insertAccount(Account account) {
    	String sql = "INSERT INTO account (" +
    	        "user_id, account_number, account_type, balance, currency, status, created_at" +
    	        ") VALUES (?, ?, ?, ?, ?, ?, NOW())";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

        	ps.setLong(1, account.getUserId());
        	ps.setString(2, account.getAccountNumber());
        	ps.setString(3, account.getAccountType());
        	ps.setDouble(4, account.getBalance());
        	ps.setString(5, account.getCurrency());
        	ps.setString(6, account.getStatus());


            int rows = ps.executeUpdate();
            return rows > 0; // true if insert succeeded

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static boolean Signup(User user) {
    	 String sql = "INSERT INTO `user`(`username`, `password_hash`, `email`, `full_name`, `role`, `status`, `created_at`) " +
    	            "VALUES(?, ?, ?, ?, ?, ?, NOW())";

         try (Connection conn = getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {

             ps.setString(1, user.getUsername());
             ps.setString(2, user.getPasswordHash());
             ps.setString(3, user.getEmail());
             ps.setString(4, user.getFullName());
             ps.setString(5, "USER");
             ps.setString(6, "ACTIVE");

             int rows = ps.executeUpdate();
             return rows > 0; // true if insert was successful

         } catch (SQLException e) {
             e.printStackTrace();
             return false;
         }
    }
    
    public static int countUsers() {
        String sql = "SELECT COUNT(*) FROM `user` where role != 'ADMIN'"; // Note: table name is lowercase 'user' in most setups

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) { // Use executeQuery(), not executeUpdate()

            if (rs.next()) {
                return rs.getInt(1); // First column contains COUNT(*)
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Error indicator
    }

}
