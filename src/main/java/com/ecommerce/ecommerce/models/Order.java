package com.ecommerce.ecommerce.models;

import java.util.Date;

public class Order {
    private int id;
    private int userId;      // User ID who made the order
    private Date date;       // Date of order creation
    private String status;   // Status of the order (e.g., PENDING, SHIPPED, etc.)
    private double total_price;
    // Default Constructor
    public Order() {}

    // Parameterized Constructor
    public Order(int id, int userId, Date date, String status,double total_price) {
        this.id = id;
        this.userId = userId;
        this.date = date;
        this.status = status;
        this.total_price=total_price;


    }

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }


    public Date getDate() {
        return date;
    }
    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public double getTotalPrice()
    {
        return this.total_price;
    }
    public void setTotalPrice(double total_price){
        this.total_price=total_price;
    }
}
