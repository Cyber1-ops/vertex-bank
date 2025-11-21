package com.bank.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Random;
import com.bank.models.Card;
import com.bank.models.CardApplication;
import com.bank.models.Account;

public class CardDBUtil {
    
    private static Connection getConnection() throws SQLException {
        return DatabaseUtil.getConnection();
    } 
    
    // Get all cards for a user (through their accounts)
    public static ArrayList<Card> getUserCards(long userId) {
        ArrayList<Card> cards = new ArrayList<>();
        String sql = "SELECT c.* FROM card c " +
                     "INNER JOIN account a ON c.account_id = a.account_id " +
                     "WHERE a.user_id = ? AND c.status != 'EXPIRED' " +
                     "ORDER BY c.issued_at DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cards.add(new Card(rs));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cards;
    }
    
    // Get cards for a specific account
    public static ArrayList<Card> getAccountCards(long accountId) {
        ArrayList<Card> cards = new ArrayList<>();
        String sql = "SELECT * FROM card WHERE account_id = ? AND status != 'EXPIRED' ORDER BY issued_at DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cards.add(new Card(rs));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cards;
    }
    
    // Get all card applications for a user
    public static ArrayList<CardApplication> getUserCardApplications(long userId) {
        ArrayList<CardApplication> applications = new ArrayList<>();
        String sql = "SELECT * FROM card_application WHERE user_id = ? ORDER BY applied_at DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    applications.add(new CardApplication(rs));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return applications;
    }
    
    // Create a new card application
    public static boolean createCardApplication(long userId, long accountId, String cardType) {
        String sql = "INSERT INTO card_application (user_id, account_id, card_type, status, applied_at) " +
                     "VALUES (?, ?, ?, 'PENDING', NOW())";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, userId);
            ps.setLong(2, accountId);
            ps.setString(3, cardType);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Generate a random 16-digit card number
    private static String generateCardNumber() {
        Random random = new Random();
        StringBuilder cardNumber = new StringBuilder();
        for (int i = 0; i < 16; i++) {
            cardNumber.append(random.nextInt(10));
        }
        return cardNumber.toString();
    }
    
    // Generate a random 3-digit CVV
    private static String generateCVV() {
        Random random = new Random();
        return String.format("%03d", random.nextInt(1000));
    }
    
    // Issue a card (create card from approved application)
    public static boolean issueCard(long applicationId) {
        // First get the application details
        String getAppSql = "SELECT * FROM card_application WHERE application_id = ?";
        long accountId = 0;
        String cardType = null;
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(getAppSql)) {
            
            ps.setLong(1, applicationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    accountId = rs.getLong("account_id");
                    cardType = rs.getString("card_type");
                } else {
                    return false;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        
        // Check if card number already exists (very unlikely but check anyway)
        String cardNumber;
        do {
            cardNumber = generateCardNumber();
        } while (cardNumberExists(cardNumber));
        
        String cvv = generateCVV();
        LocalDate expiryDate = LocalDate.now().plusYears(3);
        
        // Insert the card
        String insertCardSql = "INSERT INTO card (account_id, card_number, card_type, expiry_date, cvv, status, issued_at) " +
                              "VALUES (?, ?, ?, ?, ?, 'ACTIVE', NOW())";
        
        // Update application status
        String updateAppSql = "UPDATE card_application SET status = 'APPROVED', processed_at = NOW() WHERE application_id = ?";
        
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            
            try (PreparedStatement cardPs = conn.prepareStatement(insertCardSql);
                 PreparedStatement appPs = conn.prepareStatement(updateAppSql)) {
                
                cardPs.setLong(1, accountId);
                cardPs.setString(2, cardNumber);
                cardPs.setString(3, cardType);
                cardPs.setDate(4, java.sql.Date.valueOf(expiryDate));
                cardPs.setString(5, cvv);
                
                int cardRows = cardPs.executeUpdate();
                
                if (cardRows > 0) {
                    appPs.setLong(1, applicationId);
                    int appRows = appPs.executeUpdate();
                    
                    if (appRows > 0) {
                        conn.commit();
                        return true;
                    }
                }
                
                conn.rollback();
                return false;
                
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if card number already exists
    private static boolean cardNumberExists(String cardNumber) {
        String sql = "SELECT COUNT(*) FROM card WHERE card_number = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, cardNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Block a card
    public static boolean blockCard(long cardId) {
        String sql = "UPDATE card SET status = 'BLOCKED' WHERE card_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, cardId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Activate a card
    public static boolean activateCard(long cardId) {
        String sql = "UPDATE card SET status = 'ACTIVE' WHERE card_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, cardId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get account by ID
    public static Account getAccountById(long accountId) {
        String sql = "SELECT * FROM account WHERE account_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Account(rs);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Admin: Get all pending card applications
    public static ArrayList<CardApplication> getAllPendingApplications() {
        ArrayList<CardApplication> applications = new ArrayList<>();
        String sql = "SELECT * FROM card_application WHERE status = 'PENDING' ORDER BY applied_at DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    applications.add(new CardApplication(rs));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return applications;
    }
    
    // Admin: Get all card applications
    public static ArrayList<CardApplication> getAllCardApplications() {
        ArrayList<CardApplication> applications = new ArrayList<>();
        String sql = "SELECT * FROM card_application ORDER BY applied_at DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    applications.add(new CardApplication(rs));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return applications;
    }
    
    // Admin: Get card application with user and account details
    public static CardApplication getCardApplicationWithDetails(long applicationId) {
        String sql = "SELECT * FROM card_application WHERE application_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, applicationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new CardApplication(rs);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Admin: Reject card application
    public static boolean rejectCardApplication(long applicationId) {
        String sql = "UPDATE card_application SET status = 'REJECTED', processed_at = NOW() WHERE application_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, applicationId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Count pending card applications
    public static int countPendingApplications() {
        String sql = "SELECT COUNT(*) FROM card_application WHERE status = 'PENDING'";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Count total cards
    public static int countTotalCards() {
        String sql = "SELECT COUNT(*) FROM card WHERE status != 'EXPIRED'";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
}
