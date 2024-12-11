package com.ecommerce.ecommerce.models;

public class User {
    private int id;
    private String fullName;
    private String username;
    private String email;
    private String password;
    private String type; // "client" or "admin"
    private String status; // "active" or "banned", only for clients

    // Default Constructor
    public User( String fullName,String username,String email,String password,String type,String status) {
        this.username = username;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.type = type;
        this.status = status;
    }

    // Parameterized Constructor
    public User(int id, String fullName,String username,String email,String password,String type,String status) {
        this.id = id;
        this.fullName = fullName;
        this.username = username;
        this.email = email;
        this.password = password;
        this.type = type;

        // Status only applies to "client" type users
        if ("client".equalsIgnoreCase(type)) {
            this.status = status;
        } else {
            this.status = null; // Admins have no status
        }
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getType() { return type; }
    public void setType(String type) {
        this.type = type;

        // Reset status if type is changed
        if (!"client".equalsIgnoreCase(type)) {
            this.status = null;
        }
    }

    public String getStatus() { return status; }
    public void setStatus(String status) {
        if ("client".equalsIgnoreCase(this.type)) {
            this.status = status;
        } else {
            this.status = null; // Admins have no status
        }
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
