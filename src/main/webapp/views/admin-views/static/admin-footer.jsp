<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
<!-- Admin Footer -->
<footer class="bg-gray-800 text-gray-200 py-6 mt-10">
  <div class="container mx-auto flex flex-col md:flex-row items-center justify-between">
    <!-- Footer Text -->
    <div class="text-center md:text-left mb-4 md:mb-0">
      <p class="text-sm">&copy; <%= new java.util.Date().getYear() + 1900 %> Admin Dashboard. All Rights Reserved.</p>
      <p class="text-xs text-gray-400 mt-1">Powered by YourCompanyName</p>
    </div>

    <!-- Quick Links -->
    <div class="flex space-x-6">
      <a href="${pageContext.request.contextPath}/admin/manage-products"
         class="text-gray-400 hover:text-white text-sm transition duration-300">
        Manage Products
      </a>
      <a href="${pageContext.request.contextPath}/admin/manage-users"
         class="text-gray-400 hover:text-white text-sm transition duration-300">
        Manage Users
      </a>
      <a href="${pageContext.request.contextPath}/admin/manage-orders"
         class="text-gray-400 hover:text-white text-sm transition duration-300">
        Manage Orders
      </a>
      <a href="${pageContext.request.contextPath}/logout"
         class="text-gray-400 hover:text-red-500 text-sm transition duration-300">
        Logout
      </a>
    </div>
  </div>
</footer>
</body>