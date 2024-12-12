package com.ecommerce.ecommerce.dao;

import com.ecommerce.ecommerce.models.OrderItem;
import com.ecommerce.ecommerce.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO {

    public boolean addOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, orderItem.getOrderId());
            preparedStatement.setInt(2, orderItem.getProductId());
            preparedStatement.setInt(3, orderItem.getQuantity());
            preparedStatement.executeUpdate();
            return true;

        } catch (Exception e) {
            logDatabaseException((SQLException) e);
        }
        return false;
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    OrderItem orderItem = new OrderItem(
                            resultSet.getInt("product_id"),
                            resultSet.getInt("order_id"),
                            resultSet.getInt("quantity")
                    );
                    orderItems.add(orderItem);
                }
            }
        } catch (Exception e) {
            logDatabaseException((SQLException) e);
        }

        return orderItems;
    }

    public boolean updateOrderItem(OrderItem orderItem) {
        String sql = "UPDATE order_items SET quantity = ? WHERE order_id = ? AND product_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderItem.getQuantity());
            preparedStatement.setInt(2, orderItem.getOrderId());
            preparedStatement.setInt(3, orderItem.getProductId());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            logDatabaseException((SQLException) e);
        }
        return false;
    }

    public boolean deleteOrderItem(int orderId, int productId) {
        String sql = "DELETE FROM order_items WHERE order_id = ? AND product_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderId);
            preparedStatement.setInt(2, productId);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            logDatabaseException((SQLException) e);
        }
        return false;
    }

    private void logDatabaseException(SQLException e) {
        // Centralized database error logging
        e.printStackTrace();
        // Consider adding a logger for production use, e.g., Log4j, SLF4J
    }
}