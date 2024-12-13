
<nav class="bg-gradient-to-r from-purple-600 to-indigo-600 p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <div class="text-white text-3xl font-bold tracking-wider cursor-pointer"
            onclick="location.href='<%= request.getContextPath() %>/views/user-views/index.jsp';"
        >
            <i class="fas fa-store mr-2"></i>J-Store
        </div>
        <div class="flex items-center space-x-4">
            <a href="<%= request.getContextPath() %>/views/user-views/cart.jsp" class="text-white hover:text-yellow-300 transition duration-300 flex items-center">
                <i class="fas fa-shopping-cart mr-2"></i>Cart
            </a>
            <a href="<%= request.getContextPath() %>/views/user-views/orders-history.jsp" class="text-white hover:text-yellow-300 transition duration-300 flex items-center" title="Order History">
                <i class="fas fa-history mr-2"></i>Orders History
            </a>

            <a href="<%= request.getContextPath() %>/logout" class="text-white hover:text-yellow-300 transition duration-300 flex items-center">
                <i class="fas fa-sign-out-alt mr-2"></i>Logout
            </a>
        </div>
    </div>
</nav>