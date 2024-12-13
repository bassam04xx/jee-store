<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">
<div class="flex min-h-screen">
    <!-- Include Sidebar -->
    <%@ include file="../static/admin-sidebar2.jsp" %>  <!-- Adjust path as necessary -->

    <div class="container mx-auto py-8 w-full">
        <!-- Page Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-700">Add User</h1>
            <p class="text-gray-600 mt-2">Fill in the details to create a new user.</p>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 text-red-700 px-4 py-3 rounded mb-6">
                <p>${error}</p>
            </div>
        </c:if>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/user?action=add" method="post"
              class="bg-white shadow-md rounded-lg p-8 space-y-6">
            <!-- Full Name -->
            <div>
                <label for="fullName" class="block text-gray-700 font-semibold mb-2">Full Name</label>
                <input type="text" id="fullName" name="fullName"
                       class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" required>
            </div>

            <!-- Username -->
            <div>
                <label for="username" class="block text-gray-700 font-semibold mb-2">Username</label>
                <input type="text" id="username" name="username"
                       class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" required>
            </div>

            <!-- Email -->
            <div>
                <label for="email" class="block text-gray-700 font-semibold mb-2">Email</label>
                <input type="email" id="email" name="email"
                       class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" required>
            </div>

            <!-- Password -->
            <div>
                <label for="password" class="block text-gray-700 font-semibold mb-2">Password</label>
                <input type="password" id="password" name="password"
                       class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" required>
            </div>

            <!-- User Type -->
            <div>
                <label for="type" class="block text-gray-700 font-semibold mb-2">User Type</label>
                <select id="type" name="type"
                        class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" required>
                    <option value="client">Client</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <!-- Status (Only for clients) -->
            <div>
                <label for="status" class="block text-gray-700 font-semibold mb-2">Status (For Clients)</label>
                <select id="status" name="status"
                        class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
                    <option value="active">Active</option>
                    <option value="banned">Banned</option>
                </select>
            </div>

            <!-- Submit Button -->
            <div class="text-right">
                <button type="submit"
                        class="bg-gradient-to-r from-blue-500 to-blue-700 text-white px-6 py-3 rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
                    Add User
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="../static/admin-footer.jsp" %> <!-- Adjust path as necessary -->
</body>

</html>
