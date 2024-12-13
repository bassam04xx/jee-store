<div class="w-64 bg-white shadow-lg rounded-lg overflow-hidden">
    <div class="p-6 border-b border-gray-200 bg-gradient-to-r from-[#01497C] to-[#0077B6]">
        <h1 class="text-2xl font-bold text-white text-center">Admin Panel</h1>
    </div>
    <nav class="py-4">
        <ul class="space-y-2 px-3">
            <!-- Dashboard Section -->
            <li>
                <button
                        class="flex items-center w-full px-4 py-2 rounded-lg text-gray-700 hover:bg-[#E6F4F8] hover:text-[#01497C] focus:outline-none focus:ring-2 focus:ring-[#01497C] transition-all duration-200 group"
                        onclick="location.href='${pageContext.request.contextPath}/views/admin-views/index.jsp';"
                >
                    <span class="inline-flex items-center justify-center h-9 w-9 text-[#01497C] bg-[#E6F4F8] rounded-full group-hover:bg-[#01497C] group-hover:text-white transition-colors duration-200">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                    </span>
                    <span class="ml-3 font-medium">Dashboard</span>
                </button>
            </li>
            <!-- Products Section -->
            <li>
                <button
                        class="flex items-center w-full px-4 py-2 rounded-lg text-gray-700 hover:bg-[#E6F4F8] hover:text-[#01497C] focus:outline-none focus:ring-2 focus:ring-[#01497C] transition-all duration-200 group"
                        onclick="location.href='${pageContext.request.contextPath}/views/admin-views/products/list-products.jsp';"
                >
                    <span class="inline-flex items-center justify-center h-9 w-9 text-[#01497C] bg-[#E6F4F8] rounded-full group-hover:bg-[#01497C] group-hover:text-white transition-colors duration-200">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path></svg>
                    </span>
                    <span class="ml-3 font-medium">Products</span>
                </button>
            </li>
            <!-- Categories Section -->
            <li>
                <button
                        class="flex items-center w-full px-4 py-2 rounded-lg text-gray-700 hover:bg-[#E6F4F8] hover:text-[#01497C] focus:outline-none focus:ring-2 focus:ring-[#01497C] transition-all duration-200 group"
                        onclick="location.href='${pageContext.request.contextPath}/views/admin-views/categories/list-categories.jsp';"
                >
                    <span class="inline-flex items-center justify-center h-9 w-9 text-[#01497C] bg-[#E6F4F8] rounded-full group-hover:bg-[#01497C] group-hover:text-white transition-colors duration-200">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path></svg>
                    </span>
                    <span class="ml-3 font-medium">Categories</span>
                </button>
            </li>
            <!-- Users Section -->
            <li>
                <button
                        class="flex items-center w-full px-4 py-2 rounded-lg text-gray-700 hover:bg-[#E6F4F8] hover:text-[#01497C] focus:outline-none focus:ring-2 focus:ring-[#01497C] transition-all duration-200 group"
                        onclick="location.href='${pageContext.request.contextPath}/views/admin-views/users/list-users.jsp';"
                >
                    <span class="inline-flex items-center justify-center h-9 w-9 text-[#01497C] bg-[#E6F4F8] rounded-full group-hover:bg-[#01497C] group-hover:text-white transition-colors duration-200">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
                    </span>
                    <span class="ml-3 font-medium">Users</span>
                </button>
            </li>
            <!-- Orders Section -->
            <li>
                <button
                        class="flex items-center w-full px-4 py-2 rounded-lg text-gray-700 hover:bg-[#E6F4F8] hover:text-[#01497C] focus:outline-none focus:ring-2 focus:ring-[#01497C] transition-all duration-200 group"
                        onclick="location.href='${pageContext.request.contextPath}/views/admin-views/orders/list-orders.jsp';"
                >
                    <span class="inline-flex items-center justify-center h-9 w-9 text-[#01497C] bg-[#E6F4F8] rounded-full group-hover:bg-[#01497C] group-hover:text-white transition-colors duration-200">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path></svg>
                    </span>
                    <span class="ml-3 font-medium">Orders</span>
                </button>
            </li>
        </ul>
    </nav>
    <div class="p-4 border-t border-gray-200">
        <button
                class="flex items-center w-full px-4 py-2 text-gray-700 hover:bg-[#E6F4F8] hover:text-[#01497C] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#01497C] transition-all duration-200 group"
                onclick="location.href='${pageContext.request.contextPath}/logout';"
        >
        <span class="inline-flex items-center justify-center h-9 w-9 text-[#01497C] bg-[#E6F4F8] rounded-full group-hover:bg-[#01497C] group-hover:text-white transition-colors duration-200">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7"></path>
                </svg>
            </span>
            <span class="ml-3 font-medium">Logout</span>
        </button>
    </div>
</div>