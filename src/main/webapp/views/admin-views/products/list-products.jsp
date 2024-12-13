<%@ page import="com.ecommerce.ecommerce.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.dao.CategoryDAO" %>
<%@ page import="com.ecommerce.ecommerce.models.Category" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">
<%
    // Retrieve the session
    session = request.getSession();

    // Get products from session
    List<Product> products = (List<Product>) session.getAttribute("products");

    // Initialize CategoryDAO object
    CategoryDAO categoryDAO = new CategoryDAO();

    // Fetch all categories
    List<Category> categories = categoryDAO.getAllCategories();

    // Create a map of categories for quick lookup by ID
    Map<Integer, Category> categoryMap = new HashMap<>();
    for (Category category : categories) {
        categoryMap.put(category.getId(), category);
    }

    // Redirect to fetch products if not present
    if (products == null) {
        response.sendRedirect(request.getContextPath() + "/product?action=list");
        return; // Stop further processing
    }

    // Debugging: Print categoryMap contents
    for (Map.Entry<Integer, Category> entry : categoryMap.entrySet()) {
        System.out.println("Category ID: " + entry.getKey() + " Category Name: " + entry.getValue().getName());
    }
%>

<div class="flex min-h-screen">
    <!-- Include Sidebar -->
    <%@ include file="../static/admin-sidebar2.jsp" %>  <!-- Adjust path as necessary -->

    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold text-gray-700 mb-4">Product Management</h1>
        <div class="flex justify-end mb-4">
            <a href="${pageContext.request.contextPath}/product?action=add" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Add New Product</a>
        </div>

        <%
            // Check if products list is not empty
            if (products != null && !products.isEmpty()) {
        %>
        <table class="w-full bg-white shadow-md rounded-lg table-auto">
            <thead class="bg-gray-200">
            <tr>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Product Name</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Description</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Price</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Stock</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Category</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Image</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Loop through the products
                for (Product product : products) {
                    // Get the category for the product
                    Category category = categoryMap.get(product.getCategory_id());
            %>
            <tr class="border-b hover:bg-gray-50">
                <td class="px-4 py-3 text-sm"><%= product.getName() %></td>
                <td class="px-4 py-3 text-sm"><%= product.getDescription() %></td>
                <td class="px-4 py-3 text-sm"><%= product.getPrice() %></td>
                <td class="px-4 py-3 text-sm"><%= product.getStock() %></td>
                <td class="px-4 py-3 text-sm">
                    <%
                        if (category != null) {
                            out.print(category.getName());
                        } else {
                            out.print("<span class=\"text-gray-500\">No category</span>");
                        }
                    %>
                </td>
                <td class="px-4 py-3 text-sm">
                    <img src="data:<%= product.getMimeType() %>;base64,<%= product.getImageBase64() %>" alt="<%= product.getName() %>" class="w-32 h-32 object-cover rounded-md">
                </td>
                <td class="px-4 py-3 text-sm">
                    <a href="<%= request.getContextPath() + "/product?action=edit&id=" + product.getId() %>" class="text-blue-500 hover:text-blue-700">Edit</a>
                    <a href="<%= request.getContextPath() + "/product?action=delete&id=" + product.getId() %>" class="text-red-500 hover:text-red-700 ml-2">Delete</a>
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
