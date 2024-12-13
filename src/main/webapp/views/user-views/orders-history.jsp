<%@ page import="com.ecommerce.ecommerce.models.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.models.User" %>
<%@ page import="com.ecommerce.ecommerce.dao.OrderDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");

    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return; // Stop further processing
    }
    if (currentUser.getStatus().equalsIgnoreCase("banned")) {
        response.sendRedirect(request.getContextPath() + "/views/banned.jsp");
        return; // Stop further processing
    }
    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getOrdersByUserId(currentUser.getId());

    System.out.println("orders: " + orders);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - J-Store</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-purple-50 to-indigo-100 text-gray-900 min-h-screen flex flex-col">
<%@ include file="./static/navbar.jsp" %>

<main class="container mx-auto py-12 flex-grow px-4">
    <h1 class="text-4xl font-bold text-indigo-800 mb-8 text-center">Order History</h1>
    <div class="bg-white shadow-lg rounded-lg overflow-hidden">
        <table class="min-w-full leading-normal">
            <thead>
            <tr class="bg-gradient-to-r from-purple-600 to-indigo-600 text-white">
                <th class="px-5 py-3 text-left text-sm font-semibold uppercase tracking-wider">Order ID</th>
                <th class="px-5 py-3 text-left text-sm font-semibold uppercase tracking-wider">Date</th>
                <th class="px-5 py-3 text-left text-sm font-semibold uppercase tracking-wider">Status</th>
                <th class="px-5 py-3 text-left text-sm font-semibold uppercase tracking-wider">Total Amount</th>
            </tr>
            </thead>
            <tbody>
            <% if (orders != null && !orders.isEmpty()) {
            for (Order order : orders) { %>
            <tr class="hover:bg-purple-50 transition-colors duration-200">
                <td class="px-5 py-5 border-b border-gray-200 text-sm">
                    <span class="font-semibold text-indigo-700">#<%= order.getId() %></span>
                </td>
                <td class="px-5 py-5 border-b border-gray-200 text-sm">
                    <%= order.getDate() %>
                </td>
                <td class="px-5 py-5 border-b border-gray-200 text-sm">
                                <span class="px-3 py-1 rounded-full text-xs font-medium
                                    <%= order.getStatus().equalsIgnoreCase("completed") ? "bg-green-200 text-green-800" :
                                       order.getStatus().equalsIgnoreCase("pending") ? "bg-yellow-200 text-yellow-800" :
                                       "bg-red-200 text-red-800" %>">
                                    <%= order.getStatus() %>
                                </span>
                </td>
                <td class="px-5 py-5 border-b border-gray-200 text-sm">
                    $<%= String.format("%.2f", order.getTotalPrice()) %>
                </td>
            </tr>
            <% }} else { %>
            <tr class="hover:bg-purple-50 transition-colors duration-200">
                <td class="px-5 py-5 border-b border-gray-200 text-sm">
                    <span class="font-semibold text-indigo-700">No orders found.</span>
                </td>
                <td class="px-5 py-5 border-b border-gray-200 text-sm">
                    <span class="font-semibold text-indigo-700">No orders found.</span>
                </td>
                <td class="px-5 py-5 border-b border-gray-200 text-sm">
                                <span class="px-3 py-1 rounded-full text-xs font-medium
                                    bg-red-200 text-red-800">
                                    No orders found.
                                </span>
                </td>
                <td class="px-5 py-5 border-b border-gray-200 text-sm">
                    $0.00
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</main>

<%@ include file="./static/footer.jsp" %>

<script>
    // Add any necessary JavaScript here
</script>
</body>
</html>