package com.ecommerce.ecommerce.controllers;

import com.ecommerce.ecommerce.dao.OrderDAO;
import com.ecommerce.ecommerce.dao.OrderDetailsDAO;
import com.ecommerce.ecommerce.dao.ProductDAO;
import com.ecommerce.ecommerce.models.Order;
import com.ecommerce.ecommerce.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

public class OrderController extends HttpServlet {

    private OrderDAO orderDAO;
    private ProductDAO productDAO;
    private OrderDetailsDAO orderDetailsDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        productDAO = new ProductDAO();
        orderDetailsDAO = new OrderDetailsDAO();
    }

    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Read the JSON array from the request body
        String json = request.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);

        boolean isSuccess = true;


        Order order = new Order(0, currentUser.getId(), new Date(), "PENDING");
        // Add each order item as necessary
        // Handle the logic to store items in order details, etc.
        isSuccess &= orderDAO.addOrder(order);


        if (isSuccess) {
            response.getWriter().write("Order confirmed");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to confirm the order.");
        }
    }
    private void addOrder(HttpServletRequest request, HttpServletResponse response, User currentUser) throws SQLException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Order order = new Order(0, currentUser.getId(), new Date(), "PENDING");

        boolean isSuccess = orderDAO.addOrder(order);
        if (isSuccess) {
            response.sendRedirect("order?action=list");
        } else {
            request.setAttribute("error", "Failed to add order. Please try again.");
            // Consider forwarding to an error page
        }
    }
}