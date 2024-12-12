<%@ page import="com.ecommerce.ecommerce.models.Order" %>
<%@ page import="com.ecommerce.ecommerce.models.OrderItem" %>
<%@ page import="com.ecommerce.ecommerce.dao.OrderItemDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.dao.ProductDAO" %>
<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../static/admin-sidebar.jsp" %>
<%
  Order order = (Order) request.getAttribute("order");
  if (order == null) {
    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found.");
    return;
  }
  OrderItemDAO orderItemDAO = new OrderItemDAO();
  List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderId(order.getId());
  ProductDAO productDAO = new ProductDAO();

%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Number: <%= order.getId() %></title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.0.3/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<div class="flex">

  <div class="w-3/4 p-8">
    <h1 class="text-3xl font-bold text-gray-800">Order Number: <%= order.getId() %></h1>
    <h2 class="text-xl text-gray-600">Order Date: <%= order.getDate() %></h2>
    <h2 class="text-xl text-gray-600 mb-6">Order Status: <%= order.getStatus() %></h2>

    <% if (orderItems.isEmpty()) { %>
    <p class="text-red-500">No items in this order.</p>
    <% } else { %>
    <table class="min-w-full table-auto bg-white shadow-md rounded-lg">
      <thead>
      <tr>
        <th class="px-4 py-2 text-left text-sm font-semibold text-gray-700 border-b">Order ID</th>
        <th class="px-4 py-2 text-left text-sm font-semibold text-gray-700 border-b">Product Name</th>
        <th class="px-4 py-2 text-left text-sm font-semibold text-gray-700 border-b">Quantity</th>
        <th class="px-4 py-2 text-left text-sm font-semibold text-gray-700 border-b">Total Price</th>
      </tr>
      </thead>
      <tbody>
      <% for (OrderItem item : orderItems) { %>
      <tr class="border-b">
        <td class="px-4 py-2 text-sm text-gray-700"><%= item.getOrderId() %></td>
        <td class="px-4 py-2 text-sm text-gray-700"><%
        Product product =productDAO.getProductById(item.getProductId());
        %><%= product.getName() %></td>
        <td class="px-4 py-2 text-sm text-gray-700"><%= item.getQuantity() %></td>
        <td class="px-4 py-2 text-sm text-gray-700"><%=
        product.getPrice()*item.getQuantity() %></td>
      </tr>
      <% } %>
      </tbody>
    </table>
    <% } %>
  </div>
</div>
</body>
</html>
