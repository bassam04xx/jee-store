package com.ecommerce.ecommerce.controllers;

import com.ecommerce.ecommerce.dao.OrderItemDAO;
import com.ecommerce.ecommerce.models.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.file.FileStore;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
public class OrderItemController extends HttpServlet {
    private OrderItemDAO orderItemDAO = new OrderItemDAO();

    @Override
    public void init() {
        orderItemDAO = new OrderItemDAO(); // Initialize the DAO object
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        System.out.println("Action: " + action);
        switch (action) {
            case "view":
                // View order items for a particular order
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderId(orderId);
                request.setAttribute("orderItems", orderItems);
                request.getRequestDispatcher(request.getContextPath() + "/views/order-items.jsp").forward(request, response);
                break;
            case "deleteFromCart":
                int productId = Integer.parseInt(request.getParameter("productId"));
                List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
                if (cart != null) {
                    cart.removeIf(item -> item.getProductId() == productId);
                    session.setAttribute("cart", cart);
                    response.sendRedirect(request.getContextPath() + "/views/user-views/cart.jsp");
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cart is empty or not found.");
                }

                break;



            default:
                // Provide a default action or error handling
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not supported");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        request.getParameterMap().forEach((key, value) -> System.out.println(key + ": " + String.join(", ", value)));

        HttpSession session = request.getSession();

        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing");
            return;
        }

        switch (action) {
            case "addProductToCart":
                addProductToCart(request, response);
                break;
            case "updateCart":
                updateCart(request, response, session);
                break;

            default:
                String errorMessage = "Action not supported: " + action;
                System.out.println(errorMessage);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, errorMessage);
                break;
        }
    }


    private void addProductToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        OrderItem foundItem = null;
        for (OrderItem item : cart) {
            if (item.getProductId() == productId) {
                foundItem = item;
                break;
            }
        }

        if (foundItem != null) {
            foundItem.setQuantity(foundItem.getQuantity() + quantity);
        } else {
            OrderItem newItem = new OrderItem(productId, 0, quantity); // Order ID will be set when the order is confirmed
            cart.add(newItem);
        }
        session.setAttribute("cart", cart);
        response.sendRedirect(request.getContextPath() + "/views/user-views/cart.jsp");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

        if (cart != null) {
            for (OrderItem item : cart) {
                String quantityParam = request.getParameter("quantity_" + item.getProductId());
                if (quantityParam != null) {
                    try {
                        int updatedQuantity = Integer.parseInt(quantityParam);
                        if (updatedQuantity > 0) {
                            item.setQuantity(updatedQuantity);
                        }
                    } catch (NumberFormatException e) {
                        // Log the error or handle invalid input
                    }
                }
            }
            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "/views/user-views/cart.jsp");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cart is empty or not found.");
        }
    }
}
