<%@ include file="./static/admin-sidebar.jsp" %> <!-- Include Sidebar -->

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">
<% if(request.getAttribute("products")==null){
  response.sendRedirect(request.getContextPath() + "/product?action=list");
} %>


<div class="flex">
  <!-- Sidebar Section -->
  <aside class="w-64 bg-gray-800 text-white min-h-screen">
    <div class="p-6">
      <h1 class="text-xl font-bold mb-6">Admin Panel</h1>
      <ul>
        <li><a href="#" class="block py-2 px-4 hover:bg-gray-700">Dashboard</a></li>
        <li><a href="#" class="block py-2 px-4 hover:bg-gray-700">Products</a></li>
        <li><a href="#" class="block py-2 px-4 hover:bg-gray-700">Orders</a></li>
        <li><a href="#" class="block py-2 px-4 hover:bg-gray-700">Users</a></li>
        <li><a href="#" class="block py-2 px-4 hover:bg-gray-700">Logout</a></li>
      </ul>
    </div>
  </aside>

  <!-- Main Content Section -->
  <main class="flex-1 p-8">
    <div class="mb-8">
      <h1 class="text-3xl font-bold text-gray-700">Product Management</h1>
      <p class="text-gray-600 mt-2">Manage products, edit, delete, or add new products to your catalog.</p>
    </div>

    <!-- Add Product Button -->
    <div class="mb-4 text-right">
      <a href="${pageContext.request.contextPath}/product?action=add" class="bg-blue-500 text-white py-2 px-4 rounded-lg shadow-lg hover:bg-blue-600 transition duration-300">Add New Product</a>
    </div>

    <!-- Product Table -->
    <table class="min-w-full bg-white border border-gray-300 rounded-lg shadow-md">
      <thead>
      <tr class="bg-gray-200 text-gray-700">
        <th class="px-6 py-3 text-left">Product Name</th>
        <th class="px-6 py-3 text-left">Description</th>
        <th class="px-6 py-3 text-left">Price</th>
        <th class="px-6 py-3 text-left">Stock</th>
        <th class="px-6 py-3 text-left">Actions</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="product" items="${products}">
        <tr class="border-b hover:bg-gray-50">
          <td class="px-6 py-3">${product.name}</td>
          <td class="px-6 py-3">${product.description}</td>
          <td class="px-6 py-3">${product.price}</td>
          <td class="px-6 py-3">${product.stock}</td>
          <td class="px-6 py-3">
            <a href="${pageContext.request.contextPath}/product?action=edit&id=${product.id}" class="text-blue-500 hover:text-blue-700 px-4 py-2 rounded-md">Edit</a>
            <a href="${pageContext.request.contextPath}/product?action=delete?id=${product.id}" class="text-red-500 hover:text-red-700 px-4 py-2 rounded-md">Delete</a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>

  </main>
</div>

<!-- Footer Section -->
<%@ include file="./static/admin-footer.jsp" %> <!-- Include Footer -->

</body>

</html>
