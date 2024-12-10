<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.ecommerce.ecommerce.models.CartItem" %>
<%
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
    if (cartItems == null) {
        cartItems = new ArrayList<>();
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - J-Store</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">
<!-- Navbar -->
<nav class="bg-gradient-to-r from-blue-900 to-blue-600 p-4">
    <div class="container mx-auto flex justify-between items-center">
        <div class="text-white text-2xl font-bold">
            J-Store
        </div>
        <div>
            <a href="<%= request.getContextPath() %>/views/user-views/index.jsp" class="text-white hover:text-blue-200 mx-2">Continue Shopping</a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<main class="container px-4 py-8">
    <h2 class="text-3xl font-bold text-gray-800 mb-6 text-center">Your Shopping Cart</h2>
    <div id="cart-content" class="bg-white shadow-sm rounded-lg p-6">
        <% if (cartItems.isEmpty()) { %>
        <p class="text-gray-600 text-center">Your cart is empty.</p>
        <% } else { %>
        <form action="<%= request.getContextPath() %>/updateCart" method="POST">
            <table class="min-w-full leading-normal">
                <thead>
                <tr>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Quantity</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (CartItem item : cartItems) { %>
                <tr>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                        <div class="flex items-center">
                            <div class="flex-shrink-0 w-10 h-10">
                            </div>
                            <div class="ml-3">
                                <p class="text-gray-900 whitespace-no-wrap"><%= item.getProductId() %></p>
                            </div>
                        </div>
                    </td>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                        <input type="number" name="quantity_<%= item.getProductId() %>" value="<%= item.getQuantity() %>" min="1" class="w-16 text-center border mx-2">
                    </td>

                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                        <button type="submit" name="remove_<%= item.getProductId() %>" value="remove" class="text-red-600 hover:text-red-900">Remove</button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <div class="mt-4 text-right">
                <button type="submit" class="mt-4 inline-block bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600">Update Cart</button>
            </div>
        </form>
        <% } %>
    </div>

    <% if (!cartItems.isEmpty()) { %>
    <div class="mt-8 text-right">
        <form action="<%= request.getContextPath() %>/confirmOrder" method="POST">
            <button type="submit" class="mt-4 inline-block bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600">Confirm Order</button>
        </form>
    </div>
    <% } %>
</main>

<!-- Footer -->
<footer class="bg-gradient-to-r from-gray-900 to-gray-800 text-white py-4 mt-12">
    <div class="container mx-auto text-center">
        <p>&copy; 2024 J-Store. All rights reserved.</p>
    </div>
</footer>

</body>
</html>
