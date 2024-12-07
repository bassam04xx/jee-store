<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%
    // Fetch the list of products from the request
 if(request.getAttribute("products")==null){
     String userType ="client";
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
    <title>E-Commerce</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-900">
<!-- Header -->
<header class="bg-white shadow-md py-4">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-2xl font-bold text-gray-800">
            <a href="<%= request.getContextPath() %>/product?action=list">E-Commerce</a>
        </h1>
        <nav>
            <a href="<%= request.getContextPath() %>/cart" class="text-gray-600 hover:text-gray-900">Cart</a>
        </nav>
    </div>
</header>

<!-- Main Content -->
<main class="container mx-auto py-8">
    <h2 class="text-xl font-semibold mb-4">Available Products</h2>
    <% if (products != null && !products.isEmpty()) { %>
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        <% for (Product product : products) { %>
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <img src="<%= request.getContextPath() + "/uploads/" + product.getImage() %>" alt="<%= product.getName() %>" class="w-full h-48 object-cover">
            <div class="p-4">
                <h3 class="text-lg font-semibold text-gray-800"><%= product.getName() %></h3>
                <p class="text-gray-600 text-sm"><%= product.getDescription() %></p>
                <p class="text-gray-800 font-bold mt-2">$<%= product.getPrice() %></p>
                <a href="<%= request.getContextPath() %>/product?action=details&id=<%= product.getId() %>" class="block text-center bg-blue-500 text-white py-2 mt-4 rounded hover:bg-blue-600">
                    View Details
                </a>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <p class="text-gray-600">No products are available at the moment.</p>
    <% } %>
</main>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-4 mt-8">
    <div class="container mx-auto text-center">
        <p>&copy; 2024 E-Commerce. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
