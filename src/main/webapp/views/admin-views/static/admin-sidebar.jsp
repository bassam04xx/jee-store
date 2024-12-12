<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
<div class="container mx-auto mt-10">
  <!-- Page Header -->
  <div class="mb-10">
    <h1 class="text-3xl font-bold text-gray-700">Admin Dashboard</h1>
  </div>

  <!-- Admin Options -->
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
    <!-- Manage Products -->
    <div class="bg-white shadow-md rounded-lg overflow-hidden hover:shadow-lg transition-shadow duration-300">
      <a href="${pageContext.request.contextPath}/views/admin-views/index.jsp#products"
         class="block text-center p-8 bg-gradient-to-r from-blue-500 to-blue-700 text-white font-semibold text-xl rounded-t-lg">
        Manage Products
      </a>
      <div class="p-4 text-gray-600 text-center">Add, edit, and delete products.</div>
    </div>

    <!-- Manage Users -->
    <div class="bg-white shadow-md rounded-lg overflow-hidden hover:shadow-lg transition-shadow duration-300">
      <a href="${pageContext.request.contextPath}/views/admin-views/index.jsp#users"
         class="block text-center p-8 bg-gradient-to-r from-green-500 to-green-700 text-white font-semibold text-xl rounded-t-lg">
        Manage Users
      </a>
      <div class="p-4 text-gray-600 text-center">View, edit, and manage user accounts.</div>
    </div>

    <!-- Manage Orders -->
    <div class="bg-white shadow-md rounded-lg overflow-hidden hover:shadow-lg transition-shadow duration-300">
      <a href="${pageContext.request.contextPath}//views/admin-views/index.jsp#orders"
         class="block text-center p-8 bg-gradient-to-r from-yellow-500 to-yellow-700 text-white font-semibold text-xl rounded-t-lg">
        Manage Orders
      </a>
      <div class="p-4 text-gray-600 text-center">Track and process orders.</div>
    </div>
  </div>

  <!-- Logout Button -->
  <div class="mt-10 flex justify-center">
    <a href="${pageContext.request.contextPath}/user?action=logout"
       class="bg-red-500 text-white px-8 py-3 rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
      Logout
    </a>
  </div>
</div>
</body>
