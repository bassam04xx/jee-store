<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%
    if (request.getAttribute("products") == null) {
        String userType = "client";
        request.setAttribute("Type", userType);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/product?action=list");
        dispatcher.forward(request, response);
    }
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>J-Store - Products</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100 text-gray-900">
<!-- Navbar -->
<nav class="bg-gradient-to-r from-blue-900 to-blue-600 p-4">
    <div class="container mx-auto flex justify-between items-center">
        <div class="text-white text-2xl font-bold">
            J-Store
        </div>
        <div>
            <a href="<%= request.getContextPath() %>/cart" class="text-white hover:text-blue-200 mx-2">Cart</a>
            <a href="<%= request.getContextPath() %>/logout" class="text-white hover:text-blue-200 mx-2">Logout</a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<main class="container mx-auto py-8">
    <h2 class="text-3xl font-bold text-gray-800 mb-6 text-center">Shop Our Collection</h2>
    <% if (products != null && !products.isEmpty()) { %>
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
        <% for (Product product : products) { %>
        <div class="bg-white shadow-lg rounded-lg overflow-hidden transition-transform transform hover:scale-105">
            <img src="<%= request.getContextPath() + "/uploads/" + product.getImage() %>" alt="<%= product.getName() %>" class="w-full h-64 object-cover">
            <div class="p-5">
                <h3 class="text-xl font-semibold text-gray-800"><%= product.getName() %></h3>
                <p class="text-gray-600 mt-2"><%= product.getDescription() %></p>
                <div class="text-gray-800 font-bold mt-3 mb-4">$<%= product.getPrice() %></div>
                <a href="<%= request.getContextPath() %>/views/user-views/product-details.jsp?id=<%= product.getId() %>" class="block text-center bg-blue-500 text-white py-2 rounded hover:bg-blue-600">
                    View Details
                </a>
                <button class="add-to-cart block text-center bg-green-500 text-white py-2 mt-2 rounded hover:bg-green-600" data-id="<%= product.getId() %>" data-name="<%= product.getName() %>" data-price="<%= product.getPrice() %>">
                    Add to Cart
                </button>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <p class="text-gray-600 text-center">No products are available at the moment.</p>
    <% } %>
</main>

<!-- Footer -->
<footer class="bg-gradient-to-r from-gray-900 to-gray-800 text-white py-4 mt-8">
    <div class="container mx-auto text-center">
        <p>&copy; 2024 J-Store. All rights reserved.</p>
    </div>
</footer>

<!-- JavaScript for Cart Management -->
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const cartButtons = document.querySelectorAll('.add-to-cart');

        cartButtons.forEach(button => {
            button.addEventListener('click', () => {
                // Get product details from data attributes
                const productId = button.getAttribute('data-id');
                const productName = button.getAttribute('data-name');
                const productPrice = parseFloat(button.getAttribute('data-price'));

                // Get current cart from localStorage or initialize it
                let cart = JSON.parse(localStorage.getItem('current-order')) || [];

                // Check if product is already in the cart
                const productIndex = cart.findIndex(item => item.id === productId);

                if (productIndex !== -1) {
                    // If product exists, increment the quantity
                    cart[productIndex].quantity += 1;
                } else {
                    // Add new product with default quantity of 1
                    cart.push({ id: productId, name: productName, price: productPrice, quantity: 1 });
                }

                // Save the updated cart to localStorage
                localStorage.setItem('current-order', JSON.stringify(cart));

                // Provide feedback to the user
                alert(`${productName} added to the cart.`);
            });
        });
    });
</script>
</body>
</html>
