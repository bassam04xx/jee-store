package com.ecommerce.ecommerce.controllers;

import com.ecommerce.ecommerce.dao.OrderDetailsDAO;
import com.ecommerce.ecommerce.models.OrderDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/orderDetails")
public class OrderDetailsController extends HttpServlet {

    private OrderDetailsDAO orderDetailsDAO;

    @Override
    public void init() {
        orderDetailsDAO = new OrderDetailsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "list":
                    listOrderDetails(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteOrderDetail(request, response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addOrderDetail(request, response);
                    break;
                case "update":
                    updateOrderDetail(request, response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listOrderDetails(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        List<OrderDetails> orderDetailsList = orderDetailsDAO.getAllOrderDetails();
        request.setAttribute("orderDetailsList", orderDetailsList);
        request.getRequestDispatcher("/views/order-details/list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        OrderDetails existingOrderDetail = orderDetailsDAO.getOrderDetailsByOrderId(id).get(0); // Ensure correct logic to fetch by ID
        request.setAttribute("orderDetail", existingOrderDetail);
        request.getRequestDispatcher("/views/order-details/edit.jsp").forward(request, response);
    }

    private void addOrderDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));

        OrderDetails orderDetail = new OrderDetails(0, orderId, productId, quantity, totalPrice);
        orderDetailsDAO.addOrderDetail(orderDetail);
        response.sendRedirect("orderDetails?action=list");
    }

    private void updateOrderDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));

        OrderDetails orderDetail = new OrderDetails(id, orderId, productId, quantity, totalPrice);
        orderDetailsDAO.updateOrderDetail(orderDetail);
        response.sendRedirect("orderDetails?action=list");
    }

    private void deleteOrderDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        orderDetailsDAO.deleteOrderDetail(id);
        response.sendRedirect("orderDetails?action=list");
    }
}