<%@ page import="com.ecommerce.ecommerce.models.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.ecommerce.dao.UserDAO" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">
<%
    // Retrieve the session
    session = request.getSession();

    // Initialize UserDAO object
    UserDAO userDAO = new UserDAO();

    // Fetch all users
    List<User> users = userDAO.getAllUsers();

    // Redirect to fetch users if not present
    if (users == null || users.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/user?action=list");
        return; // Stop further processing
    }

    // Debugging: Print users list
    for (User user : users) {
        System.out.println("User ID: " + user.getId() + " User Name: " + user.getFullName());
    }
%>

<div class="flex min-h-screen">
    <!-- Include Sidebar -->
    <%@ include file="../static/admin-sidebar2.jsp" %>  <!-- Adjust path as necessary -->

    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold text-gray-700 mb-4">User Management</h1>
        <div class="flex justify-end mb-4">
            <a href="${pageContext.request.contextPath}/user?action=add" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Add New User</a>
        </div>

        <%
            // Check if users list is not empty
            if (users != null && !users.isEmpty()) {
        %>
        <table class="w-full bg-white shadow-md rounded-lg table-auto">
            <thead class="bg-gray-200">
            <tr>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Full Name</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Username</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Email</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">User Type</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Status</th>
                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Loop through the users
                for (User user : users) {
            %>
            <tr class="border-b hover:bg-gray-50">
                <td class="px-4 py-3 text-sm"><%= user.getFullName() %></td>
                <td class="px-4 py-3 text-sm"><%= user.getUsername() %></td>
                <td class="px-4 py-3 text-sm"><%= user.getEmail() %></td>
                <td class="px-4 py-3 text-sm"><%= user.getType() %></td>
                <td class="px-4 py-3 text-sm"><%= user.getStatus() %></td>
                <td class="px-4 py-3 text-sm">
                    <a href="<%= request.getContextPath() + "/user?action=edit&id=" + user.getId() %>" class="text-blue-500 hover:text-blue-700">Edit</a>
                    <a href="<%= request.getContextPath() + "/user?action=delete&id=" + user.getId() %>" class="text-red-500 hover:text-red-700 ml-2">Delete</a>
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
