    package com.ecommerce.ecommerce.models;

    public class Product {
        private int id;
        private String name;
        private String description;
        private double price;
        private int stock;       // New field for stock
        private byte[] image; // Updated to store image as blob
        private int category_id;
        private String imageBase64;
        private String mimeType;



        // Default Constructor
        public Product() {}

        // Parameterized Constructor
        public Product(int id, String name, String description, double price, int stock, byte[] image, int category) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.price = price;
            this.stock = stock;
            this.image = image;
            this.category_id = category;

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



        public int getCategory_id() {
            return category_id;
        }

        public void setCategory_id(int category_id) {
            this.category_id = category_id;
        }

        public byte[] getImage() {
            return image;
        }

        public void setImage(byte[] image) {
            this.image = image;
        }

        public String getImageBase64() {
            return imageBase64;
        }

        public void setImageBase64(String imageBase64) {
            this.imageBase64 = imageBase64;
        }

        public String getMimeType() {
            return mimeType;
        }

        public void setMimeType(String mimeType) {
            this.mimeType = mimeType;
        }
    }
