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
    <title>Orders</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">
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
    <%@ include file="../static/admin-sidebar2.jsp" %>  <!-- Adjust path as necessary -->

    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold text-gray-700 mb-4">Order Management</h1>
        <div class="flex justify-end mb-4">
            <a href="${pageContext.request.contextPath}/order?action=add" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Add New Order</a>
        </div>

        <%
            // Check if orders list is not empty
            if (orders != null && !orders.isEmpty()) {
        %>
        <table class="w-full bg-white shadow-md rounded-lg table-auto">
            <thead class="bg-gray-200">
            <tr>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Order ID</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">User Name</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Order Date</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Status</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Loop through the orders
                for (Order order : orders) {
                    // Get the user for the order
                    User user = userMap.get(order.getUserId());
            %>
            <tr class="border-b hover:bg-gray-50">
                <td class="px-4 py-3 text-sm"><%= order.getId() %></td>
                <td class="px-4 py-3 text-sm">
                    <%
                        if (user != null) {
                            out.print(user.getFullName());
                        } else {
                            out.print("<span class=\"text-gray-500\">Unknown user</span>");
                        }
                    %>
                </td>
                <td class="px-4 py-3 text-sm"><%= order.getDate() %></td>
                <td class="px-4 py-3 text-sm"><%= order.getStatus() %></td>
                <td class="px-4 py-3 text-sm">
                    <a href="<%= request.getContextPath() + "/order?action=edit&id=" + order.getId() %>" class="text-blue-500 hover:text-blue-700">Edit</a>
                    <a href="<%= request.getContextPath() + "/order?action=view&id=" + order.getId() %>" class="text-green-500 hover:text-red-700 ml-2">Show</a>
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
