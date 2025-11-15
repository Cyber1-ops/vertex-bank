package com.bank.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

public class AuditLog {
    private long logId;
    private long userId;
    private String action;
    private String ipAddress;
    private String details;
    private LocalDateTime timestamp;
    
    public AuditLog() {}
    
    public AuditLog(ResultSet rs) throws SQLException {
        this.logId = rs.getLong("log_id");
        this.userId = rs.getLong("user_id");
        this.action = rs.getString("action");
        this.ipAddress = rs.getString("ip_address");
        this.details = rs.getString("details");
        
        java.sql.Timestamp timestampSql = rs.getTimestamp("timestamp");
        if (timestampSql != null) {
            this.timestamp = timestampSql.toLocalDateTime();
        } else {
            this.timestamp = null;
        }
    }
    
    public AuditLog(long logId, long userId, String action, String ipAddress, String details, LocalDateTime timestamp) {
        this.logId = logId;
        this.userId = userId;
        this.action = action;
        this.ipAddress = ipAddress;
        this.details = details;
        this.timestamp = timestamp;
    }

    // Getters and Setters
    public long getLogId() { return logId; }
    public void setLogId(long logId) { this.logId = logId; }
    
    public long getUserId() { return userId; }
    public void setUserId(long userId) { this.userId = userId; }
    
    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }
    
    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
    
    public String getDetails() { return details; }
    public void setDetails(String details) { this.details = details; }
    
    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }
}