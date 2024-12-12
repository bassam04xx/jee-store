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
</head>
<body class="bg-gray-100 text-gray-900">
<!-- Navbar -->
<nav class="bg-gradient-to-r from-blue-900 to-blue-600 p-4">
  <div class="container mx-auto flex justify-between items-center">
    <div class="text-white text-2xl font-bold">
      J-Store
    </div>
    <div>
      <a href="<%= request.getContextPath() %>/cart" class="text-white hover:text-blue-200 mx-2">Cart <i class="fas fa-shopping-cart"></i></a>
      <a href="<%= request.getContextPath() %>/logout" class="text-white hover:text-blue-200 mx-2">Logout</a>
    </div>
  </div>
</nav>

<!-- Main Content -->
<main class="container mx-auto py-12">
  <% if (product != null) { %>
  <div class="flex flex-col md:flex-row bg-white shadow-lg rounded-lg overflow-hidden">
    <div class="md:w-1/2">
      <img src="<%= request.getContextPath() + "/uploads/" + product.getImage() %>" alt="<%= product.getName() %>" class="w-full h-full object-cover">
    </div>
    <div class="md:w-1/2 p-8">
      <h2 class="text-4xl font-bold text-gray-800"><%= product.getName() %></h2>
      <p class="text-gray-600 mt-4"><%= product.getDescription() %></p>
      <div class="text-2xl text-gray-800 font-bold mt-5">$<%= product.getPrice() %></div>
      <!-- Counter Section -->
      <div class="mt-6 flex items-center">
        <button id="decreaseQuantity" class="bg-gray-300 text-gray-800 px-4 py-2 rounded-l hover:bg-gray-400 focus:outline-none">
          -
        </button>
        <input
                id="quantity"
                type="number"
                value="1"
                min="1"
                max="<%= product.getStock() %>"
                readonly
                class="w-12 text-center border-t border-b border-gray-300 focus:outline-none">
        <button id="increaseQuantity" class="bg-gray-300 text-gray-800 px-4 py-2 rounded-r hover:bg-gray-400 focus:outline-none">
          +
        </button>
        <p class="ml-4 text-sm text-gray-600">Stock: <%= product.getStock() %></p>
      </div>

      <div class="flex items-center mt-6">
        <form action="<%= request.getContextPath() %>/orderItem" method="POST">
          <input type="hidden" name="action" value="addProductToCart">
          <input type="hidden" name="productId" value="<%= product.getId() %>">
          <input type="hidden" id="formQuantity" name="quantity" value="1">
          <button type="submit" class="flex items-center justify-center bg-blue-500 text-white px-4 py-2 rounded-lg shadow-lg hover:bg-blue-600 focus:ring-2 focus:ring-blue-500 focus:outline-none mr-4">
            <i class="fas fa-cart-plus mr-2"></i>Add to Cart
          </button>
        </form>
        <a href="<%= request.getContextPath() %>/views/user-views/index.jsp" class="flex items-center justify-center bg-green-500 text-white px-4 py-2 rounded-lg shadow-lg hover:bg-green-600 focus:ring-2 focus:ring-green-500 focus:outline-none">
          <i class="fas fa-arrow-left mr-2"></i>Continue Shopping
        </a>
      </div>
      <hr class="my-8">
    </div>
  </div>
  <% } else { %>
  <p class="text-gray-600 text-center mt-16">Product not found.</p>
  <% } %>
</main>

<!-- Footer -->
<footer class="bg-gradient-to-r from-gray-900 to-gray-800 text-white py-4 mt-12">
  <div class="container mx-auto text-center">
    <p>&copy; 2024 J-Store. All rights reserved.</p>
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