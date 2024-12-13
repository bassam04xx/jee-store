<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%@ page import="com.ecommerce.ecommerce.models.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.models.Category" %>
<%@ page import="com.ecommerce.ecommerce.models.Order" %>
<%@ page import="com.ecommerce.ecommerce.dao.CategoryDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  List<Category> categories = (List<Category>) session.getAttribute("categories");
  CategoryDAO categoryDAO = new CategoryDAO();
  if (categories != null) {
    categories = categoryDAO.getAllCategories();
    session.setAttribute("categories", categories);
  }
  List<Order> orders = (List<Order>) session.getAttribute("orders");
  if (products == null) {
    response.sendRedirect(request.getContextPath() + "/product?action=list");
    return; // Stop further processing
  }
  // Redirect to fetch users if not present
  if (users == null) {
    response.sendRedirect(request.getContextPath() + "/user?action=list");
    return; // Stop further processing
  }
  if (orders == null) {
    response.sendRedirect(request.getContextPath() + "/order?action=list");
    return; // Stop further processing
  }

%>
<div class="flex min-h-screen">
  <!-- Sidebar -->
  <%@include file="static/admin-sidebar2.jsp"%>

  <!-- Main Content -->
  <main class="flex-1 p-8">
    <!-- Products Section -->
    <div id="products" class="mb-8">
      <h1 class="text-3xl font-bold text-gray-700">Product Management</h1>
      <div class="flex justify-end mb-4">
        <a href="${pageContext.request.contextPath}/product?action=add" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Add New Product</a>
      </div>
      <c:if test="${!empty products}">
        <table class="w-full bg-white shadow-md rounded-lg">
          <thead class="bg-gray-200">
          <tr>
            <th class="px-4 py-2">Product Name</th>
            <th class="px-4 py-2">Description</th>
            <th class="px-4 py-2">Price</th>
            <th class="px-4 py-2">Stock</th>
            <th class="px-4 py-2">Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="product" items="${products}">
            <tr class="border-b hover:bg-gray-50">
              <td class="px-4 py-2">${product.name}</td>
              <td class="px-4 py-2">${product.description}</td>
              <td class="px-4 py-2">${product.price}</td>
              <td class="px-4 py-2">${product.stock}</td>
              <td class="px-4 py-2">
                <a href="${pageContext.request.contextPath}/product?action=edit&id=${product.id}" class="text-blue-500">Edit</a>
                <a href="${pageContext.request.contextPath}/product?action=delete&id=${product.id}" class="text-red-500 ml-2">Delete</a>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </c:if>
    </div>

    <!-- Categories Section -->
    <div id="categories" class="mb-8">
      <h1 class="text-3xl font-bold text-gray-700">Category Management</h1>
      <div class="flex justify-end mb-4">
        <a href="${pageContext.request.contextPath}/category?action=add" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Add New Category</a>
      </div>
      <c:if test="${!empty categories}">
        <table class="w-full bg-white shadow-md rounded-lg">
          <thead class="bg-gray-200">
          <tr>
            <th class="px-4 py-2">Category Name</th>
            <th class="px-4 py-2">Description</th>
            <th class="px-4 py-2">Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="category" items="${categories}">
            <tr class="border-b hover:bg-gray-50">
              <td class="px-4 py-2">${category.name}</td>
              <td class="px-4 py-2">${category.description}</td>
              <td class="px-4 py-2">
                <a href="${pageContext.request.contextPath}/category?action=edit&id=${category.id}" class="text-blue-500">Edit</a>
                <a href="${pageContext.request.contextPath}/category?action=delete&id=${category.id}" class="text-red-500 ml-2">Delete</a>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </c:if>
    </div>

    <!-- Add sections for Users and Orders similarly -->

    <--! User Section !-->
    <div class="mt-8">
      <h2 class="text-2xl font-bold text-gray-800 mb-6">Users</h2>
      <c:if test="${not empty users}">
        <table class="w-full text-sm text-left text-gray-500 mt-4">
          <thead>
            <tr class="border-b border-gray-200">
              <th class="px-4 py-2">Username</th>
              <th class="px-4 py-2">Email</th>
              <th class="px-4 py-2">Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${users}" var="user">
              <tr class="border-b border-gray-200">
                <td class="px-4 py-2">${user.username}</td>
                <td class="px-4 py-2">${user.email}</td>
                <td class="px-4 py-2">
                  <a href="${pageContext.request.contextPath}/user?action=edit&id=${user.id}" class="text-blue-500 ml-2">Edit</a>
                  <a href="${pageContext.request.contextPath}/user?action=delete&id=${user.id}" class="text-red-500 ml-2">Delete</a>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:if>
    </div>

    <--! Order Section !-->
    <div class="mt-8">
      <h2 class="text-2xl font-bold text-gray-800 mb-6">Orders</h2>
      <c:if test="${not empty orders}">
        <table class="w-full text-sm text-left text-gray-500 mt-4">
          <thead>
            <tr class="border-b border-gray-200">
              <th class="px-4 py-2">Order ID</th>
              <th class="px-4 py-2">Username</th>
              <th class="px-4 py-2">Email</th>
              <th class="px-4 py-2">Total</th>
              <th class="px-4 py-2">Status</th>
              <th class="px-4 py-2">Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${orders}" var="order">
              <tr class="border-b border-gray-200">
                <td class="px-4 py-2">${order.orderId}</td>
                <td class="px-4 py-2">${order.username}</td>
                <td class="px-4 py-2">${order.email}</td>
                <td class="px-4 py-2">${order.total}</td>
                <td class="px-4 py-2">${order.status}</td>
                <td class="px-4 py-2">
                  <a href="${pageContext.request.contextPath}/order?action=edit&id=${order.id}" class="text-blue-500 ml-2">Edit</a>
                  <a href="${pageContext.request.contextPath}/order?action=delete&id=${order.id}" class="text-red-500 ml-2">Delete</a>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:if>
    </div>
  </main>
</div>
</body>

</html>
