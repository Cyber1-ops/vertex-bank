package com.bank.models;
import java.time.LocalDate;
import java.sql.ResultSet;
import java.sql.SQLException;
public class User {
    private long userId;
    private String username;
    private String passwordHash;
    private String fullName;
    private String email;
    private String phone;
    private LocalDate dob;
    private Integer age;
    private String nationality;
    private String passportNumber;
    private String idNumber;
    private String address;
    private Double monthlyIncome;
    private String role;
    private String status;
    
    public User(){}
    
    
    public User(ResultSet rs) throws SQLException {
        this.userId = rs.getLong("user_id");
        this.username = rs.getString("username");
        this.passwordHash = rs.getString("password_hash");
        this.fullName = rs.getString("full_name");
        this.email = rs.getString("email");
        this.phone = rs.getString("phone");
        java.sql.Date sqlDate = rs.getDate("dob");
        this.dob = (sqlDate != null) ? sqlDate.toLocalDate() : null;
         this.age = rs.getInt("age");
        if (rs.wasNull()) this.age = null; 
        this.age = rs.getInt("age");
        this.nationality = rs.getString("nationality");
        this.passportNumber = rs.getString("passport_number");
        this.idNumber = rs.getString("id_number");
        this.address = rs.getString("address");
        this.monthlyIncome = rs.getDouble("monthly_income");
        this.role = rs.getString("role");
        this.status = rs.getString("status");
    }



    public long getUserId() { return userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }
    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }
    public String getNationality() { return nationality; }
    public void setNationality(String nationality) { this.nationality = nationality; }
    public String getPassportNumber() { return passportNumber; }
    public void setPassportNumber(String passportNumber) { this.passportNumber = passportNumber; }
    public String getIdNumber() { return idNumber; }
    public void setIdNumber(String idNumber) { this.idNumber = idNumber; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public Double getMonthlyIncome() { return monthlyIncome; }
    public void setMonthlyIncome(Double monthlyIncome) { this.monthlyIncome = monthlyIncome; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String toString(){
    	return this.username + " "+this.fullName; 
    	
    }
}


