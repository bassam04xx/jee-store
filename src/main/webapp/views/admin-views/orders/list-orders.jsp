<%@ page import="com.ecommerce.ecommerce.models.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.dao.UserDAO" %>
<%@ page import="com.ecommerce.ecommerce.models.User" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
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

    // Get orders from session
    List<Order> orders = (List<Order>) session.getAttribute("orders");

    // Initialize UserDAO object
    UserDAO userDAO = new UserDAO();

    // Create a map of users for quick lookup by user ID
    Map<Integer, User> userMap = new HashMap<>();
    for (Order order : orders) {
        int userId = order.getUserId();
        if (!userMap.containsKey(userId)) {
            User user = userDAO.getUserById(userId); // Fetch user by ID
            userMap.put(userId, user);
        }
    }

    // Redirect to fetch orders if not present
    if (orders == null) {
        response.sendRedirect(request.getContextPath() + "/order?action=list");
        return; // Stop further processing
    }

    // Debugging: Print userMap contents
    for (Map.Entry<Integer, User> entry : userMap.entrySet()) {
        System.out.println("User ID: " + entry.getKey() + " User Name: " + entry.getValue().getFullName());
    }
%>

<div class="flex min-h-screen">
    <!-- Include Sidebar -->
    <%@ include file="../static/admin-sidebar2.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">
        <header class="bg-white shadow-sm z-10">
            <div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8 flex justify-between items-center">
                <h1 class="text-2xl font-semibold text-gray-900">Order Management</h1>
                <div class="flex items-center">
                    <div class="relative mr-4">
                        <input type="text" placeholder="Search orders..." class="w-64 pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary">
                        <div class="absolute left-3 top-2.5 text-gray-400">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/order?action=add" class="bg-primary text-white py-2 px-4 rounded-lg hover:bg-blue-600 transition duration-300 flex items-center">
                        <i class="fas fa-plus mr-2"></i> Add New Order
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
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Order ID</th>
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">User Name</th>
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Order Date</th>
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Status</th>
                                <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-3 text-gray-600 font-bold tracking-wider uppercase text-xs">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% for (Order order : orders) {
                                User user = userMap.get(order.getUserId());
                            %>
                            <tr class="hover:bg-gray-50">
                                <td class="border-b border-gray-200 px-6 py-4">
                                    <div class="flex items-center">
                                        <div class="text-sm font-medium text-gray-900">#<%= order.getId() %></div>
                                    </div>
                                </td>
                                <td class="border-b border-gray-200 px-6 py-4">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 h-10 w-10">
                                            <img class="h-10 w-10 rounded-full" src="https://www.gravatar.com/avatar/<%= user != null ? user.getEmail().toLowerCase().trim() : "" %>?s=200&d=mp" alt="<%= user != null ? user.getFullName() : "Unknown User" %>">
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-medium text-gray-900">
                                                <%= user != null ? user.getFullName() : "<span class=\"text-gray-500\">Unknown user</span>" %>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="border-b border-gray-200 px-6 py-4">
                                    <div class="text-sm text-gray-900"><%= order.getDate() %></div>
                                </td>
                                <td class="border-b border-gray-200 px-6 py-4">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                            <%= order.getStatus().equalsIgnoreCase("completed") ? "bg-green-100 text-green-800" :
                                               order.getStatus().equalsIgnoreCase("pending") ? "bg-yellow-100 text-yellow-800" :
                                               "bg-red-100 text-red-800" %>">
                                            <%= order.getStatus() %>
                                        </span>
                                </td>
                                <td class="border-b border-gray-200 px-6 py-4 text-sm">
                                    <a href="<%= request.getContextPath() + "/order?action=edit&id=" + order.getId() %>" class="text-primary hover:text-blue-800 mr-3">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="<%= request.getContextPath() + "/order?action=view&id=" + order.getId() %>" class="text-green-600 hover:text-green-800">
                                        <i class="fas fa-eye"></i> View
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