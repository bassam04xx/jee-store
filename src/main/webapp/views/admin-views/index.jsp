<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%@ page import="com.ecommerce.ecommerce.models.User" %>
<%@ page import="com.ecommerce.ecommerce.models.Order" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<%
  // Retrieve session object
  session = request.getSession();

  // Get data from session
  List<Product> products = (List<Product>) session.getAttribute("products");
  List<User> users = (List<User>) session.getAttribute("users");
  List<Order> orders = (List<Order>) session.getAttribute("orders"); // Assuming orders are stored in session

  // Redirect to fetch users if not present
  if (users == null) {
    response.sendRedirect(request.getContextPath() + "/user?action=list");
    return; // Stop further processing
  }

  // Redirect to fetch orders if not present
  if (orders == null) {
    response.sendRedirect(request.getContextPath() + "/order?action=list");
    return; // Stop further processing
  }
%>

<div class="flex">
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
    <c:if test="${!empty products}">
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
              <a href="${pageContext.request.contextPath}/product?action=delete&id=${product.id}" class="text-red-500 hover:text-red-700 px-4 py-2 rounded-md">Delete</a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:if>

    <!-- User Management Section -->
    <div class="mb-8 mt-10">
      <h1 class="text-3xl font-bold text-gray-700">User Management</h1>
      <p class="text-gray-600 mt-2">Manage users, edit, delete, or add new users to your catalog.</p>
    </div>

    <!-- Add User Button -->
    <div class="mb-4 text-right">
      <a href="${pageContext.request.contextPath}/views/admin-views/users/add-user.jsp" class="bg-blue-500 text-white py-2 px-4 rounded-lg shadow-lg hover:bg-blue-600 transition duration-300">Add New User</a>
    </div>

    <!-- User Table -->
    <c:if test="${!empty users}">
      <table class="min-w-full bg-white border border-gray-300 rounded-lg shadow-md">
        <thead>
        <tr class="bg-gray-200 text-gray-700">
          <th class="px-6 py-3 text-left">Username</th>
          <th class="px-6 py-3 text-left">Full Name</th>
          <th class="px-6 py-3 text-left">Role</th>
          <th class="px-6 py-3 text-left">Status</th>
          <th class="px-6 py-3 text-left">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
          <tr class="border-b hover:bg-gray-50">
            <td class="px-6 py-3">${user.username}</td>
            <td class="px-6 py-3">${user.fullName}</td>
            <td class="px-6 py-3">${user.type}</td>
            <td class="px-6 py-3">${user.status}</td>
            <td class="px-6 py-3">
              <a href="${pageContext.request.contextPath}/user?action=edit&id=${user.id}" class="text-blue-500 hover:text-blue-700 px-4 py-2 rounded-md">Edit</a>
              <a href="${pageContext.request.contextPath}/user?action=delete&id=${user.id}" class="text-red-500 hover:text-red-700 px-4 py-2 rounded-md">Delete</a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:if>
  </main>
</div>

<!-- Footer Section -->
<%@ include file="./static/admin-footer.jsp" %> <!-- Include Footer -->

</body>
</html>