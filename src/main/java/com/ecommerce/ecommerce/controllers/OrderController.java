package com.ecommerce.ecommerce.controllers;

import com.ecommerce.ecommerce.dao.OrderDAO;
import com.ecommerce.ecommerce.dao.OrderItemDAO;
import com.ecommerce.ecommerce.dao.ProductDAO;
import com.ecommerce.ecommerce.models.Order;
import com.ecommerce.ecommerce.models.OrderItem;
import com.ecommerce.ecommerce.models.Product;
import com.ecommerce.ecommerce.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.file.Files;
import java.util.Date;
import java.util.List;

public class OrderController extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("confirmOrder".equals(action)) {
            confirmOrder(request, response);
            HttpSession session = request.getSession();
            session.removeAttribute("orders-his");
        } else if ("edit".equals(action)) {
            orderDAO.updateOrder(request.getParameter("status"),Integer.parseInt(request.getParameter("id")));
            response.sendRedirect(request.getContextPath()+"/order?action=list");

        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not supported");
        }
    }

    private void confirmOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
        User currentUser = (User) session.getAttribute("currentUser");

        System.out.println("cart: " + cart);
        System.out.println("currentUser: " + currentUser);
        if (cart != null && currentUser != null) {
            Order order = new Order(0, currentUser.getId(), new Date(), "PENDING",0);
            boolean orderCreated = orderDAO.addOrder(order);

            if (orderCreated) {
                System.out.println("Order created with ID: " + order.getId());
                double totalPrice = 0;
                ProductDAO productDAO=new ProductDAO();
                for (OrderItem cartItem : cart) {
                    cartItem.setOrderId(order.getId());
                    orderItemDAO.addOrderItem(cartItem);
                    Product product = productDAO.getProductById(cartItem.getProductId());
                    totalPrice += cartItem.getQuantity() * product.getPrice();

                }
                orderDAO.updateOrderPrice(order.getId(),totalPrice);

            session.removeAttribute("cart");
                response.sendRedirect(request.getContextPath() + "/views/user-views/cart.jsp"); // Redirect to confirmation page
            } else {
                request.setAttribute("error", "Failed to confirm your order.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("cart.jsp"); // Redirect back to cart if empty or user is not logged in
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("list".equals(action)) {
            HttpSession session = request.getSession();
            List<Order> orders = orderDAO.getAllOrders();
            session.setAttribute("orders", orders);
            request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.getOrderById(orderId);
            request.setAttribute("order", order);
            request.getRequestDispatcher("/views/admin-views/orders/edit-order.jsp").forward(request, response);
            
        }
        else if ("view".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.getOrderById(orderId);
            request.setAttribute("order", order);
            request.getRequestDispatcher("/views/admin-views/orders/show-order.jsp").forward(request, response);

        }
        else if("orders-his".equals(action)){
            getOrdersByUser(request, response);
        }
        else{
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not supported");
        }
    }
    public void getOrdersByUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser != null) {
            int userId = currentUser.getId();
            List<Order> orders = orderDAO.getOrdersByUserId(userId);
            session.setAttribute("orders-his",orders);
            response.sendRedirect(request.getContextPath()+"/views/user-views/orders-history.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }




}
