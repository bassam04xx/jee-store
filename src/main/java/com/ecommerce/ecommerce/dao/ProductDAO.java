package com.ecommerce.ecommerce.dao;

import com.ecommerce.ecommerce.models.Product;
import jakarta.servlet.http.Part;

import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import static com.ecommerce.ecommerce.utils.DatabaseConnection.getConnection;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Product product = new Product(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("description"),
                        resultSet.getDouble("price"),
                        resultSet.getInt("stock"),
                        resultSet.getBytes("image"),
                        resultSet.getInt("category_id")
                );

                product.setMimeType(resultSet.getString("mime_type")); // Set MIME type

                byte[] imageBytes = resultSet.getBytes("image");
                if (imageBytes != null) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    product.setImageBase64(base64Image);
                }

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return products;
    }

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, description, price, stock, image, mime_type, category_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setInt(4, product.getStock());
            preparedStatement.setBytes(5, product.getImage());
            preparedStatement.setString(6, product.getMimeType()); // Save the MIME type
            preparedStatement.setInt(7, product.getCategory_id());
            preparedStatement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return false;
    }


//    private String saveImage(Part imagePart, ServletContext context) {
//        String uploadDir = context.getRealPath("/uploads"); // Correct the path here
//        File uploadDirFile = new File(uploadDir);
//
//        if (!uploadDirFile.exists()) {
//            uploadDirFile.mkdirs(); // Create the directory if it doesn't exist
//        }
//
//        String fileName = extractFileName(imagePart);
//        String imagePath = uploadDir + File.separator + fileName;
//
//        try {
//            imagePart.write(imagePath); // Save the file to disk
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        return "webapp/uploads/" + fileName; // Return relative path to store in the DB
//    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                return fileName;
            }
        }
        return "";
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        Product product = null;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    product = new Product(
                            resultSet.getInt("id"),
                            resultSet.getString("name"),
                            resultSet.getString("description"),
                            resultSet.getDouble("price"),
                            resultSet.getInt("stock"),
                            resultSet.getBytes("image"),
                            resultSet.getInt("category_id")
                    );

                    product.setMimeType(resultSet.getString("mime_type")); // Set MIME type

                    byte[] imageBytes = resultSet.getBytes("image");
                    if (imageBytes != null) {
                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                        product.setImageBase64(base64Image);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return product;
    }


    public boolean updateProduct(Product updatedProduct) {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, stock = ?, image = ?, mime_type = ?, category_id = ? WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, updatedProduct.getName());
            preparedStatement.setString(2, updatedProduct.getDescription());
            preparedStatement.setDouble(3, updatedProduct.getPrice());
            preparedStatement.setInt(4, updatedProduct.getStock());
            preparedStatement.setBytes(5, updatedProduct.getImage());
            preparedStatement.setString(6, updatedProduct.getMimeType()); // Update MIME type
            preparedStatement.setInt(7, updatedProduct.getCategory_id());
            preparedStatement.setInt(8, updatedProduct.getId());
            preparedStatement.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public boolean deleteProduct(int productId) {
        String query = "DELETE FROM products WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, productId);
            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0; // Return true if the product was deleted
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false in case of an error
        }
    }

    public List<Product> getProductsByCategoryId(int categoryId) {
        String sql = "SELECT * FROM products WHERE category_id = ?";
        List<Product> products = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, categoryId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = new Product(
                            resultSet.getInt("id"),
                            resultSet.getString("name"),
                            resultSet.getString("description"),
                            resultSet.getDouble("price"),
                            resultSet.getInt("stock"),
                            resultSet.getBytes("image"),
                            resultSet.getInt("category_id")
                    );
                    product.setMimeType(resultSet.getString("mime_type")); // Set MIME type
                    byte[] imageBytes = resultSet.getBytes("image");
                    if (imageBytes != null) {
                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                        product.setImageBase64(base64Image);
                    }
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }
}


