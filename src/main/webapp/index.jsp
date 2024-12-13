<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%@ page import="com.ecommerce.ecommerce.dao.ProductDAO" %>
<%
    session = request.getSession();
    List<Product> products = (List<Product>) session.getAttribute("products");

    if (products == null) {
        ProductDAO productDAO = new ProductDAO();
        products = productDAO.getAllProducts();
        session.setAttribute("products", products);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>J-Store - Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-white">

<!-- Navbar -->
<nav class="bg-gradient-to-r from-blue-900 to-blue-600 p-4">
    <div class="container mx-auto flex justify-between items-center">
        <div class="text-white text-2xl font-bold">
            J-Store
        </div>
        <div>
            <a href="<c:url value='/views/signup.jsp' />" class="text-white hover:text-blue-200 mx-2">Sign Up</a>
            <a href="<c:url value='/views/login.jsp' />" class="text-white hover:text-blue-200 mx-2">Sign In</a>
        </div>
    </div>
</nav>

<!-- Welcome Banner -->
<section class="bg-gradient-to-r from-blue-100 to-white py-20">
    <div class="container mx-auto text-center">
        <h1 class="text-5xl font-extrabold text-gray-800">Welcome to J-Store</h1>
        <p class="text-gray-600 mt-4 text-lg">Your portal to a futuristic shopping experience</p>
    </div>
</section>

<!-- All Products Section -->
<section class="bg-gray-50 py-20">
    <div class="container mx-auto px-6 lg:px-20">
        <h2 class="text-4xl font-bold text-gray-800 mb-10 text-center">Discover Our Exclusive Collection</h2>
        <p class="text-gray-600 text-lg mb-16 text-center">Explore a wide range of products tailored to meet your needs. Shop now and experience the difference!</p>

        <% if (products != null && !products.isEmpty()) { %>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
            <% for (Product product : products) { %>
            <div class="bg-white shadow-lg rounded-lg overflow-hidden hover:shadow-xl transition-shadow duration-300">
                <div class="w-full h-48 bg-gray-100 flex items-center justify-center overflow-hidden">
                    <img src="data:<%= product.getMimeType() %>;base64,<%= product.getImageBase64() %>"
                         alt="<%= product.getName() %>"
                         class="object-contain h-full w-full">
                </div>
                <div class="p-6">
                    <h3 class="text-lg font-semibold text-gray-800 truncate"><%= product.getName() %></h3>
                    <p class="text-sm text-gray-500 mt-2 line-clamp-2"><%= product.getDescription() %></p>
                    <p class="text-lg font-bold text-green-600 mt-4">$<%= product.getPrice() %></p>

                    <!-- Render Add to Cart only if user is logged in -->
                    <% if (session.getAttribute("currentUser") != null) { %>
                    <form method="post" action="<%= request.getContextPath() %>/add-to-cart" class="mt-4">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <input type="hidden" id="formQuantity" name="quantity" value="1">
                        <button type="submit"
                                class="w-full bg-blue-600 text-white py-2 rounded-lg shadow-lg hover:bg-blue-700 focus:ring-2 focus:ring-blue-400 focus:outline-none">
                            <i class="fas fa-cart-plus mr-2"></i>Add to Cart
                        </button>
                    </form>
                    <% } else { %>
                    <p class="text-sm text-gray-500 mt-4">Please <a href="<c:url value='/views/login.jsp' />" class="text-blue-600 hover:underline">log in</a> to add items to your cart.</p>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <p class="text-gray-600 text-center">No products are available at the moment. Please check back later.</p>
        <% } %>
    </div>
</section>



<!-- Features Section -->
<section class="bg-white py-20">
    <div class="container mx-auto text-center">
        <h2 class="text-3xl font-bold text-gray-800 mb-6">Why Shop with Us?</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="bg-yellow-50 shadow-lg rounded-lg p-6 flex flex-col items-center">
                <i class="fas fa-gem text-blue-600 text-4xl mb-4"></i>
                <h3 class="text-xl font-semibold text-blue-600">Exclusive Products</h3>
                <p class="text-gray-600 mt-2">Discover unique items curated just for you.</p>
            </div>
            <div class="bg-yellow-50 shadow-lg rounded-lg p-6 flex flex-col items-center">
                <i class="fas fa-shipping-fast text-blue-600 text-4xl mb-4"></i>
                <h3 class="text-xl font-semibold text-blue-600">Fast Delivery</h3>
                <p class="text-gray-600 mt-2">Experience speedy and reliable delivery services.</p>
            </div>
            <div class="bg-yellow-50 shadow-lg rounded-lg p-6 flex flex-col items-center">
                <i class="fas fa-headset text-blue-600 text-4xl mb-4"></i>
                <h3 class="text-xl font-semibold text-blue-600">24/7 Customer Support</h3>
                <p class="text-gray-600 mt-2">We're here to help around the clock.</p>
            </div>
        </div>
    </div>
</section>

<!-- Trending Products Section -->
<section class="bg-gradient-to-r from-green-50 to-green-100 py-20">
    <div class="container mx-auto text-center">
        <h2 class="text-3xl font-bold text-gray-800 mb-6">Trending Products</h2>
        <p class="text-gray-600 mb-8">Catch up with the latest and greatest in our catalog.</p>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Add product cards here -->
            <div class="bg-white shadow-lg rounded-lg p-6">
                <h3 class="text-lg font-semibold text-blue-600">Product Name</h3>
                <p class="text-gray-600 mt-2">Brief product description goes here.</p>
            </div>
            <!-- Repeat similar blocks for more products -->
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="bg-gradient-to-r from-purple-50 to-purple-100 py-20">
    <div class="container mx-auto text-center">
        <h2 class="text-3xl font-bold text-gray-800 mb-6">What Our Customers Say</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="bg-white shadow-lg rounded-lg p-6">
                <p class="text-gray-800 italic">"An amazing shopping experience with timely delivery!"</p>
                <p class="text-gray-600 mt-2">- Customer Name</p>
            </div>
            <div class="bg-white shadow-lg rounded-lg p-6">
                <p class="text-gray-800 italic">"Wide range of products with excellent quality."</p>
                <p class="text-gray-600 mt-2">- Customer Name</p>
            </div>
            <div class="bg-white shadow-lg rounded-lg p-6">
                <p class="text-gray-800 italic">"Outstanding customer support and service."</p>
                <p class="text-gray-600 mt-2">- Customer Name</p>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action Section -->
<section class="bg-gradient-to-r from-green-400 to-blue-500 py-20">
    <div class="container mx-auto text-center text-white">
        <h2 class="text-3xl font-bold mb-4">Join Us Today!</h2>
        <p class="mb-6">Become a part of our community and start exploring now.</p>
        <a href="<c:url value='/views/signup.jsp' />" class="bg-white text-blue-600 font-semibold py-2 px-4 rounded hover:bg-blue-100">
            Sign Up Now
        </a>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gradient-to-r from-blue-900 to-blue-600 p-4 text-center text-white">
    &copy; 2023 J-Store. All Rights Reserved.
</footer>

</body>
</html>