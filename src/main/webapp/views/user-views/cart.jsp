<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.models.OrderItem" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.ecommerce.ecommerce.dao.ProductDAO" %>
<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%
    List<OrderItem> cartItems = (List<OrderItem>) session.getAttribute("cart");
    if (cartItems == null) {
        cartItems = new ArrayList<>();
    }
    ProductDAO productDAO = new ProductDAO();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - J-Store</title>
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
<!-- Navbar -->
<nav class="bg-gradient-to-r from-purple-600 to-indigo-600 p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <div class="text-white text-3xl font-bold tracking-wider">
            <i class="fas fa-store mr-2"></i>J-Store
        </div>
        <div>
            <a href="<%= request.getContextPath() %>/views/user-views/index.jsp" class="text-white hover:text-yellow-300 transition duration-300 flex items-center">
                <i class="fas fa-arrow-left mr-2"></i>Continue Shopping
            </a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<main class="container mx-auto py-12 flex-grow px-4">
    <h2 class="text-4xl font-bold text-indigo-800 mb-8 text-center">Your Shopping Cart</h2>
    <div id="cart-content" class="bg-white shadow-lg rounded-lg overflow-hidden">
        <% if (cartItems.isEmpty()) { %>
        <div class="p-8 text-center">
            <i class="fas fa-shopping-cart text-6xl text-gray-300 mb-4"></i>
            <p class="text-xl text-gray-600">Your cart is empty.</p>
            <a href="<%= request.getContextPath() %>/views/user-views/index.jsp" class="mt-4 inline-block bg-gradient-to-r from-purple-500 to-indigo-600 text-white px-6 py-2 rounded-lg hover:from-purple-600 hover:to-indigo-700 transition duration-300">
                Start Shopping
            </a>
        </div>
        <% } else { %>
        <form action="<%= request.getContextPath() %>/orderItem?action=updateCart" method="POST">
            <table class="min-w-full leading-normal">
                <thead>
                <tr class="bg-gradient-to-r from-purple-600 to-indigo-600 text-white">
                    <th class="px-5 py-3 text-left text-sm font-semibold uppercase tracking-wider">Product Name</th>
                    <th class="px-5 py-3 text-left text-sm font-semibold uppercase tracking-wider">Quantity</th>
                    <th class="px-5 py-3 text-left text-sm font-semibold uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (OrderItem item : cartItems) {
                    // Fetch product based on productId
                    Product product = productDAO.getProductById(item.getProductId());
                %>
                <tr class="hover:bg-purple-50 transition-colors duration-200">
                    <td class="px-5 py-5 border-b border-gray-200 text-sm">
                        <p class="font-semibold text-indigo-700"><%= product.getName() %></p>
                    </td>
                    <td class="px-5 py-5 border-b border-gray-200 text-sm">
                        <input type="number" name="quantity_<%= item.getProductId() %>" value="<%= item.getQuantity() %>" min="1" class="w-20 text-center border border-gray-300 rounded-md focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                    </td>
                    <td class="px-5 py-5 border-b border-gray-200 text-sm">
                        <a href="<%= request.getContextPath() %>/orderItem?action=deleteFromCart&productId=<%= item.getProductId() %>" class="text-red-600 hover:text-red-800 transition duration-300">
                            <i class="fas fa-trash-alt mr-1"></i>Remove
                        </a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <div class="p-6 bg-gray-50 border-t border-gray-200">
                <div class="flex justify-between items-center">
                    <button type="submit" class="bg-gradient-to-r from-purple-500 to-indigo-600 text-white px-6 py-2 rounded-lg hover:from-purple-600 hover:to-indigo-700 transition duration-300">
                        <i class="fas fa-sync-alt mr-2"></i>Update Cart
                    </button>
                </div>
            </div>
        </form>
        <form action="<%= request.getContextPath() %>/order?action=confirmOrder" method="POST" class="mt-4 w-full flex justify-between items-center   rounded-lg p-8 space-y-6">
            <button type="submit" class="bg-gradient-to-r from-green-500 to-green-600 text-white px-6 py-2 rounded-lg hover:from-green-600 hover:to-green-700 transition duration-300">
                <i class="fas fa-check-circle mr-2"></i>Confirm Order
            </button>
        </form>
        <% } %>
    </div>
</main>

<!-- Footer -->
<footer class="bg-gradient-to-r from-gray-800 to-gray-900 text-white py-6">
    <div class="container mx-auto text-center">
        <p>&copy; 2024 J-Store. All rights reserved.</p>
        <div class="mt-4 flex justify-center space-x-4">
            <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                <i class="fab fa-facebook-f"></i>
            </a>
            <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                <i class="fab fa-twitter"></i>
            </a>
            <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                <i class="fab fa-instagram"></i>
            </a>
        </div>
    </div>
</footer>

<script>
    // Add any necessary JavaScript here
</script>
</body>
</html>
