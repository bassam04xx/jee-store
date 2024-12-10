<%@include file="../static/admin-sidebar.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
<div class="container mx-auto mt-10">
    <!-- Page Header -->
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-gray-700">Edit Category</h1>
        <p class="text-gray-600 mt-2">Update the details of the category below.</p>
    </div>

    <!-- Form -->
    <form action="${pageContext.request.contextPath}/category?action=edit" method="post"
          class="bg-white shadow-md rounded-lg p-8 space-y-6">
        <!-- Hidden Category ID -->
        <input type="hidden" name="id" value="${category.id}">

        <!-- Name -->
        <div>
            <label for="name" class="block text-gray-700 font-semibold mb-2">Category Name</label>
            <input type="text" id="name" name="name" value="${category.name}" placeholder="Enter category name"
                   class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
        </div>

        <!-- Submit Button -->
        <div class="text-right">
            <button type="submit"
                    class="bg-gradient-to-r from-green-500 to-green-700 text-white px-6 py-3 rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
                Update Category
            </button>
        </div>
    </form>
</div>
<%@include file="../static/admin-footer.jsp"%>
</body>
</html>
