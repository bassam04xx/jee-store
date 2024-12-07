package com.ecommerce.ecommerce.models;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private int stock;       // New field for stock
    private String image;    // New field for image

    // Default Constructor
    public Product() {}

    // Parameterized Constructor
    public Product(int id, String name, String description, double price, int stock, String image) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.image = image;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStock() { return stock; }           // Getter for stock
    public void setStock(int stock) { this.stock = stock; } // Setter for stock

    public String getImage() { return image; }       // Getter for image
    public void setImage(String image) { this.image = image; } // Setter for image
}
