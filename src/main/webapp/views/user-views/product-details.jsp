<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Details</title>
  <!-- Add Tailwind CSS via CDN -->
  <script src="https://cdn.tailwindcss.com"></script>

  <script>
    // Automatically submit the form after a short delay to fetch related products
    window.onload = function() {
      document.getElementById("related-products-form").submit();
    };
  </script>
</head>
<body class="bg-gray-100 text-gray-900">

<div class="max-w-4xl mx-auto p-6 bg-white rounded-lg shadow-lg mt-10">
  <h1 class="text-3xl font-semibold text-center mb-6">Product Details</h1>

  <%
    // Fetch the product object passed from the controller
    Product product = (Product) request.getAttribute("product");
    if (product != null) {
  %>

  <!-- Product Info Section -->
  <div class="flex flex-col md:flex-row items-center">
    <img class="w-full md:w-1/2 rounded-lg shadow-lg mb-6 md:mb-0" src="<%= request.getContextPath() + "/uploads/" + product.getImage() %>" alt="<%= product.getName() %> image" />
    <div class="md:ml-8 text-center md:text-left">
      <h2 class="text-2xl font-semibold mb-2"><%= product.getName() %></h2>
      <p class="text-gray-700 mb-4"><strong>Description:</strong> <%= product.getDescription() %></p>
      <p class="text-xl font-bold text-green-600 mb-4"><strong>Price:</strong> $<%= product.getPrice() %></p>
      <p class="text-sm text-gray-600 mb-6"><strong>Stock:</strong> <%= product.getStock() %> items available</p>

      <!-- Add to Cart Button -->
      <button class="bg-green-500 text-white px-6 py-2 rounded-lg shadow-md hover:bg-green-600 transition duration-300 mb-6">
        Add to Cart
      </button>

      <!-- Back Button -->
      <a href="<%= request.getContextPath() + "/product?action=list" %>"
         class="bg-blue-500 text-white px-6 py-2 rounded-lg shadow-md hover:bg-blue-600 transition duration-300">
        Back to Product List
      </a>
    </div>
  </div>

  <hr class="my-8 border-gray-300">

  <!-- Hidden Form to Fetch Related Products -->

  <!-- Related Products Section -->
  <h2 class="text-2xl font-semibold text-center mb-6">You May Also Like</h2>
  <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
    <%
      // Simulate fetching related products (replace with actual data fetch)
      List<Product> relatedProducts = new ArrayList<>(); // Assuming you fetch related products here
      for (Product relatedProduct : relatedProducts) {
    %>
    <div class="bg-white rounded-lg shadow-lg p-4">
      <img class="w-full h-48 object-cover rounded-lg mb-4" src="<%= request.getContextPath() + "/uploads/" + relatedProduct.getImage() %>" alt="<%= relatedProduct.getName() %> image" />
      <h3 class="text-lg font-semibold text-gray-800 mb-2"><%= relatedProduct.getName() %></h3>
      <p class="text-gray-700 mb-4"><%= relatedProduct.getDescription() %></p>
      <p class="text-xl font-bold text-green-600 mb-4">$<%= relatedProduct.getPrice() %></p>
      <a href="<%= request.getContextPath() + "/product?action=view&id=" + relatedProduct.getId() %>"
         class="bg-blue-500 text-white px-4 py-2 rounded-lg shadow-md hover:bg-blue-600 transition duration-300 w-full text-center">
        View Details
      </a>
    </div>
    <% } %>
  </div>

  <%
  } else {
  %>
  <p class="text-center text-red-500">Product not found.</p>
  <%
    }
  %>

</div>

</body>
</html>
