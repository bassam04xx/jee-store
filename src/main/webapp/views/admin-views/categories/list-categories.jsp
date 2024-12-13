<%@ page import="com.ecommerce.ecommerce.models.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.dao.CategoryDAO" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">
<%
    // Retrieve the session
    session = request.getSession();

    // Initialize CategoryDAO object
    CategoryDAO categoryDAO = new CategoryDAO();

    // Fetch all categories
    List<Category> categories = categoryDAO.getAllCategories();

    // Redirect to fetch categories if not present
    if (categories == null || categories.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/category?action=list");
        return; // Stop further processing
    }

    // Debugging: Print categories list
    for (Category category : categories) {
        System.out.println("Category ID: " + category.getId() + " Category Name: " + category.getName());
    }
%>

<div class="flex min-h-screen">
    <!-- Include Sidebar -->
    <%@ include file="../static/admin-sidebar2.jsp" %>  <!-- Adjust path as necessary -->

    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold text-gray-700 mb-4">Category Management</h1>
        <div class="flex justify-end mb-4">
            <a href="${pageContext.request.contextPath}/category?action=add" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Add New Category</a>
        </div>

        <%
            // Check if categories list is not empty
            if (categories != null && !categories.isEmpty()) {
        %>
        <table class="w-full bg-white shadow-md rounded-lg table-auto">
            <thead class="bg-gray-200">
            <tr>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Category Name</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Loop through the categories
                for (Category category : categories) {
            %>
            <tr class="border-b hover:bg-gray-50">
                <td class="px-4 py-3 text-sm"><%= category.getName() %></td>
                <td class="px-4 py-3 text-sm">
                    <a href="<%= request.getContextPath() + "/category?action=edit&id=" + category.getId() %>" class="text-blue-500 hover:text-blue-700">Edit</a>
                    <a href="<%= request.getContextPath() + "/category?action=delete&id=" + category.getId() %>" class="text-red-500 hover:text-red-700 ml-2">Delete</a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
            }
        %>
    </div>
</div>

</body>
<%@ include file="../static/admin-footer.jsp" %> <!-- Adjust path as necessary -->

</html>
