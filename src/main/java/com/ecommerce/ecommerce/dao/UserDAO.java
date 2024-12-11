package com.ecommerce.ecommerce.dao;

import com.ecommerce.ecommerce.models.User;
import com.ecommerce.ecommerce.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static com.ecommerce.ecommerce.utils.DatabaseConnection.getConnection;

public class UserDAO {

    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                users.add(new User(
                        resultSet.getInt("id"),
                        resultSet.getString("full_name"),
                        resultSet.getString("username"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("type"),
                        resultSet.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return users;
    }

    // Add a user (Sign Up)
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, full_name, password, type, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getFullName());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getType());

            // Set status only for clients
            if ("client".equalsIgnoreCase(user.getType())) {
                preparedStatement.setString(5, user.getStatus());
            } else {
                preparedStatement.setNull(5, Types.VARCHAR);
            }

            preparedStatement.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return false;
    }

    // Get a user by ID
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        User user = null;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    user = new User(
                            resultSet.getInt("id"),
                            resultSet.getString("full_name"),
                            resultSet.getString("username"),
                            resultSet.getString("email"),
                            resultSet.getString("password"),
                            resultSet.getString("type"),
                            resultSet.getString("status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    // Update a user
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET username = ?, full_name = ?, password = ?, type = ?, status = ? WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getFullName());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getType());

            // Set status only for clients
            if ("client".equalsIgnoreCase(user.getType())) {
                preparedStatement.setString(5, user.getStatus());
            } else {
                preparedStatement.setNull(5, Types.VARCHAR);
            }

            preparedStatement.setInt(6, user.getId());
            preparedStatement.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    // Delete a user
    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0; // Return true if the user was deleted
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false in case of an error
        }
    }

    // Sign Up
    public boolean signup(String fullName, String username, String email, String password) {
        String sql = "INSERT INTO users (full_name, username, email, password, type, status) VALUES (?, ?, ?, ?, 'client', 'active')";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, fullName);
            preparedStatement.setString(2, username);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, password);
            preparedStatement.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return false;
    }

    // Sign In
    public User signin(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        User user = null;
        System.out.println("username"+username);
        System.out.println("password"+password);


        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    user = new User(
                            resultSet.getInt("id"),
                            resultSet.getString("full_name"),
                            resultSet.getString("username"),
                            resultSet.getString("email"),
                            resultSet.getString("password"),
                            resultSet.getString("type"),
                            resultSet.getString("status")
                    );
                }
                System.out.println("user"+user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return user; // Return user if credentials are valid, null otherwise
    }
}
