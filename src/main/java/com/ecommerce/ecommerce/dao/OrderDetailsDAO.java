package com.ecommerce.ecommerce.dao;

import com.ecommerce.ecommerce.models.OrderDetails;
import com.ecommerce.ecommerce.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailsDAO {

    // Fetch all order details
    public List<OrderDetails> getAllOrderDetails() {
        List<OrderDetails> orderDetailsList = new ArrayList<>();
        String sql = "SELECT * FROM order_details";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                orderDetailsList.add(new OrderDetails(
                        resultSet.getInt("id"),
                        resultSet.getInt("order_id"),
                        resultSet.getInt("product_id"),
                        resultSet.getInt("quantity"),
                        resultSet.getDouble("total_price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return orderDetailsList;
    }

    // Add a new order detail
    public boolean addOrderDetail(OrderDetails orderDetail) {
        String sql = "INSERT INTO order_details (order_id, product_id, quantity, total_price) VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderDetail.getOrderId());
            preparedStatement.setInt(2, orderDetail.getProductId());
            preparedStatement.setInt(3, orderDetail.getQuantity());
            preparedStatement.setDouble(4, orderDetail.getTotalPrice());
            preparedStatement.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Fetch order details by order ID
    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetails> orderDetailsList = new ArrayList<>();
        String sql = "SELECT * FROM order_details WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    orderDetailsList.add(new OrderDetails(
                            resultSet.getInt("id"),
                            resultSet.getInt("order_id"),
                            resultSet.getInt("product_id"),
                            resultSet.getInt("quantity"),
                            resultSet.getDouble("total_price")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return orderDetailsList;
    }

    // Update an existing order detail
    public boolean updateOrderDetail(OrderDetails orderDetail) {
        String sql = "UPDATE order_details SET product_id = ?, quantity = ?, total_price = ? WHERE id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderDetail.getProductId());
            preparedStatement.setInt(2, orderDetail.getQuantity());
            preparedStatement.setDouble(3, orderDetail.getTotalPrice());
            preparedStatement.setInt(4, orderDetail.getId());
            preparedStatement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    // Delete an order detail by ID
    public boolean deleteOrderDetail(int id) {
        String sql = "DELETE FROM order_details WHERE id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    // Get the total price for a specific order
    public double getTotalPriceByOrderId(int orderId) {
        String sql = "SELECT SUM(total_price) AS total_price FROM order_details WHERE order_id = ?";
        double totalPrice = 0.0;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    totalPrice = resultSet.getDouble("total_price");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return totalPrice;
    }
}