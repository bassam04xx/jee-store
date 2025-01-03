package com.ecommerce.ecommerce.controllers;

import com.ecommerce.ecommerce.dao.ProductDAO;
import com.ecommerce.ecommerce.dao.UserDAO;
import com.ecommerce.ecommerce.models.Product;
import com.ecommerce.ecommerce.models.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class UserController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "signup":
                handleSignup(request, response);
                break;
            case "signin":
                handleSignin(request, response);
                break;
            case "add":
                handleAddUser(request, response);
                break;
            case "edit":
                handleEditUser(request, response);
                break;
            case "delete":
                handleDeleteUser(request, response);
                break;


            default:
                System.out.println("the action"+action);
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleEditUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Retrieve and validate the user ID
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            request.setAttribute("error", "Invalid user ID.");
            request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            User existingUser = userDAO.getUserById(userId);

            if (existingUser != null) {
                // Update user details from form input
                existingUser.setFullName(request.getParameter("fullName"));
                existingUser.setUsername(request.getParameter("username"));
                existingUser.setPassword(request.getParameter("email"));
                String password = request.getParameter("password");
                if (password != null && !password.trim().isEmpty()) {
                    existingUser.setPassword(password); // Ensure password hashing is handled in DAO
                }

                existingUser.setType(request.getParameter("type"));

                // Handle status only if user type is client
                String type = request.getParameter("type");
                if ("client".equalsIgnoreCase(type)) {
                    existingUser.setStatus(request.getParameter("status"));
                } else {
                    existingUser.setStatus(null);
                }

                boolean isUpdated = userDAO.updateUser(existingUser);
                if (isUpdated) {
                    HttpSession session = request.getSession();
                    session.removeAttribute("users");
                    response.sendRedirect("user?action=list");
                } else {
                    request.setAttribute("error", "Failed to update the user.");
                    request.getRequestDispatcher("/views/admin-views/users/edit-user.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "User not found.");
                request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid user ID format.");
            request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Retrieve and validate the user ID
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            request.setAttribute("error", "Invalid user ID.");
            request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            User existingUser = userDAO.getUserById(userId);

            if (existingUser != null) {
                boolean isDeleted = userDAO.deleteUser(userId);

                if (isDeleted) {
                    response.sendRedirect("user?action=list");
                } else {
                    request.setAttribute("error", "Failed to delete the user.");
                    request.getRequestDispatcher("/views/admin-views/users/edit-user.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "User not found.");
                request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid user ID format.");
            request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
        }
    }

    private void handleAddUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String type = request.getParameter("type");
        String status = request.getParameter("status");

        // Handle status only if user type is client
        if (!"client".equalsIgnoreCase(type)) {
            status = null;
        }

        User user = new User (username, fullName,email ,password, type, status);
        boolean isSuccess = userDAO.addUser(user);

        if (isSuccess) {
            request.setAttribute("message", "User added successfully!");
            response.sendRedirect("user?action=list"); // Instead of product?action=list
        } else {
            request.setAttribute("error", "Failed to add user. Please try again.");
            response.sendRedirect("user?action=list");
        }


    }

    private void handleList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve users and products from session
        List<User> users = (List<User>) session.getAttribute("users");
        List<Product> products = (List<Product>) session.getAttribute("products");

        // Fetch from DAO if not present
        if (users == null) {
            users = userDAO.getAllUsers();
            session.setAttribute("users", users);
        }

        if (products == null) {
            ProductDAO productDAO = new ProductDAO();
            products = productDAO.getAllProducts();
            session.setAttribute("products", products);
        }

        // Set request attributes for the current request
        request.setAttribute("users", users);
        request.setAttribute("products", products);

        System.out.println("Users: " + users);
        System.out.println("Products: " + products);

        // Determine view type and forward
        if ("client".equals(request.getAttribute("Type"))) {
            request.getRequestDispatcher("/views/user-views/index.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
        }
    }

    private void handleSignup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean isSuccess = userDAO.signup(fullName, username, email, password);

        if (isSuccess) {
            request.setAttribute("message", "Signup successful! Please log in.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("error", "Signup failed. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/signup.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void handleSignin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username =  request.getParameter("username");
        String password =  request.getParameter("password");

        User user = userDAO.signin(username, password);
        System.out.println("User logged in: " + user);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            System.out.println("User logged in: " + user);
            String path = request.getContextPath();
            // Redirect based on user role
            if ("admin".equalsIgnoreCase(user.getType())) {
                response.sendRedirect(path+"/views/admin-views/index.jsp");
            } else if ("client".equalsIgnoreCase(user.getType())) {
                response.sendRedirect(path + "/views/user-views/index.jsp");
            } else {
                System.out.println("the user"+user);
                response.sendRedirect("error.jsp"); // Invalid role
            }
        } else {
            request.setAttribute("error", "Invalid username or password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                request.getRequestDispatcher("/views/admin-views/users/add-user.jsp").forward(request, response);
            case "list":
                handleList(request, response);
                break;
            case "logout":
                handleLogout(request, response);
                break;
                case "edit":
                    String idParam = request.getParameter("id");


                    try {
                        int userId = Integer.parseInt(idParam);
                        User existingUser = userDAO.getUserById(userId);

                        if (existingUser != null) {
                            request.setAttribute("user", existingUser);
                            request.getRequestDispatcher("/views/admin-views/users/edit-user.jsp").forward(request, response);
                        } else {
                            request.setAttribute("error", "User not found.");
                            request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                        }
                        break;
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Invalid user ID format.");
                        request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                    }
                break;
                case "delete":
                handleDeleteUser(request, response);
                break;

            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate(); // End the session
        }

        response.sendRedirect("/views/login.jsp"); // Redirect to login page
    }

}

    