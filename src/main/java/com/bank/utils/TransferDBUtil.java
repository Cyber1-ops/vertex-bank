package com.bank.utils;
import com.bank.models.Beneficiary;
import com.bank.models.TransactionRecord;
import com.bank.models.User;
import com.bank.models.Account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TransferDBUtil extends DatabaseUtil {
	
	public static List<Beneficiary> getAllBeneficiary(int userId) {
	    List<Beneficiary> beneficiaries = new ArrayList<>();
	    String sql = "SELECT * FROM beneficiary WHERE user_id = ?";

	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, userId);

	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Beneficiary b = new Beneficiary(rs);
	                beneficiaries.add(b);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return beneficiaries;
	}
	
	public static boolean addBeneficiary(Beneficiary b) {
	    String sql = "INSERT INTO `beneficiary`(user_id, beneficiary_name, account_number, bank_name, added_at) VALUES (?,?,?,?,NOW())";
	    
	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setInt(1, b.getUserId());
	        ps.setString(2, b.getBeneficiaryName());
	        ps.setString(3, b.getAccountNumber());
	        ps.setString(4, b.getBankName());
	        
	        int row = ps.executeUpdate();
	        return row > 0;  
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;    
	    }
	}
	
	public static boolean verifyAccount(String account_number) {
	    String sql = "SELECT account_number FROM `account` WHERE account_number = ?";
	    try (Connection conn = getConnection(); 
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setString(1, account_number);
	        ResultSet rs = ps.executeQuery();  
	        
	        return rs.next();  // rs.next() returns true if account found
	        
	    } catch(SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public static boolean deleteBeneficiary(int beneficiary_id) {
	    String sql = "DELETE FROM BENEFICIARY WHERE beneficiary_id = ?";
	    try(Connection conn = getConnection(); 
	        PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setInt(1, beneficiary_id);
	        int rowsAffected = ps.executeUpdate();
	        return rowsAffected > 0;  
	        
	    } catch(SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public static boolean transfer(double amount, int fromAccountId, int toAccountId, String description) {
	    String debitSQL = "UPDATE `account` SET balance = balance - ? WHERE account_id = ? AND balance >= ?";
	    String creditSQL = "UPDATE `account` SET balance = balance + ? WHERE account_id = ?";
	    String transactionSQL = "INSERT INTO `transaction` (from_account_id, to_account_id, amount, transaction_type, description, timestamp) VALUES (?, ?, ?, 'TRANSFER', ?, NOW())";
	    
	    try (Connection conn = getConnection()) {
	        conn.setAutoCommit(false);
	        
	        try (PreparedStatement debitStmt = conn.prepareStatement(debitSQL);
	             PreparedStatement creditStmt = conn.prepareStatement(creditSQL);
	             PreparedStatement transactionStmt = conn.prepareStatement(transactionSQL)) {
	            
	            // Debit from sender
	            debitStmt.setDouble(1, amount);
	            debitStmt.setInt(2, fromAccountId);
	            debitStmt.setDouble(3, amount);
	            int debitRows = debitStmt.executeUpdate();
	            
	            if (debitRows == 0) {
	                conn.rollback();
	                return false; // Insufficient funds
	            }
	            
	            // Credit to receiver
	            creditStmt.setDouble(1, amount);
	            creditStmt.setInt(2, toAccountId);
	            int creditRows = creditStmt.executeUpdate();
	            
	            if (creditRows == 0) {
	                conn.rollback();
	                return false; // Receiver account not found
	            }
	            
	            // Record transaction
	            transactionStmt.setInt(1, fromAccountId);
	            transactionStmt.setInt(2, toAccountId);
	            transactionStmt.setDouble(3, amount);
	            transactionStmt.setString(4, description);
	            transactionStmt.executeUpdate();
	            
	            conn.commit();
	            return true;
	            
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


	
	public static String getBeneficiaryAccountNumber(int beneficiary_id) {
	    String sql = "SELECT account_number FROM beneficiary WHERE beneficiary_id = ?";
	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setInt(1, beneficiary_id);
	        try (ResultSet rs = ps.executeQuery()) {
	            return rs.next() ? rs.getString("account_number") : null;
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	public static String getBeneficiaryName(int beneficiary_id) {
	    String sql = "SELECT beneficiary_name FROM beneficiary WHERE beneficiary_id = ?";
	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setInt(1, beneficiary_id);
	        try (ResultSet rs = ps.executeQuery()) {
	            return rs.next() ? rs.getString("beneficiary_name") : null;
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return null;
	    }
	}

	public static int getAccountIdByNumber(String account_number) {
	    String sql = "SELECT account_id FROM account WHERE account_number = ?";
	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setString(1, account_number);
	        try (ResultSet rs = ps.executeQuery()) {
	            return rs.next() ? rs.getInt("account_id") : -1;
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return -1;
	    }
	}

	
}



