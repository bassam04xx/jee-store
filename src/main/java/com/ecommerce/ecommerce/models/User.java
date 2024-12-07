package com.ecommerce.ecommerce.models;

public class User {
    private int id;
    private String username;
    private String fullName;
    private String password;
    private String type; // "client" or "admin"
    private String status; // "active" or "banned", only for clients

    // Default Constructor
    public User() {}

    // Parameterized Constructor
    public User(int id, String username, String fullName, String password, String type, String status) {
        this.id = id;
        this.username = username;
        this.fullName = fullName;
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
}
