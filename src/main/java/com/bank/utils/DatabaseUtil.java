package com.bank.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import java.util.ArrayList;

import com.bank.models.Account;
import com.bank.models.User;

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
                "username, password_hash, full_name, email, phone, age, " +
                "nationality, passport_number, id_number, address, monthly_income, role, status, created_at" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

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
            ps.setString(9, user.getIdNumber());
            ps.setString(10, user.getAddress());
            ps.setDouble(11, user.getMonthlyIncome());
            ps.setString(12, user.getRole());
            ps.setString(13, user.getStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static Account getAccount(int userId) {
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
    
    
    public static ArrayList<Account> getActiveUserAccounts(int userId) {
        ArrayList<Account> accounts = new ArrayList<>();
        String sql = "SELECT * FROM account WHERE user_id = ? AND status = 'ACTIVE'";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    accounts.add(new Account(rs));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return accounts;
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
            return rows > 0;

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
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean openAccount(Account account, User user) {
        // Ensure account number is generated
        if (account.getAccountNumber() == null || account.getAccountNumber().isEmpty()) {
            account.setAccountNumber(generateAccountNumber());
        }

        String updateUserSQL =
                "UPDATE `user` SET full_name=?, phone=?, dob=?, age=?, nationality=?, passport_number=?, id_number=?, address=?, monthly_income=? " +
                        "WHERE user_id=?";

        Connection conn = null;
        try {
            conn = getConnection();

            conn.setAutoCommit(false); // Start transaction

            // Update user profile with CORRECT parameter indices
            try (PreparedStatement psUpdate = conn.prepareStatement(updateUserSQL)) {
                psUpdate.setString(1, user.getFullName());
                psUpdate.setString(2, user.getPhone());

                // Handle DOB properly
                if (user.getDob() != null) {
                    psUpdate.setDate(3, java.sql.Date.valueOf(user.getDob()));
                } else {
                    psUpdate.setNull(3, java.sql.Types.DATE);
                }

                // Handle AGE properly (can be null or Integer)
                if (user.getAge() != null) {
                    psUpdate.setInt(4, user.getAge());
                } else {
                    psUpdate.setNull(4, java.sql.Types.INTEGER);
                }

                psUpdate.setString(5, user.getNationality());
                psUpdate.setString(6, user.getPassportNumber());
                psUpdate.setString(7, user.getIdNumber());
                psUpdate.setString(8, user.getAddress());

                // Handle MONTHLY_INCOME properly (can be null or Double)
                if (user.getMonthlyIncome() != null) {
                    psUpdate.setDouble(9, user.getMonthlyIncome());
                } else {
                    psUpdate.setNull(9, java.sql.Types.DOUBLE);
                }

                psUpdate.setInt(10, user.getUserId());

                int rowsUser = psUpdate.executeUpdate();

                if (rowsUser <= 0) {
                    conn.rollback();
                    return false;
                }
            } catch (Exception e) {
                e.printStackTrace();
                conn.rollback();
                return false;
            }

            // Insert account
            String insertAccountSQL = "INSERT INTO `account` (user_id, account_number, account_type, balance, currency, status, created_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, NOW())";

            try (PreparedStatement psAccount = conn.prepareStatement(insertAccountSQL)) {
                psAccount.setLong(1, account.getUserId());
                psAccount.setString(2, account.getAccountNumber());
                psAccount.setString(3, account.getAccountType());
                psAccount.setDouble(4, account.getBalance());
                psAccount.setString(5, account.getCurrency());
                psAccount.setString(6, account.getStatus());

                int rowsAccount = psAccount.executeUpdate();

                if (rowsAccount <= 0) {
                    conn.rollback();
                    return false;
                }
            } catch (Exception e) {
                e.printStackTrace();
                conn.rollback();
                return false;
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();

            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private static String generateAccountNumber() {
        Random r = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 12; i++) sb.append(r.nextInt(10));
        return sb.toString();
    }
}