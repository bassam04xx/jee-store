package com.ecommerce.ecommerce.dao;

import com.ecommerce.ecommerce.models.Order;
import com.ecommerce.ecommerce.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Fetch all orders
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                orders.add(new Order(
                        resultSet.getInt("id"),
                        resultSet.getInt("userId"),
                        resultSet.getDate("date"),
                        resultSet.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return orders;
    }

    // Add a new order
    public boolean addOrder(Order order) {
        String sql = "INSERT INTO orders (userId, date, status) VALUES (?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setDate(2, new java.sql.Date(order.getDate().getTime()));
            preparedStatement.setString(3, order.getStatus());
            preparedStatement.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Fetch order by ID
    public Order getOrderById(int id) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        Order order = null;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    order = new Order(
                            resultSet.getInt("id"),
                            resultSet.getInt("userId"),
                            resultSet.getDate("date"),
                            resultSet.getString("status")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    // Update an existing order
    public boolean updateOrder(Order order) {
        String sql = "UPDATE orders SET userId = ?, date = ?, status = ? WHERE id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setDate(2, new java.sql.Date(order.getDate().getTime()));
            preparedStatement.setString(3, order.getStatus());
            preparedStatement.setInt(4, order.getId());
            preparedStatement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    // Delete an order by ID
    public boolean deleteOrder(int id) {
        String sql = "DELETE FROM orders WHERE id = ?";

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

    // Fetch orders by user ID
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE userId = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, userId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    orders.add(new Order(
                            resultSet.getInt("id"),
                            resultSet.getInt("userId"),
                            resultSet.getDate("date"),
                            resultSet.getString("status")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return orders;
    }

    // Fetch orders by status
    public List<Order> getOrdersByStatus(String status) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE status = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, status);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    orders.add(new Order(
                            resultSet.getInt("id"),
                            resultSet.getInt("userId"),
                            resultSet.getDate("date"),
                            resultSet.getString("status")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return orders;
    }

    // Get the total number of orders
    public int getOrderCount() {
        String sql = "SELECT COUNT(*) AS total FROM orders";
        int count = 0;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                count = resultSet.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return count;
    }
}
