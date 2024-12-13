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
    <title>Product Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3b82f6',
                        secondary: '#10b981',
                    }
                }
            }
        }
    </script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>

<body class="bg-gray-50 text-gray-900">
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
%>

<div class="flex min-h-screen">
    <!-- Include Sidebar -->
    <%@ include file="../static/admin-sidebar2.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">
        <header class="bg-white shadow-sm z-10">
            <div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8 flex justify-between items-center">
                <h1 class="text-2xl font-semibold text-gray-900">Product Management</h1>
                <div class="flex items-center">
                    <div class="relative mr-4">
                        <input type="text" placeholder="Search products..." class="w-64 pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary">
                        <div class="absolute left-3 top-2.5 text-gray-400">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/product?action=add" class="bg-primary text-white py-2 px-4 rounded-lg hover:bg-blue-600 transition duration-300 flex items-center">
                        <i class="fas fa-plus mr-2"></i> Add New Product
                    </a>
                </div>
            </div>
        </header>

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100">
            <div class="container mx-auto px-4 sm:px-8">
                <div class="py-8">
                    <div class="overflow-x-auto bg-white rounded-lg shadow overflow-y-auto relative">
                        <table class="border-collapse table-auto w-full whitespace-no-wrap bg-white table-striped relative">
                            <thead>
                            <tr class="text-left">
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Product</th>
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Description</th>
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Price</th>
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Stock</th>
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Category</th>
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% for (Product product : products) {
                                Category category = categoryMap.get(product.getCategory_id());
                            %>
                            <tr class="hover:bg-gray-50">
                                <td class="border-b border-gray-200 px-6 py-4">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 h-10 w-10">
                                            <img class="h-10 w-10 rounded-full object-cover" src="data:<%= product.getMimeType() %>;base64,<%= product.getImageBase64() %>" alt="<%= product.getName() %>">
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-medium text-gray-900"><%= product.getName() %></div>
                                        </div>
                                    </div>
                                </td>
                                <td class="border-b border-gray-200 px-6 py-4">
                                    <div class="text-sm text-gray-900"><%= product.getDescription() %></div>
                                </td>
                                <td class="border-b border-gray-200 px-6 py-4">
                                    <div class="text-sm font-semibold text-gray-900">$<%= String.format("%.2f", product.getPrice()) %></div>
                                </td>
                                <td class="border-b border-gray-200 px-6 py-4">
                                    <div class="text-sm text-gray-900"><%= product.getStock() %></div>
                                </td>
                                <td class="border-b border-gray-200 px-6 py-4">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                            <%= category != null ? category.getName() : "No category" %>
                                        </span>
                                </td>
                                <td class="border-b border-gray-200 px-6 py-4 text-sm">
                                    <a href="<%= request.getContextPath() + "/product?action=edit&id=" + product.getId() %>" class="text-primary hover:text-blue-800 mr-3">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="<%= request.getContextPath() + "/product?action=delete&id=" + product.getId() %>" class="text-red-600 hover:text-red-800">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="../static/admin-footer.jsp" %>

</body>
</html>