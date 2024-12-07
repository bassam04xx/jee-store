<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/admin-views/static/admin-sidebar.jsp" %>
<% if(request.getAttribute("products")==null){
    response.sendRedirect(request.getContextPath() + "/product?action=list");
} %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
<div class="container mx-auto mt-10">
    <!-- Page Header -->
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-3xl font-bold text-gray-700">Product List</h1>
        <a href="${pageContext.request.contextPath}/product?action=add"
           class="bg-gradient-to-r from-blue-500 to-blue-700 text-white px-5 py-3 rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
            + Add Product
        </a>
    </div>

    <!-- Product Table -->
    <div class="bg-white shadow-md rounded-lg overflow-hidden">
        <table class="min-w-full border-collapse border border-gray-300">
            <thead class="bg-gradient-to-r from-gray-200 to-gray-300">
            <tr>
                <th class="border px-6 py-4 text-left font-semibold text-gray-700">ID</th>
                <th class="border px-6 py-4 text-left font-semibold text-gray-700">Name</th>
                <th class="border px-6 py-4 text-left font-semibold text-gray-700">Description</th>
                <th class="border px-6 py-4 text-left font-semibold text-gray-700">Price</th>
                <th class="border px-6 py-4 text-center font-semibold text-gray-700">Actions</th>
            </tr>
            </thead>
            <tbody class="bg-white">
            <c:forEach var="product" items="${products}">
                <tr class="hover:bg-gray-100 transition duration-200">
                    <td class="border px-6 py-4 text-gray-600">${product.id}</td>
                    <td class="border px-6 py-4 text-gray-600">${product.name}</td>
                    <td class="border px-6 py-4 text-gray-600">${product.description}</td>
                    <td class="border px-6 py-4 text-gray-600">${product.price}</td>
                    <td class="border px-6 py-4 text-center">
                        <a href="${pageContext.request.contextPath}/product?action=edit&id=${product.id}"
                           class="text-blue-600 hover:text-blue-800 mx-2">Edit</a>
                        <a href="${pageContext.request.contextPath}/product?action=delete&id=${product.id}"
                           class="text-red-600 hover:text-red-800 mx-2">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

