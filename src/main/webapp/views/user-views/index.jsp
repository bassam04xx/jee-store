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
    <title>J-Store - Discover Amazing Products</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');
        body {
            font-family: 'Poppins', sans-serif;
        }
        .product-card {
            transition: all 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-purple-50 to-indigo-100 text-gray-900 min-h-screen flex flex-col">
<!-- Navbar -->

<%@ include file="./static/navbar.jsp" %>
<!-- Main Content -->
<main class="container mx-auto py-12 flex-grow">
    <h2 class="text-4xl font-bold text-indigo-800 mb-8 text-center">Discover Amazing Products</h2>
    <% if (products != null && !products.isEmpty()) { %>
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
        <% for (Product product : products) { %>
        <div class="product-card bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl">
            <div class="relative">
                <img src="data:<%= product.getMimeType() %>;base64,<%= product.getImageBase64() %>" alt="<%= product.getName() %>" class="w-full h-48 object-cover">
                <div class="absolute top-0 right-0 bg-yellow-400 text-indigo-900 font-semibold px-3 py-1 rounded-bl-lg">
                    $<%= String.format("%.2f", product.getPrice()) %>
                </div>
            </div>
            <div class="p-5">
                <h3 class="text-xl font-semibold text-indigo-800 mb-2"><%= product.getName() %></h3>
                <p class="text-gray-600 mb-4"><%= product.getDescription() %></p>
                <form action="<%= request.getContextPath() %>/orderItem" method="post" class="flex items-center justify-between">
                    <input type="hidden" name="action" value="addProductToCart">
                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="flex-grow bg-gradient-to-r from-purple-500 to-indigo-600 text-white px-4 py-2 rounded-lg shadow-md hover:from-purple-600 hover:to-indigo-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-opacity-50 transition duration-300 ease-in-out transform hover:scale-105">
                        <i class="fas fa-cart-plus mr-2"></i>Add to Cart
                    </button>
                </form>

                <buttton type="button" class=" my-4 w-full flex-grow bg-gradient-to-r from-green-500 to-blue-500 text-center text-white px-4 py-2 rounded-lg shadow-md hover:from-purple-600 hover:to-indigo-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-opacity-50 transition duration-300 ease-in-out transform hover:scale-105">
                    <a href="<%= request.getContextPath() %>/product?action=details&id=<%= product.getId() %>" class="text-white text-center">
                        <i class="fas fa-info-circle mr-2"></i>More Info
                    </a>
                </buttton>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="text-center py-12">
        <i class="fas fa-box-open text-6xl text-gray-400 mb-4"></i>
        <p class="text-xl text-gray-600">Oops! It looks like our shelves are empty at the moment.</p>
        <p class="text-gray-500 mt-2">Check back soon for exciting new products!</p>
    </div>
    <% } %>
</main>

<!-- Footer -->

<%@ include file="./static/footer.jsp" %>

<!-- JavaScript for Cart Management -->
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const cartButtons = document.querySelectorAll('form[action$="/cart"]');

        cartButtons.forEach(form => {
            form.addEventListener('submit', (e) => {
                e.preventDefault();

                const productId = form.querySelector('input[name="productId"]').value;
                const productName = form.closest('.product-card').querySelector('h3').textContent;
                const productPrice = parseFloat(form.closest('.product-card').querySelector('.bg-yellow-400').textContent.replace('$', ''));

                let cart = JSON.parse(localStorage.getItem('current-order')) || [];

                const productIndex = cart.findIndex(item => item.id === productId);

                if (productIndex !== -1) {
                    cart[productIndex].quantity += 1;
                } else {
                    cart.push({ id: productId, name: productName, price: productPrice, quantity: 1 });
                }

                localStorage.setItem('current-order', JSON.stringify(cart));

                const notification = document.createElement('div');
                notification.textContent = `${productName} added to the cart.`;
                notification.className = 'fixed bottom-4 right-4 bg-green-500 text-white px-6 py-3 rounded-lg shadow-lg transition-opacity duration-500 opacity-0';
                document.body.appendChild(notification);

                setTimeout(() => {
                    notification.classList.remove('opacity-0');
                }, 100);

                setTimeout(() => {
                    notification.classList.add('opacity-0');
                    setTimeout(() => {
                        document.body.removeChild(notification);
                    }, 500);
                }, 3000);
            });
        });
    });
</script>
</body>
</html>