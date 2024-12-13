<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Category</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">
<div class="flex min-h-screen">
    <!-- Include Sidebar -->
    <%@ include file="../static/admin-sidebar2.jsp" %>  <!-- Adjust path as necessary -->

    <div class="container mx-auto py-8 w-full">
        <!-- Page Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-700">Add Category</h1>
            <p class="text-gray-600 mt-2">Fill in the details below to add a new category to the catalog.</p>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 text-red-700 px-4 py-3 rounded mb-6">
                <p>${error}</p>
            </div>
        </c:if>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/category?action=add" method="post"
              class="bg-white shadow-md rounded-lg p-8 space-y-6">
            <!-- Name -->
            <div>
                <label for="name" class="block text-gray-700 font-semibold mb-2">Category Name</label>
                <input type="text" id="name" name="name" value="${param.name}"
                       placeholder="Enter category name"
                       class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
            </div>



            <!-- Submit Button -->
            <div class="text-right">
                <button type="submit"
                        class="bg-gradient-to-r from-blue-500 to-blue-700 text-white px-6 py-3 rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
                    Add Category
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="../static/admin-footer.jsp" %> <!-- Adjust path as necessary -->
</body>

</html>
