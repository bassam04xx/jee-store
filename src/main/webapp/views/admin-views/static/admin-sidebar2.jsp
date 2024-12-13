<div class="w-72 bg-white shadow-md rounded-md">
    <div class="p-6 border-b border-gray-200 text-center">
        <h1 class="text-2xl font-bold text-gray-800">Admin Panel</h1>
    </div>
    <nav>
        <ul class="flex flex-col gap-4 p-4">
            <li>
                <button
                        class="flex items-center gap-4 w-full px-4 py-2 rounded-full bg-[#E6F4F8] text-[#01497C] hover:bg-[#D0E9F4] hover:shadow-inner focus:bg-gradient-to-r from-[#01497C] to-[#01497C] focus:text-white transition-all"
                        onclick="location.href='${pageContext.request.contextPath}/views/admin-views/products/list-products.jsp';"
                >
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6NQ8PrCgOoYKc15vjM7oUbeKQvhhR62CryA&s" alt="Products" class="h-6 w-6">
                    <span class="font-semibold">Products</span>
                </button>
            </li>
            <li>
                <button
                        class="flex items-center gap-4 w-full px-4 py-2 rounded-full bg-[#E6F4F8] text-[#01497C] hover:bg-[#D0E9F4] hover:shadow-inner focus:bg-gradient-to-r from-[#01497C] to-[#01497C] focus:text-white transition-all"
                        onclick="location.href='${pageContext.request.contextPath}/views/admin-views/categories/list-categories.jsp';"
                >
                    <img src="https://icons.veryicon.com/png/o/commerce-shopping/icon-of-lvshan-valley-mobile-terminal/home-category.png" alt="Categories" class="h-6 w-6">
                    <span class="font-semibold">Categories</span>
                </button>
            </li>
            <li>
                <button
                        class="flex items-center gap-4 w-full px-4 py-2 rounded-full bg-[#E6F4F8] text-[#01497C] hover:bg-[#D0E9F4] hover:shadow-inner focus:bg-gradient-to-r from-[#01497C] to-[#01497C] focus:text-white transition-all"
                        onclick="location.href='${pageContext.request.contextPath}/views/admin-views/users/list-users.jsp';"
                >
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR81iX4Mo49Z3oCPSx-GtgiMAkdDop2uVmVvw&s" alt="Users" class="h-6 w-6">
                    <span class="font-semibold">Users</span>
                </button>
            </li>
            <li>
                <button
                        class="flex items-center gap-4 w-full px-4 py-2 rounded-full bg-[#E6F4F8] text-[#01497C] hover:bg-[#D0E9F4] hover:shadow-inner focus:bg-gradient-to-r from-[#01497C] to-[#01497C] focus:text-white transition-all"
                        onclick="location.href='${pageContext.request.contextPath}/views/admin-views/orders/list-orders.jsp';"
                >
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8lZsA3JNe_0bPy53ADp_sM-kbStGyEJ999A&s" alt="Orders" class="h-6 w-6">
                    <span class="font-semibold">Orders</span>
                </button>
            </li>
        </ul>
    </nav>
</div>
