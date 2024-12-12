package com.ecommerce.ecommerce.models;

public class OrderItem {
    private int productId; // ID of the product
    private int orderId;   // ID of the order this item belongs to
    private int quantity;  // Quantity of the product in this order

    // Default Constructor
    public OrderItem() {}

    // Parameterized Constructor
    public OrderItem(int productId, int orderId, int quantity) {
        this.productId = productId;
        this.orderId = orderId;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}