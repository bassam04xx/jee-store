<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ecommerce.ecommerce.dao.ProductDAO" %>
<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
  String productIdParam = request.getParameter("id");
  Product product = null;

  // Fetch product by ID
  if (productIdParam != null) {
    try {
      int productId = Integer.parseInt(productIdParam);
      ProductDAO productDAO = new ProductDAO();
      product = productDAO.getProductById(productId);
    } catch (NumberFormatException e) {
      System.out.println("Invalid product ID format: " + productIdParam);
    }
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Details - J-Store</title>
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
<%@ include file="./static/navbar.jsp" %>

<!-- Main Content -->
<main class="container mx-auto py-12 px-4 flex-grow">
  <% if (product != null) { %>
  <div class="bg-white shadow-xl rounded-lg overflow-hidden flex flex-col md:flex-row">
    <div class="md:w-1/2">
      <img src="data:<%= product.getMimeType() %>;base64,<%= product.getImageBase64() %>" alt="<%= product.getName() %>" class="w-full h-full object-cover">
    </div>
    <div class="md:w-1/2 p-8">
      <h2 class="text-4xl font-bold text-indigo-800 mb-4"><%= product.getName() %></h2>
      <p class="text-gray-600 mb-6"><%= product.getDescription() %></p>
      <div class="text-3xl font-bold text-purple-600 mb-6">$<%= String.format("%.2f", product.getPrice()) %></div>

      <!-- Counter Section -->
      <div class="flex items-center mb-6">
        <button id="decreaseQuantity" class="bg-gray-200 text-gray-800 px-4 py-2 rounded-l-lg hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-purple-500">
          <i class="fas fa-minus"></i>
        </button>
        <input
                id="quantity"
                type="number"
                value="1"
                min="1"
                max="<%= product.getStock() %>"
                readonly
                class="w-16 text-center border-t border-b border-gray-300 py-2 focus:outline-none focus:ring-2 focus:ring-purple-500">
        <button id="increaseQuantity" class="bg-gray-200 text-gray-800 px-4 py-2 rounded-r-lg hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-purple-500">
          <i class="fas fa-plus"></i>
        </button>
        <p class="ml-4 text-sm text-gray-600">Stock: <%= product.getStock() %></p>
      </div>

      <div class="flex flex-col sm:flex-row items-center gap-4">
        <form action="<%= request.getContextPath() %>/orderItem" method="POST" class="w-full sm:w-auto">
          <input type="hidden" name="action" value="addProductToCart">
          <input type="hidden" name="productId" value="<%= product.getId() %>">
          <input type="hidden" id="formQuantity" name="quantity" value="1">
          <button type="submit" class="w-full sm:w-auto flex items-center justify-center bg-gradient-to-r from-purple-500 to-indigo-600 text-white px-6 py-3 rounded-lg shadow-lg hover:from-purple-600 hover:to-indigo-700 focus:outline-none focus:ring-2 focus:ring-purple-500 transition duration-300">
            <i class="fas fa-cart-plus mr-2"></i>Add to Cart
          </button>
        </form>
        <a href="<%= request.getContextPath() %>/views/user-views/index.jsp" class="w-full sm:w-auto flex items-center justify-center bg-gradient-to-r from-green-500 to-green-600 text-white px-6 py-3 rounded-lg shadow-lg hover:from-green-600 hover:to-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 transition duration-300">
          <i class="fas fa-arrow-left mr-2"></i>Continue Shopping
        </a>
      </div>
    </div>
  </div>
  <% } else { %>
  <div class="text-center py-12">
    <i class="fas fa-exclamation-triangle text-6xl text-yellow-500 mb-4"></i>
    <p class="text-2xl text-gray-700">Product not found.</p>
    <a href="<%= request.getContextPath() %>/views/user-views/index.jsp" class="mt-6 inline-block bg-gradient-to-r from-purple-500 to-indigo-600 text-white px-6 py-3 rounded-lg shadow-lg hover:from-purple-600 hover:to-indigo-700 focus:outline-none focus:ring-2 focus:ring-purple-500 transition duration-300">
      Return to Shop
    </a>
  </div>
  <% } %>
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

<!-- JavaScript -->
<script>
  document.addEventListener('DOMContentLoaded', () => {
    const quantityInput = document.getElementById('quantity');
    const formQuantityInput = document.getElementById('formQuantity');
    const decreaseButton = document.getElementById('decreaseQuantity');
    const increaseButton = document.getElementById('increaseQuantity');

    const maxStock = parseInt(quantityInput.getAttribute('max'), 10);

    // Quantity increment and decrement logic
    decreaseButton.addEventListener('click', () => {
      const currentValue = parseInt(quantityInput.value, 10);
      if (currentValue > 1) {
        quantityInput.value = currentValue - 1;
        formQuantityInput.value = quantityInput.value;
      }
    });

    increaseButton.addEventListener('click', () => {
      const currentValue = parseInt(quantityInput.value, 10);
      if (currentValue < maxStock) {
        quantityInput.value = currentValue + 1;
        formQuantityInput.value = quantityInput.value;
      }
    });

    // Synchronize form quantity value with displayed quantity
    quantityInput.addEventListener('change', () => {
      formQuantityInput.value = quantityInput.value;
    });
  });
</script>
</body>
</html>