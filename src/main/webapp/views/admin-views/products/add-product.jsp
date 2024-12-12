<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../static/admin-sidebar.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
<div class="container mx-auto mt-10">
    <!-- Page Header -->
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-gray-700">Add Product</h1>
        <p class="text-gray-600 mt-2">Fill in the details below to add a new product to the catalog.</p>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="bg-red-100 text-red-700 px-4 py-3 rounded mb-6">
            <p>${error}</p>
        </div>
    </c:if>

    <!-- Form -->
    <form action="${pageContext.request.contextPath}/product?action=add" method="post" enctype="multipart/form-data"
          class="bg-white shadow-md rounded-lg p-8 space-y-6">
        <!-- Name -->
        <div>
            <label for="name" class="block text-gray-700 font-semibold mb-2">Product Name</label>
            <input type="text" id="name" name="name" value="${param.name}"
                   placeholder="Enter product name"
                   class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
        </div>

        <!-- Description -->
        <div>
            <label for="description" class="block text-gray-700 font-semibold mb-2">Description</label>
            <textarea id="description" name="description" placeholder="Enter product description"
                      class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none h-24">${param.description}</textarea>
        </div>

        <!-- Price -->
        <div>
            <label for="price" class="block text-gray-700 font-semibold mb-2">Price</label>
            <input type="text" id="price" name="price" value="${param.price}"
                   placeholder="Enter product price"
                   class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
        </div>

        <!-- Stock -->
        <div>
            <label for="stock" class="block text-gray-700 font-semibold mb-2">Stock</label>
            <input type="number" id="stock" name="stock" value="${param.stock}"
                   placeholder="Enter product stock"
                   class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
        </div>

        <!-- Image -->
        <div>
            <label for="image" class="block text-gray-700 font-semibold mb-2">Image</label>
            <input type="file" id="image" name="image" accept="image/*"
                   class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
        </div>

        <!-- Category -->
        <div>
            <label for="category" class="block text-gray-700 font-semibold mb-2">Category</label>
            <select id="category" name="category" required
                    class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
                <option value="">Select a category</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.id}" ${param.category == category.id ? "selected" : ""}>
                            ${category.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- Submit Button -->
        <div class="text-right">
            <button type="submit"
                    class="bg-gradient-to-r from-blue-500 to-blue-700 text-white px-6 py-3 rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
                Add Product
            </button>
        </div>
    </form>
</div>
<%@include file="../static/admin-footer.jsp"%>
</body>
</html>
