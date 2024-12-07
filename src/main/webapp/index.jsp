<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
<div class="container mx-auto mt-10">
    <h1 class="text-2xl font-bold mb-4">Product List</h1>
    <a href="${pageContext.request.contextPath}/product?action=add"
       class="bg-blue-500 text-white px-4 py-2 rounded">
        Add Product
    </a>
    <table class="min-w-full mt-4 border border-gray-300">
        <thead>
        <tr>
            <th class="border px-4 py-2">ID</th>
            <th class="border px-4 py-2">Name</th>
            <th class="border px-4 py-2">Description</th>
            <th class="border px-4 py-2">Price</th>
            <th class="border px-4 py-2">Actions</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach var="product" items="${products}">
            <tr>
                <td class="border px-4 py-2">${product.id}</td>
                <td class="border px-4 py-2">${product.name}</td>
                <td class="border px-4 py-2">${product.description}</td>
                <td class="border px-4 py-2">${product.price}</td>
                <td class="border px-4 py-2">
                    <a href="${pageContext.request.contextPath}/product?action=edit&id=${product.id}" class="text-blue-500">Edit</a> |
                    <a href="${pageContext.request.contextPath}/product?action=delete&id=${product.id}" class="text-red-500">Delete</a>
                </td>
            </tr>
        </c:forEach>


        </tbody>
    </table>
</div>
</body>
</html>
