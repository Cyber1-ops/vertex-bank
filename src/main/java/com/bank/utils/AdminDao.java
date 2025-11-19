package com.bank.utils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.bank.models.*;
import java.util.ArrayList;

public class AdminDao extends DatabaseUtil {

	public static ArrayList<User> getAllUsers() {
		ArrayList<User> users = new ArrayList<>();
		String sql = "select * from `user` where role != 'ADMIN'";
		 try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql);
	             ResultSet rs = ps.executeQuery()) { 
                     while (rs.next()) {
	                User u = new User(rs);
	                users.add(u);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		 return users;
	}
	
	public static ArrayList<Account> getallAccount() {
		ArrayList<Account> ACs = new ArrayList<>();
		String sql = "select * from `ACCOUNT` ";
		 try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql);
	             ResultSet rs = ps.executeQuery()) { 
                     while (rs.next()) {
	                Account AC = new Account(rs);
	                ACs.add(AC);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		 return ACs;
		
	}
	
	
	
	  public static int countUsers() {
	        String sql = "SELECT COUNT(*) FROM `user` where role != 'ADMIN'"; 
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
	  
	  public static void log(Integer userId, String action, String ip, String details) {
	        String sql = "INSERT INTO AUDIT_LOG (user_id, action, ip_address, details, timestamp) "
	                     + "VALUES (?, ?, ?, ?, NOW())";

	        try (Connection conn = DatabaseUtil.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            // Handle NULL user_id: if userId is 0 or less, set it as NULL
	            if (userId <= 0) {
	                ps.setNull(1, java.sql.Types.BIGINT);
	            } else {
	                ps.setInt(1, userId);
	            }
	            ps.setString(2, action);
	            ps.setString(3, ip);
	            ps.setString(4, details);

	            ps.executeUpdate();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        
	  }
	  
	  public static ArrayList<AuditLog> getlog(){
		  ArrayList<AuditLog> ACs = new ArrayList<>();
			String sql = "select * from `AUDIT_LOG` ";
			 try (Connection conn = getConnection();
		             PreparedStatement ps = conn.prepareStatement(sql);
		             ResultSet rs = ps.executeQuery()) { 
	                     while (rs.next()) {
	                    AuditLog Alog = new AuditLog(rs);
		                ACs.add(Alog);
		            }
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
			 return ACs;
		  
	  }
	
}
